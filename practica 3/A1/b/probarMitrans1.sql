CREATE OR REPLACE
PROCEDURE probarMitrans1
AS 
BEGIN
DBMS_OUTPUT.PUT_LINE('--- proc probarMiTrans1 ---');
  

  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'REST', to_date('09-02-17:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI'), 34.25, '12345678N', 1100);
  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-16:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-16:20:50', 'YY:MM:DD HH24:MI'), 14.25, '12345678N', 1100);
  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-15:22:50', 'YY:MM:DD HH24:MI'), to_date('09-02-15:23:10', 'YY:MM:DD HH24:MI'), 16.50, '12345678N', 1400);
  
  ABD0404A.trabajando_trans_1(5);
  
  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'REST', to_date('09-02-17:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI'), 34.25, '12345678N', 1100);
  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-16:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-16:20:50', 'YY:MM:DD HH24:MI'), 14.25, '12345678N', 1100);
  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-15:22:50', 'YY:MM:DD HH24:MI'), to_date('09-02-15:23:10', 'YY:MM:DD HH24:MI'), 16.50, '12345678N', 1400);
  
  trabajando_trans_1(5);
END;

