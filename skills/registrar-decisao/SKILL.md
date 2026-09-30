---
name: registrar-decisao
description: Registra uma decisão de arquitetura em aberto (A ou B), uma sugestão distante ou a escolha feita, em docs/backlog/decisoes/, e apaga a decisão quando ela vira card ou é descartada. Usar ao pedir para registrar/decidir/adiar/descartar uma decisão, ou quando uma tarefa depende de uma escolha ainda não feita.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(rm docs/backlog/decisoes/*)
---

# registrar-decisao

Não alterar código nem commitar. Decisão não é card: não tem checklist. Só fatos: opção não confirmada → perguntar, nunca inventar. Ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md` (plugin).

## Criar
Pedido do Dev, ou sugestão distante/escolha pendente que o Claude identifica (oferecer; criar só se o Dev aceitar).
1. Criar `docs/backlog/decisoes/<nome>.md` a partir de `TEMPLATE-DECISAO.md` (esta pasta), sem alterar a estrutura. `<nome>` em pt-br, minúsculas, hífen, sem número.
2. Status: `aberta` (há escolha a fazer) ou `adiada` (sugestão distante; `Contexto` diz a condição que a reabre).
3. `tags`: `tipo/decisao` + ≥1 `modulo/` (obrigatório; não dito → perguntar) + `fluxo/` se houver; só nomes que existem (TAGS.md), novo → propor ao Dev.
4. Para cada tag `modulo/x`: somar link relativo + título na seção `Decisões` do índice `docs/backlog/modulos/<x>/<x>.md` (criar a seção se faltar; índice ausente → avisar, não criar). Só `fluxo/` → sem link em módulo.

## Decidir ou adiar
- **Decidida:** Dev informa a escolha → preencher `Decisão` (escolha + motivo), `status: decidida`. Grep `decisoes/<nome>` em `docs/backlog/` e avisar quais cards ela bloqueava; nunca mudar o status deles sem pedido.
- **Adiada:** registrar em `Contexto` a condição que reabre.

## Apagar (vira card ou descartada)
Decisão que vai virar trabalho (`planejar`/`criar-card` ou pedido do Dev) ou é descartada: não há status `descartada`, apaga-se. Listar ao Dev o que será feito e esperar o ok: arquivo, link no índice do módulo e cards que citam `decisoes/<nome>` (Grep em `docs/backlog/`). Com o ok:
1. Card que nasce da decisão ou a citava: garantir em `O que fazer` a linha `**Decisão:** <escolha + motivo>` (vinda de `Decisão`; vazia → perguntar) e tirar `decisoes/<nome>` do Deps. Status do card só muda (ex. `bloqueado` → `pendente`) se o Dev confirmar. Descartada citada em Deps → perguntar o que fazer com o card.
2. Tirar o link da seção `Decisões` do índice de cada módulo (seção vazia → remover).
3. Apagar o arquivo (`rm`).

## Regras
- Card → decisão, nunca o contrário: a decisão não cita ID nem link de card (só o índice do módulo linka a decisão); `O que depende` descreve em texto.
- Nunca apagar decisão sem o ok do Dev nem antes de a escolha estar no card.
- Nomes 100% pt-br, inclusive o arquivo.
- Decisão existente que o Dev quer ver antes de aplicar → `previa-diff`.
