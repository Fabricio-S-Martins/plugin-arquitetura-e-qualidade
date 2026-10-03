---
name: criar-regra-telegrafica
description: Cria regra telegráfica (modelo base) de um tipo de arquivo repetido no projeto, em docs/padroes/, a partir de arquivos citados ou achados por nome. Usar ao pedir regra/padrão/modelo de entidade, command, handler etc.
allowed-tools: Read, Write, Edit, Glob, Grep, Skill
---

# criar-regra-telegrafica

Só cria/atualiza `docs/padroes/<tipo>.md`. Não alterar código. Um tipo por rodada. Só fato: regra vem do código lido; dúvida → perguntar.

## Alvo
- **Com arquivos citados:** ler até 4 (os demais só por Grep das linhas estruturais).
- **Sem arquivo:** módulo não claro → perguntar. Glob só de nomes no módulo, agrupar por pasta e sufixo; propor os grupos com ≥3 arquivos parecidos (nome, quantidade, 1 exemplo) e perguntar qual virar regra.
- **Confirmar similaridade:** Grep das linhas estruturais (declaração, base, construtores, atributos) do grupo; Read de 3 amostras. Estrutura não se repete → dizer, não criar.

## Existente
Glob em `docs/padroes/`. Já há regra do tipo → `previa-diff` do ajuste; aplicar (Edit) só após aprovação.

## Escrever
`docs/padroes/<tipo>.md` (pt-br, minúsculas, hífen, singular), sem frontmatter nem tags:
````
# <Tipo>

**Modelo base:** o alvo pode ter particularidades. | **Origem:** <arquivos lidos>

## Esqueleto
```<linguagem>
<esqueleto em pseudocódigo>
```

## Variações
- **<Nome real>:** <o que difere entre os lidos>
````
- Esqueleto de até ~12 linhas, em ordem de construção (ex.: construtores → propriedades → fábrica e validações), com comentários de 2-3 palavras; sem corpo de regra de negócio.
- Omitir o que o Claude faria sem regra (visibilidade, namespace, idioma, texto de mensagem). Em todos os lidos → esqueleto; em ≥2 mas não todos → comentário `(se houver)`; em 1 só → `Variações` (1 item de 1 linha; omitir a seção se não houver).
- Nomes do negócio viram `<Nome>` no esqueleto; `Origem` e `Variações` levam os nomes reais.
- Amostra de 1 arquivo → dizer em `Origem`.

## Entrega
Informar só o caminho e a regra gerada.
