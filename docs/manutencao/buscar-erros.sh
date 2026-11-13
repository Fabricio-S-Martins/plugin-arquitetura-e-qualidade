#!/usr/bin/env bash
# Buscas mecânicas da manutenção do plugin (docs/manutencao/CONFERIR-MUDANCA.md).
# Uso, na raiz do repo: bash docs/manutencao/buscar-erros.sh
# Só lê; nunca edita. Mostra só os grupos com achado.

cd "$(git rev-parse --show-toplevel)" || exit 2

# Nomes antigos de skill: somar aqui a cada renomeação ou remoção.
ANTIGOS_HIFEN='criar-card|previa-diff|revisao-qa|encerrar-sessao'
ANTIGOS_VERBO='diagramar|documentar|especificar|planejar'

# Termos de linguagem, ferramenta ou estilo (regra 2): só valem com "ex.", "exemplo", "sugerir", "equivalente" ou "…" na linha, ou dentro de bloco de código.
TERMOS='C#|[.]NET|dotnet|csharp|xUnit|NUnit|MediatR|Swagger|OpenAPI|Entity Framework|pt-br|PascalCase|camelCase|kebab-case|snake_case|minúsculas e hífen|minúsculas, hífen'

ALVOS="skills docs/instrucoes docs/guias README.md CLAUDE.md"
achados=0

secao() { # $1 = título, $2 = linhas achadas
  [ -z "$2" ] && return
  echo "== $1"
  printf '%s\n' "$2"
  echo
  achados=$((achados + $(printf '%s\n' "$2" | wc -l)))
}

# 1. Nome antigo de skill
secao "Nome antigo de skill" "$(grep -rnE "$ANTIGOS_HIFEN|\`($ANTIGOS_VERBO)\`|skill ($ANTIGOS_VERBO)\b|:($ANTIGOS_VERBO)\b" $ALVOS)"

# 2. Caminho do plugin sem ${CLAUDE_SKILL_DIR} nas skills (texto para o CLAUDE.md do projeto, marcado "do plugin", fica fora)
secao "Caminho do plugin sem \${CLAUDE_SKILL_DIR} (skills/)" "$(
  grep -rnE 'docs/instrucoes/[A-Z-]+\.md|\.\./\.\./docs/' skills \
    | sed 's#\${CLAUDE_SKILL_DIR}/\.\./\.\./docs/##g' \
    | grep -E 'docs/instrucoes/[A-Z-]+\.md|\.\./\.\./docs/' | grep -v 'do plugin' | cut -d: -f1,2
)"

# 3. Link relativo quebrado (fora de docs/migracoes e docs/manutencao; placeholder <...> fica fora)
secao "Link quebrado" "$(
  git ls-files --cached --others --exclude-standard '*.md' | grep -vE '^docs/(migracoes|manutencao)/' | while IFS= read -r f; do
    d=$(dirname "$f")
    grep -oE '\]\([^)]+\)' "$f" | sed -E 's/^\]\(//; s/\)$//; s/#.*$//' | grep -vE '^(https?:|mailto:|$)|<' \
      | while IFS= read -r l; do [ -e "$d/$l" ] || echo "$f -> $l"; done
  done
)"

# 4. Skill citada que não existe
secao "Skill citada que não existe" "$(
  grep -rnoE "skill \`[a-z-]+\`|\`[a-z]+(ar|er|ir)-[a-z-]+\`|arquitetura-e-qualidade:[a-z-]+" $ALVOS | while IFS= read -r m; do
    n=$(printf '%s' "$m" | sed -E 's/.*(skill `|`|arquitetura-e-qualidade:)([a-z-]+)`?$/\2/')
    [ -d "skills/$n" ] || echo "$m"
  done
)"

