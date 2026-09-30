---
name: registrar-decisao
description: Registra uma decisão de arquitetura em aberto (A ou B), uma sugestão distante ou a escolha feita, em docs/backlog/decisoes/. Usar ao pedir para registrar/decidir/adiar uma decisão, ou quando uma tarefa depende de uma escolha ainda não feita.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# registrar-decisao

Não alterar código nem commitar. Decisão não é card: não tem checklist. Só fatos: opção não confirmada → perguntar, nunca inventar. Ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md` (plugin).

## Criar
Pedido do Dev, ou sugestão distante/escolha pendente que o Claude identifica (oferecer; criar só se o Dev aceitar).
1. Criar `docs/backlog/decisoes/<nome>.md` a partir de `TEMPLATE-DECISAO.md` (esta pasta), sem alterar a estrutura. `<nome>` em pt-br, minúsculas, hífen, sem número.
2. Status: `aberta` (há escolha a fazer) ou `adiada` (sugestão distante; `Contexto` diz a condição que a reabre).
3. `tags`: `tipo/decisao` + `modulo/`/`fluxo/` só de `docs/tags.md`; tag nova → propor ao Dev.
4. Somar a linha (link relativo + título, sem tags/status) em `docs/backlog/decisoes/decisoes.md`; ausente → criar (com `tags: [tipo/decisao]`) e linkar no `docs/backlog/backlog.md`.
5. Para cada tag `modulo/x`: somar link relativo + título na seção `Decisões` do índice `docs/backlog/modulos/<x>/<x>.md` (criar a seção se faltar; índice ausente → avisar, não criar). Só `fluxo/` → sem link em módulo.

## Decidir, adiar ou descartar
- **Decidida:** Dev informa a escolha → preencher `Decisão` (escolha + motivo), `status: decidida`. Grep `decisoes/<nome>` em `docs/backlog/` e avisar quais cards ela bloqueava; nunca mudar o status deles sem pedido.
- **Adiada:** registrar em `Contexto` a condição que reabre. **Descartada:** registrar o motivo em `Decisão`.

## Regras
- Card → decisão, nunca o contrário: a decisão não cita ID nem link de card (só o índice do módulo linka a decisão); `O que depende` descreve em texto.
- Nomes 100% pt-br, inclusive o arquivo.
- Decisão existente que o Dev quer ver antes de aplicar → `previa-diff`.
