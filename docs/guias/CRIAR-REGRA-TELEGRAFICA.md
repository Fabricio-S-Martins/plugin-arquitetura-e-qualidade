# Criar regra telegráfica: guia para Devs

Quando o projeto tem muitos arquivos do mesmo tipo (entidades, commands, handlers), o Claude hoje lê um deles inteiro só para copiar o padrão. A skill `criar-regra-telegrafica` resume esse padrão em poucas linhas, que o Claude lê no lugar do arquivo. A versão que ele lê da skill é [../../skills/criar-regra-telegrafica/SKILL.md](../../skills/criar-regra-telegrafica/SKILL.md).

## Como pedir
- **Com arquivos:** "cria a regra de entidade a partir de Usuario.cs e Pedido.cs".
- **Sem arquivo:** "cria uma regra telegráfica no módulo Autenticação". Ela lista só os nomes dos arquivos do módulo, mostra os grupos que se repetem (por exemplo, 6 entidades) e você escolhe qual vira regra.

## O que sai
Um arquivo `docs/padroes/<tipo>.md` no projeto, com o tipo, de onde a regra veio, uma linha por regra e as variações entre os arquivos lidos. Só texto, sem código completo. Junto vem um comparativo de tokens aproximados: 1 arquivo irmão × a regra. Se a regra do tipo já existe, ela mostra a prévia da mudança e só aplica com seu "aprovado".

## Como as outras skills usam
`criar-card`, `planejar`, `documentar` e `revisao-qa` procuram em `docs/padroes/` uma regra do tipo antes de abrir um arquivo irmão. Havendo regra, leem só ela; não havendo, abrem 1 irmão como antes.

A regra é um **modelo base**, não uma lei: se o arquivo alvo tem uma particularidade, vale o que foi pedido.

## O que ela não faz
- Não altera código nem faz commit.
- Não varre o projeto: com arquivos citados lê no máximo 4; sem arquivo, só lista nomes de um módulo.
- Não cria regra de estrutura que não se repete: avisa e para.
