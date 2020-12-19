CREATE OR REPLACE Procedure GESTION_CUPONES
AS
NombreRestaurante VARCHAR2(20);
BEGIN
  DBMS_output.put_line('--- Proc GESTION_CUPONES ---' );
  
  crea_tabla_cupones(NombreRestaurante); 
  crea_sec_cupones(NombreRestaurante);
  crea_trigger_borra_canducados(NombreRestaurante);
  crea_trigger_extiende(NombreRestaurante);
  
END GESTION_CUPONES;
