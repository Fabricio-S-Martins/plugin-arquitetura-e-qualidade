---
name: executar-tarefa
description: Executa arquivo de tarefa (ou itens do checklist), conferindo antes o estado e as dependências, e conclui a tarefa em validação com o "aprovado" do Dev. Usar ao pedir para executar, implementar, fazer ou continuar tarefa que tem arquivo, item do checklist ("faz a seção 1 da tarefa 02"), ou ao aprovar ou apontar defeito em tarefa em validação.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill
---

# executar-tarefa

Tarefa: `docs/tarefas/modulos/<modulo>/NN-*.md`. Ler inteira. Tags e estados: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`.

## Estado (antes de tudo)
1. Tag `tarefa/...`:
   - `pendente` ou `em-andamento` → seguir.
   - `em-execucao` → avisar que outra sessão pode estar nela (ou uma que caiu) e perguntar se assume; seguir só com o sim.
   - `bloqueado` → parar e dizer o motivo (dependência, especificação ou linha `**Bloqueio:**`); seguir só se o Dev liberar (liberou → apagar a linha `**Bloqueio:**`, se houver).
   - `em-validacao` → não executar o checklist; pedido com "aprovado" ou defeito → Validação; senão pedir um dos dois.
   - `concluido` → não executar; defeito = tarefa nova (`criar-tarefa`, original em `**Ref:**`).

## Dependências (antes de qualquer código)
2. `Dependências` do cabeçalho (sem a linha = livre). Tarefa citada (Read): tag `tarefa/concluido` e, via Glob/Grep, o que ela entrega existe no código (projeto, pasta, tipo). Linha `Especificação`: Read; tag fora de `aprovada`/`implementada` = pendente.
3. Dep pendente → parar, nada implementado. Dizer o que falta; tarefa não `bloqueado` e sem `[x]` → propor `tarefa/bloqueado`. Seguir só se o Dev mandar.
4. **Cadeia** (só quando o passo 3 parou): Grep literal `<arquivo-da-tarefa>.md)` em `Dependências:` das tarefas de `docs/tarefas/modulos/*/` (arquivos `NN-*.md`) pelas que dependem da tarefa (direta ou indiretamente); listar. Também ficam `tarefa/bloqueado`; mudar só o que o Dev aprovar.

## Execução
5. Dependências ok → `tarefa/em-execucao` já ao iniciar (só a tag `tarefa/...`). Tarefa com algum `[x]` nunca volta a `pendente`/`bloqueado`, nem propor isso.
6. Checklist na ordem, só itens/seções pedidos (sem recorte = tarefa toda). Referência `1.b.2` ou "item b.2" = sub-item; "item b" = pai e todos os sub-itens. Sub-item isolado: ler o pai antes (pasta e contexto). Seguir os padrões do projeto em `docs/padroes/` (práticas, convenções e `modelos/` aplicáveis; Glob) e `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md`; pasta/arquivo novo: ler também `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/ORGANIZACAO.md` (simetria entre unidades e espelho em docs/tarefas/testes). Sem padrão para o tipo do alvo: Glob dos arquivos desse tipo; <2 → seguir com o irmão (se houver), sem perguntar; ≥2 → ler até 3 (o mais recente, o mais parecido e um de outra unidade) e perguntar uma vez por tipo: criar a regra agora (skill `criar-regra-telegrafica`, depois voltar à tarefa e usá-la) ou seguir com os irmãos lidos (divergiram sem maioria → o Dev diz qual vale). Alvo fora do esqueleto (outra interface, retorno ou forma de endpoint) → perguntar ao Dev, não adaptar sozinho. Item com `(Critério N)`: manda o critério da especificação; conflito tarefa × especificação → parar e perguntar. Nada fora do escopo do arquivo da tarefa. Seção `Retomada` (fim da tarefa): ler primeiro; `Decisões` e `Descartado` valem, `Em aberto` sem resposta → perguntar ao Dev. Bloco Documentação → skill `criar-documentacao`, informando a tarefa (ela escreve todos os docs do bloco sem parar e não marca nada; os itens vão no passo 8).
7. **Build obrigatório:** comando do `CLAUDE.md` do projeto; sem ele, perguntar qual. Zero erros. Erro causado pela tarefa → corrigir e rebuildar, até 2 tentativas; seguiu falhando → parar e reportar. Erro fora do escopo da tarefa (código que ela não toca) → parar e reportar, sem corrigir. Build falho (não é impedimento) → sem `[x]` nem `em-validacao`. Sem como compilar → dizer.
8. `[x]` só depois do build sem erro, em item pedido, feito e conferido (inclusive os docs do bloco Documentação). Sub-item `[x]` conta como item marcado (passo 5); pai só vira `[x]` com todos os filhos `[x]`. Edit na linha inteira do item (letras repetem entre blocos).
9. **Fim da execução (sempre sai de `em-execucao`):** todos `[x]` → `tarefa/em-validacao`; parcial → `em-andamento` (algum `[x]`) ou `pendente` (nenhum); impedimento externo (build falho não é) → `bloqueado` só se nenhum `[x]`, com a linha `**Bloqueio:** <o que destrava>` em `O que fazer` (com `[x]`, `em-andamento` e o impedimento vai na resposta).

## Validação (tarefa `em-validacao`)
10. Ao chegar: pedir que o Dev confira (se quiser, skill `revisar-qualidade`) e responda "aprovado" ou aponte o defeito. Silêncio ou dúvida não é aprovação.
11. **Defeito:** listar os itens afetados (código, testes, documentação); com a lista confirmada pelo Dev, voltar esses itens a `[ ]` (pai também, se um filho voltou) e a tag pelo checklist (passo 9). Correção pela Execução.
12. **"Aprovado" explícito** → `tarefa/concluido` e a Conclusão (passos 13 a 17), só nessa aprovação.

## Conclusão (só no "aprovado")
13. **Dependentes:** mesmo Grep do passo 4, só os diretos. Em cada dependente, remover só o link desta tarefa (Edit na linha; sobrou vazia → apagar a linha). Dependente `tarefa/bloqueado` sem outra tarefa em `Dependências`, sem `Especificação` fora de `aprovada`/`implementada` e sem linha `**Bloqueio:**` → `tarefa/pendente` (Edit só nessa tag, linha 2); resta impedimento → segue bloqueado. Índice `<modulo>.md` com status → atualizar igual. Nada além de dependência, tag e status.
14. **Consistência (só avisar, nunca corrigir):** entre os dependentes do passo 13, tarefa com dependência restante e fora de `tarefa/bloqueado` → listar.
15. **Especificação:** Grep da linha `Especificação:` com o caminho da especificação (`especificacoes/.../<arquivo>`) em `docs/tarefas/modulos/*/`; toda tarefa que a cita `tarefa/concluido` → tag `especificacao/implementada` na especificação (só essa tag).
16. **Retomada:** tarefa com seção `Retomada` → listar as `Decisões` que valem além da tarefa e perguntar uma vez o destino de cada: linha `**Decisão:**` em `O que fazer`, regra na especificação (skill `criar-especificacao`), decisão (só se o projeto adotou: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/DECISOES.md`; grava com tag `decisao/aceita`) ou o destino que o projeto tiver para decisões. Depois do aval do Dev (nenhuma vale → só confirmar), apagar a seção inteira (Edit). Sem resposta → manter a seção.
17. **Plano:** Grep `tags:.*plano/vigente` em `docs/` (arquivos) e, neles, Grep literal `<modulo>/<arquivo-da-tarefa>.md)`. Achou → `[x]` na linha da tarefa (Edit na linha inteira) e, se todas as tarefas de uma funcionalidade ficaram `[x]`, `[x]` nela. Item novo que a execução deixou sem resposta ou fora das tarefas → propor em texto como pendência; gravar só com o aceite do Dev. Formato: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/PLANO.md`. Sem plano → nada.

## Resposta
Feito, pendente, tag final (em `em-validacao`: o pedido do passo 10), dependências removidas, tarefas desbloqueadas, especificação marcada, plano atualizado, avisos de consistência, destino das decisões da Retomada.
