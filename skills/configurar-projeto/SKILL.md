---
name: configurar-projeto
description: Prepara um projeto para documentação e cofre Obsidian - cria docs/, ajusta .gitignore, sincroniza o Obsidian, audita o CLAUDE.md, libera as skills do plugin. Usar ao iniciar um projeto novo, ou ao pedir para configurar/preparar o projeto ou o Obsidian.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill, Bash(winget *), Bash(mkdir *), Bash(dotnet tool *), Bash(claude plugin *), Bash(wc *)
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

## 4. Cofre (`docs/.obsidian/`)
Ausente → avisar que falta abrir `docs/` como cofre no Obsidian e parar.
Presente:
1. **Ignorados** (`app.json`): Grep no `.gitignore` pelas linhas dentro de `docs/`; tirar o prefixo `docs/` de cada uma (`docs/sessoes/` → `sessoes/`). Somar ao array `userIgnoreFilters` as que ainda não estiverem lá; **nunca remover** as que já existem (podem ter sido postas à mão, ex. `runbooks/`, `Migrations/`).
2. **Links** (`app.json`): `"useMarkdownLinks": true` e `"newLinkFormat": "relative"` (desliga Wikilinks; já é o formato usado nos docs).
3. Avisar ao final: "feche e reabra o Obsidian para a mudança valer" — o app pode sobrescrever `app.json` ao salvar qualquer configuração antes disso.

## 5. CLAUDE.md do projeto
Auditoria sem editar; as únicas edições são as linhas de commit e de status abaixo, e só se o Dev aceitar.
- `CLAUDE.md` ausente → avisar e sugerir criar; parar.
- Presente → Read + `wc -c`; avaliar pelo passo 1 (Auditoria) de `otimizar-tokens`: peso, regras duplicadas, conteúdo de uso raro carregado em toda sessão.
- Sem regra de commit → oferecer a linha `Commit só quando pedido e só no repo da conversa, nunca em outro; \`git add\` só dos arquivos da tarefa.` (acrescentar só se aceitar).
- Sem regra de status → oferecer a linha `Ao iniciar, concluir ou bloquear um card, trocar só a tag \`status/...\` em \`tags:\` (pendente, em-andamento, concluido, bloqueado, cancelado).` (acrescentar só se aceitar).
- Relatório curto: ranking por bytes + sugestões. Aplicar só se o Dev pedir, via `otimizar-tokens` (ou `previa-diff` para ver antes).
- Projeto novo/sem conteúdo → pular.

## 6. Plugin no projeto (`.claude/settings.json`)
Garantir `"arquitetura-e-qualidade@arquitetura-e-qualidade": true` em `enabledPlugins`. Arquivo ou chave ausente → criar (`mkdir` se preciso) só com:
```json
{ "enabledPlugins": { "arquitetura-e-qualidade@arquitetura-e-qualidade": true } }
```
Existente → somar se faltar; preservar o resto, nunca remover entrada.
Permissão das skills: nunca no settings do projeto (só vale após confiar no workspace e é preferência pessoal, não do time). Avisar que, para não ser perguntado a cada skill, o Dev adiciona `Skill(arquitetura-e-qualidade:*)` em `permissions.allow` do settings global (`settings.json` da pasta de config do Claude Code). Nunca editar o global.

## 7. Tags (migração)
Só se `docs/` tiver notas sem tag de tipo (`backlog/...` ou `documentacao/...`), com tag antiga `tipo/` ou `grupo/`, ou com campo `status:` fora das tags. Ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`.
1. Achar (Grep `-L "^tags:.*(backlog|documentacao)/"`, Grep `"tipo/|grupo/"` e Grep `"^status:"`, só em `docs/`; ignorar `docs/sessoes/`).
2. Propor, por arquivo: tag de tipo pelo caminho e nome (tabela do TAGS.md; tag antiga `tipo/x`/`grupo/x` é substituída); `modulo/`/`fluxo/` só em tarefa, doc e decisão (pelo nome do arquivo e pasta; só o título se preciso); em tarefa, tag `status/` (campo `status:` existente vira a tag e sai do frontmatter; sem campo: caixas `[x]` todas marcadas → `concluido`; senão `pendente`); em decisão, `status/` pelo campo existente, senão a cargo do Dev (listar). Nota do módulo: tipo + `modulo/<m>` (pelo nome da pasta); notas gerais: só o tipo. Tag sem pasta ou arquivo correspondente → listar para o Dev aprovar. Nota sem frontmatter → criar o bloco no topo.
3. Mostrar via `previa-diff` (só o bloco de frontmatter). Aplicar só após aprovação, sem tocar no resto do arquivo.
Sem notas pendentes → pular.

## Regras
- JSON do cofre e do settings: editar só as chaves citadas; preservar o resto do arquivo.
- Rodar de novo no mesmo projeto é seguro: passos já feitos ficam sem efeito; o passo 4 só soma o que faltar.
