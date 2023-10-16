----1----------
delimiter //

create procedure total_livros_por_genero( p_nome_Genero varchar(255), out p_qnt_livro_por_genero int)
begin
	DECLARE done_loop int default 0;
    DECLARE id_livro_genero int;
	
    
    DECLARE cursor_livros CURSOR FOR select genero.id 
    from genero 
    inner join livro on livro.id_genero = genero.id 
    where nome_genero = p_nome_Genero;
    declare continue handler for not found set done_loop = 1;
    
    set p_qnt_livro_por_genero = 0;
	open cursor_livros;
    
    while(done_loop != 1) do
		fetch cursor_livros into id_livro_genero;
		set p_qnt_livro_por_genero = p_qnt_livro_por_genero + 1;
        if done_loop != 0 then
			set p_qnt_livro_por_genero = p_qnt_livro_por_genero - 1;
        end if;
    end while;
    
    close cursor_livros;
end;
//

delimiter ;
call total_livros_por_genero('Biografia',@valor_livro);
select @valor_livro;

----2-------

delimiter //

create procedure listar_livros_por_autor( p_primeiro_nome varchar(255),p_segundo_nome varchar(255))
begin
	DECLARE done_loop int default 0;
    declare v_id_autor int;
    declare v_id_autor_cursor int;
    declare v_id_livro int;
    declare titulo_livro varchar(255);
    
    
    DECLARE cursor_livros_autor CURSOR FOR select id_autor, id_livro from livro_autor;
    declare continue handler for not found set done_loop = 1;
    drop table temp_table;
    create temporary table if not exists temp_table (titulo_livro VARCHAR(255));
    select id into v_id_autor from autor where primeiro_nome = p_primeiro_nome and ultimo_nome = p_segundo_nome;
    open cursor_livros_autor;
    while(done_loop != 1) do
		fetch cursor_livros_autor into v_id_autor_cursor, v_id_livro;
		 if v_id_autor = v_id_autor_cursor then
			select titulo into titulo_livro from livro where id = v_id_livro;
			insert into temp_table values(titulo_livro);
        end if;
    end while;
    close cursor_livros_autor;
    select * from temp_table;
end;
//

delimiter ;

call listar_livros_por_autor('Maria','Fernandes');

---3----------
delimiter //
create procedure atualizar_resumos ()
begin 
	DECLARE done_loop int default 0;
    declare id_for_book_cursor int;
    declare v_resumo_for_book text;
    declare cursor_update_resumos_livros cursor for select id, resumo from livro;
    declare continue handler for not found set done_loop = 1;
    open cursor_update_resumos_livros;
    while(done_loop != 1)do
		fetch cursor_update_resumos_livros into id_for_book_cursor, v_resumo_for_book;
        update livro set resumo = CONCAT(v_resumo_for_book, " Este é um excelente livro!") where id = id_for_book_cursor;
    end while;
    close cursor_update_resumos_livros;
    select resumo from livro;
end;
//
delimiter ;
call atualizar_resumos();
