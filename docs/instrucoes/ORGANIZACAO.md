# ORGANIZACAO

Padrão rígido; nomes não.
- Unidade = qualquer divisão do projeto (módulo, serviço, contexto, pacote). Mesmo nível = mesma estrutura interna.
- Esqueleto = pastas de toda unidade. Sob demanda = só nasce com conteúdo; ao nascer, mesmo nome e lugar em toda unidade que precisar. Pasta exclusiva de uma unidade: só dentro de pasta do esqueleto, nunca novo nível.
- Espelho: toda unidade do código existe com o mesmo nome em docs, backlog, testes e especificações; subestrutura só onde a área já a usa. Artefato novo (especificações, contratos, cenários) nasce dentro da unidade, nunca solto. Compartilhado/transversal = unidade própria nas mesmas áreas.
- Nomes (idioma, caixa, plural): fixos após escolhidos (Glob no existente). Caixa pode variar por área se cada área for uniforme.
- Criar/alterar: ler 1 unidade equivalente como modelo → replicar nas que precisam → criar o espelho no mesmo passo. Assimetria existente: listar, não corrigir sem pedir.
