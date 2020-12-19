create or replace 
FUNCTION genera_cupones (dni VARCHAR, cod_pedido NUMBER, valor_completo number, nombre_restaurante VARCHAR2) 
RETURN  TCUPONSET PIPELINED IS

  -- VARIABLES
  cupon TCUPON := TCUPON(NULL, NULL, NULL, NULL, NULL);
  n_cupones NUMBER(4);
  plsql_block VARCHAR(2000);
  sec_Cupon VARCHAR (20) := RTRIM(UPPER('sec_'|| nombre_restaurante));
  num_cupon NUMBER(8); 
  
BEGIN
  DBMS_output.put_line('--- Proc GENERA CUPONES ---' );
  
  -- GENERA CUPONES DE 1 EURO
      n_cupones := valor_completo/5;
      plsql_block := 'select ' || sec_Cupon || '.nextval from dual';
      
      FOR i IN 1 .. n_cupones 
      LOOP
        EXECUTE IMMEDIATE plsql_block INTO num_cupon;
        cupon.NumCupon := num_cupon;
        cupon.dniCliente := dni;
        cupon.codPedido := cod_pedido;
        cupon.fechacaduca := sysdate + 10;
        cupon.valor := 1;
        PIPE ROW(cupon);
      END LOOP;
      
  -- GENERA CUPONES DE 2 EUROS 
      n_cupones := valor_completo/25;
  
      
      FOR i IN 1 .. n_cupones 
      LOOP
  
        EXECUTE IMMEDIATE plsql_block INTO num_cupon;
        cupon.NumCupon := num_cupon;
        cupon.dniCliente := dni;
        cupon.codPedido := cod_pedido;
        cupon.fechacaduca := sysdate + 10;
        cupon.valor := 2;
        PIPE ROW(cupon);
      END LOOP;
      
      RETURN ;
END genera_cupones;