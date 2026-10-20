## Módulo — `<módulo>.md`
```
---
tags: [especificacao, modulo/<nome>, especificacao/rascunho]
---
# <Módulo>: regras de negócio

**Para que existe:** <1-2 linhas>

## Termos
| Termo | Significado |
|---|---|
| <termo do negócio> | <o que é, em uma frase> |

## Regras
- **<Nome que diz a regra>:** <o que vale, em uma frase>

## Fora do escopo
- <o que este módulo não resolve>
```
Sem termo do negócio a explicar → remover `Termos`. Sem item → remover `Fora do escopo`.

## Fluxo — `fluxos/<módulo>-<fluxo>.md`
```
---
tags: [especificacao, modulo/<nome>, fluxo/<nome>, especificacao/rascunho]
---
# <Fluxo>

[<Módulo>](../<módulo>.md)

**Objetivo:** <1 linha>

## Regras
- **<Nome que diz a regra>:** <o que vale, em uma frase>

## Critérios de aceite
| Critério | Quando | Então |
|:-:|---|---|
| Critério 1: <nome curto> | <situação> | <resultado observável> |

## Fora do escopo
- <o que este fluxo não faz>
```
Exemplo concreto de uma regra complexa → 1 linha em itálico abaixo dela. Sem item → remover `Fora do escopo`.
