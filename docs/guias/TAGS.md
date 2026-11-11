# Tags

As tags ajudam a achar arquivos de documentação e tarefas sem abrir um por um. A versão que o Claude lê é [../instrucoes/TAGS.md](../instrucoes/TAGS.md), telegráfica de propósito. As duas dizem a mesma coisa.

## A ideia
Cada doc, especificação e tarefa leva uma linha de tags no topo, por exemplo `tags: [tarefas, modulo/entregas, fluxo/checkout, tarefa/pendente]`. Para achar tudo de um assunto, o Claude busca essa linha (Grep, uma busca por texto dentro dos arquivos) em vez de ler pasta por pasta.

A ligação entre doc e tarefa é só pela tag em comum. A documentação nunca cita tarefas, e nada quebra quando um arquivo muda de nome ou de lugar.

**As tags não dependem das pastas.** Toda nota leva todas as tags dela, mesmo quando a pasta "já diria" o mesmo. Se um dia tudo for reunido numa pasta só, as buscas por tag continuam funcionando.

## Estrutura simétrica
O projeto tem três grupos com a mesma forma:

```
docs/
├── tarefas/
│   ├── tarefas.md                  visão geral
│   └── modulos/<m>/
│       ├── <m>.md                  nota do módulo
│       └── NN-<nome>.md            tarefa
├── documentacao/
│   ├── documentacao.md             visão geral
│   └── modulos/<m>/
│       ├── <m>.md                  nota do módulo
│       ├── api/
│       └── fluxos/
└── especificacoes/
    ├── especificacoes.md           visão geral
    └── modulos/<m>/
        ├── <m>.md                  regras de negócio do módulo
        └── fluxos/
```

Fluxos que tocam mais de um módulo ficam na pasta do módulo principal (o primeiro citado), e as notas dos outros módulos linkam para eles.

## Grupo
Toda nota leva uma tag de grupo: `tarefas`, `documentacao`, `especificacao`, `decisao`, `ponto-em-aberto`, `excecao-aceita` ou `padrao` (nomes de exemplo: se o projeto já usa outros, valem os dele). O nome do grupo é o do assunto, o mesmo do arquivo e da instrução: sem sigla nem sinônimo. As skills gravam sozinhas. Ela serve para filtrar o grafo do Obsidian (`tag:#tarefas` ou `tag:#documentacao`; cada uma pode virar favorito). Cor e filtros do grafo ficam a cargo do Dev: o plugin não mexe no `graph.json`.

## Estado: tarefa e especificação
A tarefa leva `tarefa/<estado>` e a especificação leva `especificacao/<estado>`. Uma tag só diz **o que a nota é** e **em que pé está**. No Obsidian, `tag:#tarefa` lista todas as tarefas e `-tag:#tarefa/concluido` esconde as concluídas.
- Tarefa: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`.
- Especificação: `rascunho`, `aprovada`, `implementada`, `obsoleta`.

O Claude troca só essa tag quando o andamento muda, sem mexer nas outras. Quem pede isso é uma regra que a `configurar-projeto` oferece para o `CLAUDE.md` do projeto. Notas gerais, do módulo e docs não levam estado, para não ficarem desatualizadas.

## Tags de assunto
Três eixos, iguais para tarefa e doc:
- `modulo/`: o módulo.
- `camada/`: a camada (`api`, e depois `dominio`, `aplicacao`... quando essas camadas forem documentadas).
- `fluxo/`: o comportamento ou fluxo.

Quais notas levam o quê:

| Nota | Tags |
|---|---|
| Geral | `[documentacao]` ou `[tarefas]` |
| Módulo | grupo + `modulo/autenticacao` |
| Tarefa | `[tarefas, modulo/autenticacao, fluxo/autenticacao-cadastro, tarefa/concluido]` |
| Especificação de fluxo | `[especificacao, modulo/autenticacao, fluxo/autenticacao-cadastro, especificacao/aprovada]` |
| Doc de fluxo | `[documentacao, modulo/autenticacao, fluxo/autenticacao-cadastro]` |
| Doc de camada (ex. API) | `[documentacao, modulo/autenticacao, camada/api]` |
| Pontos em aberto (arquivo único) | `[ponto-em-aberto]` |
| Exceções aceitas (arquivo único) | `[excecao-aceita]` |
| Padrão (índice, regra ou modelo de tipo) | `[padrao]`; modelo de uma camada: `[padrao, camada/aplicacao]` |

A nota do módulo é a que não tem `camada/`, `fluxo/` nem estado. A tarefa herda `fluxo/` e `camada/` das docs do bloco Documentação: se ela não gera doc de domínio, não leva `camada/dominio`. Para documentar algo novo (comportamento, domínio, infra), basta usar um valor desses eixos, sem criar tag nova.

## Sem lista de tags
Não há arquivo com a lista. As tags de assunto só usam nomes que já existem: um módulo, camada ou fluxo já em uso ou documentado. Se o Claude precisar de uma tag sem correspondente (por exemplo, um fluxo ainda não documentado), ele **propõe e espera o Dev aprovar**. Assim o vocabulário não se espalha (`entrega`, `entregas`, `delivery`).

## Projeto que já tem docs e tarefas
A `configurar-projeto` lista as notas fora do formato, propõe as tags em texto e só aplica depois da aprovação do Dev. A migração da 0.17.0 está em [../migracoes/0.17.0.md](../migracoes/0.17.0.md).

## Exemplos de pedido
- "Quais tarefas estão pendentes?"
- "O que temos sobre o módulo entregas?"
- "Tarefas pendentes do fluxo checkout."
- "O que temos documentado da API?"

## Por que é assim
- **Tags em frontmatter YAML.** É o formato que o Obsidian (propriedades) e vários geradores de site já leem, então a mesma linha serve ao Claude e a essas ferramentas.
- **Tags numa linha só.** O Claude acha as notas por uma busca de texto (Grep) sem abrir cada arquivo, o que é muito mais barato que ler pasta por pasta.
- **Estados com valores fechados.** Um conjunto fixo evita variações como `pendente`, `em aberto` e `a fazer` para a mesma coisa.
- **O nome da tag é o do assunto.** É a ideia de linguagem onipresente do DDD (Eric Evans, 2003), aplicada aos nomes do plugin: o mesmo nome no arquivo, na instrução, na tag e na conversa, sem sigla nem sinônimo.
