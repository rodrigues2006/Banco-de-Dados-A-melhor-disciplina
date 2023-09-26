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
