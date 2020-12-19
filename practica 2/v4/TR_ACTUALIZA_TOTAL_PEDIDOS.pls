create or replace TRIGGER TR_ACTUALIZA_TOTAL_PEDIDOS BEFORE INSERT OR DELETE OR UPDATE
  ON contiene FOR EACH ROW
declare
calculo NUMBER (8,2);
descuento NUMBER (8,0) default 0;
valor_completo NUMBER (8,2);
dni_cliente clientes.dni%TYPE;
cod_pedido pedidos.codigo%TYPE;
restaurante restaurantes.nombre%TYPE;
datos_pedido pedidos%ROWTYPE;
datos_descuento descuentos%ROWTYPE;
datos_restaurante restaurantes%ROWTYPE;

 -- cursor para los pedidos
 CURSOR cursor_pedidos  is  SELECT * FROM pedidos WHERE codigo = :new.pedido; 
 
 -- cursor para los descuentos
 CURSOR cursor_descuentos  is  SELECT * FROM descuentos ;
 
  -- cursor para los restaurantes
 CURSOR cursor_restaurantes is  SELECT * FROM RESTAURANTES ;
 
BEGIN
  DBMS_output.put_line('-- trigger actualiza total pedidos  ---');
  
  -- INSERTA
  IF INSERTING THEN
    DBMS_output.put_line('insert');  
    
     -- RECORRE PEDIDOS
     OPEN cursor_pedidos;
       LOOP
           FETCH cursor_pedidos
           into datos_pedido;
           exit  when cursor_pedidos%NOTFOUND ;
           
           -- RECORRE DESCUENTOS
            OPEN cursor_descuentos;
               LOOP
                   FETCH cursor_descuentos
                   into datos_descuento;
                   exit  when cursor_descuentos%NOTFOUND;
                   
                   IF datos_pedido.codigodescuento = datos_descuento.codigodescuento then
                   --OBTENEMOS DESCUENTO
                    descuento:= datos_descuento.porcentaje_descuento;
                   END IF; 
                END LOOP;
                
            IF cursor_descuentos%ISOPEN THEN CLOSE  cursor_descuentos;
            END IF; 
            
        END LOOP;
        -- OBTENEMOS DNI Y CODIGO_PEDIDO
        dni_cliente := datos_pedido.cliente;
        cod_pedido := datos_pedido.codigo;
        
      IF cursor_pedidos%ISOPEN THEN CLOSE  cursor_pedidos;
      END IF; 
      
    --CALCULO IMPORTE TOTAL DEL PEDIDO
    valor_completo := (:new.precio_con_comision * :new.unidades);
    calculo := valor_completo*(1 - descuento/100);
  
    --ACTUALIZAMOS PEDIDO
    UPDATE pedidos
    SET pedidos.importe_total =  pedidos.importe_total  + calculo
    WHERE pedidos.codigo = :new.pedido;

    --BUSCAMOS NOMBRE DEL RESTAURANTE
          OPEN cursor_restaurantes;
                LOOP
                     FETCH cursor_restaurantes
                     into datos_restaurante;
                     exit  when cursor_restaurantes%NOTFOUND;
                     IF datos_restaurante.codigo = :new.restaurante THEN
                       -- OBTENEMOS  EL NOMBRE
                       restaurante := datos_restaurante.nombre;
                     END IF;  
                END LOOP;
                
          IF cursor_restaurantes%ISOPEN
              THEN CLOSE  cursor_restaurantes;
          END IF;
          
    --INVOCAMOS A LA FUNCION GESTION CUPONES
    gestion_cupones(restaurante,dni_cliente,cod_pedido,valor_completo);
    
  ELSIF DELETING THEN
    DBMS_output.put_line('delete'); 
 
  ELSIF UPDATING THEN
   DBMS_output.put_line('update');
  
  END IF;
END;