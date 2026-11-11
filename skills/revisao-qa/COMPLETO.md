# Modo completo

Acrescenta ao modo rápido.

## Fontes
Do projeto ativo, se existirem: `MEMORY.md` (só o índice; abrir apenas os arquivos cujo resumo se relaciona ao alvo), `CLAUDE.md` (só armadilhas conhecidas) e `.editorconfig` e analisadores (linters) do projeto. Armadilhas e decisões específicas vêm de lá, nunca de memória. O que já quebra o build (analisador em `warning`/`error`) não se re-flaga; confirmar que cobre antes de pular. Faltou fonte → dizer.

## Passos
- Arquivo tocado até ~400 linhas: julgar inteiro; violação fora das linhas alteradas também é achado, rotulada `(pré-existente)`. Acima disso: ler só os trechos apontados pelo diff e pelos Grep, e declarar no relatório.
- Regra do tipo em `docs/padroes/modelos/` (Glob), se houver, no lugar do irmão (modelo base: particularidade do alvo não é achado). Sem regra, abrir até 3 arquivos irmãos reais, do mesmo tipo e da mesma camada, o mais recente, o mais parecido e um de outra unidade (achar com Glob; divergiram → apontar como achado); comparar convenções com o código real, não com memória.
- Apontar tudo que destoa dos irmãos (estilo, nomes, estrutura), não só bugs.
