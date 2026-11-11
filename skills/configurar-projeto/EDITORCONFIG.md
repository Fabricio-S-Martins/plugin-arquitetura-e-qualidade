# .editorconfig (opcional)

Lido por `configurar-projeto` quando o Dev aceita. Já existe `.editorconfig` na raiz → não tocar. Ausente → detectar e criar só com o estilo que o código do projeto já segue (indentação, espaços finais, quebra de linha antes de chaves ou blocos, ordem de importações, nomenclatura de campos): Grep do padrão em cada ponto, vale a maioria; nomenclatura só se o código já a segue. Nunca fixar `charset` nem `end_of_line`.
Chaves de estilo são da linguagem do projeto. Exemplo do formato (C#; outras linguagens usam as próprias chaves):
```ini
root = true

[*]
indent_style = space
indent_size = 4
trim_trailing_whitespace = true
insert_final_newline = false

[*.cs]
csharp_style_namespace_declarations = <maioria>:warning
csharp_new_line_before_open_brace = all
csharp_new_line_before_else = true
csharp_new_line_before_catch = true
csharp_new_line_before_finally = true
csharp_new_line_before_members_in_object_initializers = true
csharp_new_line_before_members_in_anonymous_types = true
dotnet_sort_system_directives_first = true
# + campo privado _camelCase (severity = warning), se detectado

[**/Migrations/**.cs]
generated_code = true

[*.{csproj,slnx,json,yml,yaml}]
indent_size = 2
```
No exemplo, `<maioria>` = `file_scoped` ou `block_scoped`, pelo Grep de `^namespace .*;` (file-scoped) contra `^namespace [^;]*$` (bloco).
Se o estilo só aparece no build quando a ferramenta o exige (no exemplo C#: `EnforceCodeStyleInBuild` em `Directory.Build.props`), avisar e perguntar se cria a configuração (se ausente). Antes de subir severidade: rodar o build do projeto com a opção ligada e listar o que o `.editorconfig` acusa no código existente, sem corrigir.
