---
name: otimizar-tokens
description: Refatora .md e configs para gastar menos tokens sem perder informação. Usar ao pedir para otimizar, enxugar, limpar, compactar ou reduzir tokens de arquivo, skill ou documento.
allowed-tools: Read, Glob, Grep, Edit, Write, Bash(wc *), Bash(cp *)
---

# otimizar-tokens

Reduzir tokens preservando 100% do significado. Dúvida se é perda → perguntar, nunca cortar.
Alvo: arquivos ou pasta informados; pasta → Glob e no máximo ~5 arquivos por execução, o resto vira sinalização. Sem alvo → perguntar. "Só analisa" → só relatório, sem editar; ver os cortes antes de aplicar → `previa-diff`. "Auditoria" / "onde vale otimizar" → só o passo 1. Editar direto, sem pedir permissão; perguntar só por dúvida real de perda. Alvo com alterações não commitadas → copiar antes para o diretório temporário (scratchpad) e informar no relatório.

## Público do arquivo
- **Instrução** (`SKILL.md`, `docs/instrucoes/`, `CLAUDE.md`, frontmatter): telegráfico.
- **Guia** (`docs/guias/`): linguagem amigável; só remover redundância, repetição e enfeite.
- Par `docs/instrucoes/X` ↔ `docs/guias/X`: otimizar cada um pelo seu público; os dois dizem o mesmo.

## Fluxo (maior ganho primeiro)
1. **Auditoria:** Glob nos arquivos do plugin, `wc -c` de cada um, ranking por bytes × frequência de carga: `description` e `CLAUDE.md` = toda sessão; `SKILL.md` = ao disparar; demais = quando lidos. Arquivo que a IA não carrega (`docs/guias/`) não economiza tokens. Agir primeiro no que mais pesa.
2. **Estrutura** (costuma render mais que cortar palavras): bloco de uso raro → arquivo à parte lido sob demanda, com ponteiro condicional (ex: `CSHARP.md` só com `.cs`); regra repetida entre arquivos → uma fonte, o outro aponta (DRY); regra que se repetiria por item de uma lista sujeita a crescer (ex: 1 parágrafo por ferramenta a checar) → tabela de dados + 1 regra genérica que a percorre. Conferir que nenhum uso passa a carregar mais que antes.
3. **Palavras**, só nos arquivos que ainda justificam: ler o arquivo; Grep de quem o referencia (links, caminhos) e de regras dele repetidas em outros arquivos do plugin.
4. **Inventário:** fatos atômicos: regras, números/limites, exceções, condicionais (só se / exceto / nunca), caminhos, nomes, formatos, ordem de passos.
5. Reescrever com as técnicas abaixo.
6. **Conferência:** cada item do inventário presente, com a mesma condição e o mesmo número. Faltou → restaurar.
7. `description` alterada: comparar palavras de gatilho antes/depois e testar 2-3 frases que devem e 2-3 que não devem acionar a skill.
8. Medir antes/depois: `wc -l -c` (bytes, ~3,5 por token em pt-BR). Relatório.
9. Só se pedido, equivalência: rodar o mesmo pedido de teste antes e depois (ex: gerar card de teste) e comparar.

## Remover
- Introdução, fecho, cortesia, "como usar" que repete o nome do arquivo.
- Explicação de conceito que a IA já conhece (SOLID, KISS, DTO).
- Exemplo que só repete a regra; manter o que desfaz ambiguidade.
- Duplicação dentro do arquivo → uma vez.
- Histórico, datas, "revogado", decisões sem efeito hoje.
- Enfeite: emoji, negrito em excesso, separadores, tabela com uma coluna útil, título de seção com um item só.
- "Porquê" longo; manter uma oração só se evita aplicar a regra errado.
- Negação de algo que a IA não faria sem ela — isolada ("sem X") ou dentro de instrução composta ("faça X, não Y") → omitir; vale também para texto novo. Antes de manter por "limita regra vizinha", testar: a regra vizinha, sozinha, já permite o erro? Sem exemplo concreto de como daria errado sem a negação, é redundante. Manter só se o padrão do modelo é o oposto, se já houve erro ou se o teste acima confirma o limite. Dúvida → perguntar.

## Condensar
- Prosa → lista curta ou frase telegráfica (verbo + objeto); condição em vez de narrativa. Cortar preposição, artigo e conectivo de ligação ("de um", "para o", "que está") que a forma telegráfica já dispensa.
- Sigla só se definida uma vez no arquivo; sem abreviação obscura.
- Mais importante primeiro; agrupar regras da mesma condição.

## Nunca
- Perder negação, condição ou qualificador ("nunca", "só se", "exceto", "quando"; exceção: negação redundante, ver Remover); fundir regras de condições diferentes; arredondar número ou limite.
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
