create or replace 
procedure revisa_pedidos  IS 
-- vars de trabajo
    datos_contiene contiene%ROWTYPE;
    datos_pedido pedidos%ROWTYPE;
    nFilas NUMBER DEFAULT 0;
    calculoImporteTotal NUMBER(8,2) DEFAULT 0;
    
 -- cursor para los platos que hay en contiene      
 CURSOR cursor_contiene
      is  SELECT * FROM contiene;
        
 -- cursor para los precios de los platos 
 CURSOR cursor_pedidos
      is  select * from pedidos;
       
BEGIN
  dbms_output.put_line('---- proc revisa_precio_con_comision----');
  
  -- Recorremos todos los pedidos 
  OPEN cursor_pedidos;
      LOOP
           FETCH cursor_pedidos
           into datos_pedido;
           exit  when cursor_contiene%NOTFOUND;
           
           -- calculamos Importe total de un pedido
           OPEN cursor_contiene;
               LOOP
                   FETCH cursor_contiene
                   into datos_contiene;
                   exit  when cursor_contiene%NOTFOUND;
                   
                 -- if coinciden (datos_pedido.importe_total,)  
                   IF datos_pedido.codigo = datos_contiene.pedido THEN
                      calculoImporteTotal := calculoImporteTotal +
                                            ( datos_contiene.precio_con_comision *
                                              datos_contiene.unidades
                                            );
                      nFilas := nFilas + 1;
                   END IF;   
                END LOOP;
                
            IF cursor_contiene%ISOPEN
                THEN CLOSE  cursor_contiene;
            END IF; 
            
            
      END LOOP;
      
  IF cursor_pedidos%ISOPEN
      THEN CLOSE  cursor_pedidos;
  END IF;
END revisa_pedidos;  