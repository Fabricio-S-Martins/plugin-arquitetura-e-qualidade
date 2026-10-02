# Criar card: guia para Devs

A skill `criar-card` gera um card em Markdown a partir de um pedido seu. Este guia explica o que ela faz e como ler o resultado. A versão que o Claude lê é [../../skills/criar-card/SKILL.md](../../skills/criar-card/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Como pedir
Descreva a tarefa em uma ou duas frases. Ex.: "criar card para cadastro de Cliente no módulo Vendas".

## O que sai
Um arquivo `docs/backlog/modulos/<modulo>/tarefas/NN-<nome>.md`, com o próximo número livre na pasta `tarefas/` do módulo, seguindo o [template](../../skills/criar-card/TEMPLATE-CARD.md). A estrutura é sempre a do template — o `CLAUDE.md` do projeto não acrescenta seção nova ao card, mesmo pedindo algo diferente:

- **Título:** verbo no infinitivo mais o que a task entrega, cobrindo todas as frentes. Deve servir como mensagem de commit.
- **Frontmatter:** `tags` (`backlog` mais módulo, fluxo e camada dos documentos que o card toca) e a tag de estado, que começa em `tarefa/pendente`. Veja [TAGS.md](TAGS.md).
- **Cabeçalho:** módulo, camada e dependências.
- **O que fazer:** as regras e decisões da task que o checklist não deixa óbvias, em uma linha cada. Padrões de projeto aplicados são citados pelo nome.
- **Checklist:** o passo a passo, com um bloco para cada camada que a task toca (por exemplo Domínio, Aplicação, Infraestrutura, API, DI & Migrations), em ordem de dependência. O bloco "Documentação" vem em penúltimo: um item para cada documento que a task toca (fluxo, módulo). Task sem código novo (só configuração ou texto) fica sem esse bloco. O bloco "QA & Testes" existe sempre e vem por último. Os blocos são numerados em sequência e os itens usam só letras (`a:`, `b:`...), recomeçando em `a` a cada bloco.

## Como ela lê o projeto
Para não gastar tokens, o Claude consulta o código existente em no máximo 3 camadas, priorizando as que o card cria. Se o projeto tem uma regra do tipo em `docs/padroes/` (veja [CRIAR-REGRA-TELEGRAFICA.md](CRIAR-REGRA-TELEGRAFICA.md)), ele lê só ela; senão compara com 1 arquivo irmão real do mesmo tipo e camada. Em nenhum caso varre o projeto. Se a camada ou o módulo não estiver claro, ele pergunta.

## O que você vai notar nos itens
- Cada item é uma ação direta: verbo, o quê e onde.
- Todo arquivo ou pasta diz onde fica. Projeto novo é um passo só ("Na pasta X/, criar o projeto Y"), porque a pasta do projeto já vem com ele; pastas que não vêm de graça (agrupadora do módulo, internas ao projeto) têm passo próprio.
- Objeto de dados sem comportamento (request, response, VO simples) já sai com a construção imutável da linguagem indicada no passo, em vez de esperar a revisão.
- Validações trazem critério concreto. Se faltar, o Claude pergunta em vez de inventar.
- Nomes de arquivos, classes, pastas e projetos são 100% em português (exceto tipos impostos por biblioteca).
- Passos mecânicos de convenção fixa (registrar na solution, referenciar entre projetos) ficam de fora.

## Escopo
- **Escopo mínimo:** o card cobre só o que foi pedido. Ideias extras vão como sugestão, fora do card.
- **Card grande demais:** com mais de uns 8 itens ou mais de um módulo, a skill propõe quebrar em cards ligados por dependências.
- **Prévia:** para ver como ficaria a alteração de um card existente antes de aplicar, peça a prévia (`+` e `-`).
- **Backlog:** o `docs/backlog/backlog.md` só linka o índice de cada módulo (`docs/backlog/modulos/<modulo>/<modulo>.md`); a linha da task nova (link `tarefas/<card>.md`) é adicionada nesse índice, não no `backlog.md`. Inconsistência numa linha existente é sinalizada, nunca corrigida sem pedido. O índice do módulo leva `backlog` e `modulo/<m>`, sem estado.
- **Depende de uma decisão:** se o card depende de uma decisão ainda `aberta` ou `adiada` (`<modulo>/decisoes/<nome>` em Deps), ele sai com `tarefa/bloqueado`. Quando o card nasce de uma decisão, a escolha e o motivo entram numa linha `**Decisão:**` em "O que fazer" e a decisão é apagada (com o seu ok). Veja [REGISTRAR-DECISAO.md](REGISTRAR-DECISAO.md).
