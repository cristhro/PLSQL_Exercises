create or replace 
PROCEDURE probarMitrans2
AS 
n NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- proc probarMiTrans2 ---');

  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'REST', to_date('09-02-17:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI'), 34.25, '12345678N', 1100);
  --INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-16:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-16:20:50', 'YY:MM:DD HH24:MI'), 14.25, '12345678N', 1100);
  --INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-15:22:50', 'YY:MM:DD HH24:MI'), to_date('09-02-15:23:10', 'YY:MM:DD HH24:MI'), 16.50, '12345678N', 1400);

  ABD0404A.trabajando_trans_2(3);
  
  INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'REST', to_date('09-02-17:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-17:20:50', 'YY:MM:DD HH24:MI'), 34.25, '12345678N', 1100);
  --INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-16:19:50', 'YY:MM:DD HH24:MI'), to_date('09-02-16:20:50', 'YY:MM:DD HH24:MI'), 14.25, '12345678N', 1100);
  --INSERT INTO Pedidos VALUES (Seq_CodPedidos.NEXTVAL, 'ENTREGADO', to_date('09-02-15:22:50', 'YY:MM:DD HH24:MI'), to_date('09-02-15:23:10', 'YY:MM:DD HH24:MI'), 16.50, '12345678N', 1400);
 
  ABD0404A.trabajando_trans_2(3);
END;