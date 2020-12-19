create or replace 
procedure pedidosclientes (
  dniCliente clientes.dni%type
) IS 
-- vars de trabajo
    datos_cliente clientes%ROWTYPE;
    /*
    nombrecl CHAR(30);
    apellido CHAR (20);
    calle CHAR (20);
    número NUMBER (4,0);
    piso CHAR (5);
    localidad CHAR (20);
    codigoPostal CHAR (5);
    telefonocl CHAR(9 );
    usuario CHAR (8);
    contraseña CHAR (8);
    */
    codigoPedido NUMBER;
    fechaPedido DATE;
    fechaEntrega DATE;
    estado CHAR (9);
    importeTotal NUMBER (8,2);
    
    pedido_inexistente EXCEPTION;
    
    suma NUMBER;
 -- cursor para los pedidos de un cliente       
 CURSOR cursor_pedidos_cliente
      is
        SELECT codigo, fecha_hora_pedido, fecha_hora_entrega, estado, importe_total
        FROM pedidos 
        WHERE cliente = dniCliente
        ORDER BY  fecha_hora_pedido;

begin
  dbms_output.put_line('--- proc pedido cliente ');
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
      into codigoPedido, fechaPedido, fechaEntrega, estado, importeTotal;
       IF  cursor_pedidos_cliente%NOTFOUND
          THEN  RAISE pedido_inexistente;
       END IF;
       
        LOOP
           
           DBMS_output.put_line( 'cod: ' || codigoPedido) ;
           DBMS_output.put_line( 'fecha Pedido: ' || fechaPedido);
           DBMS_output.put_line( 'fecha Entrega: ' || fechaEntrega);
           DBMS_output.put_line( 'estado: ' || estado) ;
           DBMS_output.put_line( 'importe total: ' || importeTotal) ;
           
            FETCH cursor_pedidos_cliente
            into codigoPedido, fechaPedido, fechaEntrega, estado, importeTotal;
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
            into codigoPedido, fechaPedido, fechaEntrega, estado, importeTotal;
            exit  when cursor_pedidos_cliente%NOTFOUND;
            suma := suma + importeTotal ;
          
        END LOOP;   
        DBMS_output.put_line( 'suma de pedidos: ' || suma) ;
 --Capturamos las excepciones       
 EXCEPTION
      WHEN NO_DATA_FOUND
        THEN  DBMS_output.put_line( 'DNI NO EXISTENTE' ) ;
      
     WHEN pedido_inexistente 
        THEN  DBMS_output.put_line('El cliente con dni: ' || datos_cliente.dni || 'no tiene pedidos'); 
END pedidosClientes;