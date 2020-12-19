create or replace 
procedure revisa_pedidos  IS 
-- vars de trabajo
    datos_contiene contiene%ROWTYPE;
    datos_pedido pedidos%ROWTYPE;
    nFilas NUMBER DEFAULT 0;
    calculoImporteTotal NUMBER(8,2) DEFAULT 0;
    precioXunidad NUMBER ;
    
 -- cursor para los platos que hay en contiene      
 CURSOR cursor_contiene is  SELECT * FROM contiene  FOR UPDATE;
        
 -- cursor para los precios de los platos 
 CURSOR cursor_pedidos  is  SELECT * FROM pedidos  FOR UPDATE;
       
BEGIN
  dbms_output.put_line('---- proc revisa_pedido----');
  -- Recorremos todos los pedidos 
  OPEN cursor_pedidos;
      LOOP
           FETCH cursor_pedidos
           into datos_pedido;
           exit  when cursor_pedidos%NOTFOUND;
           
           calculoImporteTotal :=0;
           
           -- calculamos Importe total de un pedido
           OPEN cursor_contiene;
               LOOP
                   FETCH cursor_contiene
                   into datos_contiene;
                   exit  when cursor_contiene%NOTFOUND;
                   
                 -- if coinciden (datos_pedido.importe_total,)  
                   IF datos_pedido.codigo = datos_contiene.pedido THEN
                      precioXunidad := datos_contiene.precio_con_comision * datos_contiene.unidades;
                      calculoImporteTotal := calculoImporteTotal + precioXunidad ;
                   END IF;   
                END LOOP;
                
            IF cursor_contiene%ISOPEN THEN CLOSE  cursor_contiene;
            END IF; 
            
            IF (coinciden(datos_pedido.importe_total,calculoImporteTotal ) = 0) THEN
                UPDATE pedidos
                SET pedidos.importe_total = calculoImporteTotal
                WHERE CURRENT OF cursor_pedidos;
                
                nFilas := nFilas + 1;
            END IF;  
      END LOOP;
      
  IF cursor_pedidos%ISOPEN THEN CLOSE  cursor_pedidos;
  END IF;
  
  IF nFilas = 0 THEN 
   DBMS_output.put_line('Ningun cambio en los datos de la tabla Pedidos.');
  ELSE 
   DBMS_output.put_line('Numero de filas modificadas :' || nFilas);
  END IF;
END revisa_pedidos;  