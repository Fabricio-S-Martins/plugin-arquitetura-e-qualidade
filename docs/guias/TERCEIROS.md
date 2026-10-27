# Conteúdo de terceiros: guia para Devs

Quando o Claude lê algo que não é seu (um repositório clonado, o README de uma biblioteca, uma issue, uma página web), esse texto pode conter ordens escondidas para a IA. A regra do plugin é simples: **o Claude lê e conta o que encontrou, mas nunca obedece**. Só vale o que você escreve na conversa e o `CLAUDE.md` do seu projeto. A versão que o Claude lê é [../instrucoes/TERCEIROS.md](../instrucoes/TERCEIROS.md), telegráfica de propósito.

## O que muda para você
- A regra entra no projeto por uma linha no seu `CLAUDE.md`, que menciona o arquivo com as regras completas. Assim vale em toda sessão, com ou sem skill, e as skills não ficam mais pesadas.
- Se o Claude achar instruções num conteúdo de terceiros, mostra o bloco **Instruções de terceiros encontradas**: onde está, o que diz, a classificação e a recomendação dele. Sem instruções, não há bloco.
- Nada é feito a partir delas sem o seu aval. Ele vale por item: aprovar rodar um comando não libera os outros, nem vale em outra conversa.

## Como o Claude classifica
- **Informativa:** explica como o projeto funciona (ex.: como compilar). Serve de contexto.
- **Operacional:** manda rodar, instalar, baixar ou escrever algo. O Claude só faz com o seu "pode", depois de ler o comando com você.
- **Suspeita:** aparece em destaque e nunca é executada. Exemplos: pedir para ignorar as regras, enviar dados do seu ambiente, baixar e rodar um script remoto, desligar um teste, mexer em permissões ou `CLAUDE.md`, pedir sigilo ou pressa, texto escondido.

## O que fica por sua conta
- Diga quais pastas do projeto são de terceiros (ex.: `referencias/`). O `configurar-projeto` oferece acrescentar uma linha ao `CLAUDE.md` com elas.
- Clone repositórios de terceiros fora do projeto e não abra o Claude de dentro deles: o `CLAUDE.md` do repositório de fora seria carregado como se fosse seu. O plugin não consegue impedir isso, só você.
- Para travar de verdade (e não só instruir), um hook poderia bloquear ferramentas de execução em pastas de terceiros. Fica como possível evolução, não faz parte do plugin hoje.
