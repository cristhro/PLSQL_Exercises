create or replace Procedure GESTION_CUPONES (
-- VARIABLES DE ENTRADA
  nombre_restaurante restaurantes.nombre%TYPE,
  dni clientes.dni%TYPE,
  cod_pedido pedidos.codigo%TYPE,
  valor_completo number
 )
AS

-- VARIABLES
suma_cupones Number(8,0); 
nombre_tabla_cupones VARCHAR (30) := RTRIM(UPPER('cupones_'|| nombre_restaurante));
trigger_borra_caducados VARCHAR2(50):= RTRIM(UPPER('bor_cad_'|| nombre_restaurante));
trigger_extiende_caducidad VARCHAR2(50):= RTRIM(UPPER('exti_cad_'|| nombre_restaurante));
plsql_block VARCHAR(2000);
  
-- COMIENZO DEL PROCEDIMIENTO
BEGIN
  
  DBMS_output.put_line('--- Proc GESTION_CUPONES ---' );


    crea_tabla_cupones(nombre_restaurante); 
    crea_sec_cupones(nombre_restaurante);
    crea_trigger_bor_cad(nombre_restaurante);
    crea_trigger_exti_cad(nombre_restaurante);
  
  -- CONTROLAMOS LA CANTIDAD DE CUPONES
    plsql_block := 'select SUM(valor)
     from ' || nombre_tabla_cupones;
    execute immediate plsql_block into suma_cupones;
    
  IF suma_cupones > valor_completo * 0.1 THEN
    EXECUTE IMMEDIATE 'ALTER TRIGGER ' || trigger_borra_caducados || ' ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER ' || trigger_extiende_caducidad || ' DISABLE';
  ELSIF suma_cupones < valor_completo * 0.01 THEN
    EXECUTE IMMEDIATE 'ALTER TRIGGER ' || trigger_borra_caducados || ' DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER ' || trigger_extiende_caducidad || ' ENABLE';
  END IF;
  
  -- LLAMA A LA FUNCION PIPELINED
  -- GENERAMOS CUPONES
      FOR cupon  IN (select * from table (genera_cupones(dni,cod_pedido, valor_completo, nombre_restaurante)))
      LOOP
              DBMS_output.put_line('valor_completo: '|| valor_completo);
              DBMS_output.put_line('nombre_restaurante: '|| nombre_restaurante);
              DBMS_output.put_line('NUMCUPON: '||cupon.NUMCUPON);
              DBMS_output.put_line('DNICLIENTE:'||cupon.DNICLIENTE);
              DBMS_output.put_line('CODPEDIDO:'||cupon.CODPEDIDO);
              DBMS_output.put_line('VALOR:'||cupon.VALOR);
              DBMS_output.put_line('FECHACADUCA:'||cupon.FECHACADUCA);
              DBMS_output.put_line('-----------------------------');  
             
              EXECUTE IMMEDIATE 'INSERT INTO ' || nombre_tabla_cupones || 
              ' (NUMCUPON, DNICLIENTE, CODPEDIDO, VALOR, FECHACADUCA) VALUES 
              (' || cupon.NUMCUPON || ',' || chr(39) || cupon.DNICLIENTE || chr(39) || ',' || chr(39) || cupon.CODPEDIDO || chr(39) || ',' || chr(39) ||cupon.VALOR || chr(39) ||',' || chr(39) || cupon.FECHACADUCA|| chr(39) || ')';
      END LOOP;
END GESTION_CUPONES;