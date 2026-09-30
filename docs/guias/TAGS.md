# Tags e status: guia para Devs

Tags e status ajudam a achar arquivos de documentação e cards sem abrir um por um. A versão que o Claude lê é [../instrucoes/TAGS.md](../instrucoes/TAGS.md), telegráfica de propósito. As duas dizem a mesma coisa.

## A ideia
Cada doc e cada card leva uma linha de tags no topo, por exemplo `tags: [tipo/task, modulo/entregas, fluxo/checkout]`. Para achar tudo de um assunto, o Claude busca essa linha (Grep, uma busca por texto dentro dos arquivos) em vez de ler pasta por pasta.

A ligação entre doc e card é só pela tag em comum. A documentação nunca cita tarefas, e nada quebra quando um arquivo muda de nome ou de lugar.

## Tag de tipo
Toda nota leva também uma tag `tipo/` (`tipo/task`, `tipo/decisao`, `tipo/backlog`, `tipo/modulo`, `tipo/api`, `tipo/fluxo`, `tipo/readme`). Ela não diz o assunto, diz **que tipo de nota é**, e dá a cor a cada nota no grafo do Obsidian: tons quentes para o backlog e frios para a documentação. A exceção são os cards: a cor deles vem do status (pendente, em andamento, concluído...), e não do tipo. O "módulo" do backlog e o "módulo" da documentação usam a mesma tag; o Obsidian os separa pela pasta (`backlog/`), e cada um tem a cor do seu grupo. As skills gravam essa tag sozinhas.

## Tags de assunto
- `modulo/`: o módulo, com o nome da pasta em `docs/modulos`.
- `fluxo/`: o fluxo, com o nome do arquivo em `docs/fluxos`.

## Sem lista de tags
Não há arquivo com a lista. As tags de assunto só usam nomes que já existem: uma pasta de módulo ou um arquivo de fluxo. Se o Claude precisar de uma tag sem correspondente (por exemplo, um fluxo ainda não documentado), ele **propõe e espera você aprovar**. Assim o vocabulário não se espalha (`entrega`, `entregas`, `delivery`).

## Status dos cards
Só cards e decisões têm status, e ele é uma tag (`status/pendente`, `status/concluido`...), igual às outras. Assim o Obsidian consegue filtrar e colorir pelo status (por exemplo, esconder o que já foi concluído com `-tag:#status/concluido`). Cada nota tem exatamente uma tag de status, e o Claude troca só ela quando o andamento muda, sem mexer nas outras. Valores: `pendente` (ao criar), `em-andamento`, `concluido`, `bloqueado`, `cancelado`.

Quem atualiza é o Claude, por uma regra que a skill `configurar-projeto` oferece para o `CLAUDE.md` do projeto: ao iniciar, concluir ou bloquear um card, ele troca a tag de status. Os índices não mostram status, para não ficarem desatualizados. O índice de cada módulo (no backlog e na documentação) leva `tipo/modulo` e `modulo/<m>`; o `backlog.md` e o README levam só a tag de tipo.

## Projeto que já tem docs e cards
A `configurar-projeto` lista as notas sem a tag `tipo/`, propõe tags e status em prévia (`+` e `-`) e só aplica depois da sua aprovação.

## Exemplos de pedido
- "Quais cards estão pendentes?"
- "O que temos sobre o módulo entregas?"
- "Cards pendentes do fluxo checkout."
