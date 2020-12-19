SET AUTOCOMMIT ON;

DROP TABLE Restaurantes CASCADE CONSTRAINTS;
DROP TABLE AreasCobertura CASCADE CONSTRAINTS;
DROP TABLE Horarios CASCADE CONSTRAINTS;
DROP TABLE Platos CASCADE CONSTRAINTS;
DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Descuentos CASCADE CONSTRAINTS;
DROP TABLE Pedidos CASCADE CONSTRAINTS;
DROP TABLE Contiene CASCADE CONSTRAINTS;

DROP SEQUENCE Seq_CodPedidos;


CREATE TABLE Restaurantes(
	codigo NUMBER(8) PRIMARY KEY,
	nombre CHAR(20) NOT NULL, 
	calle CHAR(30) NOT NULL,
	codigo_postal CHAR(5) NOT NULL,
	comision NUMBER(8,2) NULL
);

CREATE TABLE AreasCobertura (
	codigoRes NUMBER(8),	
	codigopostal CHAR(5),
	CONSTRAINT pk_areasCobertura PRIMARY KEY (codigoRes, codigopostal), 
	CONSTRAINT fk_areasCobertura FOREIGN KEY (codigoRes) 
                   REFERENCES Restaurantes(codigo) ON DELETE CASCADE
);

CREATE TABLE Horarios (
	codigoRes NUMBER(8),
	dia_semana CHAR(1),
	hora_apertura DATE NOT NULL,
	hora_cierre DATE NULL,	
	CONSTRAINT pk_horario PRIMARY KEY (CodigoRes, dia_semana),
	CONSTRAINT fk_horario FOREIGN KEY (codigoRes)
                    REFERENCES Restaurantes(codigo) ON DELETE CASCADE
);

CREATE TABLE Platos (
	restaurante NUMBER(8),
	nombrePlato CHAR(25),
	precio NUMBER(8,2) NULL,
	descripcion CHAR(30) NULL,
	categoria CHAR(20) NULL,
	CONSTRAINT pk_plato PRIMARY KEY (restaurante, nombrePlato),
	CONSTRAINT fk_plato FOREIGN KEY (restaurante) 
                     REFERENCES Restaurantes(codigo) ON DELETE CASCADE
);

CREATE TABLE Clientes (
	DNI CHAR(9) PRIMARY KEY,
	nombre CHAR(20),
	apellido CHAR(20),
	calle CHAR(20) NULL,
	numero NUMBER(4) NULL,
	piso CHAR(5) NULL,
	localidad CHAR(20) NULL,
	codigo_postal CHAR(5) NULL,
	telefono CHAR(9) NULL,
	usuario CHAR(8),
	contraseña CHAR(8)
);

CREATE TABLE Descuentos (
	codigodescuento NUMBER(8) PRIMARY KEY,	
	fecha_caducidad DATE NULL,	
	porcentaje_descuento NUMBER(3)
);

CREATE TABLE Pedidos(
	codigo NUMBER(8) PRIMARY KEY,
	estado CHAR(9) DEFAULT 'REST' NOT NULL,
	fecha_hora_pedido DATE NOT NULL,
	fecha_hora_entrega DATE NULL,
	importe_total NUMBER(8,2),
	cliente CHAR(9) NOT NULL,
	codigodescuento NUMBER(8),
	CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente) REFERENCES Clientes (DNI),
	CONSTRAINT fk_pedido_descuento FOREIGN KEY (codigodescuento)
                            REFERENCES Descuentos (codigodescuento) ON DELETE SET NULL, 		
	CONSTRAINT ck_pedido_estado CHECK (estado IN ('REST', 'CANCEL', 'RUTA', 'ENTREGADO','RECHAZADO'))
); 

CREATE TABLE Contiene (
	restaurante NUMBER(8),
	plato CHAR(25),
	pedido NUMBER(8),	
	precio_con_comision NUMBER(8,2) NULL,	
	unidades NUMBER(4) NOT NULL,
	CONSTRAINT pk_contiene PRIMARY KEY (restaurante, plato, pedido),
	CONSTRAINT fk_contiene_plato FOREIGN KEY (restaurante, plato)
                               REFERENCES Platos (restaurante, nombrePlato) ON DELETE CASCADE,	
	CONSTRAINT fk_contiene_pedido FOREIGN KEY (pedido) REFERENCES Pedidos (codigo) ON DELETE CASCADE
);
--Consultamos todas nuestras tablas de la base de datos
SELECT TABLE_NAME FROM USER_TABLES;

--Indice que optimiza la busqueda de Platos degun su categoria 
CREATE INDEX I_CatPlatos ON Platos(categoria);

--Autogeneramos con esta secuencia la clave primaria de pedidos

CREATE SEQUENCE Seq_CodPedidos INCREMENT BY 1 START WITH 1 NOMAXVALUE;

DESCRIBE RESTAURANTES;
DESCRIBE AREASCOBERTURA;
DESCRIBE HORARIOS;
DESCRIBE PLATOS;
DESCRIBE CLIENTES;
DESCRIBE DESCUENTOS;
DESCRIBE PEDIDOS;
DESCRIBE CONTIENE;
