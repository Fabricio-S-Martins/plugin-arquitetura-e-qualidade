# DECISOES (ADR)

ADR = registro de decisão de arquitetura. Opcional: só em projeto que adotou (existe o modelo `adr` em `docs/padroes/modelos/`; Glob/Grep, nomes do projeto). Projeto sem ADR → não propor.
- **Entra:** escolha estrutural difícil de reverter (tecnologia, framework, fronteira entre unidades, proibição). Escolha local de um card → linha `**Decisão:**` no card; regra de negócio → especificação.
- **Nasce só com aceite do Dev.** `planejar` propõe em texto (decisão marcada como `ADR proposto`); `executar-tarefa` oferece como destino das decisões da Retomada.
- **Lugar:** área de decisões (ex.: `docs/decisoes/`), dentro da unidade como em `ORGANIZACAO.md`; transversal = unidade própria. Índice da área: `INDICE.md`.
- **Tags:** `TAGS.md` (grupo, `modulo/<m>`, estado).
- **Leitura (camada 2):** quem toca a unidade faz Grep `tags:.*adr/aceita` + `modulo/<m>` e lê. ADR aceito manda; conflito com plano ou card → parar e perguntar. Nunca bloqueia card nem entra em `Dependências`.
- **Imutável:** decisão mudou → ADR novo (`aceita`); o antigo recebe só a tag `adr/substituida` e a linha `Substituída por`. Texto original intacto.

## Modelo (exemplo; vale o do projeto)
```
---
tags: [adr, modulo/<m>, adr/proposta]
---
# <decisão em poucas palavras>

- **Decisão e porquê:** <o que foi escolhido e o motivo, 1-3 linhas>
- **Descartado:** <opção> — <motivo>
- **Não fazer:** <o que esta decisão proíbe>
- **Substituída por:** [<ADR>](<caminho>) (só se substituída; senão apagar a linha)
```
