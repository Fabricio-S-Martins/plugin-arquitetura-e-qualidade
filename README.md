# arquitetura-e-qualidade

Plugin do Claude Code para qualidade de arquitetura em todo o ciclo do projeto: especificar, planejar, implementar, testar, documentar e organizar. Impõe o método (KISS, YAGNI, DRY, SRP e padronização) e deixa práticas, convenções e nomes a cada projeto. Inclui utilitários para gerir o contexto e reduzir tokens.

## Instalar em outro projeto

1. Abra o Claude Code dentro do projeto onde quer usar o plugin.
2. No chat, digite `/plugins`.
3. Na aba **Marketplaces**, adicione:
   ```
   https://github.com/Fabricio-S-Martins/plugin-arquitetura-e-qualidade
   ```
4. Na aba **Plugins**, instale `arquitetura-e-qualidade`.
5. Escolha o escopo: **projeto** (compartilhado com o time, se você commitar `.claude/settings.json`) ou **local** (só na sua máquina).
6. Confirme com `/plugin list`, ou digite `/help` e veja se as skills aparecem, como `/arquitetura-e-qualidade:criar-card`.

Se o `/plugins` não existir no seu ambiente (extensão VSCode antiga ou variação), use o terminal com o CLI `claude` instalado à parte:
```
claude plugin marketplace add Fabricio-S-Martins/plugin-arquitetura-e-qualidade
claude plugin install arquitetura-e-qualidade@arquitetura-e-qualidade
```

**Atualizar depois de uma mudança no plugin:** na aba **Marketplaces** do `/plugins`, clique em atualizar (ou `claude plugin marketplace update arquitetura-e-qualidade` no CLI).

## O que tem

| Skill | O que faz |
|---|---|
| `criar-card` | Cria card de tarefa em `.md` a partir do template. |
| `executar-tarefa` | Executa um card (ou parte do checklist) conferindo antes as dependências; troca a tag de estado e faz o build. |
| `criar-regra-telegrafica` | Resume em `docs/padroes/modelos/` o padrão de arquivos parecidos (entidades, commands...); as skills leem a regra no lugar de um arquivo irmão. |
| `especificar` | Define e registra as regras de negócio (especificação aprovada) antes de planejar; ajuste pequeno dispensa. |
| `planejar` | Planeja uma demanda com perguntas e fatos; só gera cards após aprovação. |
| `revisao-qa` | Revisa card ou código contra as regras de qualidade; só reporta, não corrige. |
| `documentar` | Documenta código novo, atualiza a documentação quando você pede e lista fluxos sem documentação. |
| `gerir-contexto` | Com o contexto grande, avalia se precisa trocar de sessão; só então gera um prompt de retomada. |
| `conferir-saida` | Confere se a saída de um teste de skill cumpre o que a skill pede. |
| `otimizar-tokens` | Enxuga arquivos `.md` e configs para gastar menos tokens. |   
| `previa-diff` | Mostra prévia de uma alteração (`+`/`-`) sem editar o arquivo. |
| `configurar-projeto` | Prepara um projeto novo: cria `docs/`, audita o `CLAUDE.md`, habilita o plugin; Obsidian e `.editorconfig` opcionais. |

Cada skill tem sua versão telegráfica (lida pela IA) em `skills/<nome>/SKILL.md`, e, quando o assunto exige, um guia amigável em `docs/guias/`.

## Regras de qualidade

`docs/instrucoes/QUALIDADE.md` traz os princípios e as exceções que as skills seguem ao gerar cards, projetos e código. `docs/instrucoes/ORGANIZACAO.md` traz a organização de pastas e o espelho entre unidades, lido só ao criar ou alterar estrutura. Práticas e convenções da linguagem ficam no projeto (por exemplo `docs/padroes/praticas.md`, `convencoes.md` e `testes.md`; nomes e pasta são seus): a `configurar-projeto` oferece criá-los vazios e as skills cobram só o que estiver neles.

## Leitura do projeto

As skills que leem o projeto leem até 3 camadas (a do alvo e até 2 vizinhas) e avisam isso no início. Para ler mais, é só pedir (por exemplo, "varredura completa"): vale só para aquela execução; na seguinte, volta às 3 camadas.
