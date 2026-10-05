---
name: previa-diff
description: Mostra prévia de alteração (antes e depois) sem editar arquivos. Usar ao pedir prévia, preview, comparação, "mostra como ficaria" ou algo "sem alterar"/"sem aplicar".
allowed-tools: Read, Glob, Grep
---

# previa-diff

Não editar arquivos nem criar temporários. Aplicar só se o usuário pedir depois.
1. Ler só o trecho necessário do arquivo e compor a versão nova.
2. Responder com bloco(s) de código (linguagem do arquivo), só os trechos alterados + 2-3 linhas de contexto. Mudança grande (extração de método, reorganização) → 1 bloco por unidade lógica (a chamada, cada método novo/removido), rotulado ("Bloco N — <unidade>:"), mesmo dentro do mesmo trecho contíguo do arquivo. Mais de um arquivo → nome do arquivo antes de cada bloco. Trechos não contíguos no mesmo arquivo → mesma regra, 1 bloco por trecho, na ordem em que aparecem; nunca juntar trechos distantes. Nada além dos blocos: sem comentário depois, salvo se o usuário pedir.
3. Cada unidade alterada: bloco "Antes" e bloco "Depois", rótulos fora do bloco, sem marcador `+`/`-` (em `.md` viram itens de lista). Só texto real do arquivo: nenhum comentário ou elisão inventada no lugar de linhas omitidas. Troca de 1 linha em arquivo não `.md`: `-` e `+` intercalados num bloco só.
4. Arquivo `.md`: cerca de 4 crases; nunca bloco dentro de bloco.
5. Prévia aproximada: não é patch aplicável.
