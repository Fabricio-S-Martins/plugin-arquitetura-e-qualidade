# arquitetura-e-qualidade

Plugin do Claude Code com regras de qualidade (SOLID, DRY, KISS, YAGNI, Demeter, object calisthenics, padronização) e skills para criar cards, planejar, revisar QA, documentar, encerrar sessão e otimizar tokens — gastando poucos tokens e sem perder contexto entre sessões.

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
| `planejar` | Planeja uma demanda com perguntas e fatos; só gera cards após aprovação. |
| `revisao-qa` | Revisa card ou código contra as regras de qualidade; só reporta, não corrige. |
| `documentar` | Documenta código novo e mantém a documentação em dia quando o código muda. |
| `encerrar-sessao` | Fecha uma sessão sem perder contexto; gera documento de retomada e prompt curto. |
| `conferir-saida` | Confere se a saída de um teste de skill cumpre o que a skill pede. |
| `otimizar-tokens` | Enxuga arquivos `.md` e configs para gastar menos tokens. |
| `previa-diff` | Mostra prévia de uma alteração (`+`/`-`) sem editar o arquivo. |
| `configurar-projeto` | Prepara um projeto novo: cria `docs/`, ajusta `.gitignore`, sincroniza o Obsidian. |

Cada skill tem sua versão telegráfica (lida pela IA) em `skills/<nome>/SKILL.md`, e, quando o assunto exige, um guia amigável em `docs/guias/`.

## Regras de qualidade

`docs/instrucoes/QUALIDADE.md` traz os princípios, limites e exceções que as skills seguem ao gerar cards, projetos e código.
