1- SELECT titulo FROM livros;

2-SELECT nome FROM autores WHERE nascimento <= '1900-01-01';

3-SELECT livros.titulo FROM livros JOIN autores ON livros.autor_id = autores.id WHERE autores.nome = 'J.K. Rowling';

4- select nome, curso from alunos inner join matriculas on alunos.id = matriculas.aluno_id where curso = 'Engenharia de Software';

5- select produto, Sum(receita) from vendas group by produto;