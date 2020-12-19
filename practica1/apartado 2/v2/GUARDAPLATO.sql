create or replace 
FUNCTION guardaPlato(
      restaurante_c contiene.restaurante%TYPE,
      plato_c contiene.plato%TYPE,
      pedido_c contiene.pedido%TYPE )
    return NUMBER
  AS
-- vars de trabajo
     datos_contiene contiene%ROWTYPE;

  -- cursor para leer tarjetas
      CURSOR cursor_contiene
      IS
        SELECT * 
        FROM contiene 
        WHERE restaurante = restaurante_c and
              plato = plato_c and
              pedido = pedido_c ;

  BEGIN
        OPEN cursor_contiene; 
        FETCH cursor_contiene into datos_contiene;
        if(cursor_contiene%NOTFOUND) then 
            dbms_output.put_line('No se ha podido guardar el plato');
         return 1;
        end if;
        IF cursor_contiene%ISOPEN
            THEN CLOSE  cursor_contiene;
        END IF;
        
        Insert into TrazaPlatos (RESTAURANTE
                                ,PLATO
                                ,PEDIDO
                                ,PRECIO_CON_COMISION
                                ,UNIDADES) 
                                VALUES (datos_contiene.restaurante,
                                        datos_contiene.plato,
                                        datos_contiene.pedido,
                                        datos_contiene.precio_con_comision,
                                        datos_contiene.unidades
                                  );
        return 0;
        
        
  END guardaPlato;