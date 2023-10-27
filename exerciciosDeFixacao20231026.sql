---1---------------------------------
create trigger after_Cliente_insert 
 after insert on Clientes
  FOR EACH row
  insert into Auditoria (mensagem, data_hora) values ('Novo Cliente', now());

----2-----------------------
 create trigger before_Cliente_delete
  before delete on Clientes
  for each row
  insert into Auditoria
  set action = 'Delete',
  nome = old.nome;

-----3------------------------
create trigger after_cliente_update
  after update on Clientes
  for each row
  insert into Auditoria
  set action = 'Update',
  old.nome = new.nome;


-------4-----------
delimiter $$

CREATE TRIGGER before_cliente_update
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
  IF NEW.nome IS NULL OR NEW.nome = '' THEN
     INSERT INTO Auditoria
    SET mensagem = 'erro';
  ELSE
    INSERT INTO Auditoria (action, mensagem, data_hora)
    VALUES ('Update', 'Nome atualizado', NOW());
  END IF;
END;
$$
 delimiter ;

 -------------------------5-----------------------
 delimiter $$
create trigger after_pedido_insert
after insert on Pedidos
for each row
begin
 UPDATE Produtos
  SET estoque = estoque - quantidade
   WHERE produto_id = NEW.produto_id;
  IF (SELECT estoque FROM Produtos WHERE produto_id = NEW.produto_id) < 5 THEN
    
INSERT INTO Auditoria (mensagem, data_hora) 
    VALUES ('Estoque baixo para o produto ' || NEW.produto_id, NOW());
  END IF;

end;
$$
 delimiter ;