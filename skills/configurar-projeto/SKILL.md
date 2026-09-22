---
name: configurar-projeto
description: Prepara um projeto para documentação e cofre Obsidian - cria docs/, ajusta .gitignore, sincroniza o Obsidian. Usar ao iniciar um projeto novo, ou ao pedir para configurar/preparar o projeto ou o Obsidian.
---

# configurar-projeto

Sem alterar código. Ordem fixa; cada passo depende do anterior.

## Ferramentas necessárias
| Ferramenta | Conferir (Windows) | Instalar (Windows) | Sem Windows |
|---|---|---|---|
| Obsidian | `winget list --id Obsidian.Obsidian` | `winget install --id Obsidian.Obsidian --exact --accept-source-agreements --accept-package-agreements` | https://obsidian.md/download |

## 1. Ferramentas da lista
Para cada linha: ausente → avisar e perguntar se instala agora (única confirmação da skill; o resto roda direto). Sim + comando Windows → rodar comando da coluna Instalar. Sem comando ou outro SO → link da coluna "Sem Windows" e parar até confirmar instalado.

## 2. Pasta docs
Ausente → criar `docs/`. Avisar: "abra `docs/` no Obsidian como cofre (Abrir pasta como cofre) antes do próximo passo" — isso só o app faz.

## 3. .gitignore
Garantir as entradas (acrescentar as que faltarem, sem duplicar; nunca remover linha existente):
- `docs/.obsidian/`
- `docs/sessoes/`

## 4. Cofre (`docs/.obsidian/app.json`)
Ausente → avisar que falta abrir `docs/` como cofre no Obsidian e parar.
Presente:
1. **Ignorados:** Grep no `.gitignore` pelas linhas dentro de `docs/`; tirar o prefixo `docs/` de cada uma (`docs/sessoes/` → `sessoes/`). Somar ao array `userIgnoreFilters` do `app.json` as que ainda não estiverem lá; **nunca remover** as que já existem (podem ter sido postas à mão, ex. `runbooks/`, `Migrations/`).
2. **Links:** `"useMarkdownLinks": true` e `"newLinkFormat": "relative"` no `app.json` (desliga Wikilinks; já é o formato usado nos docs).
3. Avisar ao final: "feche e reabra o Obsidian para a mudança valer" — o app pode sobrescrever o arquivo ao salvar outra configuração antes disso.

## Regras
- JSON do `app.json`: editar só as chaves acima; preservar o resto do arquivo.
- Rodar de novo no mesmo projeto é seguro: passos já feitos ficam sem efeito; o passo 4 só soma o que faltar.
