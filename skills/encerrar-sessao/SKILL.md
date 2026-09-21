---
name: encerrar-sessao
description: Encerra ou troca de sessão sem perder contexto. Gera prompt de retomada compacto e resumo da conversa em .md legível para humanos. Usar ao pedir encerrar sessão, compactar, prompt de retomada, continuar em outra sessão ou resumo da conversa.
---

# encerrar-sessao

Só o que está na conversa: nunca suposição, nunca reler o projeto para "completar". Única leitura extra: `git status --short` + branch. Não editar código, não commitar.

## Fluxo
1. **Inventário:** percorrer a conversa e separar: objetivo, decisões (com o porquê), fatos com fonte (`arquivo:linha` ou "usuário"), feito, pendente, alternativas descartadas (com motivo), armadilhas, preferências dadas pelo usuário, em aberto. Item só no chat vale como perdido: entra no prompt ou no resumo.
2. **Prompt de retomada** (para a IA): autocontido, quem retoma não viu a conversa. Bloco de código, máx. ~40 linhas, telegráfico, não depende do resumo .md.
3. **Resumo .md** (para humano): reescrever, não transcrever. Salvar em `docs/sessoes/AAAA-MM-DD-tema.md` do projeto; pasta ausente → criar. Mesmo dia e tema → atualizar o arquivo.
4. **Fechar:** no chat, o prompt em bloco de código, o caminho do resumo e 1 linha dizendo que pode dar `/clear` e colar o prompt.

## Prompt
- **Contexto:** projeto, branch, estado do git (limpo ou o que está sujo).
- **Estado:** 2-4 linhas do que está feito e provado.
- **Decisões (não reabrir):** 1 linha cada, com o porquê.
- **Tarefa:** o próximo passo concreto, em 1-2 frases; com fases e portão de confirmação onde houver risco.
- **Não fazer:** armadilhas e alternativas descartadas.
- **Regras do usuário:** só as dadas na conversa (idioma, formato, limites).
- **Em aberto:** o que ainda não é fato; perguntar ao usuário, nunca assumir.
- **Ler antes de agir:** os arquivos citados no prompt (caminho + motivo). Fechar o prompt com a linha fixa: "Sem presumir, deve ler."

## Resumo .md
Ordem por importância, não cronológica. Português simples, frases completas, termo técnico explicado uma vez.
- **Em uma frase:** o que a sessão fez.
- **Onde paramos:** feito e não feito, em 3-6 linhas.
- **O que ficou decidido:** cada decisão com o porquê, em linguagem de quem não viu a conversa.
- **O que foi descartado:** o que foi considerado e recusado, e por quê.
- **Próximos passos:** lista numerada, o primeiro é o que abre a próxima sessão.
- **Dúvidas em aberto:** o que precisa de resposta do usuário.
- **Arquivos mexidos:** caminho + 1 linha do que mudou.

Seção vazia → omitir.
