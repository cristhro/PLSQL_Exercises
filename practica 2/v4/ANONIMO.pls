create or replace procedure anonimo as

--datos_cupon TCUPON(0,'02777453L',123, 100, sysdate) TCUPON;
BEGIN

  DBMS_output.put_line('--- Proc ANONIMO ---' );
  --crea_tabla_cupones('prueba'); 
  --crea_sec_cupones('prueba');
--INSERT INTO Contiene VALUES (2345, 'chana masala', 2, 25, 1);
 --INSERT INTO Contiene VALUES (3456, 'vege-burguer', 3, 25, 4);

 INSERT INTO Contiene VALUES (5678, 'torta gallega', 3, 10, 8);
 --INSERT INTO Contiene VALUES (2345, 'pollo tikka', 7, 20, 3);
--INSERT INTO Contiene VALUES (5678, 'tortaDeCarneEspecial', 8, 10, 1);
--INSERT INTO Contiene VALUES (3456, 'crunch-burguer', 7, 100, 1);
--INSERT INTO Contiene VALUES (3456, 'vege-burguer', 7, 150, 3);
--INSERT INTO Contiene VALUES (1234, 'pizza margarita', 10, 200, 2);
/*
INSERT INTO Contiene VALUES (1234, 'pizza vegetal', 10, NULL, 2);
INSERT INTO Contiene VALUES (3456, 'hot-burguer', 10, NULL, 1);
  */
  

END;