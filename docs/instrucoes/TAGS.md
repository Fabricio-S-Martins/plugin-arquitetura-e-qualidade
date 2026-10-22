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
- **Grupo** (exatamente 1 por nota): `backlog`, `documentacao`, `especificacao` ou `padrao` (exemplos; vale o nome que o projeto já usa, `QUALIDADE.md`).
- **Estado** (só card e especificação; exatamente 1): `tarefa/<valor>` no card, `especificacao/<valor>` na especificação. Dizem o tipo e o estado.
- **Assunto:** `modulo/<m>`, `camada/<c>`, `fluxo/<f>`.

| Nota | Tags |
|---|---|
| Geral | grupo |
| Módulo (backlog e doc) | grupo + `modulo/<m>` |
| Card | `backlog` + ≥1 `modulo/` + `fluxo/` e `camada/` herdados + `tarefa/<valor>` |
| Doc de fluxo | `documentacao` + ≥1 `modulo/` + ≥1 `fluxo/` |
| Especificação de módulo | `especificacao` + ≥1 `modulo/` + `especificacao/<valor>` |
| Especificação de fluxo | `especificacao` + ≥1 `modulo/` + ≥1 `fluxo/` + `especificacao/<valor>` |
| Doc de camada (API, domínio, aplicação, infra; inclui técnico por projeto) | `documentacao` + ≥1 `modulo/` + ≥1 `camada/` |
| Padrão (índice da área ou do grupo, regra, modelo de tipo) | `padrao`; modelo de tipo de uma camada: + `camada/<c>` (nome já em uso; senão propor) |

- Nota do módulo = a que não tem `camada/` nem `fluxo/` (nem estado, exceto na especificação). Geral, módulo, fluxo e camada da documentação e do backlog não levam estado; a especificação (de módulo ou fluxo) leva. Padrões não levam estado.
- Card herda `modulo/`, `fluxo/` e `camada/` dos docs do bloco Documentação; sem doc dessa camada, sem `camada/`. `fluxo/` = nome do fluxo; `camada/` = nome da camada (a API é `camada/api`).

## Vocabulário
Sem arquivo de lista: tag de assunto = nome já em uso (Grep `modulo/`, `camada/` ou `fluxo/` em `docs/`, só as tags) ou que existe no projeto (módulo com nota própria; fluxo ou camada com doc).
- Sem correspondente (ex. fluxo ainda não documentado, camada nova) → propor ao Dev (nome + 1 linha); usar só se aprovar. Nunca inventar.

## Estado do card
Exatamente 1 tag `tarefa/<valor>` por nota; trocar = substituir só esse item da lista, preservando as demais. Valores fechados (conjunto e significado; o nome da tag é o do projeto): `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`. Outro valor → não gravar.
Card com `Especificação` fora de `aprovada`/`implementada` → `tarefa/bloqueado`.

## Estado da especificação
Skill `especificar`. Mesma regra (1 tag `especificacao/<valor>`). Valores fechados: `rascunho` (ao criar ou alterar), `aprovada` (só com aprovação explícita do Dev), `implementada` (só especificação de fluxo; `executar-tarefa`, quando todo card que a cita está `concluido` ou `cancelado` e ao menos um `concluido`), `obsoleta` (só se o Dev disser).