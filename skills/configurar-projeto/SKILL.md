---
name: configurar-projeto
description: Configura docs/, CLAUDE.md e plugin do projeto; Obsidian e .editorconfig são opcionais. Usar ao iniciar projeto novo ou ao pedir para configurar/preparar o projeto ou o Obsidian.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill, Bash(winget *), Bash(mkdir *), Bash(claude plugin *), Bash(wc *)
---

# configurar-projeto

Sem alterar código. Ordem fixa.

## 1. Ferramentas do projeto
Lista do projeto: arquivo da área de padrões com tag `padrao` e nome `ferramentas.md` (Glob em `docs/`; pasta e nome do projeto, sugerindo `docs/padroes/regras/ferramentas.md`). 1 linha por ferramenta: `<ferramenta> — conferir: <comando> — instalar: <comando ou link>`. Exemplo, só do formato: `<servidor de linguagem> — conferir: <comando que lista a ferramenta> — instalar: <comando ou link>`.
- Lista existe: para cada linha, rodar o comando de conferir; que falha → não pular: avisar e tratar como ausente. Ausente → avisar e perguntar se instala agora. Sim + comando → rodar. Sem comando, ou comando inaplicável ao sistema → mostrar o link ou a instrução da linha e parar até confirmar instalado.
- Sem lista: perguntar uma vez se o projeto exige ferramentas locais (ex.: servidor de linguagem, CLI de build). Não → seguir. Sim → criar o arquivo só com o que o Dev informar, com `tags` do grupo de padrões (ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`) e linha no índice do grupo (ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/INDICE.md`, seção Índice de padrões). Depois, conferir como acima.

