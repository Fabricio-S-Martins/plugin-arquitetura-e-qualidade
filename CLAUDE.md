# Plugin arquitetura-e-qualidade

Regras de trabalho neste repo:

1. Só informação necessária. Cortar palavras sem perder regras, limites ou exceções (economia de tokens; conteúdo usado com frequência).
2. Instrução por padrão: `docs/instrucoes/X.md`, telegráfico, lido pelo Claude.
3. Guia só se necessário: `docs/guias/X.md`, amigável, mesmo nome. Criar quando o Dev precisa entender o que é pedido ou decidido (cards, fluxos, skills, decisões do projeto). Não criar para princípios genéricos já conhecidos.
4. Se existirem os dois, o guia é visão geral — não repete cada regra, só não pode contradizer a instrução. Mudança que muda o que sai ou o que o Dev decide → atualizar os dois. (Vale só para a documentação do plugin.)
5. Skills: `SKILL.md` enxuto; guia amigável em `docs/guias/` só se necessário.
6. Respostas no chat: amigáveis e objetivas.
7. Skills que leem o projeto: no máximo 3 camadas (alvo + até 2 vizinhas), Glob → Grep → Read, 1 arquivo irmão, nunca varrer o projeto; camada não clara → perguntar.
8. Mudança que o usuário quer ver antes de aplicar (prévia, "mostra como ficaria") → skill `previa-diff`; nunca editar para mostrar.
9. Referência de qualidade ao gerar cards/projetos/código: `docs/instrucoes/QUALIDADE.md`.
10. Skill que lê/edita arquivo declara `allowed-tools` com só o que usa; regra que ela nunca deve fazer (editar, commitar) fica reforçada aí, não só na prosa.
