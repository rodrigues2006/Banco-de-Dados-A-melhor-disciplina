1- SELECT titulo FROM livros;

2-SELECT nome FROM autores WHERE nascimento <= '1900-01-01';

3-SELECT livros.titulo FROM livros JOIN autores ON livros.autor_id = autores.id WHERE autores.nome = 'J.K. Rowling';

4- select nome, curso from alunos inner join matriculas on alunos.id = matriculas.aluno_id where curso = 'Engenharia de Software';

5- select produto, Sum(receita) from vendas group by produto;

6- select nome, count(autor_id) as ContagemAutor from livros inner join autores on autores.id = livros.autor_id group by nome;

7- select curso, count(*) as qtdAlunos from matriculas group by curso;

8- select produto, avg(receita) as MédiaDeReceita from vendas  group by produto;

9- select receita, sum(receita) as ReceitaTotal from vendas where receita > '10000' group by receita;

10- select titulo, count(titulo) as contagemDeLivro from livros inner join autores on livros.id = livros.autor_id group by titulo HAVING COUNT(titulo) > 2;

11- select autores.nome, livros.titulo from autores inner join livros on autores.id = livros.autor_id;

12- select alunos.nome, matriculas.curso from alunos  right join matriculas on alunos.id = matriculas.aluno_id;

13- select autores.nome as NomeAutor, livros.titulo as TituloDoLivro from autores left join livros on autores.id = livros.autor_id;

14- select alunos.nome as NomeDoAluno, matriculas.curso as CursoOn from alunos right join matriculas on alunos.id = matriculas.aluno_id;

15- select alunos.nome as NomeAluno, matriculas.curso from alunos inner join matriculas on alunos.id = matriculas.aluno_id;

16- select autores.nome as Autor, count(livros.titulo) as QtdTitulos from autores  inner join livros on autores.id = livros.autor_id group by autores.nome order by QtdTitulos desc  limit 1;

17 - select produto, sum(receita) as MenorReceita from vendas group by produto order by MenorReceita asc limit 1;