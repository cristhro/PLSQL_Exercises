create or replace 
PROCEDURE trabajando_trans_2 (numero_segundos IN number)
  as
-- variables
 id_transaccion varchar(20);
 valor_actual_secuencia INT;
 valor_antiguo_secuencia INT := -1;
 
BEGIN 
  
  LOOP
   
   -- OBTENEMOS EL VALOR ACTUAL DE LA SECUENCIA
   SELECT  sec_trans_1.NEXTVAL into valor_actual_secuencia
    FROM dual ; 
   
   -- COMPROBAMOS SI SON IGUALES LAS SECUENCIAS
   IF  valor_actual_secuencia =  valor_antiguo_secuencia 
    -- SALIMOS DEL BUCLE
    THEN exit;
   ELSE -- SI NO SON IGUALES
    valor_antiguo_secuencia := valor_actual_secuencia;
    hector.dormir(5);     
   END IF;
   
  END LOOP;
  
  SELECT dbms_transaction.local_transaction_id into id_transaccion
  FROM dual ;
 
  DBMS_OUTPUT.PUT_LINE('he terminado de trabajar :' || id_transaccion || ' sec antigua:  '|| 
  valor_antiguo_secuencia || ' dec actual: ' || valor_actual_secuencia);

end trabajando_trans_2;