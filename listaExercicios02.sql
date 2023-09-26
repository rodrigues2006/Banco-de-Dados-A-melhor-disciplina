1- delimiter //
  
create procedure sp_ListarAutores ()
  
begin 
   select * from autor;
end;

//

call sp_ListarAutores ();



2- delimiter //

create procedure sp_LivrosPorCategoria (in NomeCategoria varchar(100))

begin

declare ID_categoria int;
select Categoria_ID into ID_categoria from categoria where NomeCategoria = nome;
select * from livro where Categoria_ID = ID_categoria;

end;
//

call sp_LivrosPorCategoria  ('Romance');
//



3- delimiter //

create procedure sp_ContarLivrosPorCategoria(in nomeCategoria varchar(100))

begin
	declare id_CATEGORIA int;
    select Categoria_ID into id_CATEGORIA from categoria where nomeCategoria = nome;
	select count(Categoria_ID) as QuantidadesLivros from livro where Categoria_ID = id_CATEGORIA group by Categoria_ID;
end;
//
call sp_ContarLivrosPorCategoria('Autoajuda');
//


4-  delimiter // 

create procedure sp_VerificarLivrosCategoria(in nome_categoria varchar(100))

begin
	declare id_CATEGORIA int;
    declare QNT_livros_categorias int;
    declare livro_existente varchar(100);
    
    select Categoria_ID into id_CATEGORIA from categoria where nome_categoria = nome;
    select count(Categoria_ID) into qnt_livros_categorias from livro where Categoria_ID = id_CATEGORIA group by Categoria_ID;
    if QNT_livros_categorias = 0 then 
		 set livro_existente = 'Categoria não possui livros';
    elseif QNT_livros_categorias > 0 then
		 set livro_existente = 'Categoria possui livros';
    end if;
        select livro_existente;
end;
//

call sp_VerificarLivrosCategoria('Ciência')//


5- 
delimiter //

 create procedure sp_LivrosAteAno(in ANO int)
begin
	 select Titulo, Ano_Publicacao from livro where Ano_Publicacao <= ano order by Ano_Publicacao;
end;
//
call sp_LivrosAteAno(1999)//


6- delimiter //

create procedure sp_TitulosPorCategoria(in nomeCategoria varchar(100))
begin
	declare id_CATEGORIA int;
    select Categoria_ID into id_CATEGORIA from categoria where nomeCategoria = nome;
	select Titulo from livro where Categoria_ID = id_CATEGORIA;
end;
//
call sp_TitulosPorCategoria('Romance')//


7- delimiter //

create procedure sp_AdicionarLivro(in nome_livro varchar(100),in editora_id int, in ano_publicacao int,in n_paginas int , in categoria_id int)
begin
	declare id_livro int default 1;
    declare Livro_nao_repetido boolean default true;
    declare Titulo_livro varchar(255);
    declare qnt_livros int;
    declare msg_erro varchar(200);
    select count(*) into qnt_livros from livro;
    
    
	while Livro_nao_repetido and id_livro <= qnt_livros   DO 
		select Titulo into Titulo_livro from livro where Livro_ID = id_livro;
        if nome_livro = Titulo_livro or editora_id > 2  then
			set Livro_nao_repetido = false;
            set msg_erro = "Titulo do livro repetido ou ID da editora inserido errado";
            select msg_erro;
		else
			set id_livro = id_livro + 1;
		end if;
			
	end while;
    if Livro_nao_repetido then 
		insert into livro values(qnt_livros + 1 ,nome_livro, editora_id ,  ano_publicacao , n_paginas  ,  categoria_id ) ;
    end if;
    
		
end;
//

call sp_AdicionarLivro('Maquiavel', 2,2023,456,2)//


8- delimiter //

create procedure sp_AutorMaisAntigo()

begin
	select Nome, Sobrenome from autor 
    order by Data_Nascimento 
    limit 1;
end;
//

call sp_AutorMaisAntigo()//


9-delimiter //

create procedure sp_ContarLivrosPorCategoria(in nomeCategoria varchar(100))
begin
	declare id_CATEGORIA int; 
    select Categoria_ID into id_CATEGORIA from categoria where nomeCategoria = nome; 
	select count(Categoria_ID) as QuantidadesLivros from livro where Categoria_ID = id_CATEGORIA group by Categoria_ID;
    
end;
//

Call sp_ContarLivrosPorCategoria('Ciência')//