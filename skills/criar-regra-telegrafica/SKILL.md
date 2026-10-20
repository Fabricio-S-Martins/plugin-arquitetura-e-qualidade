---
name: criar-regra-telegrafica
description: Cria regra telegráfica (modelo base) de um tipo de arquivo repetido no projeto, em docs/padroes/, a partir de arquivos citados ou achados por nome. Usar ao pedir regra/padrão/modelo de um tipo (ex: entidade, handler).
allowed-tools: Read, Write, Glob, Grep
---

# criar-regra-telegrafica

Só cria `docs/padroes/<tipo>.md`. Não alterar código. Um tipo por rodada. Só fato: regra vem de arquivo lido com Read (Grep só confirma estrutura); dúvida → perguntar.

## Alvo
- **Com arquivos citados:** ler até 4 (os demais só por Grep das linhas estruturais).
- **Sem arquivo:** módulo/pasta não claro → perguntar. Glob só de nomes na pasta, agrupar por pasta e sufixo; propor os grupos com ≥3 arquivos parecidos (nome, quantidade, 1 exemplo) e perguntar qual virar regra.
- **Confirmar similaridade:** Grep das linhas estruturais (declaração, base, construtores, atributos) do grupo; Read de 3 amostras (molde = a mais limpa). Estrutura não se repete → dizer, não criar. Divergência de nome ou formatação → vale a maioria; avisar o Dev dos desvios, sem registrá-los.

## Escrever
`docs/padroes/<tipo>.md` (idioma do projeto, minúsculas, hífen, singular), sem frontmatter nem tags. Arquivo já existe → perguntar se sobrescreve; sem "sim" explícito, parar:
````
# <Tipo>

## Esqueleto
```<linguagem>
<esqueleto>
```
<3-5 linhas curtas: o que costuma variar>
````
- Esqueleto: código real na linguagem do projeto, formatação exata do arquivo (declaração, assinatura, chaves, ordem dos membros). Ex. C#: namespace file-scoped `namespace X;`, sem chaves de namespace nem indentação extra; construtor com a assinatura inteira numa linha logo abaixo dos campos, sem linha em branco acima, e linha em branco entre o construtor e o primeiro método. Sem corpo de regra de negócio.
- O que varia entre os arquivos do tipo (verbo, rota, parâmetros, status, exceções, retorno) vira placeholder curto e consistente (`<E>`/`<e>`). Nunca fixar status (204, 400, 404…) se algum arquivo do tipo retorna outro. Vários `catch` → um só (o presente em todos).
- Omitir `using`. Comentários só os da origem; nunca `///`/`//` novos.
- Texto abaixo: só o que varia (ex.: "verbo, rota e status variam"; "um catch por exceção lançada"), sem nome de arquivo real nem regra de produto ou segurança (autorização, perfis): é do plano/card.
- Mesmo bloco repetido em todos os arquivos lidos (ex.: checagem de falha do `Resultado<T>` + `throw new ArgumentException(...)`) → sinalizar ao Dev como possível método de extensão.

## Barreira de tokens e entrega
Antes de gravar: estimar (caracteres ÷ 4, dezena mais próxima) a regra e o custo de ler 2 irmãos e mostrar:
| | Tokens |
|-|-|
| 2 arquivos irmãos (soma dos lidos) | ~N |
| Regra | ~M (−X%) |
Regra < 2 irmãos → gravar; ≥ 2 → avisar e deixar o Dev decidir, sem bloquear. Entrega: só o caminho e a regra gerada.
