# Convenções C#

Verificar nos `.cs` do escopo (modo completo: arquivo inteiro), contra os irmãos do projeto. Pular um item só se analyzer/`.editorconfig` ativo o cobre.

| Item | Regra | Verificação (Grep) |
|---|---|---|
| Campo privado | `private readonly Tipo _camelCase`; `readonly` quando não muda após o construtor | `private\s+(readonly\s+)?[\w<>\[\]?]+\s+[A-Za-z]\w*\s*[;=]` (campo sem `_`); `readonly` conferir no Read |
| Visibilidade | classe de implementação só usada no próprio assembly (DI do mesmo projeto) → `internal`, salvo motivo real | `^\s*public\s+(sealed\s+)?class` e conferir no Read quem a usa |
| Namespace | em bloco (`namespace X { ... }`), nunca file-scoped; exceção: código gerado (Migrations) | `^namespace\s+[\w.]+;` |
| Teste xUnit | `Metodo_ComCenario_DeveResultado`; o segmento do meio começa com `Com` | `\[(Fact\|Theory)\]` com `-A 2`, conferir o nome |
| Fim de arquivo | termina direto na última `}`, sem linha em branco | ler o fim do arquivo |
| Nomes | 100% pt-br (arquivo, classe, pasta, projeto); exceção: tipo imposto por biblioteca/framework | julgamento; checar cada palavra |
