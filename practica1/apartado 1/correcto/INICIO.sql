create or replace 
procedure anonimo as
BEGIN
  -- cliente existe y con pedidos
	pedidosclientes('12345678M');
  
  -- cliente existe y sin pedido
  	pedidosclientes('1');
    
  -- cliente no existe  
    pedidosclientes('12N');
END;