# PONTOS-EM-ABERTO

Peneira de achados ainda sem decisão: desvio do padrão do projeto, ou possível desvio, que não será resolvido agora. Não se perde nem vira correção fora do escopo. Entra e sai item o tempo todo; o que foi decidido vai para o destino (abaixo) e sai daqui. Opcional: só onde o `CLAUDE.md` do projeto tem a linha deste assunto. Nomes de arquivo, pasta e tag citados são exemplo: valem os do projeto.
- **Entra:** desvio ou possível desvio de regra do projeto (práticas, convenções, testes, especificação, decisão) achado fora do escopo da tarefa em execução, mesmo sem certeza de ser problema. **Fora:** bug da tarefa em execução (corrige-se nela, no próprio trabalho), decisão já tomada (`DECISOES.md`), exceção já aceita (`EXCECOES-ACEITAS.md`), pendência no arquivo da tarefa (`Retomada`).
- **Arquivo:** um só, na raiz de `docs/` (Grep `tags:.*ponto-em-aberto` em `docs/`; ausente → perguntar o nome, sugerindo `docs/pontos-em-aberto.md`). Nasce no 1º registro, com ok do Dev. Tags: `TAGS.md`. Não é área com unidades: sem índice nem espelho.
- **Registrar:** Dev pede ("registra nos pontos em aberto") → gravar direto. Achado do Claude → nunca corrigir nem ignorar: propor em texto a entrada pronta e gravar só com aceite. Antes, conferir se já foi tratado: Grep pelo módulo ou arquivo em (1) este arquivo, (2) as exceções aceitas, (3) as decisões aceitas do módulo, (4) tarefas `tarefa/pendente` do módulo. Coberto → não registrar; dizer onde está. Parecido mas não igual → perguntar. Gravar no fim do arquivo (Edit), sem ler o resto.
- **Ler:** só o Dev, por padrão. Claude lê só a pedido ("o que tem em aberto em X?", "faz a triagem"); nunca por iniciativa, nunca dentro de outra skill.
- **Triagem (a pedido):** listar título + `Área` de cada entrada; o Dev dá o destino de cada uma; executar:
  - aceito, escolha estrutural difícil de reverter → gravar a decisão `decisao/proposta` (projeto com decisões, `DECISOES.md`; senão regra no padrão do projeto) e criar a tarefa do que precisa ser feito (`criar-tarefa` ou `planejar`);
  - aceito, pontual (ou "não era problema") → gravar a linha em `EXCECOES-ACEITAS.md` com o motivo (regra ambígua → esclarecer a regra); se algo ainda não foi implementado e não há tarefa (Grep `tarefa/pendente` + `modulo/<m>`), criar a tarefa;
  - corrigir → tarefa (`criar-tarefa` ou `planejar`);
  - sem existir mais (achado factualmente errado) → só apagar.
  Destino cumprido → apagar a entrada (o destino guarda a história). Sem decisão → manter.

## Entrada (arquivo existente no projeto → seguir o formato dele)
```
## <ponto em poucas palavras>
- **Fora do padrão:** <o que foge e qual regra do projeto quebra, ou a dúvida se quebra>
- **Onde:** <módulo, arquivo ou símbolo; sem número de linha>
- **Impacto:** <risco, 1 linha>
- **Área:** <modulo/<m>, fluxo/<f> se houver>
- **Registrado em:** <data> (<tarefa ou contexto, se houver>)
```
