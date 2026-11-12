---
name: diagramar
description: Gera diagrama (fluxograma ou sequencial) e salva em arquivo. Usar ao pedir "faça um diagrama", "quero um diagrama disso", "me dê um diagrama sequencial" ou para apresentar um fluxo ou interação.
allowed-tools: Read, Write, Glob, Grep, Bash(git check-ignore *)
---

# diagramar

Só cria o arquivo do diagrama: nunca editar código nem arquivo existente (sem `Edit` em `allowed-tools`); não commitar.
1. **Pedido:** assunto e tipo. Assunto não claro → perguntar uma vez, sem adivinhar. "Disso" = conversa ou arquivo/trecho apontado: não ler o projeto. Fluxo do código, só sob pedido: Glob → Grep → Read, até 3 camadas; avisar que lê só isso e que o Dev pode pedir mais (vale só nesta execução).
2. **Padrão:** ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/DIAGRAMAS.md`. Padrão de diagrama do projeto vence. Tipo pedido → usar; sem tipo → escolher pela tabela "Quando" e dizer qual. Sequencial pedido sem interação entre atores → avisar e propor fluxograma. Tipo fora de fluxograma/sequencial → regras gerais (rótulos de negócio, vertical) e avisar que não há padrão definido.
3. **Fatos:** só do que o Dev disse ou do código lido. Ator ou passo faltando → perguntar; nunca inventar.
4. **Gate:** bloco fechado; fluxograma com rótulos entre aspas; sequencial com cor do `rect` igual à de `DIAGRAMAS.md` e mensagens dos cenários idênticas às do completo (conferir com Grep no arquivo gerado). Corrigir antes de entregar.
5. **Salvar sempre:** `docs/sessoes/diagrama-<assunto>.md` (ou o caminho pedido; pasta de sessões com outro nome no projeto → usar essa). Conteúdo: título, 1 linha de objetivo, diagrama(s). Arquivo existe → perguntar; nunca sobrescrever. Pasta não ignorada pelo git (`git check-ignore`) → avisar; não editar `.gitignore`. Responder só caminho e tipo usado.
