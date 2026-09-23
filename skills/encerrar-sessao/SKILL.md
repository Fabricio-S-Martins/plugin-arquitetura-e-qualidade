---
name: encerrar-sessao
description: Encerra ou troca de sessão sem perder contexto, inclusive para outro dev continuar. Gera um documento de retomada em .md e um prompt curto que aponta para ele. Usar ao pedir encerrar sessão, compactar, prompt de retomada, continuar em outra sessão, passar para outro dev ou resumo da conversa.
allowed-tools: Read, Glob, Grep, Write, Edit, Bash(wc *), Bash(git status *), Bash(git log *), Bash(git rev-parse *), Bash(git config user.name), Bash(mkdir *)
---

# encerrar-sessao

Executar sem pedir permissão. Só o que está na conversa: nunca suposição, nunca reler o projeto para "completar". Leituras extras: `git status --short`, branch, hash curto do último commit, `git config user.name`, o `.md` do tema se existir. Não editar código, não commitar.

Leitor: outra sessão da IA ou outro dev, sem ter visto a conversa. O documento é autocontido e fonte única; o prompt só aponta para ele.

## Fluxo
1. **Inventário:** percorrer a conversa e separar o conteúdo por seção do Documento. Item só no chat vale como perdido: entra no documento.
2. **Documento:** `docs/sessoes/<tema>.md`; tema = frente de trabalho em pt-br, minúsculas com hífen, nunca a data. Glob em `docs/sessoes/*.md` antes: frente já coberta por um arquivo → reusar o tema; dúvida → reusar o mais próximo e dizer qual no fechamento; nenhum serve → novo tema. Existe → mesclar: reescrever o estado atual, manter decisões e descartes ainda válidos, remover o resolvido. Ausente → criar (`mkdir` se preciso).
3. **Git:** `.gitignore` do projeto sem `docs/sessoes/` → acrescentar a linha.
4. **Fechar:** no chat, o prompt em bloco de código, o caminho do documento e 1 linha: para outro dev, enviar o arquivo (fora do git) junto com o prompt; depois pode dar `/clear`.

## Documento
Títulos fixos, nesta ordem. Frases curtas, uma ideia por item, caminhos e nomes exatos entre crases, datas AAAA-MM-DD, terceira pessoa ("o usuário decidiu"; nunca "você" nem "nós"), termo técnico explicado uma vez. Seção vazia → omitir. Máx. ~80 linhas; acima disso, cortar detalhe de Estado e Depois disso antes de encurtar o porquê das decisões.
- **Cabeçalho:** `# <tema>` e uma linha: `Atualizado: data · dev · branch · commit · git limpo | sujo (o quê)`.
- **Objetivo:** 1-2 frases: o que a frente busca e por quê.
- **Estado:** feito (marcar testado ou não testado) e pendente.
- **Próximo passo:** um só, concreto, com o arquivo onde começar.
- **Decisões (não reabrir):** decisão + porquê.
- **Descartado:** opção + motivo.
- **Não fazer:** armadilhas.
- **Regras do usuário:** só as dadas na conversa e que o `CLAUDE.md` do projeto não traz (idioma, formato, limites).
- **Em aberto:** pergunta + quem responde; nunca assumir.
- **Depois disso:** demais passos, em ordem.
- **Ler antes de agir:** caminho + motivo.

## Prompt
```
Retomar <tema>: ler docs/sessoes/<tema>.md e seguir o "Próximo passo".
Sem presumir, deve ler.
```

## Gate antes de fechar
Falhou algum item → corrigir antes de apresentar.
1. Grep no documento: "você", "vocês", "nós" → 0 ocorrências.
2. `wc -l` do documento ≤ ~80.
3. Reler "Documento" contra o arquivo: cabeçalho completo, ordem dos títulos, sem seção vazia, um só próximo passo, porquê em toda decisão, motivo em todo descarte.
4. `.gitignore` contém `docs/sessoes/`.
5. Prompt: 2 linhas, termina com "Sem presumir, deve ler."
6. Nenhum código editado, nada commitado.
7. "Pendente"/"Próximo passo" cita arquivo + trecho específico → 1 Grep pontual nesse trecho antes de fechar; achado já resolvido → mover para "Feito", nunca deixar pendência desatualizada.
