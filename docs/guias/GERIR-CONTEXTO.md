# Gerir contexto: guia para Devs

A skill `gerir-contexto` ajuda quando o contexto da sessão está grande: avalia se é preciso trocar de sessão e, só se for, gera um prompt para retomar em outra sessão ou passar para outro dev. A versão que o Claude lê é [../../skills/gerir-contexto/SKILL.md](../../skills/gerir-contexto/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Quando usar
Com o contexto grande: confira o uso com `/context` e chame a skill (por exemplo, "gerir contexto, está em 75%"). Ela não roda o `/context` sozinha, porque isso gastaria tokens; se você não informar o número, ela pergunta. Também serve para passar a frente para outro dev. Ela roda sem pedir permissão, salvo as perguntas abaixo.

## O que ela decide
Ela compara o que falta para terminar a tarefa (pelo que está na conversa) com o uso do contexto:
- **Falta pouco e o contexto tem folga (abaixo de 60%):** avisa que não precisa trocar de sessão. Não gera nada.
- **Falta pouco, mas o contexto está quase cheio (60% ou mais):** entrega o comando `/compact` pronto para você digitar (a IA não executa `/compact` nem `/clear`). Não gera nada.
- **Falta muito:** gera o prompt para trocar de sessão.
- **Não dá para estimar o que falta:** pergunta se falta pouco ou muito para terminar e segue a regra acima.
- **Passar para outro dev:** sempre gera o prompt.

Manter a sessão aproveita o cache (o início repetido da conversa sai mais barato e rápido). O `/compact` resume e pode perder detalhe. Trocar de sessão com `/clear` tira o peso do histórico, que é reenviado a cada mensagem, e depois de alguns minutos parado o cache já expirou.

## O que você recebe
Um prompt no chat, em um bloco de código, com o estado da frente: objetivo, o que está feito e pendente, o próximo passo, decisões com o porquê, o que foi descartado, dúvidas em aberto e o que ler antes de agir. Ele é autocontido: não depende de arquivo, e serve igual para a IA e para uma pessoa (frases curtas, caminhos exatos, datas completas). Tem no máximo cerca de 25 linhas e termina com "Sem presumir, deve ler."

Nada é salvo em arquivo. Copie o prompt antes de fechar o chat. Você dá `/clear` e cola na sessão nova.

## Passar para outro dev
Envie o prompt por chat ou e-mail; o outro dev cola na sessão dele. O texto não usa "você" nem "nós", para fazer sentido para quem não viu a conversa.

## Conferência
Antes de entregar, a skill confere se alguma pendência já foi resolvida no código (com uma busca pontual) e a move para "feito".

## Regras
- **Só o que foi dito na conversa:** ela não lê o projeto para completar lacunas. As únicas leituras extras são o estado do git e a busca pontual da conferência.
- **Não altera código, não cria arquivo e não faz commit.**
- **Dúvida vira "em aberto"**, nunca suposição.
- Toda retomada termina com "Sem presumir, deve ler.": a sessão nova lê os arquivos indicados em vez de imaginar.
