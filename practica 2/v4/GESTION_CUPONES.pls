create or replace Procedure GESTION_CUPONES (
-- VARIABLES DE ENTRADA
  restaurante restaurantes.nombre%TYPE,
  dni clientes.dni%TYPE,
  cod_pedido pedidos.codigo%TYPE,
  valor_completo number
 )
AS

-- VARIABLES
suma_total Number(8,2); 
PRAGMA AUTONOMOUS_TRANSACTION;
Nombre_Tabla_Cupones VARCHAR (30) := RTRIM(UPPER('cupones_'|| restaurante));
plsql_block VARCHAR(2000);
  
-- COMIENZO DEL PROCEDIMIENTO
BEGIN
  
  DBMS_output.put_line('--- Proc GESTION_CUPONES ---' );


  --crea_tabla_cupones(restaurante); 

  --crea_sec_cupones(restaurante);

  --crea_trigger_bor_cad(restaurante);

 -- crea_trigger_exti_cad(restaurante);
  
  -- CONTROLAMOS LA CANTIDAD DE CUPONES
  
     -- SI (SUMA_ACTUAL > 10% del Valor_Completo)
    /* IF ( suma_actual > valor_completo*0.10 ) THEN
          -- HABILITAMOS TRIGGER BORRA_CADUCADOS
          EXECUTE IMMEDIATE 'ALTER TRIGGER borra_caducados ENABLE';
          -- DESHABILITAR TRIGGER EXTIENDE_CADUCADAD
          EXECUTE IMMEDIATE 'ALTER TRIGGER extiende_caducidad DISABLE';
     END IF;
     
     -- SI (SUMA_ACTUAL < 1% del Importe_Total)
     IF (suma_actual < Importe_total*0.01) THEN   
          -- DESHABILITAMOS TRIGGER BORRA_CADUCADOS
          EXECUTE IMMEDIATE 'ALTER TRIGGER borra_caducados DISABLE';
          -- HABILITA TRIGGER EXTIENDE_CADUCADAD
          EXECUTE IMMEDIATE 'ALTER TRIGGER extiende_caducidad ENABLE';
    END IF;
   */
  -- LLAMA A LA FUNCION PIPELINED
  -- GENERAMOS CUPONES
      FOR cupon  IN (select * from table (genera_cupones(TCUPON(0,dni,cod_pedido, 0, sysdate), valor_completo, restaurante)))
      LOOP
              DBMS_output.put_line('valor_completo: '|| valor_completo);
              DBMS_output.put_line('restaurante: '|| restaurante);
              DBMS_output.put_line('NUMCUPON: '||cupon.NUMCUPON);
              DBMS_output.put_line('DNICLIENTE:'||cupon.DNICLIENTE);
              DBMS_output.put_line('CODPEDIDO:'||cupon.CODPEDIDO);
              DBMS_output.put_line('VALOR:'||cupon.VALOR);
              DBMS_output.put_line('FECHACADUCA:'||cupon.FECHACADUCA);
              DBMS_output.put_line('-----------------------------');  
              
             -- plsql_block := 'INSERT INTO ' || Nombre_Tabla_Cupones  ||' VALUES ' || cupon|| '';
             -- EXECUTE IMMEDIATE plsql_block;
              /*' || cupon.NUMCUPON ||' ,  
              ' || cupon.DNICLIENTE ||' , 
              ' || cupon.CODPEDIDO ||' ,  
              ' || cupon.VALOR ||' ,  
              ' || cupon.FECHACADUCA ||' 
              )' ;*/
      END LOOP;
END GESTION_CUPONES;