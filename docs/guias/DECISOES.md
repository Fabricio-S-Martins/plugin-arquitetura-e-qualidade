# Decisões de arquitetura

A decisão é o registro de uma escolha estrutural e do porquê dela. Serve para o time (daqui a meses) e para a IA não reabrirem uma discussão já resolvida nem sugerirem uma alternativa que já foi descartada. O padrão por trás é o **ADR** (*Architecture Decision Record*), descrito por Michael Nygard em 2011. A versão que o Claude lê é [../instrucoes/DECISOES.md](../instrucoes/DECISOES.md), telegráfica de propósito.

É opcional. O plugin só oferece; o projeto decide se adota. Para adotar, basta aceitar a pergunta do `configurar-projeto`, que cria a área de decisões (só o índice). O molde da decisão é do plugin e não é copiado para `docs/padroes/`, que guarda só o que é exclusivo do projeto. Projeto que não adotou nunca recebe sugestão de decisão.

## O que vira decisão
Escolha estrutural difícil de reverter: tecnologia, framework, fronteira entre módulos, uma proibição. Escolha que vale só para uma tarefa fica no arquivo da própria tarefa (`**Decisão:**`); regra de negócio fica na especificação; um desvio pontual aceito vai para as [exceções aceitas](EXCECOES-ACEITAS.md).

## Como nasce
Nunca sem o aceite do Dev:
- No plano, a decisão vem marcada `decisão proposta`. Se o Dev aceitar, ela é gravada junto com as tarefas.
- Ao concluir uma tarefa com `Retomada`, a decisão é um dos destinos possíveis das escolhas que valem além da tarefa.
- Na triagem dos [pontos em aberto](PONTOS-EM-ABERTO.md), um achado aceito e estrutural também vira decisão.

## O que tem nela
Três campos, para a IA ler rápido: **Decisão e porquê**, **Descartado** (com o motivo) e **Não fazer**. O estado vai na tag: `proposta`, `aceita` ou `substituida`. Fica na pasta da unidade (módulo) a que pertence; decisão que vale para o projeto todo tem unidade própria.

## Como é usada
Quem toca um módulo lê as decisões aceitas dele. A decisão aceita manda: se a demanda a contraria, a IA para e pergunta. Ela nunca bloqueia tarefa nem entra em Dependências.

## Mudou de ideia?
A decisão não é editada. Cria-se uma nova e a antiga ganha só a tag `substituida` e um link para a nova. O histórico fica inteiro.

## Por que é assim
- **Segue o ADR de Nygard.** O texto original (2011) tem título, contexto, decisão, status e consequências, em uma ou duas páginas. Quando uma decisão é revertida, mantém-se a antiga, marcada como substituída com referência à nova; o plugin adota esse encadeamento. A regra de nunca editar o texto da antiga é do plugin. Os três campos (**Decisão e porquê**, **Descartado**, **Não fazer**) são uma adaptação, pensada para a IA: guardam o que mais evita reabrir discussões e sugerir de novo uma alternativa recusada.
- **Só escolha difícil de reverter.** O ADR existe para decisões que custam caro de desfazer. Para o que é pequeno, existem o `**Decisão:**` da tarefa e as exceções aceitas, que são mais leves.
- **Nome em português, padrão conhecido.** O assunto se chama "decisão" e a tag é `decisao` (sem acento, como toda tag), porque o nome da tag segue o do assunto (ver [TAGS.md](TAGS.md)); ADR continua sendo o nome do padrão para quem quiser pesquisar mais.
