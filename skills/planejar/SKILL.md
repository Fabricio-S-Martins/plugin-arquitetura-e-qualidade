---
name: planejar
description: Planeja uma demanda com perguntas e fatos, apresenta o plano sem executar e, aprovado, gera as tarefas. Usar ao pedir planejar, plano, planejamento ou quebrar demanda em tarefas.
allowed-tools: Read, Write, Glob, Grep, Skill
---

# planejar

Não editar nem criar arquivos até a aprovação; depois dela, a única escrita própria é a decisão aceita pelo Dev (passo 8), nunca outro arquivo. Demanda nova (exceto o que `especificar` dispensa) sem especificação aprovada → `especificar` primeiro; o plano parte dela. Demanda que cabe em 1 tarefa → direto ao `criar-tarefa`, sem plano.

## Fluxo
1. **Dados:** receber a demanda (objetivo, escopo, restrições, critérios de aceite) e ler o que o usuário citar (docs, tarefas, links). Especificação do assunto (Grep `tags:.*especificacao/` + `modulo/`/`fluxo/`): `aprovada` → regras e critérios vêm dela, sem perguntar de novo; `rascunho` → parar e pedir aprovação (com `Aguardando Validações`, pedir as respostas). Dado faltando → passos 2 e 3.
2. **Fatos primeiro:** antes de perguntar, verificar no projeto (Glob → Grep → Read; até 3 divisões (camada, módulo, pasta), salvo pedido do Dev (vale só nesta execução); sem pedido, avisar que lê só isso e que ele pode pedir mais; regra do tipo em `docs/padroes/modelos/` (Glob) no lugar do irmão; sem regra, até 3 arquivos irmãos reais do mesmo tipo, o mais recente, o mais parecido e um de outra unidade; divergiram sem maioria → perguntar). Docs e tarefas do assunto: Grep por tag (`tags:.*modulo/x`, `tags:.*camada/api`, `tags:.*tarefa/pendente`) antes de abrir pastas; formato em `docs/instrucoes/TAGS.md`. Decisão aceita do módulo (projeto com decisões, `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/DECISOES.md`): Grep por tag e ler; ela manda, conflito com a demanda → perguntar. Fato = ler e citar a fonte. Termos de negócio da demanda: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md` (Linguagem do domínio). Decisão (regra, escopo, prioridade) é do usuário: perguntar, nunca chutar.
3. **Perguntas:** em rodadas, numeradas, curtas e priorizadas, formuladas pela consequência observável, não em vocabulário de código. Cada uma diz o que já foi verificado e por que a resposta muda o plano. Repetir até não restar ponto em aberto que mude o plano. Resposta vaga → perguntar de novo; nunca preencher.
4. **Padrão do projeto:** seguir o existente (padrões do projeto em `docs/padroes/`: práticas, convenções e `modelos/` do tipo; ou irmão real, `CLAUDE.md` e docs do projeto). Sem padrão: qualidade → `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md`, dizendo que não há padrão; nomenclatura, organização, arquitetura e testes são escolha do Dev → perguntar.
5. **Lentes:** antes de fechar o desenho, questioná-lo sob 4 lentes: adversário (como abusar), concorrência (dois no mesmo segundo), plantão (diagnosticar e desfazer sem programador), dev futuro (onde cobra caro). Cada lente gera pergunta ou verificação no código, nunca risco suposto. O que pegar vira decisão ou alternativa descartada.
6. **Plano:** apresentar telegráfico no formato abaixo, sem executar nada e sem explicar metodologia (só os componentes). Encerrar com "Aguardando aprovação."
7. **Aprovação:** só "aprovado" ou equivalente explícito libera as tarefas. Ajuste pedido → revisar e reapresentar. Silêncio ou dúvida não é aprovação.
8. **Tarefas:** aprovado → `criar-tarefa` para cada tarefa do plano, na ordem de dependência. Decisão marcada `decisão proposta` que o Dev aceitou → gravar a decisão (modelo de `DECISOES.md`) com tag `decisao/proposta`; `aceita` só se ele disser. Recusou → seguir sem insistir.

## Plano
- **Objetivo:** 1 linha.
- **Fluxo:** entrada, processamento, saída e eventos gerados.
- **Especificação:** arquivo e critérios que o plano cobre; critério sem tarefa → listar; "nenhuma" se `especificar` dispensa.
- **Fatos:** cada um com fonte (`arquivo:linha` ou "usuário").
- **Impacto por divisão:** só as divisões (camada, módulo, pasta) da arquitetura do projeto (verificadas no código), com os componentes a criar ou alterar.
- **Decisões:** o que será feito e por quê; marcar as que dependem de confirmação. Projeto com decisões e escolha estrutural difícil de reverter → marcar `decisão proposta`.
- **Alternativas descartadas:** 1 linha cada, com o motivo; prefixar `ARMADILHA:` quando o caminho parece barato e cobra caro.
- **Padrão seguido:** arquivo de referência, ou "nenhum".
- **Tarefas:** `NN-nome` título · divisões · deps · critérios atendidos · pronto quando (critério observável: build, teste ou fluxo), em ordem de execução. Dependência externa (credencial, terceiro) → `BLOQUEADO` + o que destrava.
- **Em aberto:** o que ainda não é fato; suposição não entra no plano. Risco só se comprovado no código ou informado pelo usuário.
