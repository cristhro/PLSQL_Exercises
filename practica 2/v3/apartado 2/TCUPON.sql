create or replace 
TYPE TCupon AS OBJECT (
  NUMCUPON	NUMBER(8,0),
  DNICLIENTE	CHAR(9 BYTE),
  CODPEDIDO	CHAR(8 BYTE),
  VALOR	CHAR(8 BYTE),
  FECHACADUCA	DATE
);