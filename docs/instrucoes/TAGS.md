# Tags

Liga docs e cards por busca (`Grep "tags:.*tarefa/pendente"`), sem link entre eles. Doc nunca cita task; card nunca linka doc por causa da tag.

Tag independe da estrutura de pastas: toda nota leva todas as suas tags; nunca achar nota por caminho. Pasta movida ou unificada → busca por tag continua valendo.

## Formato
Frontmatter no topo do arquivo, tags em 1 linha (Grep acha sem abrir o arquivo):
```yaml
---
tags: [backlog, modulo/entregas, fluxo/checkout, tarefa/pendente]
---
```
Minúsculas, pt-br, sem acento, hífen.
- **Grupo** (exatamente 1 por nota): `backlog` ou `documentacao`. Fixo no plugin; não pede aprovação.
- **Estado** (só card e decisão; exatamente 1): `tarefa/<valor>` no card, `decisao/<valor>` na decisão. Dizem o tipo e o estado.
- **Assunto:** `modulo/<m>`, `camada/<c>`, `fluxo/<f>`.

| Nota | Tags |
|---|---|
| Geral | grupo |
| Módulo (backlog e doc) | grupo + `modulo/<m>` |
| Card | `backlog` + ≥1 `modulo/` + `fluxo/` e `camada/` herdados + `tarefa/<valor>` |
| Decisão | `backlog` + ≥1 `modulo/` (obrigatório) + `fluxo/` se houver + `decisao/<valor>` |
| Doc de fluxo | `documentacao` + ≥1 `modulo/` + ≥1 `fluxo/` |
| Doc de camada (API, domínio, aplicação, infra; inclui técnico por projeto) | `documentacao` + ≥1 `modulo/` + ≥1 `camada/` |

- Nota do módulo = a que não tem `camada/`, `fluxo/` nem estado. Geral, módulo, fluxo e camada não levam estado.
- Card herda `modulo/`, `fluxo/` e `camada/` dos docs do bloco Documentação; sem doc dessa camada, sem `camada/`. `fluxo/` = nome do fluxo; `camada/` = nome da camada (a API é `camada/api`).

## Vocabulário
Sem arquivo de lista: tag de assunto = nome já em uso (Grep `modulo/`, `camada/` ou `fluxo/` em `docs/`, só as tags) ou que existe no projeto (módulo com nota própria; fluxo ou camada com doc).
- Sem correspondente (ex. fluxo ainda não documentado, camada nova) → propor ao Dev (nome + 1 linha); usar só se aprovar. Nunca inventar.

## Estado do card
Exatamente 1 tag `tarefa/<valor>` por nota; trocar = substituir só esse item da lista, preservando as demais. Valores fechados: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`. Outro valor → não gravar.
Card com Deps em `<modulo>/decisoes/<nome>` `decisao/aberta` ou `decisao/adiada` → `tarefa/bloqueado`.

## Estado da decisão
Skill `registrar-decisao`. Mesma regra (1 tag `decisao/<valor>`). Valores fechados: `aberta`, `decidida` (intervalo até virar card), `adiada`. Vira card ou é descartada → apagada (skill `registrar-decisao`). Decisão nunca cita card.
