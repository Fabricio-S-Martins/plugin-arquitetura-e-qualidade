# executar-tarefa

Executa um card sem pular a checagem de dependências.

- **Dependência pendente:** para e avisa o que falta; você decide se segue.
- **Especificação:** se o card cita uma, ela precisa estar aprovada, senão o tratamento é o de dependência pendente. O critério da especificação manda; se o card discorda dela, para e pergunta. Ao concluir, quando todos os cards que a citam estão concluídos, a especificação vira `implementada`.
- **Cadeia:** lista os cards que dependem do bloqueado; só muda a tag do que você aprovar.
- **Em andamento:** o card vira `em-andamento` ao começar e, com algum item marcado, só sai disso para `concluido`.
- **Ao concluir:** tira o card das Dependências dos que dependiam dele (apaga a linha se esvaziar) e libera os que ficaram sem nenhuma.
- **Por partes:** "faz a seção 1 do card 02" executa só ela. Documentação fica `[ ]` até você pedir; o card segue `em-andamento`. Com o card todo, a Documentação é feita pela skill `documentar`, um doc por vez.
- **Sub-itens:** "item b" executa o item e todos os sub-itens; "1.b.2" ou "item b.2" executa só aquele, lendo o item pai para saber a pasta. O item pai só é marcado quando todos os sub-itens estão marcados.
- **Padrão do projeto:** segue os padrões do projeto em `docs/padroes/` (práticas, convenções e modelos de tipo) e os princípios de qualidade do plugin (KISS, YAGNI, DRY, SRP). Em pasta ou arquivo novo, confere se a estrutura é igual à das outras unidades e se existe o espelho em docs, backlog e testes.
- **Build:** sempre compila antes de fechar (comando do `CLAUDE.md`; sem ele, ela pergunta qual é). Com erro, corrige dentro do card e não marca nada como feito.
