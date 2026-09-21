---
name: revisao-qa
description: Revisa card ou código contra as regras de qualidade e as convenções; só reporta, não corrige. Usar ao pedir revisão, QA, review ou "confere se está certo".
---

# revisao-qa

Só revisa e reporta. Não editar arquivos, não escrever código pronto, não se oferecer para corrigir. Corrigir apenas se o usuário pedir ("corrige", "ajusta"). Usuário quer ver como ficaria uma correção → `previa-diff` (não aplica). Rodar build/testes só se pedido, com o comando do `CLAUDE.md` do projeto.

## Alvo
- **Card `.md`:** conferir contra as Regras e o Gate de `skills/criar-card/SKILL.md`.
- **Código:** ler `docs/instrucoes/QUALIDADE.md`; se houver `.cs`, ler também `CSHARP.md` desta skill.
- Sem alvo informado → `git diff` atual; sem diff → perguntar.

## Modo
- **Rápido (padrão):** só o diff/alvo, itens mecânicos, regras OBR, segurança e card × código. Sem fontes do projeto, sem irmão, sem `(pré-existente)`.
- **Completo** (pedido: "completo", "profundo"): rápido + ler e seguir `COMPLETO.md` desta skill.
- **Parada antecipada:** Bloqueante estrutural (card fora do template, camada do alvo não identificável) → reportar e parar.

## Escopo (limite de leitura)
- Identificar a camada do alvo pelo caminho/projeto. Ler no máximo 3 camadas: a do alvo + até 2 vizinhas diretas (o que ela consome e quem a consome).
- Camada não clara → perguntar; fora do escopo → sinalizar, não ler; nunca varrer o projeto.

## Fluxo
1. Diff: abrir (Read) os arquivos tocados, o diff sozinho engana.
2. **Mecânico:** itens objetivos (`CSHARP.md`) verificados com Grep restrito às camadas do escopo, nunca de cabeça. Grep em modo contagem/lista de arquivos; Read só nos arquivos que casaram. Item recorrente → recomendar virar `.editorconfig`/analyzer.
3. **Card × código:** com card associado (informado ou achado em `cards/`), conferir que cada item do checklist tem contrapartida no código (Grep pelo nome citado) e que os cenários de teste do card estão cobertos. Item sem contrapartida = Bloqueante. Build/testes verdes não provam checklist cumprido.
4. **Segurança:** hash, token, criptografia e autorização têm prioridade máxima (erro silencioso: compila, roda, lógica errada). Sem teste dedicado = Bloqueante.
5. **Testes:** apontar teste que não pode falhar (afirma só o caso "falso"/vazio, sem preparação relevante, mock que já devolve o esperado): Recomendado.
6. **Julgamento:** para cada candidato perguntar: real ou purismo? analyzer já pega? confiança alta? Baixa confiança ou sem regra + local + sugestão → cortar. O filtro não vale para os mecânicos.
7. Achou um problema → varrer o escopo por todo padrão igual e reportar todos juntos.
8. **Diff cirúrgico:** apontar linha que não rastreia ao pedido, "melhoria" adjacente não pedida, refatoração do que não estava quebrado, órfão pré-existente apagado (apontar, nunca apagar). Corrigir a convenção do trecho que a mudança já toca é legítimo.
9. Cobertura ou melhoria fora do alvo vira sinalização, nunca item criado.

Precisão > cobertura. Diff limpo → aprovar; não inventar problema.

## Além dos defeitos
Sugerir a construção correta em uma frase: DTO/objeto de dados sem comportamento → `record`; tipo pequeno, imutável e em volume → `readonly struct`; classe/método sem estado → `static`.

## Relatório
Primeiro a conclusão: aprovado / com ressalvas / reprovado. Depois `Modo: <rápido|completo>. Escopo: <camadas lidas>. Não lido: <camadas/arquivos>`. Seções, com "—" quando vazia:
- **Bloqueante:** violação OBR de QUALIDADE ou erro que quebra o card/código.
- **Mecânico:** achados dos itens objetivos, sempre listada, mesmo pré-existentes. Fechar com "verificados sem ocorrência: <itens>" e "pulados por analyzer: <regra + onde confirmei>".
- **Recomendado:** violação PREF, convenção do projeto ou da linguagem.
- **Sugestão:** melhoria opcional.
- **Preservar:** 1 linha com o que carrega peso e não deve ser quebrado na próxima mudança.

Cada achado: `arquivo:linha` (ou seção do card) — regra — problema — correção em prosa, sem bloco de código. Terminar com `(confiança: alta|média)` (exceto mecânicos) e `(pré-existente)` quando fora do diff.
Mesmo padrão em vários arquivos → 1 achado listando os locais.
`Exceção: <regra> — <motivo>` registrada não é achado.
