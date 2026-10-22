---
name: executar-tarefa
description: Executa card de tarefa do backlog (ou itens do checklist), conferindo antes as dependências. Usar ao pedir para executar, implementar, fazer ou continuar card/task, ou item do checklist ("faz a seção 1 do card 02").
allowed-tools: Read, Write, Edit, Glob, Grep, Skill, Bash(dotnet build *)
---

# executar-tarefa

Card: `docs/backlog/modulos/<modulo>/tarefas/NN-*.md`. Ler inteiro. Tags: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`.

## Dependências (antes de qualquer código)
1. `Dependências` do cabeçalho (sem a linha = livre). Card citado (Read): tag `tarefa/concluido` e, via Glob/Grep, o que ele entrega existe no código (projeto, pasta, tipo). Linha `Especificação`: Read; tag diferente de `aprovada`/`implementada` = pendente.
2. Dep pendente → parar, nada implementado. Dizer o que falta; card não `bloqueado` e sem `[x]` → propor `tarefa/bloqueado`. Seguir só se o Dev mandar.
3. **Cadeia:** Grep literal `<arquivo-do-card>.md)` em `Dependências:` dos cards de `docs/backlog/modulos/*/tarefas/` pelos que dependem do card (direta ou indiretamente); listar. Também ficam `tarefa/bloqueado`; mudar só o que o Dev aprovar.

## Execução
4. Dependências ok → `tarefa/em-andamento` já ao iniciar (só a tag `tarefa/...`). Card com algum `[x]` nunca sai de `em-andamento`, só para `concluido`: sem voltar a `pendente`/`bloqueado`, nem propor isso.
5. Checklist na ordem, só itens/seções pedidos (sem recorte = card todo). Referência `1.b.2` ou "item b.2" = sub-item; "item b" = pai e todos os sub-itens. Sub-item isolado: ler o pai antes (pasta e contexto). Seguir os padrões do projeto em `docs/padroes/` (práticas, convenções e `modelos/` aplicáveis; Glob) e `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md`; pasta/arquivo novo: ler também `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/ORGANIZACAO.md` (simetria entre unidades e espelho em docs/backlog/testes). Sem padrão para o tipo do alvo: Glob dos arquivos desse tipo; <2 → seguir com o irmão (se houver), sem perguntar; ≥2 → perguntar uma vez por tipo: criar a regra agora (skill `criar-regra-telegrafica`, depois voltar ao card e usá-la) ou seguir com 1 irmão. Alvo fora do esqueleto (outra interface, retorno ou forma de endpoint) → perguntar ao Dev, não adaptar sozinho. Item com `(Critério N)`: manda o critério da especificação; conflito card × especificação → parar e perguntar. Nada fora do card. Bloco Documentação → skill `documentar` (ela marca o item e fecha o card).
6. `[x]` só em item pedido, feito e conferido. Sub-item `[x]` conta como item marcado (passo 4); pai só vira `[x]` com todos os filhos `[x]`. Edit na linha inteira do item (letras repetem entre blocos).
7. **Build obrigatório:** comando do `CLAUDE.md` do projeto; sem ele, perguntar ao Dev o comando. Zero erros; erro → corrigir dentro do card e rebuildar; build falho → sem `[x]` nem `concluido`. Sem como compilar → dizer.
8. Todos `[x]` → `tarefa/concluido`; parcial → `tarefa/em-andamento`; impedimento → `tarefa/bloqueado` só se nenhum `[x]` (com `[x]`, segue `em-andamento` e o impedimento vai na resposta).
9. **Dependentes (só ao concluir):** Grep literal `<arquivo-do-card>.md)` em `Dependências:` dos cards de `docs/backlog/modulos/*/tarefas/`. Em cada dependente, remover só o link deste card (Edit na linha; sobrou vazia → apagar a linha). Dependente `tarefa/bloqueado` sem mais nenhum card em `Dependências` e sem `Especificação` fora de `aprovada`/`implementada` → `tarefa/pendente` (Edit só nessa tag, linha 2); resta dep → segue bloqueado. Índice `<modulo>.md` com status → atualizar igual. Nada além de dependência, tag e status.
10. **Consistência (só avisar, nunca corrigir):** entre os dependentes do passo 9, card com dependência restante e fora de `tarefa/bloqueado` → listar.
11. **Especificação (só ao concluir):** Grep literal do nome do arquivo da especificação em `docs/backlog/modulos/*/tarefas/`; todo card que a cita `tarefa/concluido` ou `tarefa/cancelado`, ao menos um `concluido` → tag `especificacao/implementada` na especificação (só essa tag).

## Resposta
Feito, pendente, tag final, dependências removidas, cards desbloqueados, especificação marcada, avisos de consistência.
