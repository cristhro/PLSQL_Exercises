/*Queremos hacer una T con un procedimiento para actualizar solo los platos que son de categoría pizza, la
cambiamos por pizzaXX. A continuación queremos imprimir los datos de los platos cambiados. Antes de
empezar la actualización queremos bloquear solo esos platos para que otras Ts puedan leer pero no
modificarlos. Justifica tu solución.


b) Prueba el procedimiento en dos Ts concurrentes: en una está el procedimiento y dentro de él lo paramos
después de la instrucción adecuada. Y en la otra está un procedimiento que intenta leer un plato de categoría
pizza, y lo paramos también. Ejecútalos activando la T. correspondiente para comprobar si el
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