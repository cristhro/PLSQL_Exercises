CREATE OR REPLACE PROCEDURE consulta_platos_res
AS
CURSOR cursor_restaurantes IS
  SELECT * FROM RESTAURANTES WHERE NOMBRE = 'telericatorta';
CURSOR cursor_platos IS
  SELECT * FROM PLATOS ;
BEGIN
   DBMS_output.put_line('--- Proc consultas platos res ---' );

  FOR r in cursor_restaurantes
   LOOP
       DBMS_output.put_line('NOMBRE:' || r.NOMBRE  );
       FOR p in cursor_platos 
        LOOP
         IF r.CODIGO = p.RESTAURANTE THEN
            DBMS_output.put_line('  --------PLATO---------'  );  
            DBMS_output.put_line('  RESTAURANTE:' || p.RESTAURANTE  );
            DBMS_output.put_line('  NOMBREPLATO:' || p.NOMBREPLATO  );
            DBMS_output.put_line('  DESCRIPCION:' || p.DESCRIPCION  );
            DBMS_output.put_line('  CATEGORIA:' || p.CATEGORIA  );
          END IF;
        END LOOP;
   END LOOP;
END;

/*SET SERVEROUTPUT ON;
BEGIN
  consultasSimultaneas();
END;
*/