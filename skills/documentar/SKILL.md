---
name: documentar
description: Documenta o código novo (fluxo, módulo, API, visão geral), mantém a documentação em dia quando o código muda e, sob pedido, gera um plano aprovado para documentar o restante, item a item. Usar ao pedir documentar, doc de fluxo/módulo, plano de documentação, ou ao alterar código que já tem doc.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(git status *), Bash(git diff *), Bash(git check-ignore *)
---

# documentar

Não alterar código. Criar/atualizar docs direto; só o plano exige aprovação.
**Um documento por rodada:** escrever 1 doc → gate → informar só nome e caminho e qual é o próximo → parar. Seguir só com "próximo" ou pedido explícito.

## Modos
- **Código novo** (padrão): alvo = arquivos criados na sessão (`git status --short`) ou citados.
- **Alterado:** código que já tem doc mudou de comportamento, rota, mensagem, regra ou configuração observável → atualizar o doc afetado.
- **Sistema existente:** só sob pedido, por escopo nomeado. Escopo não claro → perguntar. Nunca varrer o projeto.
- **Plano / Item:** pedido de plano ou "faz o item N" → ler `PLANO.md` (esta pasta).

## Código novo
1. **Alvo:** ler o código (Glob → Grep → Read; até 3 camadas; regra do tipo em `docs/padroes/` no lugar do irmão; sem regra, 1 arquivo irmão real). Identificar fluxo(s) e módulo(s) tocados; nome não claro → perguntar.
2. **Existente antes de criar:** Glob em `docs/documentacao/` (padrão de docs do projeto primeiro; senão a estrutura abaixo). Doc do assunto existe → atualizar; senão criar. Projeto sem a regra "mudou comportamento → atualizar a doc" no `CLAUDE.md` → oferecer a linha (só adicionar se o usuário aceitar).
3. **Fila:** módulo → fluxos (1 por rodada) → API (só se houver rotas; modelo em `API.md`) → `docs/documentacao/documentacao.md` (criar se ausente; senão acrescentar o link do que já existe). Escrever só o próximo da fila → **Gate**.
4. **Após o último:** parar, sem perguntar pelo plano. O que ficou de fora entra em `Não documentado` no `docs/documentacao/documentacao.md` (só nomes, via Glob de 1 nível, sem ler). Plano só por pedido explícito → `PLANO.md`.

## Alterado
1. **Mudança:** ler só o que mudou (`git diff` do alvo). Extrair nomes observáveis: módulo, rota, etapa, mensagem de erro, configuração.
2. **Achar o doc:** Grep desses nomes em `docs/documentacao/` (docs não citam código; o vínculo é por nome). Nada achado → perguntar; nunca concluir que não há doc.
3. **Atualizar** o que ficou falso ou incompleto, 1 doc por rodada, listando os demais afetados → **Gate**. Refatoração sem mudança observável → não mexer.

## Estrutura e modelos
Público: negócio e dev que integra (consome a API). Linguagem de negócio, sem links nem caminhos para código, sem termos de camada (Domínio, Aplicação, Infraestrutura, handler, MediatR). Um arquivo por assunto; frases curtas, títulos sempre iguais.
- `docs/documentacao/documentacao.md`: `Módulos` (link + 1 linha) · `Não documentado`. Só aponta; fluxo e API só pelo link do módulo, nunca direto (1 fato, 1 lugar).
- `docs/documentacao/modulos/<nome>/<nome>.md`: 1-2 linhas do que o módulo é · `Etapas` (se houver ciclo) · `Regras` · `Fluxos` (links `fluxos/<f>.md`; fluxo de outro módulo: `../<principal>/fluxos/<f>.md`) · `Integração` (link para `api/<nome>-api.md`). Fluxo nunca inline.
- `docs/documentacao/modulos/<nome>/api/<nome>-api.md`: guia de integração; modelo em `API.md`.
- `docs/documentacao/modulos/<nome>/fluxos/<f>.md`: fluxo na pasta do módulo principal (o 1º citado); com 2+ módulos, os outros linkam no `Fluxos` do seu módulo. `Objetivo` (1 linha) · `Diagrama` (Mermaid `flowchart TD`, sempre vertical) · `Regras`. `Entrada`, `Passos` e `Saída` só se o diagrama não bastar.
- **Técnico por projeto:** só sob pedido explícito, em `docs/documentacao/modulos/<nome>/<nome>-<projeto>.md`.
- **Links:** relativos, só entre docs. Todo doc linka o pai imediato (fluxo e API → `../<nome>.md`; módulo → `../../documentacao.md`); só o geral não tem pai. Técnico → módulo, mas módulo nunca lista o técnico (fora do padrão).
- **Estilo:** títulos com iniciais maiúsculas; sequência ou respostas em tabela (colunas curtas centralizadas com `:---:`, passo/status em negrito, detalhe em itálico); exceção à regra geral em `> ⚠️ **Atenção:**`.

## Regras
- **Origem:** todo fato vem de código lido ou do usuário. Não confirmado → não escrever; perguntar. Sem seção `Em aberto` nos docs (exceto no plano).
- **Regra de negócio:** traduzir só o que o código confirma. Quem executa cada etapa só se o usuário informar.
- **Só o versionado:** citar (link ou nome) apenas o que o git versiona. Ignorado (`.gitignore`) ou fora do repo → não citar.
- **Mermaid:** rótulos entre aspas e em linguagem de negócio; decisão em losango.
- **Nomes:** 100% pt-br (arquivos, pastas, títulos). Arquivos de um módulo prefixados com o módulo (legibilidade no grafo e na busca), exceto a nota do módulo (`<m>.md`), que repete o nome entre backlog e documentação.
- **Tags:** seguir `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/TAGS.md` (grupo `documentacao`; `modulo/` + `fluxo/` no fluxo; `modulo/` + `camada/` na API e em doc de camada; módulo e geral sem `fluxo/` nem `camada/`). Doc sem estado; nunca citar task.
- **Doc existente que o usuário quer ver antes de aplicar** → `previa-diff`.
- **Só o que existe:** documentar o implementado, mesmo parcial; nunca inventar o que falta nem recusar por incompleto (modo Alterado atualiza depois). Fluxo sem rota → cobrir o que o código faz e dizer o que ficou de fora.

## Gate antes de entregar
1. Reler estas regras contra o doc escrito.
2. Conferir com ferramenta: rotas e mensagens de erro contra o código (Grep); links relativos (Glob); nomes ignorados pelo git (`git check-ignore`).
3. Mermaid fechado, com rótulos entre aspas.
4. Correção aplicada → varrer os docs já criados na sessão por padrão igual e corrigir junto.
