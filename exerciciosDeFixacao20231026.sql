---1---------------------------------
create trigger after_Cliente_insert 
 after insert on Clientes
  FOR EACH row
  insert into Auditoria (mensagem, data_hora) values ('Novo Cliente', now());