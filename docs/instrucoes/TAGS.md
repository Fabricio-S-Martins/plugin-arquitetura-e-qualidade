# Tags e status

Liga docs e cards por busca, sem link entre eles. Doc nunca cita task; card nunca linka doc por causa da tag.

## Formato
Frontmatter no topo do arquivo, tags em 1 linha (Grep acha sem abrir o arquivo):
```yaml
---
tags: [tipo/task, modulo/entregas, fluxo/checkout]
status: pendente
---
```
- `status` só em card e decisão. Doc: só `tags`.
- Prefixos: `tipo/` (obrigatória, ver abaixo), `modulo/` (nome da pasta em `docs/modulos`), `fluxo/` (nome do arquivo em `docs/fluxos`). Minúsculas, pt-br, sem acento, hífen.
- Toda nota leva exatamente 1 tag `tipo/`. Notas de assunto (card, doc, decisão) levam também ≥1 `modulo/` ou `fluxo/`; decisão, obrigatoriamente ≥1 `modulo/`.

## Tipo (cor no grafo do Obsidian)
Fixas no plugin; não pedem aprovação. A skill que cria a nota grava a tag.

| Grupo | Tipo | Tag | Nota |
|---|---|---|---|
| Backlog | Task | `tipo/task` | card em `docs/backlog/modulos/<modulo>/` |
| | Decisão | `tipo/decisao` | `docs/backlog/decisoes/` |
| | Backlog | `tipo/backlog` | `docs/backlog/backlog.md` |
| | Módulo | `tipo/modulo` | índice `<modulo>/<modulo>.md` |
| Documentação | API | `tipo/api` | `docs/modulos/<nome>/api/` |
| | Fluxo | `tipo/fluxo` | `docs/fluxos/` |
| | Módulo | `tipo/modulo` | `docs/modulos/<nome>/` (inclui técnico por projeto) |
| | README | `tipo/readme` | `docs/README.md` |

Sem tag de grupo: módulo do backlog e da documentação compartilham `tipo/modulo`; o grafo os separa pelo caminho (`backlog/`), cada um com a cor do seu grupo.
Índices e README levam só `tipo/` (sem `modulo/`/`fluxo/`, sem `status`).

## Vocabulário
Sem arquivo de lista: tag de assunto = nome que existe (Glob 1 nível). `modulo/x` → pasta em `docs/modulos/` ou `docs/backlog/modulos/`; `fluxo/y` → arquivo em `docs/fluxos/`.
- Sem correspondente (ex. fluxo ainda não documentado) → propor ao Dev (nome + 1 linha); usar só se aprovar. Nunca inventar.
- Card herda `modulo/` e `fluxo/` dos docs do bloco Documentação.

## Status (card)
Valores fechados: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`. Outro valor → não gravar.
Card com Deps em `decisoes/<nome>` `aberta` ou `adiada` → `bloqueado`.
Índice da pasta e `backlog.md` não levam status.

## Status (decisão)
Em `docs/backlog/decisoes/<nome>.md` (skill `registrar-decisao`). Valores fechados: `aberta`, `decidida` (intervalo até virar card), `adiada`. Vira card ou é descartada → apagada (skill `registrar-decisao`). Decisão nunca cita card.
