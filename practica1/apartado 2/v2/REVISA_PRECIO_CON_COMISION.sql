create or replace 
procedure revisa_precio_con_comision  IS 
-- vars de trabajo
    datos_contiene contiene%ROWTYPE;
    datos_plato platos%ROWTYPE;
    datos_restaurante restaurantes%ROWTYPE;

    calculo_precio_comision  NUMBER (8,2);
    nombre_plato_V CHAR(25);
    comision_rest_V NUMBER(8,2);
    precio_plato_V NUMBER(8,2);
    nFilas NUMBER;
    exito NUMBER;
 -- cursor para los platos que hay en contiene      
 CURSOR cursor_contiene
      is  SELECT * FROM contiene;
        
 -- cursor para los precios de los platos 
 CURSOR cursor_platos
      is  select * from platos;
      
 -- cursor para la comision que tienen los restaurantes   
  CURSOR cursor_restaurante
      is  select * from restaurantes;        
begin
  dbms_output.put_line('---- proc revisa_precio_con_comision----');
  nFilas := 0;
  OPEN cursor_contiene;
     
      LOOP
           FETCH cursor_contiene
           into datos_contiene;
           exit  when cursor_contiene%NOTFOUND;
          
          --Buscamos el plato de contiene en el cursor platos 
          OPEN cursor_platos;
     
                LOOP
                     FETCH cursor_platos
                     into datos_plato;
                     exit  when cursor_platos%NOTFOUND or (
                     datos_plato.nombrePlato = datos_contiene.plato and 
                     datos_plato.restaurante = datos_contiene.restaurante
                     ) ;
                END LOOP;
                precio_plato_V := datos_plato.precio;
                
          IF cursor_platos%ISOPEN
              THEN CLOSE  cursor_platos;
          END IF;
          
          --Buscamos la comision del restaurante en el que esta el plato
          OPEN cursor_restaurante;
          
                LOOP
                     FETCH cursor_restaurante
                     into datos_restaurante;
                     exit  when cursor_restaurante%NOTFOUND or 
                           datos_restaurante.codigo = datos_contiene.restaurante;
                     
                END LOOP;
                comision_rest_V := datos_restaurante.comision;
                
          IF cursor_restaurante%ISOPEN
              THEN CLOSE  cursor_restaurante;
          END IF;
          
          --calculamos el precio con comision del plato
          calculo_precio_comision := precio_plato_V + (comision_rest_V/100 *precio_plato_V);
          --calculo_precio_comision := calculo_precio_comision * datos_contiene.unidades;
          
         
          IF datos_contiene.precio_con_comision <> calculo_precio_comision or comision_rest_V is NULL
              THEN   nFilas := nFilas + 1;
                    -- modificamos la tabla contiene
                     update contiene
                     set precio_con_comision = calculo_precio_comision
                     where restaurante = datos_contiene.restaurante and plato = datos_contiene.plato and pedido = datos_contiene.pedido;
                    
                    --guardamos en una nueva tabla
                    exito := guardaPlato(  
                                datos_contiene.restaurante,
                                datos_contiene.plato,
                                datos_contiene.pedido   
                                );
             
              dbms_output.put_line('numero filas : ' || nFilas);
          END IF;
      END LOOP;
      
  IF cursor_contiene%ISOPEN
      THEN CLOSE  cursor_contiene;
  END IF;
  
  
 --Capturamos las excepciones       
 --EXCEPTION
 --     WHEN NO_DATA_FOUND
 --        THEN  DBMS_output.put_line( 'DNI NO EXISTENTE' ) ;
 --    WHEN pedido_inexistente 
 --       THEN  DBMS_output.put_line('El cliente con dni: ' || datos_cliente.dni || 'no tiene pedidos'); 
END revisa_precio_con_comision;