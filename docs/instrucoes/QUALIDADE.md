# QUALIDADE

Prioridade: KISS/YAGNI > padronização > DRY > SOLID > calisthenics.
Violou OBR → registrar `Exceção: <regra> — <motivo>`.

OBR: KISS, YAGNI, DRY, SRP, LSP, DIP, Demeter, padronização, 1 indentação/método, sem else.
PREF: OCP, ISP, demais calisthenics.

Limites: classe ≤150 linhas, método ≤15, ≤5 atributos.
KISS/método: privado só com reuso real ou (complexidade isolável + conceito de domínio nomeável); senão inline. Merece teste direto → classe pública, nunca privado nem reflection. Não fragmentar método longo e narrativo só para "simplificar".
YAGNI: interface só com 2+ implementações ou fronteira de infraestrutura; nada fora do escopo do card (registrar como sugestão).
DRY: extrair na 3ª duplicação; não unir código parecido com razões de mudança distintas.
DIP: dependências infra → aplicação → domínio; injeção via construtor.
Calisthenics PREF: value objects p/ primitivos de domínio, coleção de 1ª classe, sem abreviações, sem getters/setters expondo estado.
Padronização: ler código existente antes; 1 conceito = 1 nome; não misturar refatoração com mudança de comportamento.
