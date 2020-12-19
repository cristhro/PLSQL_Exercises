create or replace 
procedure anonimo as

--datos_cupon TCUPON(0,'02777453L',123, 100, sysdate) TCUPON;
BEGIN

  DBMS_output.put_line('--- Proc ANONIMO ---' );
  
  -- GENERAMOS CUPONES
  FOR cupon  IN (select * from table (genera_cupones(TCUPON(0,'02777453L',123, 100, sysdate), 15, 'prueba')))
  LOOP
          DBMS_output.put_line('bucle' );
          DBMS_output.put_line(cupon.NUMCUPON);
          DBMS_output.put_line(cupon.DNICLIENTE);
          DBMS_output.put_line(cupon.CODPEDIDO);
          DBMS_output.put_line(cupon.VALOR);
          DBMS_output.put_line(cupon.FECHACADUCA);
             
  END LOOP;

END;