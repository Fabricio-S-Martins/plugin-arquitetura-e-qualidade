# Modelo de api.md

Regras e estilo: `SKILL.md`.

Guia de integração, não contrato por rota:
1. Nota inicial: contrato completo (campos, tipos, status) no contrato publicado pelo projeto (OpenAPI/Swagger ou equivalente; achar como o projeto o expõe), dizendo em que ambiente fica. Sem contrato publicado → perguntar se deve ir por escrito.
2. `Ordem das Chamadas`: tabela `Passo | Método | Rota | Descrição`, só se a ordem for real. Rota fora da sequência (ex.: cancelar) em destaque de atenção (estilo de `SKILL.md`).
3. `Respostas e Erros`: tabela `Status | Tipo | Descrição / Regra` (sucesso, formato do 400, 404).

Rotas e mensagens de erro copiadas exatas do código (Grep). Rota real = prefixo do grupo ou base do host + rota do endpoint; conferir onde o projeto registra as rotas. Trecho variável → `<placeholder>`.
