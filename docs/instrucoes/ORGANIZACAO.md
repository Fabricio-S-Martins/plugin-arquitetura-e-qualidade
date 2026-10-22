# ORGANIZACAO

Padrão rígido; nomes não.
- Unidade = qualquer divisão do projeto (módulo, serviço, contexto, pacote). Mesmo nível = mesma estrutura interna.
- Esqueleto = pastas de toda unidade. Sob demanda = só nasce com conteúdo; ao nascer, mesmo nome e lugar em toda unidade que precisar. Pasta exclusiva de uma unidade: só dentro de pasta do esqueleto, nunca novo nível.
- Espelho: toda unidade do código existe com o mesmo nome em docs, backlog, testes e especificações; subestrutura só onde a área já a usa. Artefato novo (especificações, contratos, cenários) nasce dentro da unidade, nunca solto. Compartilhado/transversal = unidade própria nas mesmas áreas.
- Nomes (idioma, caixa, plural): fixos após escolhidos (Glob no existente). Caixa pode variar por área se cada área for uniforme.
- Criar/alterar: ler 1 unidade equivalente como modelo → replicar nas que precisam → criar o espelho no mesmo passo. Assimetria existente: listar, não corrigir sem pedir.

## Árvore do projeto
Por papel: nomes, níveis e número de áreas são do projeto (Glob no existente; sem padrão → perguntar uma vez, sugerindo o exemplo).
```
<raiz>/
├── <memória do projeto>                 ex.: CLAUDE.md
├── <código>/<unidade>/<subpastas do esqueleto>
├── <testes>/<unidade>/<mesmas subpastas do código>
└── <docs>/
    ├── <área com unidades>/             <índice da área> · <unidade>/ (<nota da unidade> · subpastas sob demanda)
    └── <área de padrões>/               <índice da área> · <grupo>/ (<índice do grupo> · itens)
```
- Área com unidades (ex.: tarefas, documentação, especificações, decisões): mesma estrutura em todas; cada unidade do código aparece nelas (espelho).
- Área de padrões: sem unidades; grupos por assunto (ex.: regras, modelos de tipo), cada grupo com índice.
- Índice: 1 por área e 1 por grupo; modelo em `INDICE.md`.
- Área fora da árvore (ex.: notas operacionais): fica como está; listar, não corrigir sem pedir. As que o `CLAUDE.md` do projeto lista como fora da árvore não entram na conferência.