## 2. Pastas e .gitignore
Nomes citados (`docs/`, `docs/especificacoes/`, `docs/sessoes/`) são sugestão: valem as pastas que o projeto já usa; ausente → perguntar o nome, sugerindo o citado, e criar. Garantir a pasta de sessões no `.gitignore` (sem duplicar; nunca remover linha existente). Árvore de `docs/`: ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/ORGANIZACAO.md` (Árvore do projeto) e oferecer criar só as áreas e os índices que faltam, exceto as opcionais do passo 3 (planos, decisões); nunca mover, renomear nem apagar.

## 3. Opcionais
Uma pergunta só, com os itens que faltam; aceitou → Read do arquivo e seguir; recusou → seguir sem insistir.
- **Obsidian** (`OBSIDIAN.md`): sem `docs/.obsidian/`. Se já existe → Read sem perguntar (só sincroniza o que faltar).
- **.editorconfig** (`EDITORCONFIG.md`): projeto sem `.editorconfig` na raiz.
- **Padrões do projeto** (ex.: `docs/padroes/regras/` com `praticas.md`, `convencoes.md` e, se o projeto usa testes, `testes.md`; pastas e nomes do projeto: Glob, senão perguntar sugerindo o exemplo): arquivo ausente → aceitou → criar vazio, idioma do projeto, com `tags` do grupo de padrões (ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md`), título e 1 linha-guia (`# Práticas adotadas` / `<1 prática por linha, além de KISS, YAGNI, DRY, SRP e padronização; formato opcional "regra — como verificar"; "(preferível)" no fim se não for obrigatória>`; `# Convenções da linguagem` / `<1 convenção por linha: estilo e nomenclatura; mesmo formato>`; `# Testes` / `<1 regra de teste por linha; mesmo formato>`). O conteúdo é do Dev; nunca preencher. Criar também, se faltarem, o índice da área de padrões e o do grupo (ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/INDICE.md`, seção Índice de padrões; 1 linha por arquivo, descrição do que ele guarda tirada do título).
- **Planos e Decisões** (só a área que falta: Grep da tag de grupo em `docs/`). Aceitou → ler a instrução (`${CLAUDE_SKILL_DIR}/../../docs/instrucoes/<instrução>`) e criar só a área (nome: Glob, senão perguntar sugerindo a pasta) com o índice, como em `INDICE.md`, tags conforme `TAGS.md`; nenhum plano ou decisão agora. Decisões: sem modelo em `docs/padroes/` (o molde é do plugin).

| Opcional | Tag de grupo | Instrução | Pasta sugerida | Nasce em |
|---|---|---|---|---|
| Planos (arquivo do plano de cada demanda) | `plano` | `PLANO.md` | `docs/planos/` | `criar-plano` |
| Decisões (registro de decisão de arquitetura) | `decisao` | `DECISOES.md` | `docs/decisoes/` | `criar-plano`, Retomada da `executar-tarefa`, triagem de pontos em aberto |

## 4. CLAUDE.md do projeto
Auditoria sem editar; as únicas edições são as linhas de commit, da skill, de pontos em aberto e de Production (passo 5), e só se o Dev aceitar.
- `CLAUDE.md` ausente → avisar e sugerir criar; pular o resto deste passo (segue no 5).
- Presente → Read + `wc -c`; avaliar pelo passo 1 (Auditoria) de `otimizar-tokens` e por `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/CONTEXTO.md` (camada 1): peso, regras duplicadas, conteúdo de uso raro ou de uma só unidade carregado em toda sessão.
- Sem regra de commit → oferecer a linha `Commit só quando pedido e só no repo da conversa, nunca em outro; \`git add\` só dos arquivos alterados pelo trabalho pedido.` (acrescentar só se aceitar).
- Sem ponteiro da skill → oferecer a linha `Executar tarefa → usar a skill executar-tarefa.` (acrescentar só se aceitar).
- Sem linha de pontos em aberto e exceções aceitas (Grep `PONTOS-EM-ABERTO.md` no `CLAUDE.md`) → oferecer a linha `Achado de desvio do padrão fora do escopo da tarefa, ou pedido do Dev para registrar, consultar ou triar pontos em aberto: ler antes \`docs/instrucoes/PONTOS-EM-ABERTO.md\` do plugin arquitetura-e-qualidade; nunca corrigir nem ignorar. Ao tocar um módulo: Grep \`tags:.*excecao-aceita\` em \`docs/\` e ler só as linhas com \`modulo/<m>\`; exceção aceita não se corrige nem se aponta.` (acrescentar só se aceitar; os arquivos nascem no 1º registro, não aqui). Ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/PONTOS-EM-ABERTO.md` e `EXCECOES-ACEITAS.md` só para explicar ao Dev o que a linha cobre.
- Relatório curto: ranking por bytes + sugestões. Aplicar só se o Dev pedir, via skill `otimizar-tokens` (`mostrar-previa` só se o Dev pedir para ver antes).
- Projeto novo/sem conteúdo → pular.

## 5. Plugin no projeto (`.claude/settings.json`)
Listar em texto, uma só vez, tudo o que este passo soma (`enabledPlugins`, `permissions.ask` e a linha no `CLAUDE.md`) e aplicar só após o ok; prévia com antes e depois só se o Dev aceitar ver. Nada a somar → sem listar.
Garantir `"arquitetura-e-qualidade@arquitetura-e-qualidade": true` em `enabledPlugins`. Arquivo ou chave ausente → criar (`mkdir` se preciso) só com:
```json
{ "enabledPlugins": { "arquitetura-e-qualidade@arquitetura-e-qualidade": true } }
```
Existente → somar se faltar; nunca remover entrada.
**Proteção do ambiente de produção** (também no settings; `Production` abaixo = nome do ambiente de produção do projeto: Grep na configuração de ambiente, senão perguntar sugerindo `Production`): somar em `permissions.ask` (criar a chave se faltar; sem duplicar; nunca `deny`, o Dev precisa poder aprovar) `Bash(*ENVIRONMENT*Production*)` e `Bash(*--environment*Production*)`, mais as 2 iguais com `PowerShell(...)`. Com `CLAUDE.md` presente e sem regra de `Production` nele, somar: ``Ambiente de produção (`Production`): nunca usar nem como contorno de bloqueio (ex: uma validação) sem perguntar antes, listando as opções de forma clara e objetiva.``
Permissão das skills: nunca no settings do projeto (só vale após confiar no workspace e é preferência pessoal, não do time). Avisar que, para não ser perguntado a cada skill, o Dev adiciona `Skill(arquitetura-e-qualidade:*)` em `permissions.allow` do settings global (`settings.json` da pasta de config do Claude Code). Nunca editar o global.

## Regras
- JSON do settings: editar só as chaves citadas (`enabledPlugins`, `permissions.ask`); preservar o resto do arquivo.
- Rodar de novo no mesmo projeto é seguro: passos já feitos ficam sem efeito.
