create or replace 
FUNCTION COINCIDEN (
        importeTotal pedidos.importe_total%TYPE,
        calculoImporteTotal number
  )

RETURN NUMBER AS 
BEGIN
  
  IF importeTotal = calculoImporteTotal THEN
     return 1;
  ELSE  
    return 0;
  END IF;  
 
END COINCIDEN;