---
name: previa-diff
description: Mostra prévia de alteração com + e - sem editar arquivos. Usar ao pedir prévia, preview, comparação, "mostra como ficaria" ou algo "sem alterar"/"sem aplicar".
allowed-tools: Read, Glob, Grep
---

# previa-diff

Não editar arquivos nem criar temporários. Aplicar só se o usuário pedir depois.
1. Ler só o trecho necessário do arquivo e compor a versão nova.
2. Responder com bloco(s) de código (linguagem do arquivo), só os trechos alterados + 2-3 linhas de contexto. Mudança grande (extração de método, reorganização) → 1 bloco por unidade lógica (a chamada, cada método novo/removido), rotulado ("Bloco N — <unidade>:"), mesmo dentro do mesmo trecho contíguo do arquivo. Mais de um arquivo → nome do arquivo antes de cada bloco. Trechos não contíguos no mesmo arquivo → mesma regra, 1 bloco por trecho, na ordem em que aparecem; nunca juntar trechos distantes. Nada além dos blocos: sem comentário depois, salvo se o usuário pedir.
3. Trecho com 2+ linhas trocadas: marca `+` sozinha numa linha, código novo sem prefixo (recuo original) logo abaixo, `+` sozinha fechando; linha em branco; mesma coisa com `-` para o código antigo. Troca de 1 linha só: `-` e `+` na mesma linha do código, intercalados (sem o bloco delimitado).
4. Prévia aproximada: não é patch aplicável.
