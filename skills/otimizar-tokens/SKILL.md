---
name: otimizar-tokens
description: Refatora .md e configs para gastar menos tokens sem perder informação. Usar ao pedir para otimizar, enxugar, limpar, compactar ou reduzir tokens de arquivo, skill ou documento.
---

# otimizar-tokens

Reduzir tokens preservando 100% do significado. Dúvida se é perda → perguntar, nunca cortar.
Alvo: arquivos ou pasta informados; pasta → Glob e no máximo ~5 arquivos por execução, o resto vira sinalização. Sem alvo → perguntar. "Só analisa" → só relatório, sem editar. Alvo com alterações não commitadas → avisar antes de editar (perde a reversão por `git diff`).
"Auditoria" / "onde vale otimizar": só relatório. Glob nos arquivos do plugin, `wc -c` de cada um, ranking por bytes × frequência de carga: `description` e `CLAUDE.md` = toda sessão; `SKILL.md` = ao disparar; demais = quando lidos.

## Público do arquivo
- **IA** (`SKILL.md`, `docs/ia/`, `CLAUDE.md`, frontmatter): telegráfico.
- **Dev** (`docs/dev/`): linguagem amigável; só remover redundância, repetição e enfeite.
- Par `docs/ia/X` ↔ `docs/dev/X`: otimizar cada um pelo seu público; os dois dizem o mesmo.

## Fluxo
1. Ler o arquivo; Grep de quem o referencia (links, caminhos) e de regras dele repetidas em outros arquivos do plugin.
2. **Inventário:** fatos atômicos: regras, números/limites, exceções, condicionais (só se / exceto / nunca), caminhos, nomes, formatos, ordem de passos.
3. Reescrever com as técnicas abaixo.
4. **Conferência:** cada item do inventário presente, com a mesma condição e o mesmo número. Faltou → restaurar.
5. `description` alterada: comparar palavras de gatilho antes/depois e testar 2-3 frases que devem e 2-3 que não devem acionar a skill.
6. Medir antes/depois: `wc -l -c` (bytes, ~3,5 por token em pt-BR). Relatório.
7. Só se pedido, equivalência: rodar o mesmo pedido de teste antes e depois (ex: gerar card de teste) e comparar.

## Remover
- Introdução, fecho, cortesia, "como usar" que repete o nome do arquivo.
- Explicação de conceito que a IA já conhece (SOLID, KISS, DTO).
- Exemplo que só repete a regra; manter o que desfaz ambiguidade.
- Duplicação: entre arquivos → uma fonte, o outro aponta (DRY); dentro do arquivo → uma vez.
- Histórico, datas, "revogado", decisões sem efeito hoje.
- Enfeite: emoji, negrito em excesso, separadores, tabela com uma coluna útil, título de seção com um item só.
- "Porquê" longo; manter uma oração só se evita aplicar a regra errado.

## Condensar
- Prosa → lista curta ou frase telegráfica (verbo + objeto); condição em vez de narrativa.
- Sigla só se definida uma vez no arquivo; sem abreviação obscura.
- Mais importante primeiro; agrupar regras da mesma condição.
- Bloco de uso raro → arquivo à parte lido sob demanda, com ponteiro condicional (ex: `CSHARP.md` só com `.cs`).

## Nunca
- Perder negação, condição ou qualificador ("nunca", "só se", "exceto", "quando"); fundir regras de condições diferentes; arredondar número ou limite.
- Comprimir a ponto de ficar ambíguo → manter a forma longa.
- Alterar caminhos, namespaces, assinaturas, interfaces, DTOs, tipos, identificadores e ids de checklist do template.
- Trocar nome de arquivo, âncora ou campo referenciado sem atualizar quem referencia.
- Acrescentar informação que o original não dizia.
- Código/config e blocos de código em `.md` (csharp, json, yaml): intactos; só remover comentário óbvio, espaço e linha em branco supérfluos; nunca alterar comportamento.
- Frontmatter: manter `name` e as palavras de gatilho da `description`; encurtar só o que sobra.

## Exemplo
Entrada: "É muito importante lembrar que, ao criar um novo card, deve-se sempre verificar qual é o próximo número de ID que está livre dentro da pasta `cards/` antes de salvar o arquivo, para evitar que dois cards fiquem com o mesmo identificador."
Saída: "Antes de salvar: usar o próximo ID livre em `cards/`; nunca repetir ID."

## Relatório
Por arquivo: `antes → depois (−%)` em linhas e bytes. Depois:
- **Removido:** categorias e itens relevantes.
- **Condensado:** o que mudou de forma, sem mudar de conteúdo.
- **Dúvidas:** o que não cortei por risco de perda.
