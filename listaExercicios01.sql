1- SELECT titulo FROM livros;

2-SELECT nome FROM autores WHERE nascimento <= '1900-01-01';

3-SELECT livros.titulo FROM livros JOIN autores ON livros.autor_id = autores.id WHERE autores.nome = 'J.K. Rowling';