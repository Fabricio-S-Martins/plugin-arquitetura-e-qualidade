# Modelo de api.md

Lido só ao escrever `docs/modulos/<nome>/<nome>-api.md`. Regras e estilo: `SKILL.md`.

Guia de integração, não contrato por rota:
1. Nota inicial: contrato completo (campos, tipos, status) no Swagger/OpenAPI do projeto (Grep `AddSwaggerGen`/`AddOpenApi`), dizendo em que ambiente fica. Sem Swagger/OpenAPI → perguntar se o contrato deve ir por escrito.
2. `Ordem das Chamadas`: tabela `Passo | Método | Rota | Descrição`, só se a ordem for real. Rota fora da sequência (ex.: cancelar) em `> ⚠️ **Atenção:**`.
3. `Respostas e Erros`: tabela `Status | Tipo | Descrição / Regra` (sucesso, formato do 400, 404).

Rotas e mensagens de erro copiadas exatas do código (Grep). Rota real = prefixo do grupo (`MapGroup` no host) + rota do endpoint; conferir no host. Trecho variável → `<placeholder>`.
