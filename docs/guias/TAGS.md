# Tags e status: guia para Devs

Tags e status ajudam a achar arquivos de documentação e cards sem abrir um por um. A versão que o Claude lê é [../instrucoes/TAGS.md](../instrucoes/TAGS.md), telegráfica de propósito. As duas dizem a mesma coisa.

## A ideia
Cada doc e cada card leva uma linha de tags no topo, por exemplo `tags: [backlog/tarefa, modulo/entregas, fluxo/checkout, status/pendente]`. Para achar tudo de um assunto, o Claude busca essa linha (Grep, uma busca por texto dentro dos arquivos) em vez de ler pasta por pasta.

A ligação entre doc e card é só pela tag em comum. A documentação nunca cita tarefas, e nada quebra quando um arquivo muda de nome ou de lugar.

## Estrutura simétrica
O projeto tem dois grupos com a mesma forma:

```
docs/
├── backlog/
│   ├── backlog.md                  visão geral
│   └── modulos/<m>/
│       ├── <m>.md                  nota do módulo
│       ├── tarefas/
│       └── decisoes/
└── documentacao/
    ├── documentacao.md             visão geral
    └── modulos/<m>/
        ├── <m>.md                  nota do módulo
        ├── api/
        └── fluxos/
```

Fluxos e decisões que tocam mais de um módulo ficam na pasta do módulo principal (o primeiro citado), e as notas dos outros módulos linkam para eles.

## Tag de tipo
Toda nota leva uma tag que diz **que tipo de nota é**. O prefixo é o nome da pasta do grupo:

| Grupo | Visão geral | Módulo | Conteúdo |
|---|---|---|---|
| backlog | `backlog/geral` | `backlog/modulo` | `backlog/tarefa`, `backlog/decisao` |
| documentacao | `documentacao/geral` | `documentacao/modulo` | `documentacao/api`, `documentacao/fluxo` |

As skills gravam essa tag sozinhas. Ela serve para você colorir e filtrar o grafo do Obsidian, configuração que fica por sua conta: o plugin não mexe no `graph.json`.

**Dica para as visões do grafo:** digite `tag:#backlog` (só o backlog) ou `tag:#documentacao` (só a documentação) no filtro do grafo, e guarde cada uma como favorito. A tag pai pega todas as filhas, e, como a separação é por tag, renomear uma pasta não quebra nada.

## Tags de assunto
- `modulo/`: o módulo, com o nome da pasta do módulo.
- `fluxo/`: o fluxo, com o nome do arquivo em `fluxos/`.

As notas do módulo levam `modulo/<m>`; as visões gerais levam só a tag de tipo.

## Sem lista de tags
Não há arquivo com a lista. As tags de assunto só usam nomes que já existem: uma pasta de módulo ou um arquivo de fluxo. Se o Claude precisar de uma tag sem correspondente (por exemplo, um fluxo ainda não documentado), ele **propõe e espera você aprovar**. Assim o vocabulário não se espalha (`entrega`, `entregas`, `delivery`).

## Status dos cards
Só cards e decisões têm status, e ele é uma tag (`status/pendente`, `status/concluido`...), igual às outras. Assim o Obsidian consegue filtrar e colorir pelo status (por exemplo, esconder o que já foi concluído com `-tag:#status/concluido`). Cada nota tem exatamente uma tag de status, e o Claude troca só ela quando o andamento muda, sem mexer nas outras. Valores: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`.

Quem atualiza é o Claude, por uma regra que a skill `configurar-projeto` oferece para o `CLAUDE.md` do projeto: ao iniciar, concluir ou bloquear um card, ele troca a tag de status. As notas gerais e do módulo não levam status, para não ficarem desatualizadas.

## Projeto que já tem docs e cards
A `configurar-projeto` lista as notas sem tag de tipo, propõe tags e status em prévia (`+` e `-`) e só aplica depois da sua aprovação.

## Exemplos de pedido
- "Quais cards estão pendentes?"
- "O que temos sobre o módulo entregas?"
- "Cards pendentes do fluxo checkout."
