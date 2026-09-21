---
name: planejar
description: Planeja uma demanda com perguntas e fatos, apresenta o plano sem executar e, aprovado, gera os cards. Usar ao pedir planejar, plano, planejamento ou quebrar demanda em cards.
---

# planejar

Não editar nem criar arquivos até a aprovação. Só fatos: nunca suposição. Demanda que cabe em 1 card → direto ao `criar-card`, sem plano.

## Fluxo
1. **Dados:** receber a demanda (objetivo, escopo, restrições, critérios de aceite) e ler o que o usuário citar (docs, cards, links). Dado faltando → passos 2 e 3.
2. **Fatos primeiro:** antes de perguntar, verificar no projeto (Glob → Grep → Read; até 3 camadas; 1 arquivo irmão real do mesmo tipo). Fato = ler e citar a fonte. Decisão (regra, escopo, prioridade) é do usuário: perguntar, nunca chutar.
3. **Perguntas:** em rodadas, numeradas, curtas e priorizadas, formuladas pela consequência observável, não em vocabulário de código. Cada uma diz o que já foi verificado e por que a resposta muda o plano. Repetir até não restar ponto em aberto que mude o plano. Resposta vaga → perguntar de novo; nunca preencher.
4. **Padrão do projeto:** seguir o existente (irmão real, `CLAUDE.md` e docs do projeto). Sem padrão → `docs/ia/QUALIDADE.md`, dizendo que não há padrão.
5. **Lentes:** antes de fechar o desenho, questioná-lo sob 4 lentes: adversário (como abusar), concorrência (dois no mesmo segundo), plantão (diagnosticar e desfazer sem programador), dev futuro (onde cobra caro). Cada lente gera pergunta ou verificação no código, nunca risco suposto. O que pegar vira decisão ou alternativa descartada.
6. **Plano:** apresentar telegráfico no formato abaixo, sem executar nada e sem explicar metodologia (só os componentes). Encerrar com "Aguardando aprovação."
7. **Aprovação:** só "aprovado" ou equivalente explícito libera os cards. Ajuste pedido → revisar e reapresentar. Silêncio ou dúvida não é aprovação.
8. **Cards:** aprovado → `criar-card` para cada card do plano, na ordem de dependência.

## Plano
- **Objetivo:** 1 linha.
- **Fluxo:** entrada, processamento, saída e eventos gerados.
- **Fatos:** cada um com fonte (`arquivo:linha` ou "usuário").
- **Impacto por camada:** só as camadas da arquitetura do projeto (verificadas no código), com os componentes a criar ou alterar.
- **Decisões:** o que será feito e por quê; marcar as que dependem de confirmação.
- **Alternativas descartadas:** 1 linha cada, com o motivo; prefixar `ARMADILHA:` quando o caminho parece barato e cobra caro.
- **Padrão seguido:** arquivo de referência, ou "nenhum".
- **Cards:** `TASK-XXX` título · camadas · deps · pronto quando (critério observável: build, teste ou fluxo), em ordem de execução. Dependência externa (credencial, terceiro) → `BLOQUEADO` + o que destrava.
- **Em aberto:** o que ainda não é fato; suposição não entra no plano. Risco só se comprovado no código ou informado pelo usuário.
