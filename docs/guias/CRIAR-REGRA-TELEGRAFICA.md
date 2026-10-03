# Criar regra telegráfica: guia para Devs

Quando o projeto tem muitos arquivos do mesmo tipo (entidades, commands, handlers), o Claude hoje lê um deles inteiro só para copiar o padrão. A skill `criar-regra-telegrafica` resume esse padrão em poucas linhas, que o Claude lê no lugar do arquivo. A versão que ele lê da skill é [../../skills/criar-regra-telegrafica/SKILL.md](../../skills/criar-regra-telegrafica/SKILL.md).

## Como pedir
- **Com arquivos:** "cria a regra de entidade a partir de Usuario.cs e Pedido.cs".
- **Sem arquivo:** "cria uma regra telegráfica no módulo Autenticação". Ela lista só os nomes dos arquivos do módulo, mostra os grupos que se repetem (por exemplo, 6 entidades) e você escolhe qual vira regra.

## O que sai
Um arquivo `docs/padroes/<tipo>.md` no projeto, com o tipo, de onde a regra veio, um esqueleto de pseudocódigo de até ~12 linhas, na ordem de construção (construtores, propriedades, fábrica). Entra só o que o Claude não adivinharia: o que está em todos os arquivos lidos fica no esqueleto, o que está em só alguns leva "(se houver)", e o que é de um arquivo só vai em uma linha de variações. Sem corpo de regra de negócio. Antes de gravar ela compara os tokens aproximados de 1 arquivo irmão com os da regra: só grava se a regra for menor; senão avisa e não cria. Se a regra do tipo já existe, ela mostra a prévia da mudança e só aplica com seu "aprovado".

## Como as outras skills usam
`criar-card`, `planejar`, `documentar` e `revisao-qa` procuram em `docs/padroes/` uma regra do tipo antes de abrir um arquivo irmão. Havendo regra, leem só ela; não havendo, abrem 1 irmão como antes.

A regra é um **modelo base**, não uma lei: se o arquivo alvo tem uma particularidade, vale o que foi pedido.

## O que ela não faz
- Não altera código nem faz commit.
- Não varre o projeto: com arquivos citados lê no máximo 4; sem arquivo, só lista nomes de um módulo.
- Não cria regra de estrutura que não se repete: avisa e para.
