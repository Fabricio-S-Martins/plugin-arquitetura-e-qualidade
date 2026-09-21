# Documentar: guia para Devs

A skill `documentar` cria e atualiza a documentação do projeto a partir do código. A versão que o Claude lê é [../../skills/documentar/SKILL.md](../../skills/documentar/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Um documento por vez
Em qualquer situação, cada rodada produz **um** documento. Ao terminar, ela diz só o nome e o caminho do que criou e qual é o próximo, e para. Você diz "próximo" para continuar.

## Como pedir
- **Depois de criar código novo:** "documenta o que foi feito". Ela usa os arquivos alterados na sessão.
- **Sistema que já existe:** só quando você pede, e por escopo: "documenta o fluxo de pedidos". Ela nunca varre o projeto inteiro. Se o escopo não estiver claro, pergunta.
- **Depois de alterar código que já tem documentação:** ela atualiza o que ficou desatualizado, na mesma tarefa. Como os documentos não citam arquivos de código, ela acha o documento afetado pelos nomes (módulo, rota, etapa, mensagem de erro, configuração). Se não achar nenhum, pergunta a você em vez de concluir que não existe. Refatoração que não muda nada observável não gera edição.
- **Plano:** "monta o plano de documentação do módulo Vendas".
- **Um item do plano:** "faz o item 3".

## O que sai
Documentação para quem usa o sistema: o **negócio** e o **dev que integra** a API. Linguagem de negócio, sem links nem caminhos para o código e sem termos de camada (Domínio, Aplicação, Infraestrutura). Um arquivo por assunto, sem versão separada para a IA:

- **Visão geral** (`docs/README.md`): links para os módulos e fluxos, decisões e o que ainda não está documentado. Ela só aponta, sem repetir o conteúdo dos outros documentos.
- **Módulo** (`docs/modulos/<nome>/<nome>.md`, na pasta do módulo, junto do `<nome>-api.md`): o que o módulo é, as etapas, as regras em linguagem de negócio e links para os fluxos e para a API.
- **Integração** (`docs/modulos/<nome>/<nome>-api.md`): guia para quem consome a API. Aponta para o Swagger do projeto, que já traz o contrato exato de cada rota, e explica só o que ele não diz: a ordem das chamadas (tabela de passos, com o que foge da sequência, como cancelar, em destaque) e as respostas e erros (tabela de status). Se o projeto não tem Swagger, ela pergunta se o contrato deve ir por escrito.
- **Fluxos** (`docs/fluxos/<nome>.md`): um por fluxo, com objetivo, fluxograma e regras.
- **Decisões** (`docs/decisoes/<nome>.md`): o que foi decidido, o porquê e o que foi descartado. Só entra o que você informou; se faltar o motivo, ela pergunta.
- **Técnico por projeto** (Domínio, Aplicação...): não faz parte do padrão. Só se você pedir, em `docs/modulos/<nome>/<nome>-<projeto>.md`.

O fluxograma é escrito em Mermaid, uma sintaxe de texto que vira diagrama no GitHub, no Obsidian e no VS Code, sempre na vertical (de cima para baixo), que fica legível em qualquer largura de tela. Como é texto, o git versiona e o Claude consegue atualizar.

**Estilo dos documentos:** títulos com iniciais maiúsculas, sequências e respostas em tabela (status e passos em negrito, detalhes em itálico) e exceções à regra geral em um destaque de atenção. Os fluxos mantêm o diagrama.

Se o projeto já tem um padrão de documentação, ela segue o padrão dele.

## Código novo: o que acontece
1. Ela lê o código que mudou, identifica o fluxo e o módulo tocados e procura se já existe documento deles. Se existir, atualiza; se não, cria. Se o projeto ainda não tem no `CLAUDE.md` a regra de manter a documentação em dia, ela oferece a linha e só a adiciona se você aceitar.
2. Ela escreve **um documento por vez**, nesta ordem: módulo, fluxos, API (se houver rotas) e, por último, a visão geral, que só ganha o link do que já existe. Cada documento é conferido antes de entregar.
3. Depois do último, ela pergunta se você quer o plano de documentação do restante do módulo ou fluxo.
   - **Não:** ela para. O que ficou de fora aparece na visão geral como "não documentado".
   - **Sim:** ela monta o plano.

## O plano
Funciona como o da skill `planejar`:
1. Ela levanta o que falta (só nomes, sem ler tudo) e pergunta o que o código não responde, como o que entra, o que é legado e a prioridade.
2. Ela apresenta o plano sem criar nada. Cada item é exatamente **um documento**, com o destino, o código que ele cobre e as dependências, em ordem. Termina com "Aguardando aprovação."
3. Você aprova dizendo claramente "aprovado". Se pedir ajustes, ela revisa e mostra de novo.
4. Aprovado, o plano é salvo em `docs/sessoes/plano-documentacao.md`, como uma checklist, e ela faz o **item 1**. Essa pasta fica fora do git (ela a acrescenta ao `.gitignore` se faltar), porque o plano é uma ferramenta de trabalho e não faz parte da documentação para o cliente. Você retoma em qualquer sessão, na mesma máquina. Para passar a outro dev, envie o arquivo.
5. Os demais itens saem **um por vez**, quando você diz "próximo" ou "faz o item N". Ao terminar, ela marca o item e diz qual é o próximo. Nunca faz um item que você não pediu.

## Regras
- **Só fatos:** tudo vem do código lido ou de você, mas o documento não cita arquivo. Rotas e mensagens de erro são copiadas exatas do código. O que não foi confirmado não é escrito: ela pergunta a você.
- **Só o que está no git:** ela não cita arquivos ou pastas que o git ignora (por exemplo uma pasta `runbooks/` listada no `.gitignore`), porque quem clonar o projeto não os encontraria. Ela confere isso antes de entregar.
- **Um fato, um lugar:** os demais documentos apontam por link.
- **Nomes em português**, em arquivos, pastas e títulos. Cada arquivo tem um nome único em toda a documentação, porque o Obsidian identifica a nota só pelo nome. Por isso os documentos de um módulo levam o nome do módulo na frente (`pedidos-api.md`), e o único `README.md` é o de `docs/`, a visão geral.
- **Não altera código e não faz commit.**
- **Prévia:** para ver a mudança de um documento existente antes de aplicar, peça a prévia (`+` e `-`).
