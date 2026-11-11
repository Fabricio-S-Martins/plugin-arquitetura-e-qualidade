# EXCECOES-ACEITAS

Registro fixo das particularidades aceitas: onde o projeto, de propósito, não segue uma regra sua (compatibilidade, limitação, caso específico), com o motivo. Só cresce; sai uma linha só se a exceção deixar de existir. Opcional: só onde o `CLAUDE.md` do projeto tem a linha deste assunto. Nomes de arquivo, pasta e tag citados são exemplo: valem os do projeto.
- **Entra:** desvio pontual decidido pelo Dev ou pelo time (vindo da triagem de `PONTOS-EM-ABERTO.md` ou dito direto). **Fora:** escolha estrutural difícil de reverter (`DECISOES.md`) e desvio que se vai corrigir (tarefa).
- **Arquivo:** um só, na raiz de `docs/` (Grep `tags:.*excecao-aceita` em `docs/`; ausente → perguntar o nome, sugerindo `docs/excecoes-aceitas.md`). Nasce no 1º registro, com ok do Dev. Tags: `TAGS.md`. Não é área com unidades: sem índice nem espelho.
- **Uma exceção, uma linha**, com a área escrita nela entre colchetes: o Grep devolve a exceção inteira sem abrir o arquivo.
- **Ler:** quem toca um módulo faz Grep `modulo/<m>[],]` no arquivo e lê só essas linhas. Exceção aceita manda: nunca "corrigir" o desvio ao editar, nunca apontá-lo na revisão. Conflito com plano ou tarefa → parar e perguntar. Nunca ler o arquivo inteiro sem pedido.
- **Registrar:** só com pedido ou aceite do Dev; gravar no fim (Edit), sem ler o resto. Antes, Grep pelo módulo para não duplicar. Motivo vazio ou vago → perguntar: sem motivo não é exceção, é ponto em aberto.
- **Imutável em essência:** o motivo mudou ou a exceção acabou → o Dev decide; corrigir o texto, ou apagar a linha se o desvio deixou de existir.

## Linha (arquivo existente no projeto → seguir o formato dele)
```
- <regra do projeto que não vale aqui> — <onde: módulo, arquivo ou símbolo> — <motivo> — [modulo/<m>, fluxo/<f> se houver] — <data>
```
