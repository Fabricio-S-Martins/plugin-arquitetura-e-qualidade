---
name: executar-tarefa
description: Executa card de tarefa do backlog (ou itens do checklist), conferindo antes as dependências. Usar ao pedir para executar, implementar, fazer ou continuar card/task, ou item do checklist ("faz a seção 1 do card 02").
allowed-tools: Read, Write, Edit, Glob, Grep, Skill, Bash(dotnet build *)
---

# executar-tarefa

Card: `docs/backlog/modulos/<modulo>/tarefas/NN-*.md`. Ler inteiro. Tags: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`.

## Dependências (antes de qualquer código)
1. `Deps` do cabeçalho. Card citado (Read): tag `tarefa/concluido` e, via Glob/Grep, o que ele entrega existe no código (projeto, pasta, tipo). Dep `<modulo>/decisoes/<nome>` com `decisao/aberta` ou `decisao/adiada` = pendente.
2. Dep pendente → parar, nada implementado. Dizer o que falta; card não `bloqueado` → propor `tarefa/bloqueado`. Seguir só se o Dev mandar.
3. **Cadeia:** Grep `Deps` nos cards do módulo pelos que dependem do card (direta ou indiretamente); listar. Também ficam `tarefa/bloqueado`; mudar só o que o Dev aprovar.

## Execução
4. Deps ok → `tarefa/em-andamento` (só a tag `tarefa/...`).
5. Checklist na ordem, só itens/seções pedidos (sem recorte = card todo). Seguir `docs/padroes/` aplicáveis (Glob); alvo fora do esqueleto (outra interface, retorno ou forma de endpoint) → perguntar ao Dev, não adaptar sozinho. Nada fora do card. Bloco Documentação → skill `documentar` (ela marca o item e fecha o card).
6. `[x]` só em item pedido, feito e conferido. Edit na linha inteira do item (letras repetem entre blocos).
7. **Build obrigatório:** comando do `CLAUDE.md` do projeto; sem ele, `dotnet build` na `.sln` (ou `.csproj` do módulo) achada por Glob. Zero erros; erro → corrigir dentro do card e rebuildar; build falho → sem `[x]` nem `concluido`. Sem como compilar → dizer.
8. Todos `[x]` → `tarefa/concluido`; parcial → `tarefa/em-andamento`; impedimento → `tarefa/bloqueado`.

## Resposta
Feito, pendente, tag final.
