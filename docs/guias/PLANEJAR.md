# Planejar: guia para Devs

A skill `planejar` transforma uma demanda em um plano aprovado por você e, só depois, em cards. A versão que o Claude lê é [../../skills/planejar/SKILL.md](../../skills/planejar/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Como pedir
Descreva a demanda e passe o que já tiver: objetivo, o que entra e o que não entra, restrições, critérios de aceite e links ou documentos. Quanto mais dados você der no começo, menos perguntas ela faz. Se a demanda cabe em um único card, ela dispensa o plano e vai direto para a criação do card.

## O que acontece
1. **Ela lê o que você citou** e verifica no projeto o que dá para confirmar sozinha, antes de perguntar. Fato ela descobre lendo e cita a fonte. Decisão (regra, escopo, prioridade) é sua, e ela nunca decide por você.
2. **Ela pergunta** o que o projeto não responde. As perguntas vêm em rodadas, numeradas, formuladas pela consequência que você observaria (por exemplo, "o lote esgotado some da vitrine ou continua riscado?") e não em termos de código. Cada uma diz o que já foi verificado e por que a resposta importa. Se a resposta for vaga, ela pergunta de novo, sem preencher a lacuna por conta própria.
3. **Ela testa o desenho sob quatro ângulos** antes de fechá-lo: como alguém abusaria disso, o que acontece se dois usuários fizerem a mesma coisa no mesmo segundo, se o suporte consegue diagnosticar e desfazer sem programador e onde a solução cobra caro no futuro. Cada ângulo vira uma pergunta ou uma verificação no código, nunca um risco inventado.
4. **Ela apresenta o plano** em texto curto, sem explicar a metodologia (só os componentes) e sem fazer nenhuma alteração. O plano termina com "Aguardando aprovação."
5. **Você aprova** dizendo claramente "aprovado" (ou algo equivalente). Se pedir ajustes, ela revisa e mostra de novo. Silêncio ou dúvida não contam como aprovação.
6. **Ela gera os cards**, um por item do plano, na ordem de dependência, usando a skill de criar card.

## O que tem no plano
- **Objetivo:** uma linha.
- **Fluxo:** entrada, processamento, saída e eventos gerados.
- **Fatos:** cada um com a fonte, que é um arquivo e linha ou "usuário".
- **Impacto por camada:** só as camadas da arquitetura do projeto, verificadas no código, com os componentes a criar ou alterar.
- **Decisões:** o que será feito e por quê, com marca nas que dependem da sua confirmação.
- **Alternativas descartadas:** uma linha por alternativa, com o motivo. Quando o caminho parece barato mas cobra caro depois, vem marcado com `ARMADILHA:`. Assim, ninguém reabre uma discussão sem lembrar por que aquela opção foi rejeitada.
- **Padrão seguido:** o arquivo do projeto usado como referência, ou "nenhum".
- **Cards:** título, camadas, dependências e critério de pronto observável (build, teste ou fluxo), em ordem de execução. Um card que depende de algo externo, como uma credencial ou a resposta de um terceiro, vem marcado como `BLOQUEADO`, com o que o destrava.
- **Em aberto:** o que ainda não é fato. Suposição não entra no plano, e um risco só aparece se estiver comprovado no código ou tiver sido informado por você.

## Regras
- **Só fatos:** tudo o que o plano afirma vem do código, dos documentos ou de você.
- **Padrão do projeto primeiro:** ela segue o que já existe. Se não houver padrão, usa as regras de qualidade do plugin e avisa.
- **Nada é alterado antes da aprovação.**
