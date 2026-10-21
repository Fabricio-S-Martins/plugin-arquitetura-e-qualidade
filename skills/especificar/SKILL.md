---
name: especificar
description: Define e registra as regras de negócio de um módulo ou fluxo antes de planejar, por perguntas e fatos, e grava a especificação aprovada. Usar antes de planejar uma demanda nova ou ao pedir especificar, regras de negócio ou atualizar especificação.
allowed-tools: Read, Write(**/*.md), Edit(**/*.md), Glob, Grep
---

# especificar

Especificação = regras de negócio e critérios de aceite, antes do plano. Vem antes de `planejar` em toda demanda, exceto ajuste pequeno (abaixo). Não alterar código. Modelos em `TEMPLATE-ESPECIFICACAO.md` (esta pasta). Nomes de pasta, arquivo, tag e título citados aqui são exemplo: valem os do projeto (Glob/Grep no existente); sem padrão, perguntar sugerindo o exemplo.

## Quando dispensar
Ajuste que não cria nem muda regra de negócio nem comportamento observável (texto, configuração, refatoração, correção pequena): dizer que dispensa e seguir direto para `planejar`, `criar-card` ou a tarefa. Dúvida → perguntar. O Dev pode pedir especificação mesmo assim.

## Fluxo
1. **Alvo:** módulo e fluxo (nome não claro → perguntar). Glob do arquivo do fluxo (e do módulo) em `docs/especificacoes/modulos/<módulo>/`: existe → modo Atualizar; senão criar o que faltar.
2. **Fatos primeiro:** antes de perguntar, verificar no projeto (Glob → Grep → Read; até 3 divisões; docs do assunto em `docs/documentacao/`; vocabulário do projeto). Fato = ler e citar a fonte. Regra de negócio é do Dev: perguntar, nunca chutar. Regra sem resposta → `Aguardando Validações` (formato na Escrita); o resto segue.
3. **Perguntas:** em rodadas, numeradas, curtas, pela consequência observável ("o pedido aceito ainda pode ser cancelado?"), cada uma dizendo o que já foi verificado. Resposta vaga → perguntar de novo. Regra do Dev já escrita → organizar no modelo, perguntando só o que faltar.
4. **Rascunho:** gravar com `especificacao/rascunho`, apresentar e encerrar com "Aguardando aprovação." Só "aprovado" (ou equivalente explícito) troca para `especificacao/aprovada`; ajuste pedido → revisar e reapresentar. Silêncio não é aprovação. Com `Aguardando Validações` não vazia: sem aprovação; pedir as respostas e encerrar com "Aguardando validações."
5. **Próximo passo:** informar o caminho e que a demanda segue para `planejar`.

## Atualizar
Regra ou critério mudou → editar o arquivo, voltar para `rascunho` e pedir nova aprovação (só redação: manter o estado). Validação respondida → regra e critério entram e o item sai (seção vazia → remover). Validação nova em especificação `aprovada` ou `implementada` → volta para `rascunho`. Especificação `implementada` que muda → a mudança precisa de card novo. Listar (Grep literal do nome do arquivo em `docs/backlog/`) os cards que citam a especificação, sem alterá-los. Regra substituída por outra → `obsoleta` só se o Dev disser.

## Estrutura
- `docs/especificacoes/modulos/<módulo>/<módulo>.md`: regras de negócio do módulo (a essência).
- `docs/especificacoes/modulos/<módulo>/fluxos/<módulo>-<fluxo>.md`: regras do fluxo e critérios de aceite. Fluxo com 2+ módulos fica na pasta do principal (o 1º citado).
- `docs/especificacoes/<nome da pasta>.md`: visão geral, só com o link de cada módulo (criar se ausente; senão acrescentar o link do módulo novo).
- Mesma divisão e nomes de `docs/documentacao/`; mesmo nome de módulo em `docs/backlog/`. Pasta do módulo ausente → criar.
- Tags: `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md` (grupo `especificacao`).

## Escrita
- Para o Dev e para a IA entenderem na primeira leitura: títulos sempre iguais, frases curtas, uma regra por linha.
- Cada regra, termo e critério diz o que é em poucas palavras (`**Cancelamento só antes do aceite:** …`), sem abreviação nem jargão. Termo do negócio explicado uma vez em `Termos`.
- Só o quê, nunca o como: sem classe, camada, tecnologia nem passo de implementação. Contrato externo (rota, campo, status, mensagem) só quando faz parte da regra.
- Critérios em tabela `Critério | Quando | Então`, numerados e nomeados (`Critério 1: cancelar antes do aceite`); número nunca é reutilizado nem renumerado. Toda regra do fluxo tem ao menos 1 critério verificável; sem critério → perguntar.
- Origem: todo fato vem do Dev ou de código lido. Não confirmado → perguntar, não escrever. Dúvida de regra sem resposta → `Validação N: <pergunta>? Hoje: <o que acontece hoje>.` em `Aguardando Validações` (numeração fixa como a dos critérios; nunca suposição); sem item, sem seção.
- Nunca citar card.

## Gate antes de apresentar
1. Reler a Escrita contra o rascunho.
2. Conferir tags (formato de `TAGS.md`, nomes do projeto) e links relativos (Glob).
3. Correção aplicada → varrer o rascunho por todo padrão igual e corrigir junto.
