create or replace PROCEDURE crea_sec_cupones(restaurante VARCHAR2)
AS
  -- VARIABLES 
  plsql_block VARCHAR(2000);
  Nombre_sec_Cupones VARCHAR (30) := RTRIM(UPPER('sec_'|| restaurante));
  NumeroFilas  NUMBER DEFAULT 0;

BEGIN
   DBMS_output.put_line('--- Proc crea_sec_cupones ---' );
  
  -- CONTADOR DE TABLA
   FOR TABLE_NAME IN (  SELECT object_name FROM user_objects where object_name = Nombre_sec_Cupones )
    LOOP
        NumeroFilas := NumeroFilas + 1;
    END LOOP;
    
     -- COMPROBAMOS SI EXISTE LA TABLA
  IF NumeroFilas = 0 THEN
    DBMS_output.put_line('No existe la tabla ' || Nombre_sec_Cupones);
    DBMS_output.put_line('Creando secuencia ' || Nombre_sec_Cupones);
     
     -- BLOQUE DINAMICO
      plsql_block :=  'CREATE SEQUENCE ' || Nombre_sec_Cupones ||
                      ' INCREMENT BY 1 START WITH 1 NOMAXVALUE ';
    EXECUTE IMMEDIATE plsql_block;
    DBMS_output.put_line('--- Secuencia ' || Nombre_sec_Cupones || ' creada ');
  
  ELSE
      DBMS_output.put_line('Secuencia con nombre:'||Nombre_sec_Cupones|| ' existente en la BBDD'  );
      
  END IF;

 

END crea_sec_cupones;