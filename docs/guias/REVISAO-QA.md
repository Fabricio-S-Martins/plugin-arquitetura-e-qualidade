# Revisão de QA: guia para Devs

A skill `revisao-qa` revisa um card ou um código e devolve um relatório. Este guia explica o que esperar. A versão que o Claude lê é [../../skills/revisao-qa/SKILL.md](../../skills/revisao-qa/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Como pedir
Diga o alvo: "revise o card TASK-003", "revise o arquivo X" ou "revise o que mudei". Sem alvo, o Claude revisa o `git diff` atual. Por padrão a revisão é **rápida**; peça "revisão completa" para o modo profundo.

## Os dois modos
- **Rápido (padrão):** olha só o que mudou. Confere as convenções verificáveis por busca, as regras obrigatórias, segurança e se o código cumpre o card. É o mais barato em tokens.
- **Completo:** além disso, lê o arquivo inteiro (aponta problemas antigos como `(pré-existente)`), compara com um arquivo irmão, lê o `CLAUDE.md`, a `memory/` e o `.editorconfig` do projeto e aponta o que destoa do padrão.
- **Parada antecipada:** se há um problema estrutural grave, como um card fora do template, ela reporta e para, sem gastar o resto da revisão.

## O que ela confere
- **Card:** as mesmas regras usadas para criar o card (título, localização, validações, consistência, nomes, escopo).
- **Código:** as regras de [QUALIDADE.md](../instrucoes/QUALIDADE.md) e, em C#, as convenções de estilo (campo privado, `internal`, namespace em bloco, nome de teste, fim de arquivo).
- **Card × código:** se há um card associado, cada item do checklist precisa ter contrapartida no código e os cenários de teste precisam estar cobertos. Build e testes verdes não bastam para dizer que o card está pronto.
- **Segurança:** hash, token, criptografia e autorização têm prioridade máxima, porque o erro é silencioso. Sem teste dedicado, é bloqueante.
- **Testes:** aponta teste que não consegue falhar, como um que só afirma o caso "falso" ou um mock que já devolve o resultado esperado.
- **Escopo da mudança:** aponta alterações que não têm relação com o pedido.
- **Construção certa:** quando cabe, sugere `record`, `readonly struct` ou `static`.

## Como ela trabalha
- **Limite de leitura:** para não gastar tokens, lê no máximo 3 camadas: a do alvo e até 2 vizinhas diretas. Se não souber qual é a camada do alvo, pergunta. O que fica de fora aparece no relatório na linha `Escopo`, para você pedir outra passada se quiser.
- **Itens objetivos por busca:** as convenções mecânicas são verificadas com busca no código, não de cabeça, então o resultado não muda de uma revisão para outra. Se o mesmo item aparece sempre, ela sugere transformá-lo em regra automática do projeto.
- **Precisão acima de cobertura:** achado de baixa confiança é descartado. Código limpo é aprovado, sem inventar problema.

## O que sai
Uma conclusão (aprovado, com ressalvas ou reprovado), a linha `Modo` e `Escopo`, e a lista de achados:
- **Bloqueante:** quebra uma regra obrigatória ou um erro real.
- **Mecânico:** convenções verificáveis por busca. A seção sempre aparece e diz o que foi verificado sem ocorrência.
- **Recomendado:** quebra uma preferência ou convenção.
- **Sugestão:** melhoria opcional.
- **Preservar:** uma linha com o que está bom e não deve ser quebrado na próxima mudança.

Cada achado indica onde está, qual regra foi quebrada, o problema e como corrigir, em texto e sem código pronto, com o nível de confiança. Um problema encontrado é procurado em todo o escopo, e o mesmo padrão em vários arquivos vira um achado só, com a lista dos locais.

## O que ela não faz
- Não edita arquivos nem se oferece para corrigir. Você corrige, ou pede explicitamente ("corrige", "ajusta").
- Se você quiser ver como ficaria uma correção, peça a prévia: ela mostra a mudança com `+` e `-`, sem aplicar.
- Não cria itens novos fora do alvo. Cobertura que falta vira sinalização.
- Não roda build nem testes por conta própria. Só quando você pedir, usando o comando do `CLAUDE.md` do projeto.
