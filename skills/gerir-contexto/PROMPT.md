## Retomada na tarefa
Arquivo de tarefa em execução citado na conversa (caminho exato; ausente ou duvidoso → perguntar uma vez, ou seguir sem arquivo de tarefa): o estado vai na tarefa, não no prompt.
1. Read da tarefa. Seção `## Retomada` já existe → atualizar no lugar; senão acrescentar como última seção, no fim do arquivo. Tag `tarefa/em-execucao` (execução interrompida) → voltar pelo checklist: algum `[x]` → `em-andamento`, nenhum → `pendente` (só essa tag).
2. Gravar só o que o checklist não diz, linha vazia → omitir; mesmas regras de escrita do Prompt. Plano `vigente` que cita a tarefa (Grep `tags:.*plano/vigente` em `docs/` e, neles, o nome do arquivo da tarefa) → linha em `Ler antes de agir`:
```
## Retomada
Atualizado: AAAA-MM-DD · dev · branch · commit · git limpo | sujo (o quê)
- **Decisões (não reabrir):** decisão + porquê.
- **Descartado:** opção + motivo.
- **Não fazer:** armadilhas.
- **Regras do usuário:** só as dadas na conversa e que o CLAUDE.md do projeto não traz.
- **Em aberto:** pergunta + quem responde; nunca assumir.
- **Próximo passo:** um só, com o item do checklist e o arquivo onde começar.
- **Depois disso:** demais passos, em ordem.
- **Ler antes de agir:** caminho + motivo.
```
3. Fechar no chat com 1 linha, sem bloco de prompt: "Retomar a tarefa `<caminho>`: ler inteira, a seção Retomada primeiro. Sem presumir, deve ler." Outro dev → enviar essa linha. A seção sai quando a tarefa conclui (`executar-tarefa`).

## Prompt
Sem arquivo de tarefa em execução. Leitor: outra sessão da IA ou outro dev, sem ter visto a conversa. O prompt é autocontido.
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
