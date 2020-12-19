create or replace 
PROCEDURE consultasSimultaneas
AS
BEGIN
 SET TRANSACTION READ ONLY;
 consulta_platos_res();
 consulta_horario_res();
END;

/*SET SERVEROUTPUT ON;
BEGIN
  consultasSimultaneas();
END;
*/