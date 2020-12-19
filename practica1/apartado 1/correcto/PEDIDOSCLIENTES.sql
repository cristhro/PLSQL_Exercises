create or replace 
procedure pedidosclientes (
  dniCliente clientes.dni%type
) IS 
-- vars de trabajo
    datos_cliente clientes%ROWTYPE;
    datos_pedidos_CL pedidos%ROWTYPE;
  
    
    pedido_inexistente EXCEPTION;
    suma NUMBER;
    
 -- cursor para los pedidos de un cliente       
 CURSOR cursor_pedidos_cliente
      is
        SELECT *
        FROM pedidos 
        WHERE cliente = dniCliente
        ORDER BY  fecha_hora_pedido;

begin
  dbms_output.put_line('---- proc pedido cliente ----');
  SELECT * INTO datos_cliente
  FROM clientes
  WHERE dni = dnicliente;
  
  -- mostramos los datos del cliente
  DBMS_output.put_line( 'dni: ' || datos_cliente.dni );
  DBMS_output.put_line( 'nombre: ' || datos_cliente.nombre);
  DBMS_output.put_line( 'apellido: ' || datos_cliente.apellido );
  DBMS_output.put_line( 'calle: ' || datos_cliente.calle );
  DBMS_output.put_line( 'numero: ' || datos_cliente.numero );
  DBMS_output.put_line( 'piso: ' || datos_cliente.piso );
  DBMS_output.put_line( 'localidad: ' || datos_cliente.localidad );
  DBMS_output.put_line( 'codigo postal: ' || datos_cliente.codigo_postal);
  DBMS_output.put_line( 'teléfono: ' || datos_cliente.telefono );
  DBMS_output.put_line( 'usuario: ' || datos_cliente.usuario );
  
  
  OPEN cursor_pedidos_cliente;
      FETCH cursor_pedidos_cliente
      into datos_pedidos_CL;
      
      IF  cursor_pedidos_cliente%NOTFOUND
          THEN  RAISE pedido_inexistente;
      END IF;
       
        LOOP
             DBMS_output.put_line( 'cod: ' || datos_pedidos_CL.codigo) ;
             DBMS_output.put_line( 'fecha Pedido: ' || datos_pedidos_CL.fecha_hora_pedido);
             DBMS_output.put_line( 'fecha Entrega: ' || datos_pedidos_CL.fecha_hora_entrega);
             DBMS_output.put_line( 'estado: ' || datos_pedidos_CL.estado) ;
             DBMS_output.put_line( 'importe total: ' || datos_pedidos_CL.importe_total) ;
             
             FETCH cursor_pedidos_cliente
             into datos_pedidos_CL;
             exit  when cursor_pedidos_cliente%NOTFOUND;
            
        END LOOP;
  IF cursor_pedidos_cliente%ISOPEN
      THEN CLOSE  cursor_pedidos_cliente;
  END IF;
  
-- Calculamos la suma de los importes de todos los pedidos del cliente
  OPEN cursor_pedidos_cliente;
       
        suma :=0;
        LOOP
              FETCH cursor_pedidos_cliente
              into datos_pedidos_CL;
              exit  when cursor_pedidos_cliente%NOTFOUND;
              suma := suma + datos_pedidos_CL.importe_total ;    
        END LOOP;   
        DBMS_output.put_line( 'suma de pedidos: ' || suma) ;
  
  IF cursor_pedidos_cliente%ISOPEN
      THEN CLOSE  cursor_pedidos_cliente;
  END IF;      
  
 --Capturamos las excepciones       
 EXCEPTION
      WHEN NO_DATA_FOUND
        THEN  DBMS_output.put_line( 'DNI NO EXISTENTE' ) ;
     WHEN pedido_inexistente 
        THEN  DBMS_output.put_line('El cliente con dni: ' || datos_cliente.dni || 'no tiene pedidos'); 
END pedidosClientes;