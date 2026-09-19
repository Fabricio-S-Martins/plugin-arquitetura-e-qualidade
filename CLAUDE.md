# Plugin arquitetura-e-qualidade

Regras de trabalho neste repo:

1. Só informação necessária. Cortar palavras sem perder regras, limites ou exceções (economia de tokens; conteúdo usado com frequência).
2. Arquivo IA por padrão: `docs/ia/X.md`, telegráfico, lido pelo Claude.
3. Arquivo Dev só se necessário: `docs/dev/X.md`, amigável, mesmo nome. Criar quando o Dev precisa entender o que é pedido ou decidido (cards, fluxos, skills, decisões do projeto). Não criar para princípios genéricos já conhecidos.
4. Se existirem os dois, dizem o mesmo. Mudou um → mudar o outro.
5. Skills: `SKILL.md` enxuto (IA); guia amigável em `docs/dev/` só se necessário.
6. Respostas no chat: amigáveis e objetivas.
7. Skills que leem o projeto: no máximo 3 camadas (alvo + até 2 vizinhas), Glob → Grep → Read, 1 arquivo irmão, nunca varrer o projeto; camada não clara → perguntar.
8. Mudança que o usuário quer ver antes de aplicar (prévia, "mostra como ficaria") → skill `previa-diff`; nunca editar para mostrar.
9. Referência de qualidade ao gerar cards/projetos/código: `docs/ia/QUALIDADE.md`.
