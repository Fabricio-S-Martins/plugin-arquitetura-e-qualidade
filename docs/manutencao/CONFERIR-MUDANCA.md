# Conferir mudança

Manutenção deste plugin; não vai para projeto. Ler ao propor ou editar skill, `docs/instrucoes/` ou guia.

## Ao escrever
- Busca por campo ou linha (`Especificação:`, `tags:.*tarefa/`), nunca só pelo nome do arquivo: o nome pega arquivo de outro tipo.
- Lista exaustiva leva "só"; exemplo leva "ex.:". Sem marca, lista entre parênteses é lida como exemplo.
- "Parar" sempre com o alcance: o passo, a skill ou a skill que chamou.
- Um caso = uma regra: antes de somar regra, Grep do caso na skill; achou → fundir. Ordem entre checagens → numerar.
- Palavra com dois sentidos → qualificar sempre (ex.: plano da demanda × plano de documentação). Gatilho de `description` não se repete em outra skill.
- Chamada no meio do fluxo de outra skill: a chamadora escreve ``skill `<nome>` `` e diz o que passa e onde continua; citação sem chamada fica só `` `<nome>` ``. A chamada traz, antes do fluxo, esta frase (texto idêntico; o script compara):

```
**Chamada por outra skill** (no meio do fluxo dela): fazer todo o trabalho pedido sem parar entre partes; ao terminar, não parar nem apontar a próxima skill. Pedido de aprovação ao Dev continua: esperar a resposta. Depois, voltar à skill que chamou, no passo seguinte ao da chamada.
```

## Antes de propor: testar no papel
Dizer na proposta o que foi testado.
1. Regra nova ou alterada × cada estado do alvo (tabelas de `docs/instrucoes/TAGS.md`): o que acontece em cada um. Sem resposta → pergunta ao Dev.
2. Mudança em skill que chama ou é chamada: seguir o texto das duas ao pé da letra, do pedido até a chamadora terminar.
3. Correção: aplicar em todos os estados de entrada e nos dois sentidos (link de ida e de volta; quem chama e quem é chamado). Não resolve todos → não propor.
4. Perguntas de risco (passo 5 de `skills/criar-plano/SKILL.md`) sobre a mudança, inclusive várias sessões ou agentes ao mesmo tempo.

## Ao aplicar
1. Texto, valor ou nome trocado → Grep do antigo no repo (fora de `docs/migracoes/`) e corrigir onde aparecer, guias inclusive. Skill renomeada ou removida → nome antigo na lista do script.
2. Reler a skill inteira: regra que contradiz ou repete outra.
3. Estado novo ou alterado: Grep da tag nas skills; precisa ter quem grava, quem lê e saída (estado final: "nenhum").
4. Guia com fluxograma: estados, laços com limite e ramos de saída do texto estão no diagrama, e cada nó tem passo na skill; mensagens e detalhes ficam no texto.
5. Migração (regra 13): `git show HEAD:<arquivo>` do formato antigo; mostrar no chat a tabela antigo → novo, uma linha por estado ou combinação (estado + `[x]` + dependência + linha de motivo); cada linha vira passo, linha sem passo = migração incompleta. Passo de busca filtra pela tag do tipo.
6. Rodar `bash docs/manutencao/buscar-erros.sh`; cada achado → corrigir ou dizer por que é falso positivo.
7. Simulação com agente em projeto de teste: só se o Dev pedir.
