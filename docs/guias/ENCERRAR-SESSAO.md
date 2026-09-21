# Encerrar sessão: guia para Devs

A skill `encerrar-sessao` fecha uma sessão sem perder o contexto e deixa tudo pronto para retomar em outra sessão ou passar para outro dev. A versão que o Claude lê é [../../skills/encerrar-sessao/SKILL.md](../../skills/encerrar-sessao/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Quando usar
Ao encerrar, trocar de sessão, antes de dar `/clear` ou ao passar a frente para outro dev. Peça algo como "encerra a sessão" ou "prepara a retomada". Ela roda sem pedir permissão.

## O que você recebe
1. **Um documento por tema**, em `docs/sessoes/<tema>.md`. Ele guarda o estado atual da frente: objetivo, o que está feito, o próximo passo, decisões com o porquê, o que foi descartado, dúvidas em aberto e o que ler antes de agir. Serve igual para a IA e para uma pessoa: frases curtas, títulos sempre iguais, caminhos exatos e datas completas.
2. **Um prompt curto**, no chat, que só aponta para o documento. Você dá `/clear` e cola na sessão nova.

Antes de criar, ela procura em `docs/sessoes/` se a frente já tem arquivo: se tiver, reusa o tema; em dúvida, reusa o mais próximo e diz qual no fim. O documento tem no máximo cerca de 80 linhas; se passar, ela corta detalhe de estado e de passos futuros antes de encurtar o porquê das decisões. Rodar de novo no mesmo tema atualiza o mesmo arquivo: o estado é reescrito, o que foi resolvido sai, decisões e descartes ainda válidos ficam.

## Passar para outro dev
O arquivo fica fora do git (a skill acrescenta `docs/sessoes/` ao `.gitignore`). Para passar a frente, envie o arquivo e o prompt por chat ou e-mail; o outro dev coloca o arquivo na mesma pasta e cola o prompt. O texto não usa "você" nem "nós", para fazer sentido para quem não viu a conversa.

## Checagem antes de entregar
Antes de mostrar o resultado, a skill confere o próprio trabalho e corrige o que falhar: o documento não usa "você" nem "nós", tem no máximo cerca de 80 linhas, traz o cabeçalho completo e os títulos na ordem, tem um só próximo passo, cada decisão com o porquê e cada descarte com o motivo. Confere também que o `.gitignore` tem `docs/sessoes/`, que o prompt tem 2 linhas e termina com "Sem presumir, deve ler.", e que nenhum código foi editado nem commitado.

## Regras
- **Só o que foi dito na conversa:** ela não lê o projeto para completar lacunas. As únicas leituras extras são o estado do git e o documento do tema, se existir.
- **Não altera código e não faz commit.**
- **Dúvida vira "em aberto"**, nunca suposição.
- Toda retomada termina com "Sem presumir, deve ler.": a sessão nova lê os arquivos indicados em vez de imaginar.
