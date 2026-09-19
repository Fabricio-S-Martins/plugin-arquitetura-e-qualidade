# Modo completo

Acrescenta ao modo rápido.

## Fontes
Do projeto ativo, se existirem: `MEMORY.md` (só o índice; abrir apenas os arquivos cujo resumo se relaciona ao alvo), `CLAUDE.md` (só armadilhas conhecidas) e `.editorconfig`/analyzers. Armadilhas e decisões específicas vêm de lá, nunca de memória. O que já quebra o build (analyzer em `warning`/`error`) não se re-flaga; confirmar que cobre antes de pular. Faltou fonte → dizer.

## Passos
- Arquivo tocado até ~400 linhas: julgar inteiro; violação fora das linhas alteradas também é achado, rotulada `(pré-existente)`. Acima disso: ler só os trechos apontados pelo diff e pelos Grep, e declarar no relatório.
- Abrir 1 arquivo irmão real, do mesmo tipo e da mesma camada (achar com Glob); comparar convenções com o código real, não com memória.
- Apontar tudo que destoa dos irmãos (estilo, nomes, estrutura), não só bugs.
