# Planejar

A skill `planejar` transforma uma demanda em um plano aprovado pelo Dev e, só depois, em tarefas. A versão que o Claude lê é [../../skills/planejar/SKILL.md](../../skills/planejar/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Antes do plano: a especificação
Toda demanda nova começa por [especificar](ESPECIFICAR.md), que decide e registra as regras de negócio. O plano parte da especificação aprovada e cuida só do "como". Ajuste pequeno, que não muda regra de negócio, dispensa a especificação.

## Como pedir
O pedido descreve a demanda e traz o que já houver: objetivo, o que entra e o que não entra, restrições, critérios de aceite e links ou documentos. Quanto mais dados no começo, menos perguntas ela faz. Se a demanda cabe em uma única tarefa, ela dispensa o plano e vai direto para a criação da tarefa.

## O que acontece
1. **Ela lê o que foi citado** e verifica no projeto o que dá para confirmar sozinha, antes de perguntar. Fato ela descobre lendo e cita a fonte. Decisão (regra, escopo, prioridade) é do Dev, e ela nunca decide por ele.
2. **Ela pergunta** o que o projeto não responde. As perguntas vêm em rodadas, numeradas, formuladas pela consequência que o Dev observaria (por exemplo, "o lote esgotado some da vitrine ou continua riscado?") e não em termos de código. Cada uma diz o que já foi verificado e por que a resposta importa. Se a resposta for vaga, ela pergunta de novo, sem preencher a lacuna por conta própria.
3. **Ela testa o desenho sob quatro ângulos** antes de fechá-lo: como alguém abusaria disso, o que acontece se dois usuários fizerem a mesma coisa no mesmo segundo, se o suporte consegue diagnosticar e desfazer sem programador e onde a solução cobra caro no futuro. Cada ângulo vira uma pergunta ou uma verificação no código, nunca um risco inventado.
4. **Ela apresenta o plano** em texto curto, sem explicar a metodologia (só os componentes) e sem fazer nenhuma alteração. O plano termina com "Aguardando aprovação."
5. **O Dev aprova** dizendo claramente "aprovado" (ou algo equivalente). Se pedir ajustes, ela revisa e mostra de novo. Silêncio ou dúvida não contam como aprovação.
6. **Ela gera as tarefas**, um por item do plano, na ordem de dependência, usando a skill de criar tarefa.

## O que tem no plano
- **Objetivo:** uma linha.
- **Fluxo:** entrada, processamento, saída e eventos gerados.
- **Especificação:** o arquivo e os critérios de aceite que o plano cobre.
- **Fatos:** cada um com a fonte, que é um arquivo e linha ou "usuário".
- **Impacto por camada:** só as camadas da arquitetura do projeto, verificadas no código, com os componentes a criar ou alterar.
- **Decisões:** o que será feito e por quê, com marca nas que dependem da confirmação do Dev.
- **Decisões estruturais:** em projeto que adotou [decisões](DECISOES.md), a escolha difícil de reverter vem marcada `decisão proposta`; só é gravada se o Dev aceitar, junto com as tarefas. As decisões aceitas do módulo são lidas antes e mandam sobre o plano.
- **Alternativas descartadas:** uma linha por alternativa, com o motivo. Quando o caminho parece barato mas cobra caro depois, vem marcado com `ARMADILHA:`. Assim, ninguém reabre uma discussão sem lembrar por que aquela opção foi rejeitada.
- **Padrão seguido:** o arquivo do projeto usado como referência, ou "nenhum".
- **Tarefas:** título, camadas, dependências e critério de pronto observável (build, teste ou fluxo), em ordem de execução. Uma tarefa que depende de algo externo, como uma credencial ou a resposta de um terceiro, vem marcado como `BLOQUEADO`, com o que o destrava.
- **Em aberto:** o que ainda não é fato. Suposição não entra no plano, e um risco só aparece se estiver comprovado no código ou tiver sido informado pelo Dev.

## Regras
- **Só fatos:** tudo o que o plano afirma vem do código, dos documentos ou do Dev.
- **Padrão do projeto primeiro:** ela segue o que já existe. Se não houver padrão, usa as regras de qualidade do plugin e avisa.
- **Nada é alterado antes da aprovação.** Depois dela, além das tarefas, só a decisão que o Dev aceitou.
- **Linguagem do domínio:** se a demanda usa um termo de negócio diferente do que a documentação e a especificação já usam para o mesmo conceito, o Claude confirma antes, com uma pergunta na mesma rodada. Confirmado como sinônimo, a equivalência pode ser gravada numa linha na especificação do módulo, com aceite.

## Por que é assim
- **Plano aprovado antes de qualquer alteração.** Errar o desenho num texto custa muito menos que refazer código. Por isso nada é criado antes do "aprovado" do Dev.
- **Alternativas descartadas com o motivo.** É o campo **Descartado** da [decisão](DECISOES.md) (o ADR de Nygard): evita que alguém reabra uma discussão sem lembrar por que a opção foi rejeitada.
- **Critério de pronto observável em cada tarefa.** Segue a ideia da definição de pronto (*Definition of Done*): build, teste ou fluxo que se possa ver, não "está pronto" por opinião.
- **Os quatro ângulos.** São perguntas que o desenho normal costuma esconder (abuso, concorrência, suporte e custo futuro), por isso cada uma vira pergunta ou verificação no código, nunca um risco inventado.
