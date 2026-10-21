# ÍNDICE

Índice da pasta raiz de uma área (tarefas, documentação, especificações): 1 por área, mesmo modelo nas três. Nomes de pasta, arquivo, tag e título de seção citados são exemplo: valem os do projeto (Glob/Grep no índice existente ou em área irmã; sem padrão → perguntar uma vez). Unidade = módulo, serviço, contexto etc., como em `QUALIDADE.md`.

## Modelo
```
<tags da área, conforme TAGS.md>
# <nome da pasta>

<1 frase: o que a pasta guarda>

## Módulos
- [<Unidade>](<caminho relativo>): <descrição da unidade em 1 linha>
```
- Título = só o nome da pasta, sem sufixo de projeto. Idioma e caixa do projeto.
- Lista, nunca tabela. Só a unidade e a descrição; fluxo e API só pelo link da unidade (1 fato, 1 lugar).
- Ordem alfabética pelo nome da unidade, sem acento nem caixa. Unidade nova entra na posição certa; índice fora de ordem → ordenar só ao editar para incluir.
- Descrição da unidade: mesma frase nos três índices. Fonte = nota da própria unidade (documentação, depois especificação); copiar, nunca reescrever. Sem nota → perguntar ao Dev.
- Escrita para quem abre o índice isolado: termos descritivos, sem termo do plugin.

## Exceções (únicas diferenças permitidas)
- Tarefas: lista também unidade sem regra de negócio nem fluxo (ex.: compartilhada). Exceção declarada ao Espelho de `QUALIDADE.md`, não assimetria a corrigir.
- Documentação: mantém a seção do que ainda não foi documentado (`Não documentado`), só nomes (Glob de 1 nível, sem ler).

## Atualizar
Incluir só a unidade da rodada. Inconsistência em linha existente → sinalizar, nunca corrigir sem pedido.
