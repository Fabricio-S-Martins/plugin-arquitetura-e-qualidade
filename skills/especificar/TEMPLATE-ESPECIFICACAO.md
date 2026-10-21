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

## Aguardando Validações
- Validação 1: <pergunta de regra de negócio sem resposta>? Hoje: <o que acontece hoje>.
```
Sem termo do negócio a explicar → remover `Termos`. Sem item → remover `Fora do escopo`. Sem validação pendente → remover `Aguardando Validações`.

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

## Aguardando Validações
- Validação 1: <pergunta de regra de negócio sem resposta>? Hoje: <o que acontece hoje>.
```
Exemplo concreto de uma regra complexa → 1 linha em itálico abaixo dela. Sem item → remover `Fora do escopo`. Sem validação pendente → remover `Aguardando Validações`.

## Visão geral — `<nome da pasta>.md`
```
---
tags: [especificacao]
---
# Especificações

## Módulos
- [<Módulo>](modulos/<módulo>/<módulo>.md): <1 linha>
```
Só aponta; fluxo só pelo link do módulo. Sem estado.
