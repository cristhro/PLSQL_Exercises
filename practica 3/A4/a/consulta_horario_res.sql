CREATE OR REPLACE PROCEDURE consulta_horario_res
AS
CURSOR cursor_restaurantes IS
  SELECT * FROM RESTAURANTES WHERE NOMBRE = 'telericatorta';
CURSOR cursor_horario IS
  SELECT * FROM HORARIOS ;
BEGIN
   DBMS_output.put_line('--- Proc consultas horario res ---' );

  FOR r in cursor_restaurantes
   LOOP
       DBMS_output.put_line('NOMBRE:' || r.NOMBRE  );
       
       FOR h in cursor_horario 
        LOOP
         IF r.CODIGO = h.CODIGORES THEN
            DBMS_output.put_line('  --------HORARIO---------'  );  
            DBMS_output.put_line('  CODIGORES:' || h.CODIGORES  );
            DBMS_output.put_line('  DIA_SEMANA:' || h.DIA_SEMANA  );
            DBMS_output.put_line('  HORA_APERTURA:' || h.HORA_APERTURA  );
            DBMS_output.put_line('  HORA_CIERRE:' || h.HORA_CIERRE  );
            
            EXIT WHEN r.CODIGO = h.CODIGORES;
          END IF;
        END LOOP;
   END LOOP;
END;
/*
BEGIN
CONSULTA_HORARIO_RES();
END;

*/