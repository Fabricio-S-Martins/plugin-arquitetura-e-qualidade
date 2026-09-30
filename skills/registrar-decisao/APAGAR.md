# Apagar decisão

Lido só ao apagar. Regras: `SKILL.md`.

Decisão que vai virar trabalho (`planejar`/`criar-card` ou pedido do Dev) ou é descartada: não há status `descartada`, apaga-se. Listar ao Dev o que será feito e esperar o ok: arquivo, link no índice do módulo e cards que citam `decisoes/<nome>` (Grep em `docs/backlog/`). Com o ok:
1. Card que nasce da decisão ou a citava: garantir em `O que fazer` a linha `**Decisão:** <escolha + motivo>` (vinda de `Decisão`; vazia → perguntar) e tirar `<modulo>/decisoes/<nome>` do Deps. Tag de status do card só muda (ex. `status/bloqueado` → `status/pendente`) se o Dev confirmar. Descartada citada em Deps → perguntar o que fazer com o card.
2. Tirar o link da seção `Decisões` do índice de cada módulo (principal e demais) (seção vazia → remover).
3. Apagar o arquivo (`rm`).
