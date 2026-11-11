# Revisão de QA

A skill `revisao-qa` revisa uma tarefa ou um código e devolve um relatório. Este guia explica o que esperar. A versão que o Claude lê é [../../skills/revisao-qa/SKILL.md](../../skills/revisao-qa/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Como pedir
O pedido indica o alvo: "revise a tarefa 03-aplicacao-criar-usuario", "revise o arquivo X" ou "revise o que mudei". Sem alvo, o Claude revisa o `git diff` atual. Por padrão a revisão é **rápida**; o pedido "revisão completa" aciona o modo profundo.

## Os dois modos
- **Rápido (padrão):** olha só o que mudou. Confere os itens verificáveis por busca, os princípios e itens obrigatórios, segurança e se o código cumpre a tarefa. É o mais barato em tokens.
- **Completo:** além disso, lê o arquivo inteiro (aponta problemas antigos como `(pré-existente)`), compara com a regra do tipo em `docs/padroes/modelos/` (ou, sem ela, com até 3 arquivos irmãos), lê o `CLAUDE.md`, a `memory/` e o `.editorconfig` do projeto e aponta o que destoa do padrão.
- **Parada antecipada:** se há um problema estrutural grave, como uma tarefa fora do template, ela reporta e para, sem gastar o resto da revisão.

## O que ela confere
- **Tarefa:** as mesmas regras usadas para criar a tarefa (título, localização, validações, consistência, nomes, escopo).
- **Código:** os princípios de [QUALIDADE.md](../instrucoes/QUALIDADE.md) (KISS, YAGNI, DRY, SRP e padronização) e as práticas e convenções registradas no projeto (por exemplo `docs/padroes/regras/praticas.md` e `convencoes.md`). Sem esses arquivos, ela confere só os princípios e a consistência com o código existente, e avisa que eles não existem.
- **Especificação:** se a tarefa cita uma, cada critério citado precisa ter contrapartida no código e as regras do fluxo não podem ser contrariadas.
- **Tarefa × código:** se há uma tarefa associada, cada item do checklist precisa ter contrapartida no código e os cenários de teste precisam estar cobertos. Build e testes verdes não bastam para dizer que a tarefa está pronta.
- **Segurança:** hash, token, criptografia e autorização têm prioridade máxima, porque o erro é silencioso. Sem teste dedicado, é bloqueante.
- **Testes:** aponta teste que não consegue falhar, como um que só afirma o caso "falso" ou um mock que já devolve o resultado esperado.
- **Escopo da mudança:** aponta alterações que não têm relação com o pedido.
- **Construção certa:** quando cabe, sugere a construção imutável ou sem estado que a linguagem do projeto oferece.

## Como ela trabalha
- **Limite de leitura:** para não gastar tokens, lê no máximo 3 camadas: a do alvo e até 2 vizinhas diretas. Se não souber qual é a camada do alvo, pergunta. O que fica de fora aparece no relatório na linha `Escopo`, para o Dev poder pedir outra passada. Ele avisa no início que lê só isso; o Dev pode pedir mais (vale só naquela vez).
- **Itens objetivos por busca:** as convenções mecânicas são verificadas com busca no código, não de cabeça, então o resultado não muda de uma revisão para outra. Se o mesmo item aparece sempre, ela sugere transformá-lo em regra automática do projeto.
- **Precisão acima de cobertura:** achado de baixa confiança é descartado. Código limpo é aprovado, sem inventar problema.

## O que sai
Uma conclusão (aprovado, com ressalvas ou reprovado), a linha `Modo` e `Escopo`, e a lista de achados. Seção sem achado não aparece (exceto Mecânico, que sempre aparece):
- **Bloqueante:** quebra um princípio de qualidade, um item obrigatório dos padrões do projeto (os sem marca) ou um erro real.
- **Mecânico:** convenções verificáveis por busca. Sempre aparece e diz o que foi verificado sem ocorrência.
- **Recomendado:** quebra um item marcado `(preferível)` nos padrões do projeto.
- **Sugestão:** melhoria opcional.
- **Preservar:** uma linha com o que está bom e não deve ser quebrado na próxima mudança.

Cada achado indica onde está, qual regra foi quebrada, o problema e como corrigir, em texto e sem código pronto, com o nível de confiança. Um problema encontrado é procurado em todo o escopo, e o mesmo padrão em vários arquivos vira um achado só, com a lista dos locais.

No final, um parecer curto em uma frase: se está tudo certo e, se não, qual o único ponto pendente — sem repetir a prosa técnica de cima.

## O que ela não faz
- Não edita arquivos nem se oferece para corrigir. A correção é do Dev, ou vem de pedido explícito ("corrige", "ajusta").
- Para ver como ficaria uma correção, vale pedir a prévia: ela mostra a mudança com `+` e `-`, sem aplicar.
- Não cria itens novos fora do alvo. Cobertura que falta vira sinalização.
- Não roda build nem testes por conta própria. Só quando o Dev pedir, usando o comando do `CLAUDE.md` do projeto.

## Por que é assim
- **Os princípios de base.** KISS, YAGNI, DRY e SRP (o "S" do SOLID, de Robert C. Martin) são a régua que o plugin usa; o que vai além deles (práticas e convenções) é de cada projeto.
- **Só reporta, nunca corrige.** É a separação entre quem escreve e quem revisa, como na revisão de código tradicional: o revisor que também altera deixa de ser um segundo olhar.
- **Precisão acima de cobertura.** Uma revisão cheia de achados duvidosos ensina o time a ignorá-la. Achado de baixa confiança é descartado, e código limpo é aprovado.
- **Itens mecânicos por busca.** A mesma verificação dá o mesmo resultado em toda revisão, e o que aparece sempre pode virar regra automática do projeto.
