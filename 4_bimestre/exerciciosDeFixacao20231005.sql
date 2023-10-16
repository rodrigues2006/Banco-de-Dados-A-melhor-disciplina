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
