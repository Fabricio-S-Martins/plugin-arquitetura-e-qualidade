# Criar regra telegráfica: guia para Devs

Quando o projeto tem muitos arquivos do mesmo tipo (entidades, commands, handlers), o Claude hoje lê um deles inteiro só para copiar o padrão. A skill `criar-regra-telegrafica` resume esse padrão em poucas linhas, que o Claude lê no lugar do arquivo. A versão que ele lê da skill é [../../skills/criar-regra-telegrafica/SKILL.md](../../skills/criar-regra-telegrafica/SKILL.md).

## Como pedir
- **Com arquivos:** "cria a regra de entidade a partir de Usuario.cs e Pedido.cs".
- **Sem arquivo:** "cria uma regra telegráfica no módulo Autenticação". Ela lista só os nomes dos arquivos do módulo, mostra os grupos que se repetem (por exemplo, 6 entidades) e você escolhe qual vira regra.

## O que sai
Um arquivo `docs/padroes/<tipo>.md` com só duas partes: o título e um **esqueleto quase completo em C# real**, com a formatação exata, e abaixo 3 a 5 linhas curtas sobre o que costuma variar. Tudo o que muda entre os arquivos do tipo (verbo, rota, parâmetros, status de sucesso e de erro, exceções, retorno) vira placeholder; fica no código só a estrutura. Havendo vários `catch`, o esqueleto mostra um e o texto descreve os demais. O texto não cita arquivos reais nem regras de produto ou segurança (autorização, perfis), que são do plano e do card.

Para separar o padrão das manias de um arquivo isolado, ela lê vários irmãos e usa o mais limpo como molde. Se os irmãos divergirem entre si, vale a maioria e ela avisa você dos desvios, sem registrá-los. Se o mesmo bloco se repete em todos, ela avisa que pode virar método de extensão, sem mexer no código.

Antes de gravar, compara os tokens aproximados da regra com os de 2 arquivos irmãos (1 só não fixa o padrão). Menor: grava. Maior: avisa e você decide.

Se a regra do tipo já existe (ou você pede "atualiza a regra de handler"), ela compara com 1 arquivo atual: sem diferença, diz que está em dia; com diferença, mostra a prévia e só aplica com seu "aprovado". Regras antigas com `Modelo base`, `Origem` ou `Variações` têm esses trechos removidos na prévia. Não há checagem automática: você aciona quando o padrão mudar.

## Como as outras skills usam
`criar-card`, `planejar`, `documentar` e `revisao-qa` procuram em `docs/padroes/` uma regra do tipo antes de abrir um arquivo irmão. Havendo regra, leem só ela; não havendo, abrem 1 irmão como antes.

A regra é um **modelo base**, não uma lei: se o alvo não se encaixa no esqueleto (outra interface, retorno ou forma de endpoint), a `executar-tarefa` pergunta a você em vez de adaptar sozinha.

## O que ela não faz
- Não altera código nem faz commit.
- Não varre o projeto: com arquivos citados lê no máximo 4; sem arquivo, só lista nomes de um módulo.
- Não cria regra de estrutura que não se repete: avisa e para.
