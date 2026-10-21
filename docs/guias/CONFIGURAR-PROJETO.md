# Configurar projeto: guia para Devs

A skill `configurar-projeto` prepara um projeto para usar o plugin. A versão que o Claude lê é [../../skills/configurar-projeto/SKILL.md](../../skills/configurar-projeto/SKILL.md), telegráfica de propósito. Obsidian e `.editorconfig` são opcionais e ficam em arquivos à parte, lidos só quando você aceita: [OBSIDIAN.md](../../skills/configurar-projeto/OBSIDIAN.md) e [EDITORCONFIG.md](../../skills/configurar-projeto/EDITORCONFIG.md).

## Quando usar
No início de um projeto, ou quando quiser preparar o Obsidian ou o `.editorconfig`. Peça algo como "configura este projeto" ou "prepara o Obsidian aqui".

## O que ela faz, em ordem
1. **Confere as ferramentas de C#** (só em projeto C#): o `csharp-ls` e o plugin `csharp-lsp`, que deixam o Claude navegar pelo código com precisão (definições, referências e erros de tipo). Se faltar alguma, pergunta antes de instalar; no Windows instala pelo `dotnet`/`claude`, senão pede para você instalar pelo link oficial.
2. **Cria as pastas de documentação** (a raiz e a das especificações, onde ficam as regras de negócio), perguntando o nome de cada uma e sugerindo `docs/` e `docs/especificacoes/`; se o projeto já tem pastas com outros nomes, usa as suas. Põe a pasta de sessões (planos e notas de trabalho, sugestão `docs/sessoes/`) no `.gitignore`, se faltar.
3. **Pergunta pelos opcionais que faltam**, numa pergunta só:
   - **Obsidian** (se não houver `docs/.obsidian/`): instala o app se precisar, ignora `docs/.obsidian/` no git e, com o cofre já aberto, sincroniza a configuração: o grafo e a busca ignoram as mesmas pastas do `.gitignore` (só acrescenta, nunca apaga o que você pôs à mão) e os Wikilinks são desligados. No final avisa para fechar e reabrir o Obsidian. Abrir `docs/` como cofre só o app faz. Se o cofre já existe, ela sincroniza sem perguntar.
   - **`.editorconfig`** (projeto C# sem o arquivo): cria com a formatação do projeto, para o código gerado sair igual. Só fixa o que o código já segue (namespace file-scoped ou em bloco, campo privado `_x`) e nunca fixa `charset` nem `end_of_line`. Avisa que as regras de estilo só aparecem no build com `EnforceCodeStyleInBuild` e pergunta se cria o `Directory.Build.props`. Antes de subir severidade, faz um build com a opção ligada e lista o que o arquivo acusa, sem corrigir.
   - Se você recusar, ela segue sem insistir.
4. **Audita o `CLAUDE.md`** (peso e regras repetidas) sem editar. Se faltar a regra de commit, oferece "commit só quando pedido e só no repo da conversa, nunca em outro"; se faltar o ponteiro da skill, oferece "executar tarefa/card → usar a skill `executar-tarefa`". Só adiciona o que você aceitar.
5. **Habilita o plugin no projeto** (`enabledPlugins` em `.claude/settings.json`). A permissão das skills não vai para o projeto: é preferência sua. Para não ser perguntado a cada skill, coloque `Skill(arquitetura-e-qualidade:*)` em `permissions.allow` do `settings.json` global; a skill avisa e nunca mexe nele.
   - **Proteção do ambiente de produção:** soma em `permissions.ask` do projeto regras que fazem o Claude pedir sua aprovação antes de qualquer comando com `Production`, e acrescenta ao `CLAUDE.md` a regra de nunca usar produção nem como contorno de bloqueio sem perguntar. É `ask` e não `deny`, para você poder aprovar. Lista o que vai somar e só aplica depois do seu ok, sem duplicar o que já existe.

## Rodar de novo
É seguro repetir: o que já está feito não muda, e a sincronização do cofre só acrescenta o que faltar.

## Regras
- Não altera código.
- Não remove nada que você configurou manualmente.
