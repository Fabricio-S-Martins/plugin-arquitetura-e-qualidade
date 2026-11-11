# executar-tarefa

Executa uma tarefa sem pular a checagem de dependências.

- **Dependência pendente:** para e avisa o que falta; o Dev decide se segue.
- **Especificação:** se a tarefa cita uma, ela precisa estar aprovada, senão o tratamento é o de dependência pendente. O critério da especificação manda; se a tarefa discorda dela, para e pergunta. Ao concluir, quando todas as tarefas que a citam estão concluídas, a especificação vira `implementada`.
- **Cadeia:** lista as tarefas que dependem do bloqueado; só muda a tag do que o Dev aprovar.
- **Em andamento:** a tarefa vira `em-andamento` ao começar e, com algum item marcado, só sai disso para `concluido`.
- **Ao concluir:** tira a tarefa das Dependências das que dependiam dela (apaga a linha se esvaziar) e libera as que ficaram sem nenhuma.
- **Por partes:** "faz a seção 1 da tarefa 02" executa só ela. Documentação fica `[ ]` até o Dev pedir; a tarefa segue `em-andamento`. Com a tarefa toda, a Documentação é feita pela skill `documentar`, um doc por vez.
- **Sub-itens:** "item b" executa o item e todos os sub-itens; "1.b.2" ou "item b.2" executa só aquele, lendo o item pai para saber a pasta. O item pai só é marcado quando todos os sub-itens estão marcados.
- **Padrão do projeto:** segue os padrões do projeto em `docs/padroes/` (práticas, convenções e modelos de tipo) e os princípios de qualidade do plugin (KISS, YAGNI, DRY, SRP). Em pasta ou arquivo novo, confere se a estrutura é igual à das outras unidades e se existe o espelho em docs, tarefas e testes.
- **Retomada:** se a tarefa tem a seção `Retomada` (gravada pelo `gerir-contexto` ao trocar de sessão), ela é lida primeiro: decisões e descartes valem, dúvida em aberto vira pergunta ao Dev. Ao concluir, ela pergunta o destino de cada decisão que vale além da tarefa (linha `**Decisão:**`, especificação ou o destino do projeto) e só então apaga a seção.
- **Build:** sempre compila antes de fechar (comando do `CLAUDE.md`; sem ele, ela pergunta qual é). Com erro, corrige dentro da tarefa e não marca nada como feito.

## Por que é assim
- **Dependências conferidas antes de começar.** É parecido com a definição de pronto para começar (*Definition of Ready*) usada por times ágeis: não se inicia o que ainda depende de algo que não existe.
- **Build antes de fechar.** É a regra da integração contínua: não se dá por pronto o que quebra a compilação.
- **A especificação manda sobre a tarefa.** A tarefa é o como; a especificação é o que foi combinado. Se divergem, a skill para e pergunta em vez de escolher.
