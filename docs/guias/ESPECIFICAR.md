# Especificar: guia para Devs

A skill `especificar` decide e registra as regras de negócio **antes** do plano, para o projeto não perder a essência do que foi combinado. A versão que o Claude lê é [../../skills/especificar/SKILL.md](../../skills/especificar/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Onde entra
`especificar` → `planejar` → `criar-card` → `executar-tarefa`. A especificação diz **o quê** e como saber que está certo. O plano e os cards dizem **como**. A documentação, no fim, descreve o que foi implementado.

## Quando não é preciso
Ajuste pequeno que não cria nem muda regra de negócio (texto, configuração, refatoração, correção pequena) vai direto para o plano, o card ou a tarefa. Na dúvida, o Claude pergunta. Você pode pedir a especificação mesmo assim.

## Como pedir
Diga o módulo e o fluxo: "especifica o cancelamento de pedido". Se você já tem as regras escritas, passe: o Claude organiza e pergunta só o que faltar. Se não tem, ele conduz por perguntas.

## O que acontece
1. Ele confere o que o projeto já responde (docs do assunto) antes de perguntar.
2. Pergunta as regras em rodadas curtas e numeradas, pela consequência que você veria ("o pedido aceito ainda pode ser cancelado?"). Resposta vaga gera nova pergunta; ele nunca preenche por conta própria. Regra que você ainda não sabe responder não é escrita: vira uma **validação** na seção `Aguardando Validações` (pergunta + o que acontece hoje), e o resto segue.
3. Grava um **rascunho** e pede aprovação. Só "aprovado" vira **aprovada**. Com validação pendente não há aprovação: quando você responde, a regra e o critério entram na especificação e a validação sai.
4. Cards e a execução usam a especificação aprovada. Quando os cards que a citam estão concluídos ou cancelados (ao menos um concluído), ela vira **implementada**.

## O que sai
Pasta `docs/especificacoes/`, com a mesma divisão da documentação e do backlog:
- `<pasta>.md`: visão geral, com o link de cada módulo especificado.
- `modulos/<módulo>/<módulo>.md`: regras de negócio do módulo (a essência).
- `modulos/<módulo>/fluxos/<módulo>-<fluxo>.md`: regras do fluxo e **critérios de aceite**.

Um critério de aceite é uma condição concreta que diz como saber se o fluxo está certo, em tabela `Critério | Quando | Então`. O número (`Critério 1: cancelar antes do aceite`) é fixo: o card diz qual critério cada item cumpre, e a revisão confere cada um contra o código.

A escrita é para você e para a IA entenderem na primeira leitura: títulos sempre iguais, frases curtas, uma regra por linha, cada regra com um nome que diz o que ela é. Só o quê, nunca o como.

## Se a regra mudar
O Claude edita, volta a especificação para rascunho e pede nova aprovação. Lista os cards que a citam, sem mexer neles.

## O que ela não faz
- Não altera código nem cards.
- Não decide regra de negócio por você.
