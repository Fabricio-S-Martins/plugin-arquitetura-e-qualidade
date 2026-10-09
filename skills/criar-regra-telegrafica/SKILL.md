---
name: criar-regra-telegrafica
description: Cria regra telegráfica (modelo base) de um tipo de arquivo repetido no projeto, em docs/padroes/, a partir de arquivos citados ou achados por nome. Usar ao pedir regra/padrão/modelo de entidade, command, handler etc., ou para atualizar uma regra existente.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill
---

# criar-regra-telegrafica

Só cria/atualiza `docs/padroes/<tipo>.md`. Não alterar código. Um tipo por rodada. Só fato: regra vem de arquivo lido com Read (Grep só confirma estrutura); dúvida → perguntar.

## Alvo
- **Com arquivos citados:** ler até 4 (os demais só por Grep das linhas estruturais).
- **Sem arquivo:** módulo não claro → perguntar. Glob só de nomes no módulo, agrupar por pasta e sufixo; propor os grupos com ≥3 arquivos parecidos (nome, quantidade, 1 exemplo) e perguntar qual virar regra.
- **Confirmar similaridade:** Grep das linhas estruturais (declaração, base, construtores, atributos) do grupo; Read de 3 amostras. Estrutura não se repete → dizer, não criar.
- Ler vários irmãos para separar o padrão das manias de um arquivo isolado; molde = o mais limpo. Divergência de nome ou formatação → vale a maioria; avisar o Dev dos desvios, sem registrá-los.

## Existente / atualizar
Glob em `docs/padroes/`. Já há regra do tipo (ou pedido de atualizar) → Read da regra + 1 arquivo atual do tipo (o mais recente); comparar só estrutura e formatação com o esqueleto. Regra com `Modelo base`, `Origem` ou `Variações` → propor remover esses trechos na prévia. Sem diferença nem trecho a remover → "regra em dia", parar. Com diferença → `previa-diff` do ajuste, após a barreira de tokens; aplicar (Edit) só após "sim"/"aprovado" explícito (reclamação ou ajuste não é aprovação).

## Escrever
`docs/padroes/<tipo>.md` (pt-br, minúsculas, hífen, singular), sem frontmatter nem tags:
````
# <Tipo>

## Esqueleto
```<linguagem>
<esqueleto>
```
<3-5 linhas curtas: o que costuma variar>
````
- Esqueleto: C# real, formatação exata (namespace em bloco, classe, assinatura, chaves, ordem dos membros; construtor com a assinatura inteira numa linha logo abaixo dos campos, sem linha em branco acima, e linha em branco entre o construtor e o primeiro método). Sem corpo de regra de negócio.
- Tudo o que varia entre os arquivos do tipo vira placeholder curto e consistente (`<E>`/`<e>`): verbo, rota, parâmetros, status de sucesso e de erro, exceções, tipo de retorno, quantidade de catch. Nunca fixar status (204, 400, 404…) se algum arquivo do tipo retorna outro.
- Vários `catch` → um só (o presente em todos); os demais descritos no texto.
- Omitir `using`. Comentários só os da origem; nunca `///`/`//` novos.
- Texto abaixo: só o que varia (ex.: "verbo, rota e status variam"; "um catch por exceção lançada"), sem nome de arquivo real nem regra de produto ou segurança (autorização, perfis): é do plano/card.
- Mesmo bloco repetido em todos os arquivos lidos (ex.: checagem de falha do `Resultado<T>` + `throw new ArgumentException(...)`) → sinalizar ao Dev como possível método de extensão.

## Barreira de tokens
Antes de gravar: estimar (caracteres ÷ 4, dezena mais próxima) a regra e o custo de ler 2 irmãos e mostrar:
| | Tokens |
|-|-|
| 2 arquivos irmãos (soma dos lidos) | ~N |
| Regra | ~M (−X%) |
- Regra < 2 irmãos → gravar (ou, se já existir, prévia e aprovação).
- Regra ≥ 2 irmãos → avisar e deixar o Dev decidir; não bloquear nem negar a prévia.

## Entrega
Informar só o caminho e a regra gerada.
