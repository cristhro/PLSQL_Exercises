create or replace Procedure CREA_TRIGGER_BOR_CAD
   (  restaurante IN varchar2 )

AS
   plsql_block VARCHAR(2000);
   Nombre_Trigger_Caducados VARCHAR (30) := RTRIM(UPPER('bor_cad_'|| restaurante));
   Nombre_Tabla_Cupones VARCHAR (30) := RTRIM(UPPER('cupones_'|| restaurante));
   NumeroFilas  NUMBER DEFAULT 0;
   Fecha_Actual DATE DEFAULT SYSDATE ;
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  DBMS_output.put_line('--- Proc CREA_TRIGGER_BOR_CAD ---' );

  -- CONTADOR DE TABLA
   FOR TRIGGER_NAME IN (  SELECT TRIGGER_NAME FROM user_triggers where TRIGGER_NAME = Nombre_Trigger_Caducados )
   LOOP 
        NumeroFilas := NumeroFilas + 1;
   END LOOP;
  
  -- COMPROBAMOS SI EXISTE EL TRIGGER
  IF NumeroFilas = 0 THEN
    DBMS_output.put_line('No existe el trigger ' || Nombre_Trigger_Caducados);
    DBMS_output.put_line('Creando trigger ' || Nombre_Trigger_Caducados);
    
    -- BLOQUE DINAMICO
    plsql_block:= 'CREATE OR REPLACE 
                  TRIGGER ' || Nombre_Trigger_Caducados ||' 
                  AFTER  INSERT   ON '  || Nombre_Tabla_Cupones || ' 
                  FOR EACH ROW
                  DECLARE
                    Fecha_Actual DATE DEFAULT SYSDATE ;
                  BEGIN
                    DELETE FROM  '  || Nombre_Tabla_Cupones || ' 
                    WHERE FECHACADUCA < Fecha_Actual OR FECHACADUCA = Fecha_Actual;
                  END '|| Nombre_Trigger_Caducados || ';';
    EXECUTE IMMEDIATE plsql_block;
    DBMS_output.put_line('--- Trigger ' || Nombre_Trigger_Caducados || ' creado ');
  ELSE
    DBMS_output.put_line('trigger:'||Nombre_Trigger_Caducados|| ' existente en la BBDD'  );
  END IF;
   
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END CREA_TRIGGER_BOR_CAD;