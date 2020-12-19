-- solo para el pedido que afecte a la tabla contiene

CREATE OR REPLACE  TRIGGER TR_actualiza_total_pedidos
       after
       INSERT or DELETE or UPDATE of pedido on contine
       FOR EACH ROW
       
BEGIN

IF DELETING THEN
  DBMS_output.put_line('borrado');
ELSIF INSERTING THEN
  DBMS_output.put_line('insertado');
  -- bloque de codigo
  UPDATE PEDIDOS
  SET IMPORTE_TOTAL = :new.IMPORTE_TOTAL


ELSE 
  DBMS_output.put_line('modificado');
END IF
END ;--TR_actualiza_total_pedidos;