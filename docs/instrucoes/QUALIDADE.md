# QUALIDADE

Contexto: a fonte de verdade é o projeto atual (arquivos, CLAUDE.md, o que o Dev disse), nunca outro projeto, a memória ou os exemplos do plugin (ilustrativos).
Nomes que as skills citam (pasta, subpasta, arquivo, tag, título de seção; ex.: `docs/backlog`, `tarefa/concluido`, `Dependências`) são exemplo do conceito: valem os do projeto (Glob, Grep, nota irmã); sem padrão → perguntar uma vez, sugerindo o exemplo. Conceito e estrutura do plugin não mudam.
Boas práticas (KISS, YAGNI, DRY, SRP…) valem sempre: não dependem de arquitetura.
Escolha do Dev: nomenclatura (idioma, camelCase/snake_case/kebab-case…), organização, arquitetura (DDD, monólito, microsserviços…) e uso de testes. Ordem: o que o projeto já usa → o que o Dev disser → perguntar uma vez (sem padrão silencioso do plugin). Escolhido, vira o padrão: seguir rigidamente, sem misturar.
Projeto com testes → vale o arquivo de testes do projeto (ex.: `testes.md`); sem testes → não exigir nem cobrar.
Padrões do projeto: 1 arquivo por assunto (ex.: `docs/padroes/praticas.md`, `convencoes.md`, `testes.md`; modelos de tipo em `docs/padroes/modelos/`; pasta e nomes são do projeto). Item sem marca = obrigatório; `(preferível)` no fim = preferível. Formato opcional `regra — como verificar` (a verificação por busca alimenta o Mecânico). Existindo, ler e cobrar só o que está neles; ausentes → só os princípios abaixo e a consistência com o código existente.
Regra do plugin (ex: nomes em pt-br) vale para os arquivos do plugin, não para o projeto.
Escrita: o que o Dev lê ou vai para o projeto usa termos descritivos, sem abreviação nem jargão; sigla de conhecimento geral (API, CI/CD, VO, KISS) fica; sigla ou termo do plugin ou pouco conhecido → por extenso ou explicado na 1ª vez, inclusive o termo interno que aparece na saída. Instrução interna pode ser telegráfica.
Todo nome (arquivo, regra, seção, critério) diz o que é em poucas palavras.
Organização: criar ou alterar pasta, arquivo ou unidade (código, docs, backlog, testes, especificações) → ler antes `ORGANIZACAO.md` (mesma pasta).

Prioridade: KISS/YAGNI > padronização > DRY > SRP.
Violou regra obrigatória (princípio ou prática do projeto) → registrar `Exceção: <regra> — <motivo>`.

Obrigatórias: KISS, YAGNI, DRY, SRP, padronização.

KISS/método: método extraído só com reuso real ou (complexidade isolável + conceito de domínio nomeável); senão inline. Não fragmentar método longo e narrativo só para "simplificar".
YAGNI: não criar abstração (ex.: interface) sem necessidade real; nada fora do escopo do card (registrar como sugestão).
DRY: remover redundância; não unir código parecido com razões de mudança distintas.
Padronização: ler código existente antes; 1 conceito = 1 nome; não misturar refatoração com mudança de comportamento.
