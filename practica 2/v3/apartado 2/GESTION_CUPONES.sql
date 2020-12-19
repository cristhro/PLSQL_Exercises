create or replace 
Procedure GESTION_CUPONES (
-- VARIABLES DE ENTRADA
  suma_actual number ,
  importe_total number,
  dni clientes.dni%TYPE,
  cod_pedido pedidos.codigo%TYPE,
  
  restaurante VARCHAR2 )
AS

-- VARIABLES
suma_total Number(8,2);
valor_completo NUMBER DEFAULT 0;

-- COMIENZO DEL PROCEDIMIENTO
BEGIN
  DBMS_output.put_line('--- Proc GESTION_CUPONES ---' );
  
  crea_tabla_cupones(restaurante); 
  crea_sec_cupones(restaurante);
  crea_trigger_borra_canducados(restaurante);
  crea_trigger_extiende(restaurante);
  
  
  
  -- CONTROLAMOS LA CANTIDAD DE CUPONES
  
     -- SI (SUMA_ACTUAL > 10% del Valor_Completo)
     IF ( suma_actual > valor_completo*0.10 ) THEN
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
    
  -- LLAMA A LA FUNCION PIPELINED
  -- GENERAMOS CUPONES
    /*  FOR cupon  IN (select * from table (genera_cupones(TCUPON(0,'02777453L',123, 100, sysdate), 15, 'prueba')))
      LOOP
              DBMS_output.put_line('bucle' );
              DBMS_output.put_line(cupon.NUMCUPON);
              DBMS_output.put_line(cupon.DNICLIENTE);
              DBMS_output.put_line(cupon.CODPEDIDO);
              DBMS_output.put_line(cupon.VALOR);
              DBMS_output.put_line(cupon.FECHACADUCA);
                 
      END LOOP;
  */
  
  
END GESTION_CUPONES;