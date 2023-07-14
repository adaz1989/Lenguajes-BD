

-- ========================================================
-- ===============   Tablas Principales ==================
-- ========================================================

-- ___________________ Clientes ___________________________

CREATE TABLE Clientes (
  id_cliente int PRIMARY KEY NOT NULL,
  cedula int NOT NULL,
  nombre VARCHAR2(20) NOT NULL,
  apellido VARCHAR2(40) NOT NULL
);

CREATE SEQUENCE Seq_Clientes
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Clientes
  BEFORE INSERT ON Clientes
  FOR EACH ROW
BEGIN
  SELECT Seq_Clientes.NEXTVAL INTO :NEW.id_cliente FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Clientes (cedula, nombre, apellido)
VALUES (3235236432, 'Maria', 'Torres');

-- ___________________ Departamentos ___________________________

CREATE TABLE Departamentos (
  id_departamento int PRIMARY KEY NOT NULL,
  nombre_departamento varchar(40) NOT NULL
);

CREATE SEQUENCE Seq_Departamentos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Departamentos
  BEFORE INSERT ON Departamentos
  FOR EACH ROW
BEGIN
  SELECT Seq_Departamentos.NEXTVAL INTO :NEW.id_departamento FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Departamentos (nombre_departamento)
VALUES ('Recursos Humanos');

-- ___________________ Puestos ___________________________

CREATE TABLE Puestos (
  id_puesto int PRIMARY KEY NOT NULL,
  id_departamento int NOT NULL, -- FK
  nombre varchar(40) NOT NULL,
  FOREIGN KEY (id_departamento) REFERENCES Departamentos(id_departamento)
);

CREATE SEQUENCE Seq_Puestos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Puestos
  BEFORE INSERT ON Puestos
  FOR EACH ROW
BEGIN
  SELECT Seq_Puestos.NEXTVAL INTO :NEW.id_puesto FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Puestos (id_departamento, nombre)
VALUES ('1', 'Director RH');

-- ___________________ Colaboradores ___________________________

CREATE TABLE Colaboradores (
  id_colab int PRIMARY KEY NOT NULL,
  id_puesto int NOT NULL, -- FK
  cedula int NOT NULL,
  nombre varchar(20) NOT NULL,
  apellido varchar(40) NOT NULL,
  FOREIGN KEY (id_puesto) REFERENCES Puestos(id_puesto)
);

CREATE SEQUENCE Seq_Colaboradores
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Colaboradores
  BEFORE INSERT ON Colaboradores
  FOR EACH ROW
BEGIN
  SELECT Seq_Colaboradores.NEXTVAL INTO :NEW.id_colab FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Colaboradores (id_puesto,cedula,nombre,apellido)
VALUES ('1', 32555, 'Adrian', 'Alvarado Zumbado');
-- ___________________ Proveedores ___________________________

CREATE TABLE Proveedores (
  id_proveedores int PRIMARY KEY NOT NULL,
  empresa varchar(20) NOT NULL,
  costo_envio int
);

CREATE SEQUENCE Seq_Proveedores
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Proveedores
  BEFORE INSERT ON Proveedores
  FOR EACH ROW
BEGIN
  SELECT Seq_Proveedores.NEXTVAL INTO :NEW.id_proveedores FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Proveedores (empresa, costo_envio)
VALUES ('Una empresa', 5000);

-- ___________________ Metodos_Pago ___________________________

CREATE TABLE Metodos_Pago (
  id_metodo_pago int PRIMARY KEY NOT NULL,
  metodo_pago varchar(10) NOT NULL
);

CREATE SEQUENCE Seq_Metodos_Pago
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Metodos_Pago
  BEFORE INSERT ON Metodos_Pago
  FOR EACH ROW
BEGIN
  SELECT Seq_Metodos_Pago.NEXTVAL INTO :NEW.id_metodo_pago FROM DUAL;
END;
/

-- Registro 
INSERT INTO Metodos_Pago (metodo_pago)
VALUES ('Efectivo');
INSERT INTO Metodos_Pago (metodo_pago)
VALUES ('Tarjeta');
INSERT INTO Metodos_Pago (metodo_pago)
VALUES ('SINPE');


-- ___________________ Provincias ___________________________

CREATE TABLE Provincias (
  id_provincia int PRIMARY KEY NOT NULL,
  provincia varchar(20) NOT NULL
);

CREATE SEQUENCE Seq_Provincias
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Provincias
  BEFORE INSERT ON Provincias
  FOR EACH ROW
BEGIN
  SELECT Seq_Provincias.NEXTVAL INTO :NEW.id_provincia FROM DUAL;
END;
/

-- Registro
INSERT INTO Provincias (provincia)
VALUES ('San José');
INSERT INTO Provincias (provincia)
VALUES ('Alajuela');
INSERT INTO Provincias (provincia)
VALUES ('Heredia');
INSERT INTO Provincias (provincia)
VALUES ('Cartago');
INSERT INTO Provincias (provincia)
VALUES ('Puntarenas');
INSERT INTO Provincias (provincia)
VALUES ('Guanacaste');
INSERT INTO Provincias (provincia)
VALUES ('Limón');

