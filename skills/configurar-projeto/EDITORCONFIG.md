# .editorconfig (opcional, só projeto C#)

Lido por `configurar-projeto` quando o Dev aceita. Já existe `.editorconfig` na raiz → não tocar. Ausente → detectar e criar:
- **Namespace:** Grep `^namespace .*;` (file-scoped) vs `^namespace [^;]*$` (bloco); vale a maioria.
- **Campo privado:** Grep `private (readonly )?\w+ _[a-z]`; regra de nomenclatura só se o código já a segue.
```ini
root = true

[*]
indent_style = space
indent_size = 4
trim_trailing_whitespace = true
insert_final_newline = false

[*.cs]
csharp_style_namespace_declarations = block_scoped:warning
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
`block_scoped`/`file_scoped` pela maioria; nunca fixar `charset` nem `end_of_line`.
Avisar: regras de estilo só aparecem no build com `EnforceCodeStyleInBuild` (`Directory.Build.props`); perguntar se cria esse arquivo (se ausente). Antes de subir severidade: `dotnet build -p:EnforceCodeStyleInBuild=true` e listar o que o `.editorconfig` acusa no código existente, sem corrigir.
