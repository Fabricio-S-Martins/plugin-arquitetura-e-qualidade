# executar-tarefa

Executa um card sem pular a checagem de dependências.

- **Dependência pendente:** para e avisa o que falta; você decide se segue.
- **Cadeia:** lista os cards que dependem do bloqueado; só muda a tag do que você aprovar.
- **Em andamento:** o card vira `em-andamento` ao começar e, com algum item marcado, só sai disso para `concluido`.
- **Ao concluir:** tira o card das Dependências dos que dependiam dele (apaga a linha se esvaziar) e libera os que ficaram sem nenhuma.
- **Por partes:** "faz a seção 1 do card 02" executa só ela. Documentação fica `[ ]` até você pedir; o card segue `em-andamento`. Com o card todo, a Documentação é feita pela skill `documentar`, um doc por vez.
- **Sub-itens:** "item b" executa o item e todos os sub-itens; "1.b.2" ou "item b.2" executa só aquele, lendo o item pai para saber a pasta. O item pai só é marcado quando todos os sub-itens estão marcados.
- **Build:** sempre compila antes de fechar (comando do `CLAUDE.md` ou `dotnet build` na solution). Com erro, corrige dentro do card e não marca nada como feito.
