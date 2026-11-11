---
name: executar-tarefa
description: Executa arquivo de tarefa (ou itens do checklist), conferindo antes as dependências. Usar ao pedir para executar, implementar, fazer ou continuar tarefa que tem arquivo, ou item do checklist ("faz a seção 1 da tarefa 02").
allowed-tools: Read, Write, Edit, Glob, Grep, Skill
---

# executar-tarefa

Tarefa: `docs/tarefas/modulos/<modulo>/NN-*.md`. Ler inteira. Tags: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`.

## Dependências (antes de qualquer código)
1. `Dependências` do cabeçalho (sem a linha = livre). Tarefa citada (Read): tag `tarefa/concluido` e, via Glob/Grep, o que ela entrega existe no código (projeto, pasta, tipo). Linha `Especificação`: Read; tag diferente de `aprovada`/`implementada` = pendente.
2. Dep pendente → parar, nada implementado. Dizer o que falta; tarefa não `bloqueado` e sem `[x]` → propor `tarefa/bloqueado`. Seguir só se o Dev mandar.
3. **Cadeia:** Grep literal `<arquivo-da-tarefa>.md)` em `Dependências:` das tarefas de `docs/tarefas/modulos/*/` (arquivos `NN-*.md`) pelas que dependem da tarefa (direta ou indiretamente); listar. Também ficam `tarefa/bloqueado`; mudar só o que o Dev aprovar.

## Execução
4. Dependências ok → `tarefa/em-andamento` já ao iniciar (só a tag `tarefa/...`). Tarefa com algum `[x]` nunca sai de `em-andamento`, só para `concluido`: sem voltar a `pendente`/`bloqueado`, nem propor isso.
5. Checklist na ordem, só itens/seções pedidos (sem recorte = tarefa toda). Referência `1.b.2` ou "item b.2" = sub-item; "item b" = pai e todos os sub-itens. Sub-item isolado: ler o pai antes (pasta e contexto). Seguir os padrões do projeto em `docs/padroes/` (práticas, convenções e `modelos/` aplicáveis; Glob) e `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md`; pasta/arquivo novo: ler também `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/ORGANIZACAO.md` (simetria entre unidades e espelho em docs/tarefas/testes). Sem padrão para o tipo do alvo: Glob dos arquivos desse tipo; <2 → seguir com o irmão (se houver), sem perguntar; ≥2 → ler até 3 (o mais recente, o mais parecido e um de outra unidade) e perguntar uma vez por tipo: criar a regra agora (skill `criar-regra-telegrafica`, depois voltar à tarefa e usá-la) ou seguir com os irmãos lidos (divergiram sem maioria → o Dev diz qual vale). Alvo fora do esqueleto (outra interface, retorno ou forma de endpoint) → perguntar ao Dev, não adaptar sozinho. Item com `(Critério N)`: manda o critério da especificação; conflito tarefa × especificação → parar e perguntar. Nada fora do escopo do arquivo da tarefa. Seção `Retomada` (fim da tarefa): ler primeiro; `Decisões` e `Descartado` valem, `Em aberto` sem resposta → perguntar ao Dev. Bloco Documentação → skill `documentar` (ela marca o item e fecha a tarefa).
6. `[x]` só em item pedido, feito e conferido. Sub-item `[x]` conta como item marcado (passo 4); pai só vira `[x]` com todos os filhos `[x]`. Edit na linha inteira do item (letras repetem entre blocos).
7. **Build obrigatório:** comando do `CLAUDE.md` do projeto; sem ele, perguntar ao Dev o comando. Zero erros; erro → corrigir dentro da tarefa e rebuildar; build falho → sem `[x]` nem `concluido`. Sem como compilar → dizer.
8. Todos `[x]` → `tarefa/concluido`; parcial → `tarefa/em-andamento`; impedimento → `tarefa/bloqueado` só se nenhum `[x]` (com `[x]`, segue `em-andamento` e o impedimento vai na resposta).
9. **Dependentes (só ao concluir):** mesmo Grep do passo 3, só os diretos. Em cada dependente, remover só o link desta tarefa (Edit na linha; sobrou vazia → apagar a linha). Dependente `tarefa/bloqueado` sem mais nenhuma tarefa em `Dependências` e sem `Especificação` fora de `aprovada`/`implementada` → `tarefa/pendente` (Edit só nessa tag, linha 2); resta dep → segue bloqueado. Índice `<modulo>.md` com status → atualizar igual. Nada além de dependência, tag e status.
10. **Consistência (só avisar, nunca corrigir):** entre os dependentes do passo 9, tarefa com dependência restante e fora de `tarefa/bloqueado` → listar.
11. **Especificação (só ao concluir):** Grep literal do nome do arquivo da especificação em `docs/tarefas/modulos/*/`; toda tarefa que a cita `tarefa/concluido` ou `tarefa/cancelado`, ao menos uma `concluido` → tag `especificacao/implementada` na especificação (só essa tag).
12. **Retomada (só ao concluir, também quando `documentar` fechou a tarefa):** tarefa com seção `Retomada` → listar as `Decisões` que valem além da tarefa e perguntar uma vez o destino de cada: linha `**Decisão:**` em `O que fazer`, regra na especificação (skill `especificar`), decisão (só se o projeto adotou: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/DECISOES.md`; grava com tag `decisao/proposta`) ou o destino que o projeto tiver para decisões. Depois do aval do Dev (nenhuma vale → só confirmar), apagar a seção inteira (Edit). Sem resposta → manter a seção.

## Resposta
Feito, pendente, tag final, dependências removidas, tarefas desbloqueadas, especificação marcada, avisos de consistência, destino das decisões da Retomada.
