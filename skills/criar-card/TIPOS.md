# Regras de tipo novo (card que cria tipos)

- **Tipo novo:** um tipo por vez, completo, antes do próximo. Ordem: props → construtores (parâmetros recebidos; props preenchidas internamente, como Id, à parte, com o valor exato) → fábrica e validações.
- **DTO/Command/Query:** forma em prosa, não assinatura; tipo entre parênteses só se não óbvio.
- **Dados sem comportamento** (request, response, VO simples): o passo já cita a construção imutável/sem estado da linguagem. Se houver `.cs`, Grep `^\| Construção` em `${CLAUDE_SKILL_DIR}/../revisao-qa/CSHARP.md` (só essa linha).
- **Agregado com filhos:** copiar 1 par pai/filho equivalente já existente no repo. Pai nasce sem filhos; filho entra por método do pai, que valida e cria; coleção interna privada exposta como somente leitura.
