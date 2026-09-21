# Plano e item

Lido só nos modos Plano e Item. Regras e gate: `SKILL.md`.

## Plano
1. **Levantar** o restante do módulo/fluxo do alvo: Glob de 1 nível + Grep, sem ler tudo.
2. **Perguntar** só o que o código não responde (o que entra, o que é legado, prioridade), numeradas e curtas. Resposta vaga → perguntar de novo.
3. **Apresentar** sem criar doc: itens numerados `[ ] N. destino · origem (código coberto) · deps`, ordem de dependência (módulos → fluxos → API → visão geral), `Em aberto`. Cada item = exatamente 1 documento. Encerrar com "Aguardando aprovação."
4. **Aprovação:** só "aprovado" ou equivalente explícito. Ajuste → reapresentar. Aprovado → salvar em `docs/sessoes/plano-documentacao.md` (existente → atualizar; acrescentar `docs/sessoes/` ao `.gitignore` se ausente) e executar o item 1.

## Item
"Faz o item N" ou "próximo": só aquele documento → gate → marcar `[x]` → informar nome e caminho e o próximo item → parar.
