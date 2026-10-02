# Tags e status

Liga docs e cards por busca (`Grep "tags:.*status/pendente"`), sem link entre eles. Doc nunca cita task; card nunca linka doc por causa da tag.

## Formato
Frontmatter no topo do arquivo, tags em 1 linha (Grep acha sem abrir o arquivo):
```yaml
---
tags: [backlog, modulo/entregas, fluxo/checkout, status/pendente]
---
```
- Tags: tipo (`backlog` ou `documentacao`), `modulo/`, `fluxo/`, `status/` (tarefa e decisão). Minúsculas, pt-br, sem acento, hífen.
- Toda nota leva exatamente 1 tag de tipo. O resto só onde o caminho não diz:

| Nota | Caminho | Tags |
|---|---|---|
| Geral, módulo (backlog e doc, inclui técnico por projeto) | `docs/<grupo>/<grupo>.md`, `docs/<grupo>/modulos/<m>/<m>.md` | só o tipo |
| Tarefa | `docs/backlog/modulos/<m>/tarefas/` | tipo + ≥1 `modulo/` + `fluxo/` do bloco Documentação + `status/` |
| Decisão | `docs/backlog/modulos/<m>/decisoes/` | tipo + ≥1 `modulo/` (obrigatório) + `fluxo/` se houver + `status/` |
| API, fluxo (doc) | `docs/documentacao/modulos/<m>/api/`, `.../fluxos/` | tipo + ≥1 `modulo/` (inclui os outros módulos que o fluxo toca) |

- O tipo é fixo no plugin; não pede aprovação. A skill que cria a nota grava a tag. Não há tag por subtipo: Glob na pasta (`tarefas/`, `decisoes/`, `fluxos/`, `api/`).
- Nota de doc nunca leva `fluxo/`: o nome do arquivo em `fluxos/` já é o fluxo.

## Vocabulário
Sem arquivo de lista: tag de assunto = nome que existe (Glob 1 nível). `modulo/x` → pasta em `docs/documentacao/modulos/` ou `docs/backlog/modulos/`; `fluxo/y` → arquivo em `docs/documentacao/modulos/*/fluxos/`.
- Sem correspondente (ex. fluxo ainda não documentado) → propor ao Dev (nome + 1 linha); usar só se aprovar. Nunca inventar.
- Card herda `modulo/` e `fluxo/` dos docs do bloco Documentação (`fluxo/` = nome do arquivo do fluxo).

## Status (card)
Exatamente 1 tag `status/<valor>` por nota; trocar = substituir só esse item da lista, preservando as demais. Valores fechados: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`. Outro valor → não gravar.
Card com Deps em `<modulo>/decisoes/<nome>` `status/aberta` ou `status/adiada` → `status/bloqueado`.

## Status (decisão)
Em `docs/backlog/modulos/<modulo>/decisoes/<nome>.md` (skill `registrar-decisao`). Mesma regra (1 tag `status/<valor>`). Valores fechados: `aberta`, `decidida` (intervalo até virar card), `adiada`. Vira card ou é descartada → apagada (skill `registrar-decisao`). Decisão nunca cita card.
