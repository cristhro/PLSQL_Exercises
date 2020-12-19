create or replace 
PROCEDURE DATOS_CLIENTES
as

--variables
total NUMBER DEFAULT 0;

BEGIN
    dbms_output.put_line('---- proc DATOS_CLIENTES ----');
    FOR cliente IN (  SELECT dni
                      FROM clientes  )
    LOOP
        total := total + pedidos_clientes_tot(cliente.dni);
    END LOOP;

    dbms_output.put_line('Suma de todos los pedidos ' );
    dbms_output.put_line('de todos los clientes es: ' || total );
END DATOS_CLIENTES;