-- ___________________ Cantones ___________________________

CREATE TABLE Cantones (
  id_canton int PRIMARY KEY NOT NULL,
  id_provincia int NOT NULL, -- FK
  canton varchar(20) NOT NULL,
  FOREIGN KEY (id_provincia) REFERENCES Provincias(id_provincia)
);

CREATE SEQUENCE Seq_Cantones
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Cantones
  BEFORE INSERT ON Cantones
  FOR EACH ROW
BEGIN
  SELECT Seq_Cantones.NEXTVAL INTO :NEW.id_canton FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Cantones (id_provincia, canton)
VALUES (1, 'San José');

-- ___________________ Distritos ___________________________

CREATE TABLE Distritos (
  id_distrito int PRIMARY KEY NOT NULL,
  id_canton int NOT NULL, -- FK
  distrito varchar(20),
  FOREIGN KEY (id_canton) REFERENCES Cantones(id_canton)
);

CREATE SEQUENCE Seq_Distritos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Distritos
  BEFORE INSERT ON Distritos
  FOR EACH ROW
BEGIN
  SELECT Seq_Distritos.NEXTVAL INTO :NEW.id_distrito FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Distritos (id_canton, distrito)
VALUES (1, 'Carmen');

-- ___________________ Direcciones ___________________________


CREATE TABLE Direcciones (
  id_direccion int PRIMARY KEY NOT NULL,
  id_provincia int NOT NULL, -- FK
  id_canton int NOT NULL, -- FK
  id_distrito int NOT NULL, -- FK
  detalle varchar(100),
  FOREIGN KEY (id_provincia) REFERENCES Provincias(id_provincia),
  FOREIGN KEY (id_canton) REFERENCES Cantones(id_canton),
  FOREIGN KEY (id_distrito) REFERENCES Distritos(id_distrito)
);

CREATE SEQUENCE Seq_Direcciones
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Direcciones
  BEFORE INSERT ON Direcciones
  FOR EACH ROW
BEGIN
  SELECT Seq_Direcciones.NEXTVAL INTO :NEW.id_direccion FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Direcciones (id_provincia, id_canton, id_distrito, detalle)
VALUES (1, 1, 1, 'Esta es una direccion de prueba');

-- ___________________ Correos ___________________________

CREATE TABLE Correos (
  id_correo int PRIMARY KEY NOT NULL,
  correo varchar(50) NOT NULL
);

CREATE SEQUENCE Seq_Correos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Correos
  BEFORE INSERT ON Correos
  FOR EACH ROW
BEGIN
  SELECT Seq_Correos.NEXTVAL INTO :NEW.id_correo FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Correos (correo)
VALUES ('prueba@correo.com');

-- ___________________ telefonos ___________________________

CREATE TABLE telefonos (
  id_telefono int PRIMARY KEY NOT NULL,
  telefono int NOT NULL
);

CREATE SEQUENCE Seq_telefonos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_telefonos
  BEFORE INSERT ON telefonos
  FOR EACH ROW
BEGIN
  SELECT Seq_telefonos.NEXTVAL INTO :NEW.id_telefono FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO telefonos (telefono)
VALUES (71048756);

-- ___________________ Productos ___________________________

CREATE TABLE Productos (
  id_producto int PRIMARY KEY NOT NULL,
  nombre varchar(20) NOT NULL,
  marca varchar(20) NOT NULL,
  descripcion varchar(40) NOT NULL,
  precio_venta int NOT NULL,
  stock int NOT NULL
);

CREATE SEQUENCE Seq_Productos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Productos
  BEFORE INSERT ON Productos
  FOR EACH ROW
BEGIN
  SELECT Seq_Productos.NEXTVAL INTO :NEW.id_producto FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Productos (nombre, marca, descripcion, precio_venta, stock)
VALUES ('Producto1', 'marcaProducto', 'descripcion', 2500, 5);

-- ___________________ FacturaVentas ___________________________

CREATE TABLE Facturas_Compras (
  id_factura_venta int PRIMARY KEY NOT NULL,
  id_cliente int NOT NULL, -- FK
  id_colab int NOT NULL, -- FK
  id_metodo_pago int NOT NULL, -- FK
  fecha date DEFAULT SYSDATE NOT NULL,
  monto decimal(10, 1) NOT NULL,
  descuento decimal(5, 2) NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
  FOREIGN KEY (id_colab) REFERENCES Colaboradores(id_colab),
  FOREIGN KEY (id_metodo_pago) REFERENCES Metodos_Pago(id_metodo_pago)
);

CREATE SEQUENCE Seq_Facturas_Compras
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Facturas_Compras
  BEFORE INSERT ON Facturas_Compras
  FOR EACH ROW
BEGIN
  SELECT Seq_Facturas_Compras.NEXTVAL INTO :NEW.id_factura_venta FROM DUAL;
END;
/

-- Insertar un registro en la tabla Facturas_Compras
INSERT INTO Facturas_Compras (id_cliente, id_colab, id_metodo_pago, monto, descuento)
VALUES (1, 1, 1, 100.5, 0.05);

