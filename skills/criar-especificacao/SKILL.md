---
name: criar-especificacao
description: Define as regras de negócio de um módulo ou fluxo antes de planejar, por perguntas e fatos, e grava a especificação aprovada. Usar antes de planejar uma demanda nova ou ao pedir especificar, regras de negócio ou atualizar especificação.
allowed-tools: Read, Write(**/*.md), Edit(**/*.md), Glob, Grep
---

# criar-especificacao

Especificação = regras de negócio e critérios de aceite. Vem antes de `criar-plano` em toda demanda, exceto ajuste pequeno (abaixo). Não alterar código. Modelos em `TEMPLATE-ESPECIFICACAO.md` (esta pasta). Nomes de pasta, arquivo, tag e título citados aqui são exemplo: valem os do projeto (Glob/Grep no existente); sem padrão, perguntar sugerindo o exemplo.
**Chamada por outra skill** (no meio do fluxo dela): fazer todo o trabalho pedido sem parar entre partes; ao terminar, não parar nem apontar a próxima skill. Pedido de aprovação ao Dev continua: esperar a resposta. Depois, voltar à skill que chamou, no passo seguinte ao da chamada.

## Quando dispensar
Ajuste que não cria nem muda regra de negócio nem comportamento observável (texto, configuração, refatoração, correção pequena): dizer que dispensa e seguir direto para `criar-plano`, `criar-tarefa` (gera o arquivo) ou a execução do ajuste (sem arquivo da tarefa). Dúvida → perguntar. O Dev pode pedir especificação mesmo assim.

## Fluxo
1. **Alvo:** módulo e fluxo (nome não claro → perguntar). Glob do arquivo do fluxo (e do módulo) em `docs/especificacoes/modulos/<módulo>/`: existe → modo Atualizar; senão criar o que faltar.
2. **Fatos primeiro:** antes de perguntar, verificar no projeto (Glob → Grep → Read; até 3 divisões, salvo pedido do Dev (vale só nesta execução); sem pedido, avisar que lê só isso e que ele pode pedir mais; docs do assunto em `docs/documentacao/`; vocabulário do projeto). Fato = ler e citar a fonte. Termos de negócio da demanda: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md` (Linguagem do domínio). Regra de negócio é do Dev: perguntar, nunca chutar. Regra sem resposta → `Aguardando Validações` (formato na Escrita); o resto segue.
3. **Perguntas:** em rodadas, numeradas, curtas, pela consequência observável ("o pedido aceito ainda pode ser cancelado?"), cada uma dizendo o que já foi verificado. Resposta vaga → perguntar de novo. Regra do Dev já escrita → organizar no modelo, perguntando só o que faltar.
4. **Rascunho:** gravar com `especificacao/rascunho`, apresentar e encerrar com "Aguardando aprovação." Só "aprovado" (ou equivalente explícito) troca para `especificacao/aprovada`; ajuste pedido → revisar e reapresentar. Silêncio não é aprovação. Com `Aguardando Validações` não vazia: sem aprovação; pedir as respostas e encerrar com "Aguardando validações."
5. **Próximo passo:** informar o caminho e que a demanda segue para `criar-plano`.

## Atualizar
Regra ou critério mudou → editar o arquivo, voltar para `rascunho` e pedir nova aprovação (só redação: manter o estado). Validação respondida → regra e critério entram e o item sai (seção vazia → remover). Validação nova em especificação `aprovada` ou `implementada` → volta para `rascunho`. Especificação `implementada` que muda → a mudança precisa de tarefa nova. Critério mudou e há tarefa `concluido` que o cumpre (`(Critério N)` nas tarefas que citam a especificação) → listar e propor tarefa nova com a original em `**Ref:**`; criar só com aval.
- **Tarefas** (Grep da linha `Especificação:` com o caminho do arquivo em `docs/tarefas/`): voltou a `rascunho` → propor `tarefa/bloqueado` nas `tarefa/pendente` que a citam e listar como aviso as `em-andamento`, `em-execucao` e `em-validacao` (o Dev decide). Reaprovada → propor `tarefa/pendente` nas `tarefa/bloqueado` que a citam sem outra tarefa em `Dependências` e sem linha `**Bloqueio:**`. Gravar só com o aval do Dev; só a tag `tarefa/...`.
- **Obsoleta** (só se o Dev disser; de qualquer estado, inclusive `rascunho`): linha `**Obsoleta:** <data> · <motivo> · substituída por [<arquivo>](<caminho relativo>)` (sem substituta → sem o último trecho) logo abaixo do título.
- **Apagar:** com aceite do Dev e só se nenhuma nota cita o arquivo (Grep literal do nome em `docs/`, fora do índice); a linha do índice sai junto. Citada → `obsoleta`.

## Estrutura
- `docs/especificacoes/modulos/<módulo>/<módulo>.md`: regras de negócio do módulo (a essência).
- `docs/especificacoes/modulos/<módulo>/fluxos/<módulo>-<fluxo>.md`: regras do fluxo e critérios de aceite. Fluxo com 2+ módulos fica na pasta do principal (o 1º citado).
- Índice das especificações: modelo e regras em `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/INDICE.md` (criar se ausente; senão incluir o módulo novo).
- Mesma divisão e nomes de `docs/documentacao/`; mesmo nome de módulo em `docs/tarefas/`. Pasta do módulo ausente → criar.
- Tags: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md` (grupo `especificacao`).

## Escrita
- Para o Dev e para a IA entenderem na primeira leitura: títulos sempre iguais, frases curtas, uma regra por linha.
- Cada regra, termo e critério diz o que é em poucas palavras (`**Cancelamento só antes do aceite:** …`), sem abreviação nem jargão. Termo do negócio explicado uma vez em `Termos`.
- Só o quê, nunca o como: sem classe, camada, tecnologia nem passo de implementação. Contrato externo (rota, campo, status, mensagem) só quando faz parte da regra.
- Critérios em tabela `Critério | Quando | Então`, numerados e nomeados (`Critério 1: cancelar antes do aceite`); número nunca é reutilizado nem renumerado. Toda regra do fluxo tem ao menos 1 critério verificável; sem critério → perguntar.
- Origem: todo fato vem do Dev ou de código lido. Não confirmado → perguntar, não escrever. Dúvida de regra sem resposta → `Validação N: <pergunta>? Hoje: <o que acontece hoje>.` em `Aguardando Validações` (numeração fixa como a dos critérios; nunca suposição); sem item, sem seção.
- Nunca citar tarefa.

## Gate antes de apresentar
1. Reler a Escrita contra o rascunho.
2. Conferir tags (formato de `TAGS.md`, nomes do projeto) e links relativos (Glob).
3. Correção aplicada → varrer o rascunho por todo padrão igual e corrigir junto.
