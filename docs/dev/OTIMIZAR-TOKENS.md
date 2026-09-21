# Otimizar tokens: guia para Devs

A skill `otimizar-tokens` enxuga arquivos do plugin (Markdown e configuração) para o Claude gastar menos tokens ao lê-los, sem perder informação. A versão que o Claude lê é [../../skills/otimizar-tokens/SKILL.md](../../skills/otimizar-tokens/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Como pedir
Diga o arquivo ou a pasta: "otimize a skill criar-card" ou "enxugue os arquivos de docs/ia". Para ver o que ela cortaria sem alterar nada, peça "só analisa". Para ver os cortes linha a linha, peça a prévia (`+` e `-`), que também não altera o arquivo. Numa pasta, ela trata até uns 5 arquivos por vez.

## Em que ordem ela trabalha
Do que mais economiza para o que menos economiza:
1. **Auditoria:** lista os arquivos do plugin com o tamanho e classifica por tamanho vezes frequência de carga. As descrições das skills e o `CLAUDE.md` entram em toda sessão, o `SKILL.md` só quando a skill dispara e os demais só quando são lidos. Os guias de `docs/dev/` não são lidos pelo Claude, então otimizá-los não economiza tokens. Peça "auditoria" para receber só esse relatório, sem alterar nada.
2. **Estrutura:** um bloco que só se usa em certos casos vai para um arquivo à parte, lido só quando necessário (como o `CSHARP.md`, que só entra com código C#), e uma regra escrita em mais de um arquivo fica em uma fonte só. Costuma economizar mais do que cortar palavras. Ela confere que nenhum uso passe a carregar mais do que antes.
3. **Palavras:** só nos arquivos que ainda justificam, corta o que sobra no texto.

## Como ela protege o conteúdo
1. **Inventário:** antes de mexer, lista tudo o que o arquivo afirma: regras, números, limites, exceções, condições, caminhos e a ordem dos passos.
2. **Conferência:** depois de reescrever, confere item por item se tudo continua lá, com a mesma condição e o mesmo número. O que faltou é restaurado.
3. **Dúvida vira pergunta:** se não tem certeza de que algo é dispensável, ela não corta e pergunta.
4. **Referências intactas:** nomes de arquivo, âncoras e links usados por outros arquivos não mudam sem atualizar quem os usa.
5. **Gatilho da skill:** se a descrição de uma skill mudou, ela compara as palavras que a acionam antes e depois e testa algumas frases que devem e que não devem acioná-la. Um corte que tira uma palavra-chave faria a skill deixar de disparar sem ninguém perceber.
6. **Prova de equivalência (só se você pedir):** ela roda o mesmo pedido de teste antes e depois, por exemplo gerar um card de teste, e compara os resultados. É a prova real de que nada se perdeu, mas gasta tokens.

## O que ela remove e o que ela mantém
- **Remove:** introduções e fechos, explicações de conceitos que a IA já conhece, exemplos que só repetem a regra, duplicação entre arquivos, histórico sem efeito hoje e enfeites (emojis, negritos em excesso, separadores).
- **Condensa:** prosa vira lista ou frase curta, e siglas só aparecem depois de definidas.
- **Mantém sempre:** negações e condições ("nunca", "só se", "exceto"), números e limites, caminhos, namespaces, assinaturas, tipos, identificadores e ids de checklist, exemplos que desfazem ambiguidade e uma frase de "porquê" quando ela evita aplicar a regra errado.
- **Nunca acrescenta:** a versão nova não diz nada que o original não dissesse.
- **Não compacta demais:** se a versão curta ficaria ambígua, mantém a longa.

## Exemplo
Antes: "É muito importante lembrar que, ao criar um novo card, deve-se sempre verificar qual é o próximo número de ID que está livre dentro da pasta `cards/` antes de salvar o arquivo, para evitar que dois cards fiquem com o mesmo identificador."

Depois: "Antes de salvar: usar o próximo ID livre em `cards/`; nunca repetir ID."

O texto encolheu e nada foi perdido: o caminho, a ordem (antes de salvar) e a regra de não repetir continuam.

## Depende de quem lê o arquivo
- **Arquivos da IA** (`SKILL.md`, `docs/ia/`, `CLAUDE.md`): ficam telegráficos.
- **Arquivos de Dev** (`docs/dev/`): continuam amigáveis. Ela só tira repetição e enfeite.
- **Pares IA e Dev:** cada um é otimizado pelo seu público, e os dois continuam dizendo a mesma coisa.
- **Código e configuração:** inclusive blocos de código dentro de um `.md` (csharp, json, yaml), ficam intactos. Só saem comentários óbvios e espaços supérfluos, sem alterar o comportamento. No cabeçalho das skills, o nome e as palavras de gatilho da descrição são preservados.

## O que sai
Para cada arquivo, o tamanho antes e depois em linhas e bytes, com a porcentagem economizada. Depois, três listas: o que foi removido, o que foi condensado e as dúvidas (o que ela deixou de cortar por risco de perda). Ela edita direto, sem pedir permissão, e só pergunta quando tem dúvida real sobre perder informação. Se o arquivo tem alterações ainda não commitadas, ela guarda uma cópia antes de editar e informa no relatório, para você poder desfazer.

## Permissões
O cabeçalho da skill declara que ela pode ler, editar e criar arquivos e usar `wc` e `cp`, para o Claude Code não pedir aprovação a cada edição enquanto ela roda. Se mesmo assim o VS Code pedir, o modo de permissões da sua sessão ou as regras do seu `settings.json` estão prevalecendo. Nesse caso, libere `Edit` e `Write` para a pasta do plugin lá.