-- ___________________ Facturas_Compras _____________________

CREATE TABLE Facturas_Compras (
  id_factura_compra int PRIMARY KEY NOT NULL,
  id_colab int NOT NULL, -- FK
  id_proveedores int NOT NULL, -- FK
  id_metodo_pago int NOT NULL, -- FK
  fecha date DEFAULT SYSDATE NOT NULL,
  monto decimal(10, 1) NOT NULL,
  descuento decimal(5, 2) NOT NULL,
  FOREIGN KEY (id_colab) REFERENCES Colaboradores(id_colab),
  FOREIGN KEY (id_proveedores) REFERENCES Proveedores(id_proveedores),
  FOREIGN KEY (id_metodo_pago) REFERENCES Metodos_Pago(id_metodo_pago)
);

CREATE SEQUENCE Seq_Facturas_Compras
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Facturas_Compras
  BEFORE INSERT ON Facturas_Compras
  FOR EACH ROW
BEGIN
  SELECT Seq_Facturas_Compras.NEXTVAL INTO :NEW.id_factura_compra FROM DUAL;
END;
/

-- Insertar un registro en la tabla Facturas_Compras
INSERT INTO Facturas_Compras (id_colab, id_proveedores, id_metodo_pago, monto, descuento)
VALUES (1, 1, 1, 100.5, 0.05);
select * from Facturas_Compras;

-- ================================================================
-- ======================   Tablas de Apoyo =======================
-- ================================================================

-- ___________________ Direcciones_Clientes ___________________________

CREATE TABLE Direcciones_Clientes (
  id_cliente int,
  id_direccion int,
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
  FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
);

-- ___________________ Correos_Clientes ___________________________

CREATE TABLE Correos_Clientes (
  id_cliente int,
  id_correo int,
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
  FOREIGN KEY (id_correo) REFERENCES Correos(id_correo)
);

-- ___________________ Telefonos_Clientes ___________________________

CREATE TABLE Telefonos_Clientes (
  id_cliente int,
  id_telefono int,
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
  FOREIGN KEY (id_telefono) REFERENCES telefonos(id_telefono)
);

-- ___________________ Direcciones_Colaboradores ___________________________

CREATE TABLE Direcciones_Colaboradores (
  id_colab int,
  id_direccion int,
  FOREIGN KEY (id_colab) REFERENCES Colaboradores(id_colab),
  FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
);

-- ___________________ Correos_Colaboradores ___________________________

CREATE TABLE Correos_Colaboradores (
  id_colab int,
  id_correo int,
  FOREIGN KEY (id_colab) REFERENCES Colaboradores(id_colab),
  FOREIGN KEY (id_correo) REFERENCES Correos(id_correo)
);

-- ___________________ Telefonos_Colaboradores ___________________________

CREATE TABLE Telefonos_Colaboradores (
  id_colab int,
  id_telefono int,
  FOREIGN KEY (id_colab) REFERENCES Colaboradores(id_colab),
  FOREIGN KEY (id_telefono) REFERENCES telefonos(id_telefono)
);


-- ___________________ Direcciones_Proveedores ___________________________

CREATE TABLE Direcciones_Proveedores (
  id_proveedores int,
  id_direccion int,
  FOREIGN KEY (id_proveedores) REFERENCES Proveedores(id_proveedores),
  FOREIGN KEY (id_direccion) REFERENCES Direcciones(id_direccion)
);

-- ___________________ Correos_Proveedores ___________________________
CREATE TABLE Correos_Proveedores (
  id_proveedores int,
  id_correo int,
  FOREIGN KEY (id_proveedores) REFERENCES Proveedores(id_proveedores),
  FOREIGN KEY (id_correo) REFERENCES Correos(id_correo)
);

-- ___________________ Telefonos_Proveedores ___________________________

CREATE TABLE Telefonos_Proveedores (
  id_proveedores int,
  id_telefono int,
  FOREIGN KEY (id_proveedores) REFERENCES Proveedores(id_proveedores),
  FOREIGN KEY (id_telefono) REFERENCES telefonos(id_telefono)
);

-- ___________________ Productos_Proveedores ___________________________

CREATE TABLE Productos_Proveedor (
  id_proveedores int,
  id_producto int,
  precio_compra int,
  FOREIGN KEY (id_proveedores) REFERENCES Proveedores(id_proveedores),
  FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- ___________________ Factura_Productos_Ventas _________________________

CREATE TABLE Factura_Productos_Ventas (
  id_factura_venta int,
  id_producto int,
  cantidad int,
  precio int,
  FOREIGN KEY (id_factura_venta) REFERENCES Facturas_Compras(id_factura_venta),
  FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- ___________________ Factura_Productos_Compras _______________________

CREATE TABLE Factura_Productos_Compras (
  id_factura_compra int,
  id_producto int,
  cantidad int,
  precio int,
  FOREIGN KEY (id_factura_compra) REFERENCES Facturas_Compras(id_factura_compra),
  FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);


-- ________________ COMMIT _____________________

COMMIT;

