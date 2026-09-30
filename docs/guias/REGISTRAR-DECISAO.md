# Registrar decisão: guia para Devs

A skill `registrar-decisao` guarda decisões que ainda não viraram trabalho: uma escolha em aberto ou uma sugestão distante. A versão que o Claude lê é [../../skills/registrar-decisao/SKILL.md](../../skills/registrar-decisao/SKILL.md), telegráfica de propósito. As duas dizem a mesma coisa.

## Decisão ou card?
- **Card:** trabalho pronto para executar, com checklist.
- **Decisão:** ainda não dá para executar. Pode ser uma escolha entre A e B da qual outra tarefa depende, ou uma sugestão distante que talvez nunca aconteça.

## Como pedir
- "Registra a decisão: fila com RabbitMQ ou Outbox no banco."
- "Registra como decisão adiada: login com Google."
- "Decidimos Outbox, porque já usamos o banco." (registra a escolha)

Quando o Claude notar uma escolha pendente ou uma sugestão distante durante o trabalho, ele oferece registrar e só cria se você aceitar.

## O que sai
Um arquivo `docs/backlog/decisoes/<nome>.md`, com nome em português e sem número, mais uma linha no índice `docs/backlog/decisoes/decisoes.md`. Usa o [template](../../skills/registrar-decisao/TEMPLATE-DECISAO.md): contexto, opções com prós e contras, o que depende da escolha e a decisão (vazia até você decidir).

## Status
| Status | Significa |
|:---:|---|
| `aberta` | Há uma escolha a fazer. |
| `decidida` | Escolhida. O motivo fica registrado na própria decisão. |
| `adiada` | Fica para depois. O contexto diz a condição que a reabriria. |
| `descartada` | Não vai acontecer. O motivo fica registrado. |

## Ligação com os cards
Só o card aponta para a decisão: ele a cita em Deps (`decisoes/<nome>`) e fica `bloqueado` enquanto ela estiver `aberta` ou `adiada`. A decisão nunca cita card. Quando você decide, o Claude avisa quais cards estavam bloqueados, mas não muda o status deles sem você pedir.

Para os módulos que a decisão toca, o índice do módulo no backlog ganha um link para ela, numa seção `Decisões`, e o grafo do Obsidian passa a ligar os dois. O link sai do índice do módulo, e a decisão continua sem citar nada.

As decisões também levam tags (`modulo/`, `fluxo/`), então aparecem na busca por assunto. Veja [TAGS.md](TAGS.md).

## Regras
- Só fatos: opção não confirmada vira pergunta para você, nunca invenção.
- Não altera código e não faz commit.
- Prévia: para ver a mudança numa decisão existente antes de aplicar, peça a prévia (`+` e `-`).
