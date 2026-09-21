---
name: previa-diff
description: Mostra prévia de alteração com + e - sem editar arquivos. Usar ao pedir prévia, preview, comparação, "mostra como ficaria" ou algo "sem alterar"/"sem aplicar".
---

# previa-diff

Não editar arquivos nem criar temporários. Aplicar só se o usuário pedir depois.
1. Ler só o trecho necessário do arquivo e compor a versão nova.
2. Responder com um bloco de código (linguagem do arquivo) só com os trechos alterados e 2-3 linhas de contexto. Mais de um arquivo → nome do arquivo antes de cada bloco. Nada além do bloco: sem comentário depois, salvo se o usuário pedir.
3. Marcas na 1ª coluna, código com o recuo original, uma marca em cada linha alterada: `+` nova, `-` removida. Linha sem marca = contexto, inalterada.
4. Trecho com 2+ linhas trocadas: bloco `+` primeiro, depois bloco `-`, separados por linha em branco. Troca de 1 linha: `-` e `+` intercalados.
5. Prévia aproximada: não é patch aplicável.
