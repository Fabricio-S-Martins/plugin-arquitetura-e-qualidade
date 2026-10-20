# QUALIDADE

Contexto: a fonte de verdade é o projeto atual (arquivos, CLAUDE.md, o que o Dev disse), nunca outro projeto, a memória ou os exemplos do plugin (ilustrativos).
Boas práticas (KISS, YAGNI, DRY, SRP, limites…) valem sempre: não dependem de arquitetura.
Escolha do Dev: nomenclatura (idioma, camelCase/snake_case/kebab-case…), organização, arquitetura (DDD, monólito, microsserviços…) e uso de testes. Ordem: o que o projeto já usa → o que o Dev disser → perguntar uma vez (sem padrão silencioso do plugin). Escolhido, vira o padrão: seguir rigidamente, sem misturar.
Regra que cita camada (ex: DIP) vale na forma que o projeto der à camada. Projeto com testes → regras de teste valem; sem testes → não exigir nem cobrar.
Regra do plugin (ex: nomes em pt-br) vale para os arquivos do plugin, não para o projeto.

Prioridade: KISS/YAGNI > padronização > DRY > SOLID > calisthenics.
Violou OBR → registrar `Exceção: <regra> — <motivo>`.

OBR: KISS, YAGNI, DRY, SRP, LSP, DIP, Demeter, padronização, 1 indentação/método, sem else.
PREF: OCP, ISP, demais calisthenics.

Limites: classe ≤150 linhas, método ≤15, ≤5 atributos.
KISS/método: privado só com reuso real ou (complexidade isolável + conceito de domínio nomeável); senão inline. Projeto com testes: merece teste direto → classe pública, nunca privado nem reflection. Não fragmentar método longo e narrativo só para "simplificar".
YAGNI: interface só com 2+ implementações ou fronteira de infraestrutura; nada fora do escopo do card (registrar como sugestão).
DRY: extrair na 3ª duplicação; não unir código parecido com razões de mudança distintas.
DIP: depender de abstração, na direção que a arquitetura do projeto definir; injeção via construtor.
Calisthenics PREF: value objects p/ primitivos de domínio, coleção de 1ª classe, sem abreviações, sem getters/setters expondo estado.
Padronização: ler código existente antes; 1 conceito = 1 nome; não misturar refatoração com mudança de comportamento.

Organização (padrão rígido; nomes não):
- Unidade = qualquer divisão do projeto (módulo, serviço, contexto, pacote); nunca citar estilo arquitetural. Mesmo nível = mesma estrutura interna.
- Esqueleto = pastas de toda unidade. Sob demanda = só nasce com conteúdo; ao nascer, mesmo nome e lugar em toda unidade que precisar. Pasta exclusiva de uma unidade: só dentro de pasta do esqueleto, nunca novo nível.
- Espelho: toda unidade do código existe com o mesmo nome em docs, backlog, testes e specs; subestrutura só onde a área já a usa. Artefato novo (specs, contratos, cenários) nasce dentro da unidade, nunca solto. Compartilhado/transversal = unidade própria nas mesmas áreas.
- Nomes (idioma, caixa, plural): ler do existente (Glob), senão perguntar ao Dev (escolha dele); depois fixos. Caixa pode variar por área se cada área for uniforme.
- Criar/alterar: ler 1 unidade equivalente como modelo → replicar nas que precisam → criar o espelho no mesmo passo. Assimetria existente: listar, não corrigir sem pedir; nome ambíguo → perguntar.
