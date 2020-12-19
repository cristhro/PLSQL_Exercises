create or replace 
FUNCTION guardaPlato(plato contiene%ROWTYPE)
    return NUMBER 
  AS
BEGIN
  INSERT INTO trazaplatos
  VALUES plato;
  return 1;
  
  EXCEPTION
    WHEN OTHERS THEN
    return 0;
    
END;