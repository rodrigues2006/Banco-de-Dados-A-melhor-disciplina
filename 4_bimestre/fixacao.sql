create database joao_fixacao;
use joao_fixacao;
-- 1) Funções de String: --

-- a) -------------------------------------------------------------------------------------------------------------------
create table nomes(
	nome varchar(100)
);
insert into nomes values("Roberta"),("Roberto"),("Maria Clara"),("João");
-- b) -------------------------------------------------------------------------------------------------------------------
select upper(nome) from nomes;
-- c) -------------------------------------------------------------------------------------------------------------------
SELECT 
    LENGTH(nome)
FROM
    nomes;
-- d) -------------------------------------------------------------------------------------------------------------------
SELECT 
    CASE
        WHEN nome LIKE '%a' THEN CONCAT('Sra. ', nome)
        ELSE CONCAT('Sr. ', nome)
    END AS Sra_ou_Sr
FROM nomes;


-- 2) Funções Numéricas: ----------------------------------------------------------------------------------------------------------

-- a) -------------------------------------------------------------------------------------------------------------------

create table produtos(
	produto varchar(100),
    preco float,
    quantidade integer
);
insert into produtos values("Camisa CR7",456.656,56),("Neymar",37328583.90,90),("Messi",489396.78,15);
select * from produtos;
-- b) -------------------------------------------------------------------------------------------------------------------
select round(preco,2) from produtos;
-- c) -------------------------------------------------------------------------------------------------------------------
select abs(quantidade) from produtos;
-- d) -------------------------------------------------------------------------------------------------------------------
select round(avg(preco),2) from produtos;

-- 3) Funções de Data: -------------------------------------------------------------------------------------------------

-- a) -------------------------------------------------------------------------------------------------------------------
create table eventos(
	data_evento datetime
);
insert into eventos values("2022-03-16 23:26:55"),("2022-03-16 23:26:55"),("2022-03-16 23:26:55"),("2022-03-16 23:26:55");
select * from eventos;
-- b) -------------------------------------------------------------------------------------------------------------------
insert into eventos values(now());
-- c) -------------------------------------------------------------------------------------------------------------------
select datediff(now(),"1989-12-25");
-- d) ------------------------------------------------------------------------------------------------------------------
select dayname(data_evento) from eventos;

-- 4) Funções de Controle de Fluxo: -------------------------------------------------------------------------------------------------

-- a) -------------------------------------------------------------------------------------------------------------------
select IF(quantidade < 1,"Fora de estoque","Em estoque") from produtos;
-- b) -------------------------------------------------------------------------------------------------------------------
SELECT 
    CASE
        WHEN preco < 800 THEN "Barato"
        WHEN preco > 800 && preco < 1300 THEN "Médio" 
        ELSE  "Caro"
    END AS Classificacao
FROM produtos;
-- 5)  Função Personalizada: -------------------------------------------------------------------------------------------------

-- a) -------------------------------------------------------------------------------------------------------------------
delimiter //
create procedure TOTAL_VALOR(in preco float, in qnt_produto integer)
begin
	select round(preco * qnt_produto,2) as Valor_total;
end;
//
delimiter ;
call TOTAL_VALOR(899.99,90);
-- b) -------------------------------------------------------------------------------------------------------------------
select * from produtos;
call TOTAL_VALOR(456.656,56);
call TOTAL_VALOR(37328583.90,90);
call TOTAL_VALOR(489396.78,15);

-- 6) Funções de Agregação: -------------------------------------------------------------------------------------------------

-- a) -------------------------------------------------------------------------------------------------------------------
select count(produto) from produtos;
-- b) -------------------------------------------------------------------------------------------------------------------
select max(preco) from produtos;
-- c) -------------------------------------------------------------------------------------------------------------------
select min(preco) from produtos;
-- d) -------------------------------------------------------------------------------------------------------------------
select sum(IF(quantidade < 1,"Fora de estoque",quantidade))  from produtos;

-- 7) Funções de Agregação: ----------------------------------------------------------------------------------------------

-- a) -------------------------------------------------------------------------------------------------------------------
delimiter //
create procedure sp_fatorial(in num_user int)
begin
	declare fatorial_num_user int default num_user;
    fatorial_loop: LOOP
		set fatorial_num_user = fatorial_num_user * (num_user - 1);
        set num_user = num_user - 1;
        if num_user = 1 then select fatorial_num_user; leave fatorial_loop;
        end if;
    END LOOP fatorial_loop;
    
end;
//
delimiter ;
call sp_fatorial(5);
-- b) -------------------------------------------------------------------------------------------------------------------
delimiter //
create procedure f_exponencial(in num_1 int,in num_2 int)
begin
	select power(num_1,num_2);
end;
//
delimiter ;
call f_exponencial(3,4);
-- c) -------------------------------------------------------------------------------------------------------------------
delimiter //
create procedure palindromo(in palavra varchar(100))
begin
	select if(lower(palavra) = lower(reverse(palavra)),1,0) as isPalindromo;
end;
//
delimiter ;
call palindromo('Osso');