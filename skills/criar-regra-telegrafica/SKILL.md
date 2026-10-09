---
name: criar-regra-telegrafica
description: Cria regra telegráfica (modelo base) de um tipo de arquivo repetido no projeto, em docs/padroes/, a partir de arquivos citados ou achados por nome. Usar ao pedir regra/padrão/modelo de entidade, command, handler etc., ou para atualizar uma regra existente.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill
---

# criar-regra-telegrafica

Só cria/atualiza `docs/padroes/<tipo>.md`. Não alterar código. Um tipo por rodada. Só fato: regra, `Origem` e `Variações` vêm de arquivo lido com Read (Grep só confirma estrutura); dúvida → perguntar.

## Alvo
- **Com arquivos citados:** ler até 4 (os demais só por Grep das linhas estruturais).
- **Sem arquivo:** módulo não claro → perguntar. Glob só de nomes no módulo, agrupar por pasta e sufixo; propor os grupos com ≥3 arquivos parecidos (nome, quantidade, 1 exemplo) e perguntar qual virar regra.
- **Confirmar similaridade:** Grep das linhas estruturais (declaração, base, construtores, atributos) do grupo; Read de 3 amostras. Estrutura não se repete → dizer, não criar.

## Existente / atualizar
Glob em `docs/padroes/`. Já há regra do tipo (ou pedido de atualizar) → Read da regra + 1 arquivo atual do tipo (o apontado em `Variações`/`Origem`, senão o mais recente); comparar só estrutura e formatação com o esqueleto. Sem diferença → "regra em dia", parar. Com diferença → `previa-diff` do ajuste, após a barreira de tokens; aplicar (Edit) só após "sim"/"aprovado" explícito (reclamação ou ajuste não é aprovação).

## Escrever
`docs/padroes/<tipo>.md` (pt-br, minúsculas, hífen, singular), sem frontmatter nem tags:
````
# <Tipo>

**Modelo base:** o alvo pode ter particularidades. | **Origem:** <curta>

## Esqueleto
```<linguagem>
<esqueleto em código real>
```

## Variações
- **<Nome real>:** <só o que muda>
````
- Esqueleto = molde literal: código real copiado de arquivo existente, formatação exata (namespace, chaves, indentação; em C#, construtor com a assinatura inteira numa linha logo abaixo dos campos, sem linha em branco acima, e linha em branco entre o construtor e o primeiro método).
- Omitir `using` (deduzíveis pelos tipos); manter `namespace` e `class`, que carregam a formatação. Sem corpo de regra de negócio.
- Comentários só os da origem; nunca `///`/`//` novos. Sem `(se houver)`: o esqueleto é o caso mais comum; diferenças vão em `Variações`, 1 linha curta por variação, só o que muda (omitir a seção se não houver).
- Placeholders curtos e consistentes (`<E>`/`<e>` para a entidade). Nomes reais só em `Origem` e `Variações`.
- Forma estrutural diferente do esqueleto (ex.: `INotificationHandler` no lugar de `IRequestHandler`) → `Variações` + 1 único arquivo de referência para consulta, nunca vários irmãos.
- `Origem` curta, sem listar os arquivos-base; atualizar só se o Dev pedir. Amostra de 1 arquivo → dizer.
- Mesmo bloco repetido em todos os arquivos de origem (ex.: checagem de falha do `Resultado<T>` + `throw new ArgumentException(...)`) → sinalizar ao Dev como possível método de extensão.

## Barreira de tokens
Antes de gravar, estimar (caracteres ÷ 4, dezena mais próxima) a regra e a média dos irmãos lidos e mostrar:
| | Tokens |
|-|-|
| 1 arquivo irmão (média dos lidos) | ~N |
| Regra | ~M (−X%) |
- Regra < média → gravar (ou, se já existir, prévia e aprovação).
- Regra ≥ média → avisar e não gravar nem prévia; o tipo não compensa regra.

## Entrega
Informar só o caminho e a regra gerada.
