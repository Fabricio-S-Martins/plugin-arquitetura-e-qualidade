# DECISOES

Decisão = registro de decisão de arquitetura. Opcional: só em projeto que adotou (existe a área de decisões, com índice de tag `decisao`; Grep `tags:.*decisao` em `docs/`, nomes do projeto). Projeto sem decisões → não propor. O molde é do plugin (abaixo): não vai para `docs/padroes/`, que guarda só o exclusivo do projeto.
- **Entra:** escolha estrutural difícil de reverter (tecnologia, framework, fronteira entre unidades, proibição). Escolha local de uma tarefa → linha `**Decisão:**` no arquivo da tarefa; regra de negócio → especificação; desvio pontual aceito → `EXCECOES-ACEITAS.md`.
- **Nasce só com aceite do Dev.** `planejar` propõe em texto (marcada `decisão proposta`); `executar-tarefa` oferece como destino das decisões da Retomada; a triagem de `PONTOS-EM-ABERTO.md` também.
- **Lugar:** área de decisões (ex.: `docs/decisoes/`), dentro da unidade como em `ORGANIZACAO.md`; transversal = unidade própria. Índice da área: `INDICE.md`.
- **Tags:** `TAGS.md` (grupo, `modulo/<m>`, estado).
- **Leitura (camada 2):** quem toca a unidade faz Grep `tags:.*decisao/aceita` + `modulo/<m>` e lê. Decisão aceita manda; conflito com plano ou tarefa → parar e perguntar. Nunca bloqueia tarefa nem entra em `Dependências`.
- **Imutável:** decisão mudou → decisão nova (`aceita`); a antiga recebe só a tag `decisao/substituida` e a linha `Substituída por`. Texto original intacto.

## Modelo (decisão já existente no projeto → seguir a irmã)
```
---
tags: [decisao, modulo/<m>, decisao/proposta]
---
# <decisão em poucas palavras>

- **Decisão e porquê:** <o que foi escolhido e o motivo, 1-3 linhas>
- **Descartado:** <opção> — <motivo>
- **Não fazer:** <o que esta decisão proíbe>
- **Substituída por:** [<decisão>](<caminho>) (só se substituída; senão apagar a linha)
```
