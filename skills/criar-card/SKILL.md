---
name: criar-card
description: Cria card de tarefa em .md a partir do template. Usar ao pedir para criar/planejar card, task ou TASK-XXX.
---

# criar-card

Ler `docs/instrucoes/QUALIDADE.md` (plugin). Criar `cards/TASK-XXX.md` (próximo ID livre, ou pasta do projeto) a partir de `TEMPLATE-CARD.md`, sem alterar a estrutura. Blocos do checklist: 1 por camada que a task toca, em ordem de dependência (ex: Domínio, Aplicação, Infraestrutura, API, DI & Migrations), nomes da arquitetura do projeto; `Documentação` penúltimo e `QA & Testes` sempre por último. Numerar em sequência, sem pular. Itens: `**[ ] a:**`, letra reiniciando em `a` a cada bloco.

## Escopo de leitura
Consultar o código existente em no máximo 3 camadas, priorizando as que o card cria. Achar com Glob, filtrar com Grep, só então Read; nunca varrer o projeto. Camada/módulo não claro → perguntar.

## Regras
- **Título:** verbo no infinitivo + o que entrega, cobrindo todas as frentes; serve de mensagem de commit. Sem prefixo de camada.
- **O que fazer:** regras e decisões da task que o checklist não deixa óbvias, 1 linha cada (`**Tema:** regra`). Não repetir itens do checklist. Padrão de projeto aplicado citado pelo nome. Sem conteúdo → remover seção.
- **Checklist:** 1 ação direta por item (verbo + o quê + onde), sem justificativa nem parênteses redundantes. Sem seções duplicadas ("Arquivos a criar", "Contrato do endpoint"): rota, entrada, saída e status do endpoint vão no item que o cria.
- **Localização:** todo arquivo/pasta diz onde fica. Ordem: pasta → arquivo → conteúdo. Pasta e arquivo de mesmo nome = passos separados.
- **Sem passos mecânicos** de convenção fixa (registrar na solution, referência entre projetos, apagar arquivo de template).
- **Validações:** critério concreto (tamanho, formato, valores). Não definido → perguntar, nunca inventar.
- **Tipo novo:** um tipo por vez, completo, antes do próximo. Ordem: props → construtores (parâmetros recebidos; props preenchidas internamente, como Id, à parte, com o valor exato) → fábrica e validações.
- **DTO/Command/Query:** forma em prosa, não assinatura; tipo entre parênteses só se não óbvio.
- **Agregado com filhos:** copiar 1 par pai/filho equivalente já existente no repo. Pai nasce sem filhos; filho entra por método do pai, que valida e cria; coleção interna privada exposta como somente leitura.
- **Consistência:** nenhum membro citado sem definição no passo do tipo. Usar expressão exata do código (`resultado.Sucesso == false`).
- **Cobertura:** tecnologia nova → passo de registro/config (DI) e dependências de suporte; mecanismo não óbvio → "como" passo a passo; operação com resultado → retorno explícito; segurança/criptografia (erro silencioso) → prioridade e task de teste dedicada.
- **Nomes:** 100% pt-br (arquivo, classe, pasta, projeto). Exceção: tipo imposto por biblioteca/framework; a classe própria que o implementa traduz. Checar cada palavra antes de escrever.
- **Documentação:** task que cria/altera código → bloco com 1 item por doc do que a task toca (fluxo, módulo) + item final perguntando ao Dev se quer o plano do restante. Task sem código novo (só config/texto) → omitir o bloco.
- **Testes:** descrever cenários, não nomes de método.
- **Card existente:** ver a mudança antes de aplicar → `previa-diff`.
- **Escopo (YAGNI):** só o pedido; extras como sugestão fora do card. Mais de ~8 itens ou mais de um módulo → propor quebra com Deps.

## Gate antes de apresentar
1. Reler estas regras contra o rascunho, linha a linha.
2. Abrir (Read) 1 arquivo irmão real do mesmo tipo e da mesma camada; ao introduzir tipo novo em módulo, listar (Glob, 1 nível, sem ler os arquivos) as pastas de 1 outro módulo existente.
3. Correção aplicada → varrer o card por todo padrão igual e corrigir junto; reler o card inteiro e cortar redundância.
