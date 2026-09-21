# Criar card: guia para Devs

A skill `criar-card` gera um card em Markdown a partir de um pedido seu. Este guia explica o que ela faz e como ler o resultado. A versão que o Claude lê é [../../skills/criar-card/SKILL.md](../../skills/criar-card/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Como pedir
Descreva a tarefa em uma ou duas frases. Ex.: "criar card para cadastro de Cliente no módulo Vendas".

## O que sai
Um arquivo `cards/TASK-XXX.md`, com o próximo número livre, seguindo o [template](../../skills/criar-card/TEMPLATE-CARD.md):

- **Título:** verbo no infinitivo mais o que a task entrega, cobrindo todas as frentes. Deve servir como mensagem de commit.
- **Cabeçalho:** módulo, camada, status (começa em "a fazer") e dependências.
- **O que fazer:** as regras e decisões da task que o checklist não deixa óbvias, em uma linha cada. Padrões de projeto aplicados são citados pelo nome.
- **Checklist:** o passo a passo, com um bloco para cada camada que a task toca (por exemplo Domínio, Aplicação, Infraestrutura, API, DI & Migrations), em ordem de dependência. O bloco "Documentação" vem em penúltimo: um item para cada documento que a task toca (fluxo, módulo) e um último item que pergunta se você quer o plano de documentação do restante. Task sem código novo (só configuração ou texto) fica sem esse bloco. O bloco "QA & Testes" existe sempre e vem por último. Os blocos são numerados em sequência e os itens usam só letras (`a:`, `b:`...), recomeçando em `a` a cada bloco.

## Como ela lê o projeto
Para não gastar tokens, o Claude consulta o código existente em no máximo 3 camadas, priorizando as que o card cria. Ele compara com 1 arquivo irmão real do mesmo tipo e camada, sem varrer o projeto. Se a camada ou o módulo não estiver claro, ele pergunta.

## O que você vai notar nos itens
- Cada item é uma ação direta: verbo, o quê e onde.
- Todo arquivo ou pasta diz onde fica.
- Validações trazem critério concreto. Se faltar, o Claude pergunta em vez de inventar.
- Nomes de arquivos, classes, pastas e projetos são 100% em português (exceto tipos impostos por biblioteca).
- Passos mecânicos de convenção fixa (registrar na solution, referenciar entre projetos) ficam de fora.

## Escopo
- **Escopo mínimo:** o card cobre só o que foi pedido. Ideias extras vão como sugestão, fora do card.
- **Card grande demais:** com mais de uns 8 itens ou mais de um módulo, a skill propõe quebrar em cards ligados por dependências.
- **Prévia:** para ver como ficaria a alteração de um card existente antes de aplicar, peça a prévia (`+` e `-`).
