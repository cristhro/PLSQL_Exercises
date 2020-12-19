create or replace PROCEDURE crea_tabla_cupones(restaurante VARCHAR2)
AS
  -- VARIABLES 
  plsql_block VARCHAR(2000);
  Nombre_Tabla_Cupones VARCHAR (30) := RTRIM(UPPER('cupones_'|| restaurante));
  NumeroFilas  NUMBER DEFAULT 0;
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  DBMS_output.put_line('--- Proc crea_tabla_cupones ---' );
  
  -- CONTADOR DE TABLA
   FOR TABLE_NAME IN (  SELECT TABLE_NAME FROM tabs where TABLE_NAME = Nombre_Tabla_Cupones )
    LOOP
        NumeroFilas := NumeroFilas + 1;
    END LOOP;


  -- COMPROBAMOS SI EXISTE LA TABLA
  IF NumeroFilas = 0 THEN
    DBMS_output.put_line('No existe la tabla ' || Nombre_Tabla_Cupones);
    DBMS_output.put_line('Creando la tabla ' || Nombre_Tabla_Cupones);
     
     -- BLOQUE DINAMICO
      plsql_block :=  'create table ' || Nombre_Tabla_Cupones ||
                      ' of TCUPON ';
      EXECUTE IMMEDIATE plsql_block;
    DBMS_output.put_line('--- Tabla ' || restaurante || ' creada ');
   
  ELSE
      DBMS_output.put_line('tabla con nombre:'||Nombre_Tabla_Cupones|| ' existente en la BBDD'  );
      
  END IF;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END crea_tabla_cupones;