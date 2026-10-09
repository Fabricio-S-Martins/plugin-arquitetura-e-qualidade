# Obsidian (opcional)

Lido por `configurar-projeto` quando o Dev aceita ou `docs/.obsidian/` já existe.

## 1. Ferramenta
| Conferir (Windows) | Instalar (Windows) | Sem Windows |
|---|---|---|
| `winget list --id Obsidian.Obsidian` | `winget install --id Obsidian.Obsidian --exact --accept-source-agreements --accept-package-agreements` | https://obsidian.md/download |

Ausente → avisar e perguntar se instala (mesma regra de instalação do `SKILL.md`).

## 2. .gitignore
Garantir `docs/.obsidian/` (sem duplicar; nunca remover linha existente).

## 3. Cofre (`docs/.obsidian/`)
Ausente → avisar: "abra `docs/` no Obsidian como cofre (Abrir pasta como cofre)" — só o app faz; encerrar esta parte.
Presente:
1. **Ignorados** (`app.json`): Grep no `.gitignore` pelas linhas dentro de `docs/`; tirar o prefixo `docs/` de cada uma (`docs/sessoes/` → `sessoes/`). Somar ao array `userIgnoreFilters` as que faltarem; **nunca remover** as existentes (podem ter sido postas à mão, ex. `runbooks/`, `Migrations/`).
2. **Links** (`app.json`): `"useMarkdownLinks": true` e `"newLinkFormat": "relative"` (desliga Wikilinks; já é o formato usado nos docs).
3. Avisar: "feche e reabra o Obsidian para a mudança valer" — o app pode sobrescrever `app.json` ao salvar qualquer configuração antes disso.

JSON do cofre: editar só as chaves citadas; preservar o resto.
