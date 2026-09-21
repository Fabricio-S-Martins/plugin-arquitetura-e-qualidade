# Encerrar sessão: guia para Devs

A skill `encerrar-sessao` fecha uma sessão sem perder o contexto. A versão que o Claude lê é [../../skills/encerrar-sessao/SKILL.md](../../skills/encerrar-sessao/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Quando usar
Ao encerrar, trocar de sessão ou antes de dar `/clear`. Peça algo como "encerra a sessão", "prepara o prompt de retomada" ou "resume a conversa".

## O que você recebe
1. **Um prompt de retomada**, no chat, em bloco de código. É a conversa compactada: contém só o que a próxima sessão precisa para continuar (estado, decisões, próximo passo, o que não fazer). Você dá `/clear` e cola o prompt na sessão nova.
2. **Um resumo em .md**, salvo em `docs/sessoes/AAAA-MM-DD-tema.md` do projeto. É escrito para você ler, não para a IA: português simples, do mais importante para o menos, com o porquê de cada decisão. Não é a transcrição da conversa.

O prompt não depende do resumo: cada um funciona sozinho.

O prompt lista os arquivos que a próxima sessão deve ler antes de agir e termina sempre com a frase "Sem presumir, deve ler.", para a nova sessão não inventar o que não viu.

## O que tem no resumo
- **Em uma frase:** o que a sessão fez.
- **Onde paramos:** o que está feito e o que não está.
- **O que ficou decidido:** cada decisão com o porquê.
- **O que foi descartado:** o que foi considerado e recusado, e por quê.
- **Próximos passos:** lista numerada; o primeiro abre a próxima sessão.
- **Dúvidas em aberto:** o que ainda precisa da sua resposta.
- **Arquivos mexidos:** caminho e uma linha do que mudou.

Seção sem conteúdo é omitida.

## Regras
- **Só o que foi dito na conversa:** ela não lê o projeto para completar lacunas. A única leitura extra é o estado do git.
- **Não altera código e não faz commit.** Só cria ou atualiza o resumo.
- **Dúvida vira "em aberto"**, nunca suposição.
