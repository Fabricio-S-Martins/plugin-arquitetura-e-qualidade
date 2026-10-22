# Decisões de arquitetura (ADR): guia para Devs

ADR é o registro de uma escolha estrutural e do porquê dela. Serve para você (daqui a meses) e para a IA não reabrirem uma discussão já resolvida nem sugerirem uma alternativa que já foi descartada. A versão que o Claude lê é [../instrucoes/DECISOES.md](../instrucoes/DECISOES.md), telegráfica de propósito.

É opcional. O plugin só oferece; o projeto decide se adota. Para adotar, aceite a pergunta do `configurar-projeto`: ele cria o modelo e a área de decisões (só o índice). Projeto que não adotou nunca recebe sugestão de ADR.

## O que vira ADR
Escolha estrutural difícil de reverter: tecnologia, framework, fronteira entre módulos, uma proibição. Escolha que vale só para um card fica no próprio card (`**Decisão:**`); regra de negócio fica na especificação.

## Como nasce
Nunca sem o seu aceite:
- No plano, a decisão vem marcada `ADR proposto`. Se você aceitar, o ADR é gravado junto com os cards.
- Ao concluir um card com `Retomada`, o ADR é um dos destinos possíveis das decisões que valem além do card.

## O que tem nele
Três campos, para a IA ler rápido: **Decisão e porquê**, **Descartado** (com o motivo) e **Não fazer**. O estado vai na tag: `proposta`, `aceita` ou `substituida`. Fica na pasta da unidade (módulo) a que pertence; decisão que vale para o projeto todo tem unidade própria.

## Como é usado
Quem toca um módulo lê os ADRs aceitos dele. O ADR aceito manda: se a demanda o contraria, a IA para e pergunta. Ele nunca bloqueia card nem entra em Dependências.

## Mudou de ideia?
O ADR não é editado. Cria-se um novo ADR e o antigo ganha só a tag `substituida` e um link para o novo. O histórico fica inteiro.
