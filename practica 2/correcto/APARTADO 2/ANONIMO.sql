
BEGIN

   -- INSERTA UNA FILA EN LA TABLA CONTIENE
   --drop  table cupones_templo;
   INSERT INTO Contiene VALUES (2345, 'chana masala', 2, 25, 1);
   -- Primero salta el trigger ACTUALIZA_TOTAL_PEDIDOS
   -- en el trigger en el apartado ON INSERT se invoca a la funcion GESTION_CUPONES.
   -- En La funcion cupones se invoca a las funciones dinamicas con el nombre del restaurante:
        
	   	--crea_tabla_cupones(nombre_restaurante); 		
	    --crea_sec_cupones(nombre_restaurante);
	    --crea_trigger_bor_cad(nombre_restaurante);
	    --crea_trigger_exti_cad(nombre_restaurante);
	    -- Despues de eso se Habilitaran o desabilitaran
	    -- los Trigger de acuerdo a una serie de condicionescondiciones  

	    -- Finalmente se llamara a la funcion GENERA_CUPONES que devolvera en tiempo 
	    -- de ejecucion fila a fila los cupones, dichas filas se iran insertando en la Tabla cupones del restaurante.	
END;