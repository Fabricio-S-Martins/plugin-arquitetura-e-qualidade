# PLANO

Nota do plano de uma demanda, gravada pela `criar-plano` após o "aprovado". Nomes de pasta, arquivo, tag e título de seção citados são exemplo: valem os do projeto (Glob/Grep na área existente; sem padrão → perguntar uma vez, sugerindo o exemplo). Modelo do projeto em `docs/padroes/modelos/` (Glob) vale no lugar do exemplo.

## Lugar e tags
- `docs/planos/modulos/<modulo>/<nome-da-demanda>.md`: nome no padrão do projeto; sem padrão, sugerir minúsculas, hífen, sem `NN`. Módulo principal; vários módulos → todas as tags `modulo/`; principal não óbvio → perguntar.
- Tags conforme `TAGS.md` (grupo `plano`, estado `plano/vigente` ao criar). Índice do módulo e da área conforme `INDICE.md`; a linha do plano vai no índice do módulo.
- Demanda com plano `vigente` (Grep `tags:.*plano/vigente` + `modulo/`; vários no módulo → o da demanda pelo título; dúvida → perguntar): editar o arquivo, nunca criar outro.

## Modelo
```
<tags>
# <demanda>

Especificação: [<arquivo>](<caminho relativo>)
Padrão seguido: <arquivo ou nenhum>

## Objetivo
<1 linha>

## Funcionalidades
- [ ] <funcionalidade> — <critérios cobertos>; tarefas: <NN, NN>

## Fluxo
<diagrama>

## Decisões
- <decisão> — <porquê>

## Alternativas descartadas
- <alternativa> — <motivo>

## Tarefas
- [ ] [<Módulo> NN](<caminho relativo>/NN-nome.md): <título> · deps · pronto quando <critério observável>

## Frentes
- Frente A: <NN, NN, NN>

## Pendências
- [ ] <pendência>
```
- `Especificação`: só se existe (conferir via Glob). `Padrão seguido`: "nenhum" se não há.
- `Fluxo`: só se o fluxo tem mais de um passo ou ator; diagrama conforme `DIAGRAMAS.md`. `Decisões`, `Alternativas descartadas` e `Pendências` sem conteúdo → omitir a seção.
- `Frentes`: só se o plano aprovado as tem (critério na `criar-plano`); tarefas de cada frente na ordem sugerida, sem responsável.
- Alternativa que parece barata e cobra caro: prefixar `ARMADILHA:`. Decisão que o Dev mandou registrar (`DECISOES.md`): link para ela na linha.
- Tarefa dependente de algo externo: `BLOQUEADO` + o que destrava.
- Fatos e impacto por divisão ficam só no plano apresentado no chat.

## Marcação
- Tarefa: `[x]` por `executar-tarefa` quando a tarefa vira `tarefa/concluido` (em `em-validacao`, ainda não).
- Funcionalidade: `[x]` por `executar-tarefa` quando todas as suas tarefas estiverem `[x]`.
- Pendência: `[x]` só com a confirmação do Dev de que foi resolvida; a resposta fica anotada na mesma linha.
- Nova pendência: propor em texto; gravar só com o aceite do Dev.
- Sem marcação intermediária (em execução, em andamento).

## Obsoleto e apagar
- `plano/obsoleto` só se o Dev disser: linha `**Obsoleto:** <data> · <motivo> · substituído por [<arquivo>](<caminho relativo>)` (sem substituto → sem o último trecho) logo abaixo do título; o substituto nasce `vigente`.
- Apagar: com aceite do Dev e só se nenhuma nota cita o arquivo (Grep literal do nome em `docs/`, fora do índice); a linha do índice sai junto. Citado → `obsoleto`.
