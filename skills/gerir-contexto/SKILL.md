---
name: gerir-contexto
description: Com o contexto grande, avalia se precisa trocar de sessão; só então gera um prompt de retomada, senão avisa que não precisa. Usar ao informar o uso do contexto, ou pedir trocar de sessão, compactar, prompt de retomada, passar para outro dev ou resumo da conversa.
allowed-tools: Read, Grep, Bash(git status *), Bash(git log *), Bash(git rev-parse *), Bash(git config user.name)
---

# gerir-contexto

Sem pedir permissão (salvo perguntas de Avaliar). Só o que está na conversa: nunca suposição, nunca reler o projeto para "completar". Leituras extras: `git status --short`, branch, hash curto do último commit, `git config user.name`. Não editar código, não criar arquivo.

## Avaliar
Chamada após o usuário conferir o `/context`. Nunca rodar `/context` nem medir o contexto.
- **Ocupação:** a que o usuário informou na conversa; ausente → perguntar uma vez ("quanto o `/context` mostra?").
- **Falta:** estimar pelo que está na conversa (pendências, próximos passos combinados).

| Falta | Saída |
|---|---|
| Pouco, ocupação < 60% | "Não precisa trocar de sessão." Sem prompt. |
| Pouco, ocupação ≥ 60% | Entregar `/compact focar em <o que falta>` para o usuário digitar (a IA não executa `/compact` nem `/clear`). Sem prompt. |
| Muito | Gerar o Prompt. |
| Não dá para estimar | Perguntar ao usuário se falta pouco ou muito para terminar; pouco → tratar como "Pouco"; muito → gerar o Prompt. |

Usuário pediu passar para outro dev → sempre gerar o Prompt.

## Prompt
Ler `${CLAUDE_SKILL_DIR}/PROMPT.md` e seguir (só neste caso).
