---
name: documentar
description: Documenta o código novo (fluxo, módulo, API, visão geral), mantém a documentação em dia quando o código muda e, se o usuário quiser, gera um plano aprovado para documentar o restante, item a item. Usar ao pedir documentar, documentação, doc de fluxo/módulo, plano de documentação, ou ao alterar código que já tem doc.
---

# documentar

Só fatos do código. Não alterar código nem commitar. Criar/atualizar docs direto; só o plano exige aprovação.
**Um documento por rodada:** escrever 1 doc → gate → informar só nome e caminho e qual é o próximo → parar. Seguir só com "próximo" ou pedido explícito.

## Modos
- **Código novo** (padrão): alvo = arquivos criados na sessão (`git status --short`) ou citados.
- **Alterado:** código que já tem doc mudou de comportamento, rota, mensagem, regra ou configuração observável → atualizar o doc afetado.
- **Sistema existente:** só sob pedido, por escopo nomeado ("documenta o fluxo de pedidos"). Escopo não claro → perguntar. Nunca varrer o projeto.
- **Plano / Item:** pedido de plano, "sim" à pergunta final do código novo ou "faz o item N" → ler `PLANO.md` (esta pasta).

## Código novo
1. **Alvo:** ler o código do alvo (Glob → Grep → Read; até 3 camadas; 1 arquivo irmão real). Identificar fluxo(s) e módulo(s) tocados; nome não claro → perguntar.
2. **Existente antes de criar:** Glob em `docs/` (padrão de docs do projeto primeiro; senão a estrutura abaixo). Doc do assunto existe → atualizar; senão criar. Projeto sem a regra "mudou comportamento → atualizar a doc" no `CLAUDE.md` → oferecer a linha (só adicionar se o usuário aceitar).
3. **Fila:** módulo → fluxos (1 por rodada) → API (só se houver rotas; modelo em `API.md`) → `docs/README.md` (criar se ausente; senão acrescentar o link do que já existe). Escrever só o próximo da fila → **Gate**.
4. **Após o último:** "Quer o plano de documentação do restante de <módulo/fluxo>?" Não → parar; o que ficou de fora entra em `Não documentado` no `docs/README.md` (só nomes, via Glob de 1 nível, sem ler). Sim → `PLANO.md`.

## Alterado
1. **Mudança:** ler só o que mudou (`git diff` do alvo). Extrair nomes observáveis: módulo, rota, etapa, mensagem de erro, configuração (ex.: ambiente do Swagger).
2. **Achar o doc:** Grep desses nomes em `docs/` (docs não citam código; o vínculo é por nome). Nada achado → perguntar; nunca concluir que não há doc.
3. **Atualizar** o que ficou falso ou incompleto, 1 doc por rodada, listando os demais afetados → **Gate**. Refatoração sem mudança observável → não mexer.

## Estrutura e modelos
Público: negócio e dev que integra (consome a API). Linguagem de negócio, sem links nem caminhos para código, sem termos de camada (Domínio, Aplicação, Infraestrutura, handler, MediatR). Um arquivo por assunto; frases curtas, títulos sempre iguais.
- `docs/README.md`: `Módulos` e `Fluxos` (link + 1 linha) · `Decisões` (links) · `Não documentado`. Só aponta.
- `docs/modulos/<nome>/<nome>.md`: 1-2 linhas do que o módulo é · `Etapas` (se houver ciclo) · `Regras` (linguagem de negócio) · `Fluxos` (links) · `Integração` (link para `<nome>-api.md`). Fluxo nunca inline.
- `docs/modulos/<nome>/<nome>-api.md`: guia de integração; modelo em `API.md`.
- `docs/fluxos/<nome>.md`: `Objetivo` (1 linha) · `Diagrama` (Mermaid `flowchart TD`, sempre vertical) · `Regras`. `Entrada`, `Passos` e `Saída` só se o diagrama não bastar.
- `docs/decisoes/<nome>.md`: `Contexto` · `Decisão` · `Motivo` · `Descartado`. Só do que o usuário informou; motivo ausente → perguntar.
- **Técnico por projeto** (Domínio, Aplicação...): só sob pedido explícito, em `docs/modulos/<nome>/<nome>-<projeto>.md`.
- **Links:** relativos, só entre docs.
- **Estilo:** títulos com iniciais maiúsculas; sequência ou respostas em tabela (colunas curtas centralizadas com `:---:`, passo/status em negrito, detalhe em itálico); exceção à regra geral em `> ⚠️ **Atenção:**`.

## Regras
- **Origem:** todo fato vem de código lido ou do usuário. Não confirmado → não escrever; perguntar. Sem seção `Em aberto` nos docs (exceto no plano).
- **Regra de negócio:** traduzir só o que o código confirma. Quem executa cada etapa só se o usuário informar.
- **Só o versionado:** citar (link ou nome) apenas o que o git versiona. Ignorado (`.gitignore`) ou fora do repo → não citar. Ex.: `runbooks/` ignorada.
- **Um fato, um lugar:** o resto aponta por link.
- **Mermaid:** rótulos entre aspas e em linguagem de negócio; decisão em losango; só o que o código faz.
- **Nomes:** 100% pt-br (arquivos, pastas, títulos). Nome de arquivo único em todo `docs/` (Obsidian identifica nota só pelo nome): docs de módulo prefixados com o módulo (`pedidos-api.md`).
- **Doc existente que o usuário quer ver antes de aplicar** → `previa-diff`.

## Gate antes de entregar
1. Reler estas regras contra o doc escrito.
2. Conferir com ferramenta: rotas e mensagens de erro contra o código (Grep); links relativos (Glob); nomes ignorados pelo git (`git check-ignore`).
3. Mermaid fechado, com rótulos entre aspas.
4. Correção aplicada → varrer os docs já criados na sessão por padrão igual e corrigir junto.
