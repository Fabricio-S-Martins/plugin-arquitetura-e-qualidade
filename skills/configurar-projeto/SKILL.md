---
name: configurar-projeto
description: Prepara um projeto para documentação e cofre Obsidian - cria docs/, ajusta .gitignore, sincroniza o Obsidian, audita o CLAUDE.md. Usar ao iniciar um projeto novo, ou ao pedir para configurar/preparar o projeto ou o Obsidian.
allowed-tools: Read, Write, Edit, Glob, Bash(winget *), Bash(mkdir *), Bash(dotnet tool *), Bash(claude plugin *), Bash(wc *)
---

# configurar-projeto

Sem alterar código. Ordem fixa; cada passo depende do anterior.

## Ferramentas necessárias
| Ferramenta | Conferir (Windows) | Instalar (Windows) | Sem Windows |
|---|---|---|---|
| Obsidian | `winget list --id Obsidian.Obsidian` | `winget install --id Obsidian.Obsidian --exact --accept-source-agreements --accept-package-agreements` | https://obsidian.md/download |
| csharp-ls (só projeto C#) | `dotnet tool list -g` | `dotnet tool install -g csharp-ls` | requer .NET SDK: https://dotnet.microsoft.com/download |
| plugin csharp-lsp (só projeto C#) | `claude plugin list` | `claude plugin marketplace add anthropics/claude-plugins-official` (se faltar) e `claude plugin install csharp-lsp@claude-plugins-official` | mesmo comando |

## 1. Ferramentas da lista
Para cada linha: ausente → avisar e perguntar se instala agora (única confirmação da skill; o resto roda direto). Sim + comando Windows → rodar comando da coluna Instalar. Sem comando ou outro SO → link da coluna "Sem Windows" e parar até confirmar instalado.

## 2. Pasta docs
Ausente → criar `docs/`. Avisar: "abra `docs/` no Obsidian como cofre (Abrir pasta como cofre) antes do próximo passo" — isso só o app faz.

## 3. .gitignore
Garantir as entradas (acrescentar as que faltarem, sem duplicar; nunca remover linha existente):
- `docs/.obsidian/`
- `docs/sessoes/`

## Paleta de cores do grafo
Ordem fixa, RGB decimal: azul `5016565`, verde `5025616`, âmbar `14723390`, roxo `9795021`, teal `5093036`, rosa `15037332`.

## 4. Cofre (`docs/.obsidian/`)
Ausente → avisar que falta abrir `docs/` como cofre no Obsidian e parar.
Presente:
1. **Ignorados** (`app.json`): Grep no `.gitignore` pelas linhas dentro de `docs/`; tirar o prefixo `docs/` de cada uma (`docs/sessoes/` → `sessoes/`). Somar ao array `userIgnoreFilters` as que ainda não estiverem lá; **nunca remover** as que já existem (podem ter sido postas à mão, ex. `runbooks/`, `Migrations/`).
2. **Links** (`app.json`): `"useMarkdownLinks": true` e `"newLinkFormat": "relative"` (desliga Wikilinks; já é o formato usado nos docs).
3. **Cores** (`graph.json`): Glob 1 nível em `docs/`, pastas só (sem as do `userIgnoreFilters`, que não aparecem no grafo). Cada pasta sem entrada em `colorGroups` (`query: "path:<pasta>"`) → somar uma, cor = próxima da paleta ainda não usada no arquivo, ciclando se a lista acabar. **Nunca** alterar `query` ou `color` de entrada já existente.
4. Avisar ao final: "feche e reabra o Obsidian para a mudança valer" — o app pode sobrescrever `app.json` e `graph.json` ao salvar qualquer configuração antes disso.

## 5. CLAUDE.md do projeto
Só auditoria, sem editar (`CLAUDE.md` e arquivos que ele carrega nunca são alterados aqui).
- `CLAUDE.md` ausente → avisar e sugerir criar; parar.
- Presente → Read + `wc -c`; avaliar por `docs/instrucoes/QUALIDADE.md` e pelo passo 1 (Auditoria) de `otimizar-tokens`: peso, regras duplicadas, conteúdo de uso raro carregado em toda sessão.
- Relatório curto: ranking por bytes + sugestões. Aplicar só se o Dev pedir, via `otimizar-tokens` (ou `previa-diff` para ver antes).
- Projeto novo/sem conteúdo → pular.

## Regras
- JSON do cofre: editar só as chaves acima; preservar o resto do arquivo.
- Rodar de novo no mesmo projeto é seguro: passos já feitos ficam sem efeito; o passo 4 só soma o que faltar.
