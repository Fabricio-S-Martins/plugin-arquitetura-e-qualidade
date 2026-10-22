---
name: configurar-projeto
description: Configura docs/, CLAUDE.md e plugin do projeto; Obsidian e .editorconfig são opcionais. Usar ao iniciar projeto novo ou ao pedir para configurar/preparar o projeto ou o Obsidian.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill, Bash(winget *), Bash(mkdir *), Bash(dotnet tool *), Bash(claude plugin *), Bash(wc *), Bash(dotnet build *)
---

# configurar-projeto

Sem alterar código. Ordem fixa.

## Ferramentas necessárias
| Ferramenta | Conferir (Windows) | Instalar (Windows) | Sem Windows |
|---|---|---|---|
| csharp-ls (só projeto C#) | `dotnet tool list -g` (procurar `csharp-ls`) | `dotnet tool install -g csharp-ls` | requer .NET SDK: https://dotnet.microsoft.com/download |
| plugin csharp-lsp (só projeto C#) | `claude plugin list` (procurar `csharp-lsp`) | `claude plugin marketplace add anthropics/claude-plugins-official` (se faltar) e `claude plugin install csharp-lsp@claude-plugins-official` | mesmo comando |

## 1. Ferramentas da lista
Linha "só projeto C#": rodar só se Glob achar `*.csproj`/`*.sln` na raiz ou 1 nível abaixo; senão, pular. Comando de conferir que falha → não pular: avisar e tratar como ausente.
Para cada linha: ausente → avisar e perguntar se instala agora. Sim + comando Windows → rodar comando da coluna Instalar. Sem comando ou outro SO → link da coluna "Sem Windows" e parar até confirmar instalado.

## 2. Pastas e .gitignore
Nomes citados (`docs/`, `docs/especificacoes/`, `docs/sessoes/`) são sugestão: valem as pastas que o projeto já usa; ausente → perguntar o nome, sugerindo o citado, e criar. Garantir a pasta de sessões no `.gitignore` (sem duplicar; nunca remover linha existente).

## 3. Opcionais
Uma pergunta só, com os itens que faltam; aceitou → Read do arquivo e seguir; recusou → seguir sem insistir.
- **Obsidian** (`OBSIDIAN.md`): sem `docs/.obsidian/`. Se já existe → Read sem perguntar (só sincroniza o que faltar).
- **.editorconfig** (`EDITORCONFIG.md`): projeto C# (critério do passo 1) sem `.editorconfig` na raiz.
- **Padrões do projeto** (ex.: `docs/padroes/praticas.md`, `convencoes.md` e, se o projeto usa testes, `testes.md`; pasta e nomes do projeto: Glob, senão perguntar sugerindo o exemplo): arquivo ausente → aceitou → criar vazio, idioma do projeto, só título e 1 linha-guia (`# Práticas adotadas` / `<1 prática por linha, além de KISS, YAGNI, DRY, SRP e padronização; formato opcional "regra — como verificar"; "(preferível)" no fim se não for obrigatória>`; `# Convenções da linguagem` / `<1 convenção por linha: estilo e nomenclatura; mesmo formato>`; `# Testes` / `<1 regra de teste por linha; mesmo formato>`). O conteúdo é do Dev; nunca preencher.

## 4. CLAUDE.md do projeto
Auditoria sem editar; as únicas edições são as linhas de commit, da skill e de Production (passo 5), e só se o Dev aceitar.
- `CLAUDE.md` ausente → avisar e sugerir criar; parar.
- Presente → Read + `wc -c`; avaliar pelo passo 1 (Auditoria) de `otimizar-tokens`: peso, regras duplicadas, conteúdo de uso raro carregado em toda sessão.
- Sem regra de commit → oferecer a linha `Commit só quando pedido e só no repo da conversa, nunca em outro; \`git add\` só dos arquivos da tarefa.` (acrescentar só se aceitar).
- Sem ponteiro da skill → oferecer a linha `Executar tarefa/card → usar a skill executar-tarefa.` (acrescentar só se aceitar).
- Relatório curto: ranking por bytes + sugestões. Aplicar só se o Dev pedir, via `otimizar-tokens` (`previa-diff` só se o Dev pedir para ver antes).
- Projeto novo/sem conteúdo → pular.

## 5. Plugin no projeto (`.claude/settings.json`)
Garantir `"arquitetura-e-qualidade@arquitetura-e-qualidade": true` em `enabledPlugins`. Arquivo ou chave ausente → criar (`mkdir` se preciso) só com:
```json
{ "enabledPlugins": { "arquitetura-e-qualidade@arquitetura-e-qualidade": true } }
```
Existente → somar se faltar; preservar o resto, nunca remover entrada.
**Proteção do ambiente de produção** (também no settings; `Production` abaixo = nome do ambiente de produção do projeto: Grep na configuração de ambiente, senão perguntar sugerindo `Production`): somar em `permissions.ask` (criar a chave se faltar; sem duplicar; nunca `deny`, o Dev precisa poder aprovar) `Bash(*ENVIRONMENT*Production*)` e `Bash(*--environment*Production*)`, mais as 2 iguais com `PowerShell(...)`. Com `CLAUDE.md` presente e sem regra de `Production` nele, somar: ``Ambiente de produção (`Production`): nunca usar nem como contorno de bloqueio (ex: uma validação) sem perguntar antes, listando as opções de forma clara e objetiva.`` Listar em texto o que será somado (uma só vez, settings e `CLAUDE.md`) e aplicar só após o ok; prévia com antes e depois só se o Dev aceitar ver. Nada a somar → sem listar.
Permissão das skills: nunca no settings do projeto (só vale após confiar no workspace e é preferência pessoal, não do time). Avisar que, para não ser perguntado a cada skill, o Dev adiciona `Skill(arquitetura-e-qualidade:*)` em `permissions.allow` do settings global (`settings.json` da pasta de config do Claude Code). Nunca editar o global.

## Regras
- JSON do settings: editar só as chaves citadas (`enabledPlugins`, `permissions.ask`); preservar o resto do arquivo.
- Rodar de novo no mesmo projeto é seguro: passos já feitos ficam sem efeito.
