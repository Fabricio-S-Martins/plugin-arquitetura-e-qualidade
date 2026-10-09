## Prompt
Leitor: outra sessão da IA ou outro dev, sem ter visto a conversa. O prompt é autocontido.
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
