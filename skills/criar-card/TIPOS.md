# Regras de tipo novo (card que cria tipos)

- **Tipo novo:** um tipo por vez, completo, antes do próximo. Ordem: props → construtores (parâmetros recebidos; props preenchidas internamente, como Id, à parte, com o valor exato) → fábrica e validações.
- **Tipo de dados ou mensagem** (ex.: DTO, request): forma em prosa, não assinatura; tipo entre parênteses só se não óbvio.
- **Dados sem comportamento** (request, response, VO simples): o passo já cita a construção imutável/sem estado que a linguagem oferece, conforme as convenções do projeto.
- **Tipo com filhos** (ex.: agregado): copiar 1 par pai/filho equivalente já existente no repo e seguir a prática do projeto.
