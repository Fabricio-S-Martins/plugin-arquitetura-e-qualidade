# Plugin arquitetura-e-qualidade

Objetivo: qualidade de arquitetura em todo o ciclo do projeto (especificação, planejamento, implementação, testes, documentação, organização), com a IA facilitando. O plugin impõe o método, nunca padrão concreto: o projeto define o seu e o plugin o faz valer, sem exceção silenciosa. Entre opções, a de melhor qualidade; empate → a que gasta menos tokens e passos. Economia de tokens nunca à custa de qualidade ou contexto.

Regras de trabalho neste repo:

1. Qualidade e abstração ao gerar cards/projetos/código: `docs/instrucoes/QUALIDADE.md` (o padrão é do projeto; o plugin só impõe o método).
2. Nada específico de linguagem, ferramenta, número ou estilo no plugin: isso vive nos arquivos de padrões do projeto (práticas, convenções, testes, modelos). O plugin só dá exemplo, marcado como exemplo.
3. Só informação necessária: cortar palavras sem perder regra, limite, exceção nem o porquê que evita interpretação errada (conteúdo usado com frequência).
4. Instrução por padrão: `docs/instrucoes/X.md`, telegráfico, lido pelo Claude.
5. `SKILL.md` enxuto. Guia só se necessário: `docs/guias/X.md`, amigável, mesmo nome; criar quando o Dev precisa entender o que é pedido ou decidido (cards, fluxos, skills, decisões do projeto), nunca para princípio genérico conhecido. Existindo instrução e guia, o guia é visão geral: não repete cada regra nem contradiz a instrução; mudança no que sai ou no que o Dev decide → atualizar os dois (só documentação do plugin).
6. Respostas no chat: amigáveis e objetivas.
7. Skills que leem o projeto: por padrão no máximo 3 camadas (alvo + até 2 vizinhas), Glob → Grep → Read, 1 arquivo irmão; camada não clara → perguntar. Sem pedido do Dev, avisar que lê só isso e que ele pode pedir mais (ex: varredura completa; vale só naquela execução); nunca varrer o projeto sem pedido.
8. Prévia (`previa-diff`): nunca mostrar por iniciativa do Claude; no máximo perguntar se o usuário quer ver. Só mostra se ele pedir ("prévia", "mostra como ficaria") ou aceitar. Padrão: alinhar o desenho em texto e, combinado, aplicar direto. Nunca editar para mostrar.
9. Skill que lê/edita arquivo declara `allowed-tools` com só o que usa; regra que ela nunca deve fazer (editar, commitar) fica reforçada aí, não só na prosa.
10. Nomes de skills, arquivos e pastas em português.
11. Commit só quando pedido e só no repo da conversa, nunca em outro; `git add` só dos arquivos da tarefa. Mensagem `tipo: descrição` (`feat:`, `fix:`, `docs:`).
12. Mudança em skill → subir `version` em `.claude-plugin/plugin.json`: correção `0.y.Z`; skill nova, comportamento novo ou nome alterado `0.Y.0`.
13. Mudança no formato de arquivo do projeto (frontmatter, pasta, nome, tag) ou regra que sai do plugin → no mesmo commit, `docs/migracoes/X.Y.Z.md` com o prompt só daquela versão: regras novas ou retiradas + passos que listam o que muda em texto e só aplicam após o "aprovado" do Dev, sem alterar código nem commitar. Regra retirada: a migração a oferece ao projeto só se ele a usava, nunca com item novo.
14. Ao criar ou mexer em skill, perguntar: o que o Dev precisa no 1º uso? E o que isto impõe a um projeto (tem que ser exemplo, nunca regra fixa)? O resto é parte opcional, escolhida por ele (modo ou escopo). Parte grande e de uso raro → arquivo à parte, lido sob demanda; parte curta → `SKILL.md` como modo. O padrão funciona sem escolha; gate, checagem do padrão do projeto e regras comuns ficam no núcleo: simplificar o uso nunca tira a checagem de qualidade.
15. Tipo de nota ou arquivo novo que o plugin gera no projeto: antes de fechar, conferir tags (`TAGS.md`), índice (`INDICE.md`), lugar e espelho (`ORGANIZACAO.md`), nomes do projeto, guia e migração. Nota sem tags não existe.
