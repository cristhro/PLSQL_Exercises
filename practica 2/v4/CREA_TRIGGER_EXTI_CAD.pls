create or replace Procedure CREA_TRIGGER_EXTI_CAD
   (  restaurante IN varchar2 )
AS
   plsql_block VARCHAR(2500);
   Nombre_Trigger VARCHAR (35) := RTRIM(UPPER('exti_cad_'|| restaurante));
   Nombre_Tabla VARCHAR (35) := RTRIM(UPPER('cupones_'|| restaurante));
   NumeroFilas  NUMBER DEFAULT 0;
   Fecha_Actual DATE DEFAULT SYSDATE ;
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  DBMS_output.put_line('--- Proc CREA_TRIGGER_EXTIENDE_CADUCIDAD ---' );

  -- CONTADOR DE TABLA
   FOR TRIGGER_NAME IN (  SELECT TRIGGER_NAME FROM user_triggers where TRIGGER_NAME = Nombre_Trigger )
   LOOP 
        NumeroFilas := NumeroFilas + 1;
   END LOOP;
  
  -- COMPROBAMOS SI EXISTE EL TRIGGER
  IF NumeroFilas = 0 THEN
    DBMS_output.put_line('No existe el trigger ' || Nombre_Trigger);
    DBMS_output.put_line('Creando trigger ' || Nombre_Trigger);
    
    -- BLOQUE DINAMICO
    plsql_block:= 'CREATE OR REPLACE 
                  TRIGGER ' || Nombre_Trigger ||'
                  AFTER  INSERT   ON '||  Nombre_Tabla ||  '
                  FOR EACH ROW
                  DECLARE
                    Fecha_Actual DATE DEFAULT SYSDATE ;
                  BEGIN
                    FOR FechaCaduca IN (  SELECT FechaCaduca FROM '||  Nombre_Tabla  ||' where FechaCaduca < Fecha_Actual   )
                    LOOP 
                     update ' || Nombre_Tabla || '
                     set FechaCaduca = FechaCaduca + 10;
                    END LOOP ;
                  END '|| Nombre_Trigger || ';';
    EXECUTE IMMEDIATE plsql_block;
    DBMS_output.put_line('--- Trigger ' || Nombre_Trigger || ' creado ');
  ELSE
    DBMS_output.put_line('trigger:'||Nombre_Trigger|| ' existente en la BBDD'  );
  END IF;
   
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END CREA_TRIGGER_EXTI_CAD;