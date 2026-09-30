# Tags e status

Liga docs e cards por busca (`Grep "tags:.*status/pendente"`), sem link entre eles. Doc nunca cita task; card nunca linka doc por causa da tag.

## Formato
Frontmatter no topo do arquivo, tags em 1 linha (Grep acha sem abrir o arquivo):
```yaml
---
tags: [backlog/tarefa, modulo/entregas, fluxo/checkout, status/pendente]
---
```
- Prefixos: tipo da nota (`backlog/` ou `documentacao/`, ver abaixo), `modulo/`, `fluxo/`, `status/` (tarefa e decisão). Minúsculas, pt-br, sem acento, hífen.
- Toda nota leva exatamente 1 tag de tipo. Tarefa, decisão e doc levam também ≥1 `modulo/` ou `fluxo/`; decisão, obrigatoriamente ≥1 `modulo/`.

## Tipo
Fixas no plugin; não pedem aprovação. A skill que cria a nota grava a tag. O prefixo é o nome da pasta do grupo.

| Grupo | Nota | Tag | Caminho |
|---|---|---|---|
| backlog | Geral | `backlog/geral` | `docs/backlog/backlog.md` |
| | Módulo | `backlog/modulo` | `docs/backlog/modulos/<m>/<m>.md` |
| | Tarefa | `backlog/tarefa` | `docs/backlog/modulos/<m>/tarefas/` |
| | Decisão | `backlog/decisao` | `docs/backlog/modulos/<m>/decisoes/` |
| documentacao | Geral | `documentacao/geral` | `docs/documentacao/documentacao.md` |
| | Módulo | `documentacao/modulo` | `docs/documentacao/modulos/<m>/<m>.md` (inclui técnico por projeto) |
| | API | `documentacao/api` | `docs/documentacao/modulos/<m>/api/` |
| | Fluxo | `documentacao/fluxo` | `docs/documentacao/modulos/<m>/fluxos/` |

- Nota do módulo (backlog e documentação) leva também `modulo/<m>`; nota geral leva só a tag de tipo. Nenhuma das três leva `status/`.

## Vocabulário
Sem arquivo de lista: tag de assunto = nome que existe (Glob 1 nível). `modulo/x` → pasta em `docs/documentacao/modulos/` ou `docs/backlog/modulos/`; `fluxo/y` → arquivo em `docs/documentacao/modulos/*/fluxos/`.
- Sem correspondente (ex. fluxo ainda não documentado) → propor ao Dev (nome + 1 linha); usar só se aprovar. Nunca inventar.
- Card herda `modulo/` e `fluxo/` dos docs do bloco Documentação.

## Status (card)
Exatamente 1 tag `status/<valor>` por nota; trocar = substituir só esse item da lista, preservando as demais. Valores fechados: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`. Outro valor → não gravar.
Card com Deps em `<modulo>/decisoes/<nome>` `status/aberta` ou `status/adiada` → `status/bloqueado`.

## Status (decisão)
Em `docs/backlog/modulos/<modulo>/decisoes/<nome>.md` (skill `registrar-decisao`). Mesma regra (1 tag `status/<valor>`). Valores fechados: `aberta`, `decidida` (intervalo até virar card), `adiada`. Vira card ou é descartada → apagada (skill `registrar-decisao`). Decisão nunca cita card.
