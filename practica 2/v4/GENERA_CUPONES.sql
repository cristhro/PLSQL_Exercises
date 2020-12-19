create or replace 
FUNCTION genera_cupones (datos_cupon TCUPON ,Valor_Completo number, restaurante VARCHAR2) 
RETURN  TCUPONSET PIPELINED IS

  -- VARIABLES
  valor_asignado NUMBER (4);
  cupon TCUPON;
  n NUMBER(4);
  plsql_block VARCHAR(2000);
  sec_Cupon VARCHAR (20) := RTRIM(UPPER('sec_'|| restaurante));

BEGIN
  DBMS_output.put_line('--- Proc GENERA CUPONES ---' );
  
  -- GENERA CUPONES DE 1 EURO
      n := Valor_Completo/5;
      valor_asignado:=1;
      
      FOR i IN 1 .. n 
      LOOP
        --plsql_block := 'datos_cupon.NUMCUPON' ||  ':= ' || secuencia_Cupon || '.NEXTVAL ';
        --EXECUTE IMMEDIATE plsql_block;
              
        PIPE ROW(TCUPON(datos_cupon.NUMCUPON,datos_cupon.DNICLIENTE,datos_cupon.CODPEDIDO,valor_asignado,datos_cupon.FECHACADUCA));   
      END LOOP;
      
  -- GENERA CUPONES DE 2 EUROS 
      n := Valor_Completo/25;
      valor_asignado:=2;
      
      FOR i IN 1 .. n 
      LOOP
  
        plsql_block :=
       'PIPE ROW(TCUPON('||sec_Cupon||'.NEXTVAL,datos_cupon.DNICLIENTE,datos_cupon.CODPEDIDO,valor_asignado,datos_cupon.FECHACADUCA))';   
       EXECUTE IMMEDIATE plsql_block;
      END LOOP;
      
      RETURN ;
END genera_cupones;