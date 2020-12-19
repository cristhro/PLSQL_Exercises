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
      /*plsql_block :=  'create or replace  table ' || Nombre_Tabla_Cupones ||
                      '(
            NumCupon NUMBER(8) PRIMARY KEY,
            dniCliente CHAR(9),
            codPedido NUMBER(8),
            valor NUMBER(8,2),
            fechacaduca DEFAULT sysdate + 10);';*/
            
  plsql_block := 'CREATE TABLE ' || Nombre_Tabla_Cupones || '(
            NumCupon NUMBER(8) PRIMARY KEY,
            dniCliente CHAR(9),
            codPedido NUMBER(8),
            valor NUMBER(8,2),
            fechacaduca DATE DEFAULT sysdate + 10)';


      EXECUTE IMMEDIATE plsql_block;
    DBMS_output.put_line('--- Tabla ' || Nombre_Tabla_Cupones || ' creada ');
   
  ELSE
      DBMS_output.put_line('tabla con nombre:'||Nombre_Tabla_Cupones|| ' existente en la BBDD'  );
      
  END IF;
  COMMIT;

END crea_tabla_cupones;