create or replace 
PROCEDURE crea_tabla_cupones(nombreRestaurante VARCHAR2)
AS
  -- VARIABLES 
  plsql_block VARCHAR(2000);
  Nombre_Tabla_Cupones VARCHAR (20) := RTRIM(UPPER('cupones_'|| nombreRestaurante));
  
  NumeroFilas  NUMBER DEFAULT 0;
  
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
                      '(NumCupon NUMBER(8)  not null,
                        dniCliente CHAR(9),
                        codPedido CHAR(8),
                        Valor CHAR(8),
                        FechaCaduca DATE DEFAULT SYSDATE + 10,
                        PRIMARY KEY (NumCupon))' ;
      
    EXECUTE IMMEDIATE plsql_block;
    DBMS_output.put_line('--- Tabla ' || nombreRestaurante || ' creada ');
    commit;
    
  ELSE
      DBMS_output.put_line('tabla con nombre:'||Nombre_Tabla_Cupones|| ' existente en la BBDD'  );
      
  END IF;

END crea_tabla_cupones;