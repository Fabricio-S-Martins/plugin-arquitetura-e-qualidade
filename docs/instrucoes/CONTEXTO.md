# CONTEXTO

Contexto em 3 camadas, pela frequência de carga. Em contexto longo, o meio perde atenção: o que não pode ser perdido vai no início ou no fim do arquivo ou prompt. Nomes de arquivo e pasta são do projeto.
1. **Memória do projeto** (ex.: `CLAUDE.md`): carregada em toda sessão. Curta e constante: só o que vale sempre (comandos, ponteiros, barreiras). Conteúdo de uma unidade ou de uso raro → camada 2.
2. **Por unidade** (documentação, especificação, ADR, padrões): lida só ao tocar a unidade, achada por tag. Não duplicar na camada 1.
3. **Volátil** (card, `Retomada`): vive enquanto a tarefa vive. Concluída, sai do caminho: tag de estado, `Retomada` apagada.
