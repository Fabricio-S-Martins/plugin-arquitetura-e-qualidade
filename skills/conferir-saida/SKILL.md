---
name: conferir-saida
description: Confere se a saída de um teste de skill cumpre o que a skill pede e aponta os desvios. Usar ao pedir para conferir, validar ou checar a saída de um teste, ou quando a saída de uma skill parece fora do combinado.
allowed-tools: Read, Glob, Grep, Bash(wc *)
---

# conferir-saida

Só reporta; nunca edita (sem `Edit` em `allowed-tools`). Ajuste sugerido vai para a `previa-diff` se o usuário quiser aplicar. Compara só com a skill: fatos e qualidade do conteúdo do projeto ficam fora. Não presumir: sem evidência na saída, a regra é "não verificável".

## Entrada
Saída colada ou caminho do arquivo gerado, mais o nome da skill de origem. Sem nome → inferir por seções, formato ou caminho e dizer qual foi inferida.

## Fluxo
1. Ler `skills/<origem>/SKILL.md` e só os arquivos que ela cita e que a saída deveria seguir (ex: `TEMPLATE-CARD.md`). Não ler o projeto.
2. Extrair regras verificáveis: seções e ordem, limites (linhas, itens), proibições e condições ("nunca", "só se"), estilo (pessoa, idioma, nomes), efeitos esperados (arquivo criado, `.gitignore`, o que sai no chat) e o que não devia ocorrer (editar, commitar, perguntar).
3. Comparar regra a regra. Contável → Grep ou `wc` no arquivo gerado (ex: "você", "nós", nº de linhas).
4. Classificar cada desvio: **execução** (regra clara, ignorada) ou **skill** (regra ambígua, ausente ou conflitante).

## Relatório
- **Resumo:** N regras, X conformes, Y desvios, Z não verificáveis.
- **Desvios:** regra (`SKILL.md:linha`) · trecho da saída · causa.
- **Não verificável:** regra + o que faltou para verificar.
- **Ajuste sugerido:** só para causa "skill": correção da `SKILL.md` em `+` e `-` (formato da `previa-diff`). Causa "execução" → só apontar.
