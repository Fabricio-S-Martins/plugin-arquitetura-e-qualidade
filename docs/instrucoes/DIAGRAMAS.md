# Diagramas
Padrão de diagrama do projeto vale; abaixo é sugestão sem padrão (exemplo: Mermaid). Rótulos em linguagem de negócio, sem termo técnico (salvo público técnico informado).
## Quando
- Fluxograma (`flowchart TD`, vertical): lógica de decisão e passos de um ator. Decisão em losango; rótulos entre aspas. Laço de volta: sai da decisão para um passo de ação, que volta ao passo anterior; nunca direto da decisão.
- Sequencial (`sequenceDiagram`): interação entre módulos/atores (mensagens, eventos, ordem das chamadas).
- Fluxo com os dois aspectos → os dois.
## Sequencial
- `participant G as Pagamentos`: alias curto, nome de negócio.
- Setas: `->>` chamada · `-->>` retorno · `-)` evento assíncrono · `--x` falha.
- Cor do `rect` (exemplo; Mermaid não aceita variável; cinza médio transparente, legível em tema claro e escuro): `rgba(122, 122, 122, 0.3)`. Valor só aqui; copiar daqui; mudar = find/replace.
- Formatos: 3+ cenários → por cenário e completo; até 2 → só completo. Em fluxo documentado ficam dentro da seção `Diagrama`, subtítulos "Por cenário" e "Completo" (completo por último).
- Por cenário: 1 diagrama por caso, autossuficiente (parte do início do fluxo, sem pular passos); frase de resumo sob o título, só o que acontece naquele caso; mensagens idênticas às do completo.
- Completo: 1 diagrama; cada cenário em `rect` + `Note` de título; só um ocorre por execução. Pergunta de decisão fora do `rect`, resposta dentro. `Note` separadora ("apenas uma ocorre") nas alternativas exclusivas.
## Gate
- Bloco fechado.
- Fluxograma: decisão em losango; rótulos entre aspas.
- Sequencial: cor do `rect` igual à desta instrução (Grep); mensagens dos cenários idênticas às do completo.
