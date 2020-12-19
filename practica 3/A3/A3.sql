/*Queremos hacer una T con un procedimiento para actualizar solo los platos que son de categor�a pizza, la
cambiamos por pizzaXX. A continuaci�n queremos imprimir los datos de los platos cambiados. Antes de
empezar la actualizaci�n queremos bloquear solo esos platos para que otras Ts puedan leer pero no
modificarlos. Justifica tu soluci�n.


b) Prueba el procedimiento en dos Ts concurrentes: en una est� el procedimiento y dentro de �l lo paramos
despu�s de la instrucci�n adecuada. Y en la otra est� un procedimiento que intenta leer un plato de categor�a
pizza, y lo paramos tambi�n. Ejec�talos activando la T. correspondiente para comprobar si el
comportamiento es como se desea.
*/
CREATE OR REPLACE PROCEDURE 
modificarPlato
AS
  CURSOR cur_platos_pizza IS
    SELECT * 
    FROM platos
    WHERE categoria = 'pizza'
  FOR UPDATE;
  
  row_platos platos%ROWTYPE;
BEGIN
  OPEN cur_platos_pizza;
  FETCH cur_platos_pizza INTO row_platos;
  WHILE cur_platos_pizza%FOUND
  LOOP
    UPDATE platos
    SET categoria = 'pizzaXX'
    WHERE CURRENT OF cur_platos_pizza;
    
    FETCH cur_platos_pizza INTO row_platos;
  END LOOP;
  CLOSE cur_platos_pizza;
  hector.dormir(10);
  COMMIT;
END;