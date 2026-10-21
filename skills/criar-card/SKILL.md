---
name: criar-card
description: Cria card de tarefa em .md a partir do template. Usar ao pedir para criar/planejar card ou task.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# criar-card

Ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md` (plugin). Criar `docs/backlog/modulos/<modulo>/tarefas/NN-<nome>.md` (NN = próximo número livre em `tarefas/` do módulo; `<nome>` minúsculas, hífen) a partir de `TEMPLATE-CARD.md`; a estrutura vem só dele, nada do projeto adiciona seção. Blocos do checklist: 1 por divisão do projeto que a task toca (camada, módulo, pasta), em ordem de dependência (ex: Domínio, Aplicação, Infraestrutura, API, DI & Migrations); `Documentação` penúltimo e `QA & Testes` por último, só se o projeto usa testes. Blocos numerados em sequência; itens `- [ ] **a:**`, letra reiniciando a cada bloco; sub-itens `- [ ] **b.1:**` (regra Hierarquia).

## Escopo de leitura
Consultar o código existente em no máximo 3 camadas, priorizando as que o card cria. Achar com Glob, filtrar com Grep, só então Read. Tipo com regra em `docs/padroes/` (Glob) → ler a regra no lugar do exemplo (modelo base; particularidade do card vale). Camada/módulo não claro → perguntar.

## Regras
- **Título:** verbo no infinitivo + o que entrega, cobrindo todas as frentes; serve de mensagem de commit. Sem prefixo de camada.
- **O que fazer:** regras e decisões da task que o checklist não deixa óbvias, 1 linha cada (`**Tema:** regra`). Não repetir itens do checklist. Padrão de projeto aplicado citado pelo nome. Sem conteúdo → remover seção.
- **Checklist:** 1 ação direta por item, sem justificativa. Sem seções duplicadas ("Arquivos a criar", "Contrato do endpoint"): rota, entrada, saída e status do endpoint vão no item que o cria.
- **Localização:** todo arquivo/pasta diz onde fica; ordem pasta → arquivo → conteúdo. Projeto novo = 1 passo ("Na pasta `<pai>/`, criar o projeto `<Nome>` (<tipo>)"), sem passo para a pasta do projeto. Pasta que não vem de graça (agrupadora do módulo, interna ao projeto) = passo próprio.
- **Hierarquia:** item que cria pasta com vários arquivos (classes, testes) termina com "com:" e cada arquivo é sub-item `b.1`, `b.2`, indentado 2 espaços, com checkbox próprio. Sub-item não repete pasta nem verbo do pai (o contexto vem da hierarquia) e depende só do pai. Nunca "Dentro dela", "nela", "idem" ou pronome que dependa de item irmão (cada item entendível isolado). Item que altera um só lugar (arquivo, método existente) = letra simples, sem sub-itens. Testes de uma pasta: o pai cria a pasta e os testes são sub-itens. Ex.: pai ``**b:** Na raiz do projeto, criar a pasta `Gateway/`, com:`` e filho ``  - [ ] **b.1:** A classe `X`, herdando de `Exception`.``
- **Sem passos mecânicos** de convenção fixa (registrar na solution, referência entre projetos, apagar arquivo de template).
- **Validações:** critério concreto (tamanho, formato, valores). Não definido → perguntar, nunca inventar.
- **Card cria tipo** (classe, DTO, Command, Query, VO, agregado): ler `${CLAUDE_SKILL_DIR}/TIPOS.md` antes de escrever o checklist. Sem tipo novo, não ler.
- **Consistência:** nenhum membro citado sem definição no passo do tipo. Usar expressão exata do código (`resultado.Sucesso == false`).
- **Cobertura:** tecnologia nova → passo de registro/config (DI) e dependências de suporte; mecanismo não óbvio → "como" passo a passo; operação com resultado → retorno explícito; segurança/criptografia (erro silencioso) → prioridade e teste dedicado (se o projeto usa testes).
- **Nomes:** idioma e caixa do projeto (arquivo, classe, pasta, projeto); sem padrão → perguntar. Exceção: tipo imposto por biblioteca/framework; a classe própria que o implementa traduz.
- **Documentação:** task que cria/altera código → bloco com 1 item por doc do que a task toca (fluxo, módulo); nunca item perguntando por plano do restante (plano só por pedido explícito). Task sem código novo (só config/texto) → omitir o bloco.
- **Tags:** seguir `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md` (`backlog`, `modulo/`, `fluxo/` e `camada/` dos docs do bloco Documentação, `tarefa/pendente`; índice do módulo e `backlog.md`, se criados aqui, levam as tags da tabela).
- **Testes (se o projeto usa):** descrever cenários, não nomes de método.
- **Card existente:** editar direto; `previa-diff` só se o Dev pedir para ver antes.
- **Backlog:** `docs/backlog/backlog.md` só linka o índice de cada módulo (`docs/backlog/modulos/<modulo>/<modulo>.md`); a linha da task nova vai nesse índice (link `tarefas/<card>.md`), nunca no `backlog.md`. Inconsistência achada em linha existente → sinalizar, nunca corrigir sem pedido.
- **Escopo (YAGNI):** só o pedido; extras como sugestão fora do card. Mais de ~8 itens ou mais de um módulo → propor quebra com dependências.
- **Especificação:** demanda com especificação aprovada → linha `Especificação` no cabeçalho com link relativo (de `tarefas/`: `../../../../especificacoes/modulos/<m>/fluxos/<m>-<f>.md`, `<m>` = módulo da pasta da especificação; conferir que existe via Glob). Item que cumpre critério termina com `(Critério N)`; o card não repete regra da especificação. Especificação `rascunho` ou `obsoleta` → parar e avisar. Sem especificação: demanda que `especificar` não dispensa → apontar `especificar` antes; senão, sem a linha.
- **Dependências:** sem nenhuma → sem a linha. Card = link `[<Módulo> NN](<caminho relativo a partir de tarefas/>/NN-nome.md)` (mesmo módulo: `NN-nome.md`; outro: `../../<modulo>/tarefas/NN-nome.md`), conferindo que o arquivo existe (Glob).

## Gate antes de apresentar
1. Reler estas regras (e o `TIPOS.md`, se o card cria tipo; ainda não lido → ler agora) contra o rascunho, inclusive cada palavra do nome do arquivo (idioma do projeto).
2. Sem regra do tipo em `docs/padroes/`: abrir (Read) 1 exemplo real (interface+impl conta como 1) do mesmo tipo e camada; nunca comparar 2 candidatos. Ao introduzir tipo novo em módulo, listar (Glob, 1 nível, sem ler os arquivos) as pastas de 1 outro módulo existente.
3. Correção aplicada → varrer o card por todo padrão igual e corrigir junto; reler o card inteiro e cortar redundância.
