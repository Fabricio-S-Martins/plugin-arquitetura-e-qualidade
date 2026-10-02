---
name: registrar-decisao
description: Registra decisão de arquitetura em aberto (A ou B), sugestão distante ou escolha feita em docs/backlog/modulos/<modulo>/decisoes/, e a apaga ao virar card. Usar ao registrar/decidir/adiar/descartar decisão, ou quando uma tarefa depende de escolha ainda não feita.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(rm docs/backlog/modulos/*/decisoes/*)
---

# registrar-decisao

Não alterar código. Decisão não é card: não tem checklist. Só fatos: opção não confirmada → perguntar, nunca inventar. Ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md` (plugin).

## Criar
Pedido do Dev, ou sugestão distante/escolha pendente que o Claude identifica (oferecer; criar só se o Dev aceitar).
1. Criar `docs/backlog/modulos/<modulo>/decisoes/<nome>.md` (módulo principal = 1º `modulo/` da lista; decisão com 2+ módulos fica só na pasta do principal) a partir de `TEMPLATE-DECISAO.md` (esta pasta), sem alterar a estrutura. `<nome>` em pt-br, minúsculas, hífen, sem número.
2. Tag de status: `status/aberta` (há escolha a fazer) ou `status/adiada` (sugestão distante; `Contexto` diz a condição que a reabre).
3. `tags`: `backlog/decisao` + ≥1 `modulo/` (obrigatório; não dito → perguntar) + `fluxo/` se houver; só nomes que existem (TAGS.md), novo → propor ao Dev.
4. Links na seção `Decisões` (criar se faltar; índice ausente → avisar, não criar; índice sem `backlog/modulo` e `modulo/<m>` → sinalizar, não corrigir): índice do módulo principal → `decisoes/<nome>.md`; índice de cada outro módulo → `../<principal>/decisoes/<nome>.md` (link relativo + título).

## Decidir ou adiar
- **Decidida:** Dev informa a escolha → preencher `Decisão` (escolha + motivo), tag `status/decidida` (trocar só a tag de status). Grep `decisoes/<nome>` em `docs/backlog/` e avisar quais cards ela bloqueava; nunca mudar o status deles sem pedido.
- **Adiada:** registrar em `Contexto` a condição que reabre.

## Apagar (vira card ou descartada)
Decisão que vai virar trabalho (`planejar`/`criar-card` ou pedido do Dev) ou é descartada → ler `APAGAR.md` (esta pasta).

## Regras
- Card → decisão, nunca o contrário: a decisão não cita ID nem link de card (só o índice do módulo linka a decisão); `O que depende` descreve em texto.
- Nunca apagar decisão sem o ok do Dev nem antes de a escolha estar no card.
- Decisão existente que o Dev quer ver antes de aplicar → `previa-diff`.
