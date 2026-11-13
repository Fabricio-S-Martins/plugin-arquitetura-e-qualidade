---
name: criar-plano
description: Planeja uma demanda com perguntas e fatos, apresenta o plano sem executar e, aprovado, gera as tarefas. Usar ao pedir planejar, plano, planejamento ou quebrar demanda em tarefas.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill
---

# criar-plano

Não editar nem criar arquivos até a aprovação; depois dela, as únicas escritas próprias são o arquivo do plano e as decisões que o Dev mandou registrar, com as linhas de índice deles (passo 8). Ordem: demanda nova (exceto o que `criar-especificacao` dispensa; ela diz se dispensa) sem especificação aprovada → `criar-especificacao` primeiro; depois, demanda que cabe em 1 tarefa → direto ao `criar-tarefa`, sem plano; senão, o plano parte da especificação. Regra de negócio nova surgida no planejamento → parar e acionar `criar-especificacao`.

## Fluxo
1. **Dados:** receber a demanda (objetivo, escopo, restrições, critérios de aceite) e ler o que o usuário citar. Especificação do assunto (Grep `tags:.*especificacao/` + `modulo/`/`fluxo/`): `aprovada` → regras e critérios vêm dela, sem perguntar de novo; `rascunho` → parar e pedir aprovação (com `Aguardando Validações`, pedir as respostas); `obsoleta` → usar a substituta da linha `**Obsoleta:**`; sem substituta → perguntar. Plano `vigente` da demanda (Grep `tags:.*plano/vigente` + `modulo/`; vários → o da demanda pelo título; dúvida → perguntar): Read; o passo 8 o atualiza. Dado faltando → passos 2 e 3.
2. **Fatos primeiro:** antes de perguntar, verificar no projeto (Glob → Grep → Read; até 3 divisões (camada, módulo, pasta), salvo pedido do Dev (vale só nesta execução); sem pedido, avisar que lê só isso e que ele pode pedir mais; regra do tipo em `docs/padroes/modelos/` (Glob) no lugar do irmão; sem regra, até 3 arquivos irmãos reais do mesmo tipo, o mais recente, o mais parecido e um de outra unidade; divergiram sem maioria → perguntar). Docs e tarefas do assunto: Grep por tag (`tags:.*modulo/x`, `tags:.*camada/api`, `tags:.*tarefa/pendente`) antes de abrir pastas; formato em `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`. Decisão aceita do módulo (projeto com decisões, `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/DECISOES.md`): Grep por tag e ler; ela manda, conflito com a demanda → perguntar. Fato = ler e citar a fonte. Termos de negócio da demanda: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md` (Linguagem do domínio). Decisão (regra, escopo, prioridade) é do usuário: perguntar, nunca chutar.
3. **Perguntas:** em rodadas, numeradas, curtas e priorizadas, formuladas pela consequência observável, não em vocabulário de código. Cada uma diz o que já foi verificado e por que a resposta muda o plano. Repetir até não restar ponto em aberto que mude o plano. Resposta vaga → perguntar de novo; nunca preencher. Sempre perguntar quantas pessoas ou agentes vão executar em paralelo (1 → sem frentes).
4. **Padrão do projeto:** seguir o existente (padrões do projeto em `docs/padroes/`: práticas, convenções e `modelos/` do tipo; ou irmão real, `CLAUDE.md` e docs do projeto). Sem padrão: qualidade → `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md`, dizendo que não há padrão; nomenclatura, organização, arquitetura e testes são escolha do Dev → perguntar.
5. **Lentes:** antes de fechar o desenho, questioná-lo sob 4 lentes: adversário (como abusar), concorrência (dois no mesmo segundo), plantão (diagnosticar e desfazer sem programador), dev futuro (onde cobra caro). Cada lente gera pergunta ou verificação no código, nunca risco suposto. O que pegar vira decisão ou alternativa descartada.
6. **Plano:** apresentar telegráfico no formato abaixo, sem executar nada e sem explicar metodologia (só os componentes). Encerrar com "Aguardando aprovação." e, havendo `decisão proposta`, pedir para cada uma se registra.
7. **Aprovação:** só "aprovado" ou equivalente explícito libera as tarefas. Ajuste pedido → revisar e reapresentar. Silêncio ou dúvida não é aprovação. "Aprovado" sem resposta sobre as decisões propostas → perguntar uma vez antes de gravá-las.
8. **Tarefas e plano:** aprovado → `criar-tarefa` para cada tarefa do plano, na ordem de dependência; depois, ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/PLANO.md` e gravar o arquivo do plano (ou atualizar o `vigente`) com tags e índice (`TAGS.md`, `INDICE.md`); diagrama só se necessário (`${CLAUDE_SKILL_DIR}/../../docs/instrucoes/DIAGRAMAS.md`). Decisão proposta que o Dev mandou registrar → gravar (modelo de `DECISOES.md`) com tag `decisao/aceita`. Recusou a escolha → ajustar o plano e reapresentar (passo 6); recusou só o registro → a escolha fica só em `Decisões` do plano. Plano obsoleto ou apagar (só se o Dev disser): `PLANO.md`.

## Plano
- **Objetivo:** 1 linha.
- **Funcionalidades:** o que a demanda entrega, cada uma com os critérios que cobre.
- **Fluxo:** entrada, processamento, saída e eventos gerados.
- **Especificação:** arquivo e critérios que o plano cobre; critério sem tarefa → listar; "nenhuma" se `criar-especificacao` dispensa.
- **Fatos:** cada um com fonte (`arquivo:linha` ou "usuário").
- **Impacto por divisão:** só as divisões da arquitetura do projeto (verificadas no código), com os componentes a criar ou alterar.
- **Decisões:** o que será feito e por quê; marcar as que dependem de confirmação. Projeto com decisões e escolha estrutural difícil de reverter → marcar `decisão proposta`.
- **Alternativas descartadas:** 1 linha cada, com o motivo; prefixar `ARMADILHA:` quando o caminho parece barato e cobra caro.
- **Padrão seguido:** arquivo de referência, ou "nenhum".
- **Tarefas:** `NN-nome` título · divisões · deps · critérios atendidos · pronto quando (critério observável: build, teste ou fluxo), em ordem de execução. Dependência externa (credencial, terceiro) → `BLOQUEADO` + o que destrava.
- **Frentes** (só com mais de 1 pessoa ou agente em paralelo): `Frente A`, `Frente B`… (letras, para não confundir com o `NN` das tarefas), cada uma com as tarefas na ordem sugerida, sem responsável. Cadeia de dependência da demanda → mesma frente; tarefas que tocam o mesmo arquivo → mesma frente ou dependência entre si (essa pode ligar frentes); o resto equilibra as frentes; frente sem tarefa → avisar que o paralelo não ajuda. Bloqueio entre frentes = `deps` da tarefa.
- **Pendências:** o que ainda não é fato; suposição não entra no plano. Risco só se comprovado no código ou informado pelo usuário.
