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
Minúsculas, sem acento, hífen; idioma do projeto (ex.: pt-br).
- **Grupo** (exatamente 1 por nota): `tarefas`, `plano`, `documentacao`, `especificacao`, `decisao`, `ponto-em-aberto`, `excecao-aceita` ou `padrao` (exemplos; vale o nome que o projeto já usa, `QUALIDADE.md`). O nome do grupo é o do assunto, o mesmo do arquivo e da instrução (linguagem do projeto): nunca uma sigla ou sinônimo diferente.
- **Estado** (só tarefa, especificação, decisão e plano; exatamente 1): `tarefa/<valor>`, `especificacao/<valor>`, `decisao/<valor>` ou `plano/<valor>`, cada um na sua nota. Dizem o tipo e o estado.
- **Assunto:** `modulo/<m>`, `camada/<c>`, `fluxo/<f>`.

| Nota | Tags |
|---|---|
| Geral | grupo |
| Módulo (tarefas, doc, planos, decisões) | grupo + `modulo/<m>` |
| Tarefa | `tarefas` + ≥1 `modulo/` + `fluxo/` e `camada/` herdados + `tarefa/<valor>` |
| Plano (`PLANO.md`) | `plano` + ≥1 `modulo/` + `fluxo/` quando houver + `plano/<valor>` |
| Doc de fluxo | `documentacao` + ≥1 `modulo/` + ≥1 `fluxo/` |
| Especificação de módulo | `especificacao` + ≥1 `modulo/` + `especificacao/<valor>` |
| Especificação de fluxo | `especificacao` + ≥1 `modulo/` + ≥1 `fluxo/` + `especificacao/<valor>` |
| Doc de camada (API, domínio, aplicação, infra; inclui técnico por projeto) | `documentacao` + ≥1 `modulo/` + ≥1 `camada/` |
| Decisão (`DECISOES.md`) | `decisao` + ≥1 `modulo/` + `decisao/<valor>` |
| Pontos em aberto (`PONTOS-EM-ABERTO.md`; arquivo único, sem estado) | `ponto-em-aberto` |
| Exceções aceitas (`EXCECOES-ACEITAS.md`; arquivo único, sem estado) | `excecao-aceita` |
| Padrão (índice da área ou do grupo, regra, modelo de tipo) | `padrao`; modelo de tipo de uma camada: + `camada/<c>` (nome já em uso; senão propor) |

- Nota do módulo = a que não tem `camada/`, `fluxo/` nem estado.
- Tarefa herda `modulo/`, `fluxo/` e `camada/` dos docs do bloco Documentação; sem doc dessa camada, sem `camada/`. `fluxo/` = nome do fluxo; `camada/` = nome da camada (a API é `camada/api`).

## Vocabulário
Sem arquivo de lista: tag de assunto = nome já em uso (Grep `modulo/`, `camada/` ou `fluxo/` em `docs/`, só as tags) ou que existe no projeto (módulo com nota própria; fluxo ou camada com doc).
- Sem correspondente (ex. fluxo ainda não documentado, camada nova) → propor ao Dev (nome + 1 linha); usar só se aprovar. Nunca inventar.

## Estado da tarefa
Exatamente 1 tag `tarefa/<valor>` por nota; trocar = substituir só esse item da lista, preservando as demais. Valores fechados (conjunto e significado; o nome da tag é o do projeto); outro valor → não gravar:
- `pendente`: nenhum item `[x]` e nada a prende; ao criar, salvo motivo de `bloqueado`.
- `em-andamento`: algum item `[x]` e ninguém executando.
- `em-execucao`: uma sessão executando agora (`executar-tarefa` grava ao começar). Ao parar sem concluir, volta pelo checklist (algum `[x]` → `em-andamento`, nenhum → `pendente`): `executar-tarefa` no fim da execução; `gerir-contexto` ao gravar a `Retomada` de execução interrompida.
- `em-validacao`: todos os itens `[x]` e build sem erro; aguarda o "aprovado" do Dev.
- `concluido`: só com o "aprovado" explícito do Dev; nunca reabre (defeito depois = tarefa nova).
- `bloqueado`: nenhum item `[x]` e tarefa em `Dependências` fora de `concluido`, `Especificação` fora de `aprovada`/`implementada` ou impedimento externo (build falho não é; do plano ou da execução: linha `**Bloqueio:** <o que destrava>` em `O que fazer`; só o Dev libera, e a linha sai).

Sem estado de cancelada: tarefa que não será feita só se apaga em caso extremo, com aceite do Dev, junto com a linha do índice, o link em `Dependências` das outras e a linha no plano. O nome do arquivo da tarefa não muda (links dependem dele).

## Estado da decisão
Mesma regra (1 tag `decisao/<valor>`). Valores fechados: `aceita` (ao criar; só com aceite explícito do Dev), `substituida` (só quando uma decisão nova `aceita` a substitui).

## Estado da especificação
Skill `criar-especificacao`. Mesma regra (1 tag `especificacao/<valor>`). Valores fechados: `rascunho` (ao criar ou alterar), `aprovada` (só com aprovação explícita do Dev; ou de volta de `implementada` quando tarefa nova a cita, `criar-tarefa`), `implementada` (só especificação de fluxo; `executar-tarefa`, quando toda tarefa que a cita está `concluido`), `obsoleta` (só se o Dev disser, de qualquer estado; linha de motivo abaixo do título, `criar-especificacao`).

## Estado do plano
Mesma regra (1 tag `plano/<valor>`). Valores fechados: `vigente` (ao criar), `obsoleto` (só se o Dev disser; linha de motivo abaixo do título, `PLANO.md`).