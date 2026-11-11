# Tags

Liga docs e tarefas por busca (`Grep "tags:.*tarefa/pendente"`), sem link entre eles. Doc nunca cita tarefa; tarefa nunca linka doc por causa da tag.

Tag independe da estrutura de pastas: toda nota leva todas as suas tags; nunca achar nota por caminho. Pasta movida ou unificada → busca por tag continua valendo.

## Formato
Frontmatter no topo do arquivo, tags em 1 linha (Grep acha sem abrir o arquivo):
```yaml
---
tags: [tarefas, modulo/entregas, fluxo/checkout, tarefa/pendente]
---
```
Minúsculas, pt-br, sem acento, hífen.
- **Grupo** (exatamente 1 por nota): `tarefas`, `documentacao`, `especificacao`, `decisao`, `ponto-em-aberto`, `excecao-aceita` ou `padrao` (exemplos; vale o nome que o projeto já usa, `QUALIDADE.md`). O nome do grupo é o do assunto, o mesmo do arquivo e da instrução (linguagem do projeto): nunca uma sigla ou sinônimo diferente.
- **Estado** (só tarefa, especificação e decisão; exatamente 1): `tarefa/<valor>` na tarefa, `especificacao/<valor>` na especificação, `decisao/<valor>` na decisão. Dizem o tipo e o estado.
- **Assunto:** `modulo/<m>`, `camada/<c>`, `fluxo/<f>`.

| Nota | Tags |
|---|---|
| Geral | grupo |
| Módulo (tarefas e doc) | grupo + `modulo/<m>` |
| Tarefa | `tarefas` + ≥1 `modulo/` + `fluxo/` e `camada/` herdados + `tarefa/<valor>` |
| Doc de fluxo | `documentacao` + ≥1 `modulo/` + ≥1 `fluxo/` |
| Especificação de módulo | `especificacao` + ≥1 `modulo/` + `especificacao/<valor>` |
| Especificação de fluxo | `especificacao` + ≥1 `modulo/` + ≥1 `fluxo/` + `especificacao/<valor>` |
| Doc de camada (API, domínio, aplicação, infra; inclui técnico por projeto) | `documentacao` + ≥1 `modulo/` + ≥1 `camada/` |
| Decisão (`DECISOES.md`) | `decisao` + ≥1 `modulo/` + `decisao/<valor>` |
| Pontos em aberto (`PONTOS-EM-ABERTO.md`; arquivo único, sem estado) | `ponto-em-aberto` |
| Exceções aceitas (`EXCECOES-ACEITAS.md`; arquivo único, sem estado) | `excecao-aceita` |
| Padrão (índice da área ou do grupo, regra, modelo de tipo) | `padrao`; modelo de tipo de uma camada: + `camada/<c>` (nome já em uso; senão propor) |

- Nota do módulo = a que não tem `camada/` nem `fluxo/`.
- Tarefa herda `modulo/`, `fluxo/` e `camada/` dos docs do bloco Documentação; sem doc dessa camada, sem `camada/`. `fluxo/` = nome do fluxo; `camada/` = nome da camada (a API é `camada/api`).

## Vocabulário
Sem arquivo de lista: tag de assunto = nome já em uso (Grep `modulo/`, `camada/` ou `fluxo/` em `docs/`, só as tags) ou que existe no projeto (módulo com nota própria; fluxo ou camada com doc).
- Sem correspondente (ex. fluxo ainda não documentado, camada nova) → propor ao Dev (nome + 1 linha); usar só se aprovar. Nunca inventar.

## Estado da tarefa
Exatamente 1 tag `tarefa/<valor>` por nota; trocar = substituir só esse item da lista, preservando as demais. Valores fechados (conjunto e significado; o nome da tag é o do projeto): `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`. Outro valor → não gravar.
Tarefa com `Especificação` fora de `aprovada`/`implementada` → `tarefa/bloqueado`.

## Estado da decisão
Mesma regra (1 tag `decisao/<valor>`). Valores fechados: `proposta` (ao criar), `aceita` (só com aceite explícito do Dev), `substituida` (só quando uma decisão nova `aceita` a substitui).

## Estado da especificação
Skill `especificar`. Mesma regra (1 tag `especificacao/<valor>`). Valores fechados: `rascunho` (ao criar ou alterar), `aprovada` (só com aprovação explícita do Dev), `implementada` (só especificação de fluxo; `executar-tarefa`, quando toda tarefa que a cita está `concluido` ou `cancelado` e ao menos um `concluido`), `obsoleta` (só se o Dev disser).