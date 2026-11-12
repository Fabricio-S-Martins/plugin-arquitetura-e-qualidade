# Diagramar

A skill `diagramar` gera um diagrama (fluxograma ou sequencial) e salva em arquivo. Serve para qualquer ocasião, como apresentar um fluxo ao gestor, e não depende de o projeto ter tarefas, módulos ou documentação. A versão que o Claude lê é [../../skills/diagramar/SKILL.md](../../skills/diagramar/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa. As convenções do diagrama ficam em [DIAGRAMAS.md](../instrucoes/DIAGRAMAS.md), lido também pela skill `documentar`.

## Como pedir
- **"Faça um diagrama"**: sem assunto claro, ela pergunta o que mostrar. Com assunto, escolhe o tipo e diz qual escolheu.
- **"Quero um diagrama disso"**: "disso" é o que está na conversa ou o arquivo apontado. O projeto não é lido.
- **"Me dê um diagrama sequencial"**: o tipo pedido é usado. Se não há interação entre atores, ela avisa e propõe o fluxograma.
- **Fluxo do código**: só quando o Dev pede ("diagrama do fluxo de pedidos"). Ela lê até 3 camadas e avisa isso.

## Quando cada tipo
- **Fluxograma:** lógica de decisão e passos de um único ator.
- **Sequencial:** interação entre módulos ou atores (mensagens, eventos, ordem das chamadas).
- **Os dois**, quando o fluxo tem os dois aspectos.

No sequencial, a partir de 3 cenários saem um diagrama por cenário e um completo; com até 2, só o completo. As cores e as setas seguem o padrão em `DIAGRAMAS.md`.

## O que sai
Um arquivo `docs/sessoes/diagrama-<assunto>.md` (ou o caminho pedido) com título, uma linha de objetivo e o(s) diagrama(s). É material de trabalho, fora da documentação do sistema e fora do git. Arquivo existente nunca é sobrescrito: ela pergunta. Tipos além de fluxograma e sequencial seguem as regras gerais (rótulos de negócio, vertical), com aviso de que não há padrão definido.

## Regras
- **Só fatos:** o que o Dev disse ou o código lido. Ator ou passo faltando vira pergunta.
- **Padrão do projeto vence:** o formato sugerido (Mermaid) só vale quando o projeto não define um.
- **Não altera código, não faz commit.**

## Por que é assim
- **Fluxograma e diagrama de sequência da UML, cada um no seu papel.** O fluxograma mostra decisão e passos de um ator; o diagrama de sequência mostra a ordem das mensagens entre atores. Os dois coexistem porque respondem perguntas diferentes.
- **Diagrama como texto (*docs as code*).** Mermaid é versionável, comparável e editável pelo Claude, e renderiza no GitHub, no Obsidian e no VS Code.
- **Skill própria, convenções em um só arquivo.** O diagrama é útil fora da documentação (apresentações, conversas com gestão). Manter as convenções em `DIAGRAMAS.md` evita repetir o padrão em cada skill.
- **Cenário completo e por cenário.** O completo dá a visão inteira; os pequenos permitem ler um caso sem seguir ramos que não interessam. A cor do bloco vive em um só lugar porque o Mermaid não aceita variável de cor.
