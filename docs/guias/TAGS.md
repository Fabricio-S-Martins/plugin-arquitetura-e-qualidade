# Tags: guia para Devs

As tags ajudam a achar arquivos de documentação e cards sem abrir um por um. A versão que o Claude lê é [../instrucoes/TAGS.md](../instrucoes/TAGS.md), telegráfica de propósito. As duas dizem a mesma coisa.

## A ideia
Cada doc e cada card leva uma linha de tags no topo, por exemplo `tags: [backlog, modulo/entregas, fluxo/checkout, tarefa/pendente]`. Para achar tudo de um assunto, o Claude busca essa linha (Grep, uma busca por texto dentro dos arquivos) em vez de ler pasta por pasta.

A ligação entre doc e card é só pela tag em comum. A documentação nunca cita tarefas, e nada quebra quando um arquivo muda de nome ou de lugar.

**As tags não dependem das pastas.** Toda nota leva todas as suas tags, mesmo quando a pasta "já diria" o mesmo. Se um dia você juntar tudo numa pasta só, as buscas por tag continuam funcionando.

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

## Grupo
Toda nota leva uma tag de grupo: `backlog` ou `documentacao`. As skills gravam sozinhas. Ela serve para filtrar o grafo do Obsidian (`tag:#backlog` ou `tag:#documentacao`; guarde cada uma como favorito). Cor e filtros do grafo ficam por sua conta: o plugin não mexe no `graph.json`.

## Estado: tarefa e decisão
O card leva `tarefa/<estado>` e a decisão leva `decisao/<estado>`. Uma tag só diz **o que a nota é** e **em que pé está**. No Obsidian, `tag:#tarefa` lista todos os cards e `-tag:#tarefa/concluido` esconde os concluídos.
- Card: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`.
- Decisão: `aberta`, `decidida`, `adiada`.

O Claude troca só essa tag quando o andamento muda, sem mexer nas outras. Quem pede isso é uma regra que a `configurar-projeto` oferece para o `CLAUDE.md` do projeto. Notas gerais, do módulo e docs não levam estado, para não ficarem desatualizadas.

## Tags de assunto
Três eixos, iguais para card e doc:
- `modulo/`: o módulo.
- `camada/`: a camada (`api`, e depois `dominio`, `aplicacao`... quando você documentar essas camadas).
- `fluxo/`: o comportamento ou fluxo.

Quais notas levam o quê:

| Nota | Tags |
|---|---|
| Geral | `[documentacao]` ou `[backlog]` |
| Módulo | grupo + `modulo/autenticacao` |
| Card | `[backlog, modulo/autenticacao, fluxo/autenticacao-cadastro, tarefa/concluido]` |
| Decisão | `[backlog, modulo/pedidos, decisao/adiada]` |
| Doc de fluxo | `[documentacao, modulo/autenticacao, fluxo/autenticacao-cadastro]` |
| Doc de camada (ex. API) | `[documentacao, modulo/autenticacao, camada/api]` |

A nota do módulo é a que não tem `camada/`, `fluxo/` nem estado. O card herda `fluxo/` e `camada/` das docs do bloco Documentação: se ele não gera doc de domínio, não leva `camada/dominio`. Para documentar algo novo (comportamento, domínio, infra), basta usar um valor desses eixos, sem criar tag nova.

## Sem lista de tags
Não há arquivo com a lista. As tags de assunto só usam nomes que já existem: um módulo, camada ou fluxo já em uso ou documentado. Se o Claude precisar de uma tag sem correspondente (por exemplo, um fluxo ainda não documentado), ele **propõe e espera você aprovar**. Assim o vocabulário não se espalha (`entrega`, `entregas`, `delivery`).

## Projeto que já tem docs e cards
A `configurar-projeto` lista as notas fora do formato, propõe as tags em prévia (`+` e `-`) e só aplica depois da sua aprovação. A migração da 0.17.0 está em [../migracoes/0.17.0.md](../migracoes/0.17.0.md).

## Exemplos de pedido
- "Quais cards estão pendentes?"
- "O que temos sobre o módulo entregas?"
- "Cards pendentes do fluxo checkout."
- "O que temos documentado da API?"
