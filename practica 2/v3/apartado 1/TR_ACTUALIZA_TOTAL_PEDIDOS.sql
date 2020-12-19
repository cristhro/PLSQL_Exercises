create or replace 
TRIGGER TR_ACTUALIZA_TOTAL_PEDIDOS BEFORE INSERT OR DELETE OR UPDATE
  ON contiene FOR EACH ROW
  
  DECLARE
  --datos_contiene contiene.SPRCMNT%ROWTYPE;
BEGIN
  DBMS_output.put_line('-- trigger actualiza total pedidos  ---');
  
  IF INSERTING THEN
    DBMS_output.put_line('insert');  
    UPDATE pedidos
    SET importe_total = importe_total +:new.precio_con_comision * :new.unidades
    WHERE pedidos.codigo = :new.pedido;
    
    --datos_contiene := :NEW;
   
    -- gestion de cupones
    --gestion_cupones(datos_contiene);
    
  ELSIF DELETING THEN
    DBMS_output.put_line('delete'); 
 
  ELSIF UPDATING THEN
   DBMS_output.put_line('update');
  
  END IF;
END;