# 5. Guia sem cabeçalho (link, nas 5 primeiras linhas, para o arquivo que o Claude lê) ou sem "## Por que é assim"
secao "Guia fora do padrão" "$(
  for g in docs/guias/*.md; do
    b=$(basename "$g" .md); s=$(printf '%s' "$b" | tr 'A-Z' 'a-z')
    if [ -d "skills/$s" ]; then alvo="../../skills/$s/SKILL.md"; else alvo="../instrucoes/$b.md"; fi
    head -5 "$g" | grep -qF "]($alvo)" || echo "$g: sem link para $alvo no cabeçalho"
    grep -q '^## Por que é assim' "$g" || echo "$g: sem ## Por que é assim"
  done
)"

# 6. Estado fora das tabelas de docs/instrucoes/TAGS.md (só tag em crase, em busca `.*` ou em lista de tags; texto corrido fica fora)
validos=$(grep -oE '\b(tarefa|especificacao|decisao|plano)/[a-z-]+' docs/instrucoes/TAGS.md | sort -u)
secao "Estado fora da lista de TAGS.md" "$(
  grep -rnoE '(`|\*|, |\[)(tarefa|especificacao|decisao|plano)/[a-z-]+' $ALVOS | grep -v '^docs/instrucoes/TAGS.md:' | while IFS= read -r u; do
    v=$(printf '%s' "${u##*:}" | sed -E 's/^(`|\*|, |\[)//')
    printf '%s\n' "$validos" | grep -qxF "$v" || echo "$u"
  done
)"

# 7. Skill chamada (``skill `X` `` em outra skill) sem a frase padrão, ou com frase diferente da de CONFERIR-MUDANCA.md
frase=$(grep -m1 '^\*\*Chamada por outra skill\*\*' docs/manutencao/CONFERIR-MUDANCA.md)
if [ -z "$frase" ]; then
  secao "Frase padrão" "docs/manutencao/CONFERIR-MUDANCA.md: frase \"Chamada por outra skill\" não encontrada"
else
  secao "Skill chamada sem a frase padrão" "$(
    grep -rnoE "skill \`[a-z-]+\`" skills | while IFS= read -r m; do
      n=$(printf '%s' "$m" | sed -E 's/.*skill `([a-z-]+)`$/\1/')
      case "${m%%:*}" in skills/"$n"/*) continue ;; esac
      [ -f "skills/$n/SKILL.md" ] && ! grep -qxF "$frase" "skills/$n/SKILL.md" && echo "$m -> skills/$n/SKILL.md sem a frase"
    done | sort -u
  )"
  secao "Frase padrão com texto diferente" "$(
    grep -rn '^\*\*Chamada por outra skill\*\*' skills | while IFS= read -r l; do
      [ "${l#*:*:}" = "$frase" ] || echo "${l%%:*}"
    done
  )"
fi

# 8. Termo da regra 2 sem marca de exemplo
secao "Termo de linguagem, ferramenta ou estilo sem \"ex.\" (regra 2)" "$(
  grep -rlE "$TERMOS" skills docs/instrucoes | while IFS= read -r f; do
    awk -v f="$f" -v re="$TERMOS" '/^[ \t]*```/ {bloco = !bloco; next} !bloco && $0 ~ re {print f ":" NR ":" $0}' "$f"
  done | grep -viE 'ex\.|ex:|exemplo|sugest|sugerir|equivalente|…' | cut -c1-160
)"

# 9. Termo de gatilho repetido entre descriptions (termos separados por vírgula ou " ou ", depois de "Usar")
secao "Gatilho repetido entre descriptions" "$(
  for f in skills/*/SKILL.md; do
    n=$(basename "$(dirname "$f")")
    grep -m1 '^description:' "$f" | sed -E 's/^.*[Uu]sar //; s/^(ao pedir( para)?|ao|quando|antes de) //' \
      | sed -E 's/ ou /,/g; s/["“”.]//g' | tr ',' '\n' | sed -E 's/^ +//; s/ +$//' | grep -v '^$' \
      | while IFS= read -r t; do printf '%s\t%s\n' "$(printf '%s' "$t" | tr 'A-Z' 'a-z')" "$n"; done
  done | awk -F'\t' '{c[$1]++; s[$1]=s[$1] " " $2} END {for (t in c) if (c[t] > 1) print "\"" t "\":" s[t]}'
)"

# 10. Nome de skill sem verbo no infinitivo
secao "Nome de skill sem verbo + objeto" "$(ls skills | grep -vE '^[a-z]+(ar|er|ir)-[a-z-]+$')"

# 11. Versão (regra 12) e lembrete de migração (regra 13)
v_atual=$(grep -oE '"version": *"[0-9.]+"' .claude-plugin/plugin.json | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
v_head=$(git show HEAD:.claude-plugin/plugin.json 2>/dev/null | grep -oE '"version": *"[0-9.]+"' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
mudou=$( { git diff HEAD --name-only; git ls-files --others --exclude-standard; } | grep -E '^(skills/|docs/instrucoes/)' | head -1)
if [ -n "$mudou" ] && [ "$v_atual" = "$v_head" ]; then
  secao "Versão" "skills/ ou docs/instrucoes/ mudou e a version continua $v_atual (regra 12)"
fi

echo "Achados: $achados"
if [ "$v_atual" != "$v_head" ] && [ ! -f "docs/migracoes/$v_atual.md" ]; then
  echo "Lembrete: $v_atual sem docs/migracoes/$v_atual.md; só precisa se mudou formato de arquivo do projeto ou saiu regra (regra 13)."
fi
[ "$achados" -eq 0 ]
