---
name: revisao-qa
description: Revisa card ou código contra as regras de qualidade e as convenções; só reporta, não corrige. Usar ao pedir revisão, QA, review ou "confere se está certo".
allowed-tools: Read, Glob, Grep, Bash(git diff *), Bash(git status *)
---

# revisao-qa

Só revisa e reporta. Não editar arquivos, não escrever código pronto, não se oferecer para corrigir. Corrigir apenas se o usuário pedir ("corrige", "ajusta"). Usuário quer ver como ficaria uma correção → `previa-diff` (não aplica). Rodar build/testes só se pedido, com o comando do `CLAUDE.md` do projeto.

## Alvo
- **Card `.md`:** conferir contra as Regras e o Gate de `skills/criar-card/SKILL.md`. Item que depende de irmão ("Dentro dela", "nela", "idem") em vez de sub-item sob o pai (regra Hierarquia) = desvio; Grep no card.
- **Especificação `.md`:** conferir contra a Escrita e o Gate de `skills/especificar/SKILL.md`.
- **Código:** ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/QUALIDADE.md` e os padrões do projeto que ele indica; ausentes → avisar no relatório.
- Sem alvo informado → `git diff` atual; sem diff → perguntar.

## Modo
- **Rápido (padrão):** só o diff/alvo, itens mecânicos, princípios obrigatórios, segurança e card × código. Sem fontes do projeto, sem irmão, sem `(pré-existente)`.
- **Completo** (pedido: "completo", "profundo"): rápido + ler e seguir `COMPLETO.md` desta skill.
- **Parada antecipada:** Bloqueante estrutural (card fora do template, divisão do alvo não identificável) → reportar e parar.

## Escopo (limite de leitura)
- Identificar a divisão do alvo (camada, módulo, pasta) pelo caminho/projeto. Ler no máximo 3 divisões: a do alvo + até 2 vizinhas diretas (o que ela consome e quem a consome). Salvo pedido do Dev (vale só nesta execução); sem pedido, avisar que lê só isso e que ele pode pedir mais.
- Divisão não clara → perguntar; fora do escopo (cobertura ou melhoria) → sinalizar, não ler nem criar item.

## Fluxo
1. Diff: abrir (Read) os arquivos tocados, o diff sozinho engana.
2. **Mecânico:** itens objetivos dos padrões do projeto (os com "como verificar") verificados com Grep restrito às camadas do escopo, nunca de cabeça. Grep em modo contagem/lista de arquivos; Read só nos arquivos que casaram. Item recorrente → recomendar virar `.editorconfig`/analyzer.
3. **Card × código:** com card associado (informado ou achado em `docs/backlog/`), conferir que cada item do checklist tem contrapartida no código (Grep pelo nome citado) e, em projeto com testes, que os cenários de teste do card estão cobertos. Card com `Especificação`: ler (Read) e conferir que cada critério citado tem contrapartida no código e que as regras do fluxo não são contrariadas. Item ou critério sem contrapartida = Bloqueante. Build/testes verdes não provam checklist cumprido.
4. **Segurança:** hash, token, criptografia e autorização têm prioridade máxima (erro silencioso: compila, roda, lógica errada). Projeto com testes: sem teste dedicado = Bloqueante.
5. **Testes (projeto com testes):** apontar teste que não pode falhar (afirma só o caso "falso"/vazio, sem preparação relevante, mock que já devolve o esperado): Recomendado.
6. **Julgamento:** para cada candidato perguntar: real ou purismo? analyzer já pega? confiança alta? Baixa confiança ou sem regra + local + sugestão → cortar. O filtro não vale para os mecânicos.
7. Achou um problema → varrer o escopo por todo padrão igual e reportar todos juntos.
8. **Organização:** pasta/arquivo novo comparado com 1 unidade irmã (Glob): estrutura assimétrica ou sem espelho em docs/backlog/testes = Recomendado (ler `${CLAUDE_SKILL_DIR}/../../docs/instrucoes/ORGANIZACAO.md`); assimetria pré-existente só listar.
9. **Diff cirúrgico:** apontar linha que não rastreia ao pedido, "melhoria" adjacente não pedida, refatoração do que não estava quebrado, órfão pré-existente apagado (apontar, nunca apagar). Corrigir a convenção do trecho que a mudança já toca é legítimo.

Precisão > cobertura. Diff limpo → aprovar; não inventar problema.

## Além dos defeitos
Sugerir em uma frase a construção imutável/sem estado que a linguagem do projeto oferece (objeto de dados sem comportamento, tipo pequeno imutável em volume, classe/método sem estado), conforme as convenções do projeto.

## Relatório
Primeiro a conclusão: aprovado / com ressalvas / reprovado. Depois `Modo: <rápido|completo>. Escopo: <divisões lidas>. Não lido: <camadas/arquivos>`. Seções, omitir a que ficar vazia (exceto Mecânico, sempre listada):
- **Bloqueante:** violação de princípio de QUALIDADE ou de item obrigatório (sem marca) dos padrões do projeto, ou erro que quebra o card/código.
- **Mecânico:** achados dos itens objetivos, sempre listada, mesmo pré-existentes. Fechar com "verificados sem ocorrência: <itens>" e "pulados por analyzer: <regra + onde confirmei>".
- **Recomendado:** violação de item `(preferível)` dos padrões do projeto.
- **Sugestão:** melhoria opcional.
- **Preservar:** 1 linha com o que carrega peso e não deve ser quebrado na próxima mudança.

Cada achado: `arquivo:linha` (ou seção do card) — regra — problema — correção em prosa, sem bloco de código. Terminar com `(confiança: alta|média)` (exceto mecânicos) e `(pré-existente)` quando fora do diff.
Mesmo padrão em vários arquivos → 1 achado listando os locais.
`Exceção: <regra> — <motivo>` registrada não é achado.

Fechar com parecer em 1 frase direta: "Sim — único ponto foi X" ou, sem bloqueante/recomendado, "Sim, sem ressalvas."
