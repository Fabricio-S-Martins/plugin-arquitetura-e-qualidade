# Configurar projeto: guia para Devs

A skill `configurar-projeto` prepara um projeto para ter documentação no Obsidian. A versão que o Claude lê é [../../skills/configurar-projeto/SKILL.md](../../skills/configurar-projeto/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Quando usar
No início de um projeto, ou quando quiser abrir a documentação dele no Obsidian pela primeira vez. Peça algo como "configura este projeto" ou "prepara o Obsidian aqui". Ela roda sem pedir permissão.

## Ferramentas necessárias
A skill mantém uma lista de ferramentas que o projeto precisa ter instaladas. Hoje são três: o Obsidian e, só em projeto C#, o `csharp-ls` e o plugin `csharp-lsp` (juntos, deixam o Claude navegar pelo código com precisão: definições, referências e erros de tipo, em vez de só buscar texto). Quando surgir outra (por exemplo Python, se um projeto passar a precisar), ela entra como uma linha nova na lista, sem mudar o resto da skill.

## O que ela faz, em ordem
Os passos dependem um do outro, por isso a ordem é fixa:

1. **Confere cada ferramenta da lista.** Se faltar alguma, ela pergunta antes de instalar (é a única confirmação que pede; o resto roda direto). No Windows, instala pelo `winget` quando houver um comando pronto; senão, pede para você instalar manualmente pelo link oficial e espera confirmação antes de seguir.
2. **Cria a pasta `docs/`**, se não existir. Como abrir uma pasta no Obsidian só o próprio app faz, ela avisa que você precisa abrir `docs/` como cofre (**Abrir pasta como cofre**) antes de seguir.
3. **Ajusta o `.gitignore`** do projeto, garantindo duas entradas: `docs/.obsidian/` (a configuração local do cofre, que não deve ir para o git) e `docs/sessoes/` (onde ficam planos e notas de trabalho, também fora do git). Só acrescenta o que faltar.
4. **Sincroniza a configuração do cofre**, se ele já existir (você já abriu `docs/` no Obsidian ao menos uma vez):
   - Faz o Obsidian **ignorar no grafo e na busca** as mesmas pastas que o `.gitignore` já ignora dentro de `docs/`. Ela lê o `.gitignore`, e não mexe manualmente: o que você adicionar lá no futuro, ela replica na próxima vez que rodar. Ela nunca apaga um item que você configurou à mão, só acrescenta.
   - **Dá uma cor a cada tipo de nota no grafo**, pela tag `tipo/`. Os tipos são separados em dois grupos: **backlog** (backlog, módulo, task, decisão) e **documentação** (README, módulo, API, fluxo). As cores são escolhidas na hora: para cada grupo ela pergunta a cor-base, gera variações dela (uma por tipo), mostra a tabela e só aplica depois do seu ok. Só soma os grupos que faltam, no topo da lista, e nunca altera nem apaga um que você já tem; se sobrarem grupos antigos, avisa para você decidir.
   - **Desliga os Wikilinks**, para os links do cofre ficarem no mesmo formato markdown que a skill `documentar` já usa.
   - No final, avisa para você **fechar e reabrir o Obsidian**. Sem isso, o app pode sobrescrever a mudança sem querer, ao salvar qualquer outra configuração.

5. **Audita o `CLAUDE.md`** do projeto (peso e regras repetidas) sem editar. Se ele não tiver a regra de commit, ela oferece a linha "commit só quando pedido e só no repo da conversa, nunca em outro"; se não tiver a regra de status, oferece a linha que manda atualizar o `status:` do card ao iniciar, concluir ou bloquear. Só adiciona o que você aceitar.
6. **Habilita o plugin no projeto**, garantindo `enabledPlugins` em `.claude/settings.json`. A permissão das skills não vai para o projeto: ela é preferência sua, não do time, e só vale depois de você confiar na pasta. Para o Claude Code não perguntar a cada skill, coloque `Skill(arquitetura-e-qualidade:*)` em `permissions.allow` do `settings.json` global. A skill avisa disso e nunca mexe nesse arquivo.

7. **Migra as tags**, se houver notas sem a tag `tipo/`. Ela propõe as tags (e o status, nos cards) em prévia e só aplica depois da sua aprovação. Detalhes em [TAGS.md](TAGS.md).

## Rodar de novo
É seguro repetir a qualquer momento. Se a pasta e as entradas do `.gitignore` já existirem, esses passos não fazem nada. A sincronização do cofre só acrescenta o que estiver faltando.

## Regras
- Não altera código.
- Não remove nada que você configurou manualmente no Obsidian.
