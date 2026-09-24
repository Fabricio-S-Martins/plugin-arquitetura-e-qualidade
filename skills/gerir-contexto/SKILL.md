---
name: gerir-contexto
description: Com o contexto grande, avalia se precisa trocar de sessão; só então gera um prompt de retomada, senão avisa que não precisa. Usar ao informar o uso do contexto, ou pedir trocar de sessão, compactar, prompt de retomada, passar para outro dev ou resumo da conversa.
allowed-tools: Read, Grep, Bash(git status *), Bash(git log *), Bash(git rev-parse *), Bash(git config user.name)
---

# gerir-contexto

Sem pedir permissão (salvo perguntas de Avaliar). Só o que está na conversa: nunca suposição, nunca reler o projeto para "completar". Leituras extras: `git status --short`, branch, hash curto do último commit, `git config user.name`. Não editar código, não criar arquivo, não commitar.

Leitor do prompt: outra sessão da IA ou outro dev, sem ter visto a conversa. O prompt é autocontido.

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
1. **Inventário:** percorrer a conversa e separar o conteúdo por linha do modelo. Item só no chat vale como perdido: entra no prompt.
2. **Escrever** no modelo abaixo. Frases curtas, uma ideia por item, caminhos e nomes exatos entre crases, datas AAAA-MM-DD, terceira pessoa ("o usuário decidiu"; nunca "você" nem "nós"), termo técnico explicado uma vez. Linha vazia → omitir. Máx. ~25 linhas; acima disso, cortar detalhe de Estado e Depois disso antes de encurtar o porquê das decisões.
3. **Conferir:** "Pendente"/"Próximo passo" cita arquivo + trecho específico → 1 Grep pontual nesse trecho; achado já resolvido → mover para "Feito", nunca deixar pendência desatualizada.
4. **Fechar:** no chat, o prompt em bloco de código e 1 linha: outro dev → enviar o prompt; senão `/clear` e colar o prompt.

```
Retomar <tema>. Atualizado: data · dev · branch · commit · git limpo | sujo (o quê)
Objetivo: 1-2 frases: o que a frente busca e por quê.
Estado: feito (marcar testado ou não testado); pendente.
Próximo passo: um só, concreto, com o arquivo onde começar.
Decisões (não reabrir): decisão + porquê.
Descartado: opção + motivo.
Não fazer: armadilhas.
Regras do usuário: só as dadas na conversa e que o CLAUDE.md do projeto não traz.
Em aberto: pergunta + quem responde; nunca assumir.
Depois disso: demais passos, em ordem.
Ler antes de agir: caminho + motivo.
Sem presumir, deve ler.
```
