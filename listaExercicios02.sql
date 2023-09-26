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