# executar-tarefa

Executa um card sem pular a checagem de dependências.

- **Dependência pendente:** para e avisa o que falta; você decide se segue.
- **Cadeia:** lista os cards que dependem do bloqueado; só muda a tag do que você aprovar.
- **Por partes:** "faz a seção 1 do card 02" executa só ela. Documentação fica `[ ]` até você pedir; o card segue `em-andamento`. Com o card todo, a Documentação é feita pela skill `documentar`, um doc por vez.
- **Build:** sempre compila antes de fechar (comando do `CLAUDE.md` ou `dotnet build` na solution). Com erro, corrige dentro do card e não marca nada como feito.
