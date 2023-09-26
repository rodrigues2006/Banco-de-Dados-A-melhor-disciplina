1- delimiter //
  
create procedure sp_ListarAutores ()
  
begin 
   select * from autor;
end;

//

call sp_ListarAutores ();



2- create procedure sp_LivrosPorCategoria (in NomeCategoria varchar(100))

begin

declare ID_categoria int;
select Categoria_ID into ID_categoria from categoria where NomeCategoria = nome;
select * from livro where Categoria_ID = ID_categoria;

end;
//

call sp_LivrosPorCategoria  ('Romance');
//



3- create procedure sp_ContarLivrosPorCategoria(in nomeCategoria varchar(100))

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
-- drop procedure sp_VerificarLivrosCategoria//
call sp_VerificarLivrosCategoria('Ciência')//