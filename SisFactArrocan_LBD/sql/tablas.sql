

-- ========================================================
-- ===============   Tablas Principales ===================
-- ========================================================

-- ___________________ Clientes ___________________________

CREATE TABLE Clientes (
  IdCliente int PRIMARY KEY NOT NULL,
  Cedula int NOT NULL,
  Nombre VARCHAR2(20) NOT NULL,
  Apellidos VARCHAR2(40) NOT NULL
);

CREATE SEQUENCE Seq_Clientes
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Clientes
  BEFORE INSERT ON Clientes
  FOR EACH ROW
BEGIN
  SELECT Seq_Clientes.NEXTVAL INTO :NEW.IdCliente FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Clientes (Cedula, Nombre, Apellidos)
VALUES (3235236432, 'Maria', 'Torres');

-- ___________________ Departamentos ___________________________

CREATE TABLE Departamentos (
  IdDepartamento int PRIMARY KEY NOT NULL,
  NombreDepartamento varchar(40) NOT NULL
);

CREATE SEQUENCE Seq_Departamentos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Departamentos
  BEFORE INSERT ON Departamentos
  FOR EACH ROW
BEGIN
  SELECT Seq_Departamentos.NEXTVAL INTO :NEW.IdDepartamento FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Departamentos (NombreDepartamento)
VALUES ('Recursos Humanos');

-- ___________________ Puestos ___________________________

CREATE TABLE Puestos (
  IdPuesto int PRIMARY KEY NOT NULL,
  IdDepartamento int NOT NULL, -- FK
  Nombre varchar(40) NOT NULL,
  FOREIGN KEY (IdDepartamento) REFERENCES Departamentos(IdDepartamento)
);

CREATE SEQUENCE Seq_Puestos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Puestos
  BEFORE INSERT ON Puestos
  FOR EACH ROW
BEGIN
  SELECT Seq_Puestos.NEXTVAL INTO :NEW.IdPuesto FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Puestos (IdDepartamento, Nombre)
VALUES ('1', 'Director RH');

-- ___________________ Colaboradores ___________________________

CREATE TABLE Colaboradores (
  IdColab int PRIMARY KEY NOT NULL,
  IdPuesto int NOT NULL, -- FK
  Cedula int NOT NULL,
  Nombre varchar(20) NOT NULL,
  Apellidos varchar(40) NOT NULL,
  FOREIGN KEY (IdPuesto) REFERENCES Puestos(IdPuesto)
);

CREATE SEQUENCE Seq_Colaboradores
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Colaboradores
  BEFORE INSERT ON Colaboradores
  FOR EACH ROW
BEGIN
  SELECT Seq_Colaboradores.NEXTVAL INTO :NEW.IdColab FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Colaboradores (IdPuesto,Cedula,Nombre,Apellidos)
VALUES ('1', 32555, 'Adrian', 'Alvarado Zumbado');
-- ___________________ Proveedores ___________________________

CREATE TABLE Proveedores (
  IdProveedor int PRIMARY KEY NOT NULL,
  Empresa varchar(20) NOT NULL,
  CostoEnvio int
);

CREATE SEQUENCE Seq_Proveedores
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Proveedores
  BEFORE INSERT ON Proveedores
  FOR EACH ROW
BEGIN
  SELECT Seq_Proveedores.NEXTVAL INTO :NEW.IdProveedor FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Proveedores (Empresa, CostoEnvio)
VALUES ('Una Empresa', 5000);

-- ___________________ MetodosPago ___________________________

CREATE TABLE MetodosPago (
  IdMetodoPago int PRIMARY KEY NOT NULL,
  MetodoPago varchar(10) NOT NULL
);

CREATE SEQUENCE Seq_MetodosPago
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_MetodosPago
  BEFORE INSERT ON MetodosPago
  FOR EACH ROW
BEGIN
  SELECT Seq_MetodosPago.NEXTVAL INTO :NEW.IdMetodoPago FROM DUAL;
END;
/

-- Registro 
INSERT INTO MetodosPago (MetodoPago)
VALUES ('Efectivo');
INSERT INTO MetodosPago (MetodoPago)
VALUES ('Tarjeta');
INSERT INTO MetodosPago (MetodoPago)
VALUES ('SINPE');


-- ___________________ Provincias ___________________________

CREATE TABLE Provincias (
  IdProvincia int PRIMARY KEY NOT NULL,
  Provincia varchar(20) NOT NULL
);

CREATE SEQUENCE Seq_Provincias
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Provincias
  BEFORE INSERT ON Provincias
  FOR EACH ROW
BEGIN
  SELECT Seq_Provincias.NEXTVAL INTO :NEW.IdProvincia FROM DUAL;
END;
/

-- Registro
INSERT INTO Provincias (Provincia)
VALUES ('San José');
INSERT INTO Provincias (Provincia)
VALUES ('Alajuela');
INSERT INTO Provincias (Provincia)
VALUES ('Heredia');
INSERT INTO Provincias (Provincia)
VALUES ('Cartago');
INSERT INTO Provincias (Provincia)
VALUES ('Puntarenas');
INSERT INTO Provincias (Provincia)
VALUES ('Guanacaste');
INSERT INTO Provincias (Provincia)
VALUES ('Limón');

-- ___________________ Cantones ___________________________

CREATE TABLE Cantones (
  IdCanton int PRIMARY KEY NOT NULL,
  IdProvincia int NOT NULL, -- FK
  Canton varchar(20) NOT NULL,
  FOREIGN KEY (IdProvincia) REFERENCES Provincias(IdProvincia)
);

CREATE SEQUENCE Seq_Cantones
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Cantones
  BEFORE INSERT ON Cantones
  FOR EACH ROW
BEGIN
  SELECT Seq_Cantones.NEXTVAL INTO :NEW.IdCanton FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Cantones (IdProvincia, Canton)
VALUES (1, 'San José');

-- ___________________ Distritos ___________________________

CREATE TABLE Distritos (
  IdDistrito int PRIMARY KEY NOT NULL,
  IdCanton int NOT NULL, -- FK
  Distrito varchar(20),
  FOREIGN KEY (IdCanton) REFERENCES Cantones(IdCanton)
);

CREATE SEQUENCE Seq_Distritos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Distritos
  BEFORE INSERT ON Distritos
  FOR EACH ROW
BEGIN
  SELECT Seq_Distritos.NEXTVAL INTO :NEW.IdDistrito FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Distritos (IdCanton, Distrito)
VALUES (1, 'Carmen');

-- ___________________ Direcciones ___________________________


CREATE TABLE Direcciones (
  IdDireccion int PRIMARY KEY NOT NULL,
  IdProvincia int NOT NULL, -- FK
  IdCanton int NOT NULL, -- FK
  IdDistrito int NOT NULL, -- FK
  Detalle varchar(100),
  FOREIGN KEY (IdProvincia) REFERENCES Provincias(IdProvincia),
  FOREIGN KEY (IdCanton) REFERENCES Cantones(IdCanton),
  FOREIGN KEY (IdDistrito) REFERENCES Distritos(IdDistrito)
);

CREATE SEQUENCE Seq_Direcciones
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Direcciones
  BEFORE INSERT ON Direcciones
  FOR EACH ROW
BEGIN
  SELECT Seq_Direcciones.NEXTVAL INTO :NEW.IdDireccion FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Direcciones (IdProvincia, IdCanton, IdDistrito, Detalle)
VALUES (1, 1, 1, 'Esta es una direccion de prueba');

-- ___________________ Correos ___________________________

CREATE TABLE Correos (
  IdCorreo int PRIMARY KEY NOT NULL,
  Correo varchar(50) NOT NULL
);

CREATE SEQUENCE Seq_Correos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Correos
  BEFORE INSERT ON Correos
  FOR EACH ROW
BEGIN
  SELECT Seq_Correos.NEXTVAL INTO :NEW.IdCorreo FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Correos (Correo)
VALUES ('prueba@correo.com');

-- ___________________ Telefonos ___________________________

CREATE TABLE Telefonos (
  IdTelefono int PRIMARY KEY NOT NULL,
  Telefono int NOT NULL
);

CREATE SEQUENCE Seq_Telefonos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Telefonos
  BEFORE INSERT ON Telefonos
  FOR EACH ROW
BEGIN
  SELECT Seq_Telefonos.NEXTVAL INTO :NEW.IdTelefono FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Telefonos (Telefono)
VALUES (71048756);

-- ___________________ Productos ___________________________

CREATE TABLE Productos (
  IdProducto int PRIMARY KEY NOT NULL,
  Nombre varchar(20) NOT NULL,
  Marca varchar(20) NOT NULL,
  Descripcion varchar(40) NOT NULL,
  PrecioVenta int NOT NULL,
  Stock int NOT NULL
);

CREATE SEQUENCE Seq_Productos
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_Productos
  BEFORE INSERT ON Productos
  FOR EACH ROW
BEGIN
  SELECT Seq_Productos.NEXTVAL INTO :NEW.IdProducto FROM DUAL;
END;
/

-- Registro Prueba
INSERT INTO Productos (Nombre, Marca, Descripcion, PrecioVenta, Stock)
VALUES ('Producto1', 'MarcaProducto', 'Descripcion', 2500, 5);

-- ___________________ FacturaVentas ___________________________

CREATE TABLE FacturasVentas (
  IdFacturaV int PRIMARY KEY NOT NULL,
  IdCliente int NOT NULL, -- FK
  IdColab int NOT NULL, -- FK
  IdMetodoPago int NOT NULL, -- FK
  Fecha date DEFAULT SYSDATE NOT NULL,
  Monto decimal(10, 1) NOT NULL,
  Descuento decimal(5, 2) NOT NULL,
  FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
  FOREIGN KEY (IdColab) REFERENCES Colaboradores(IdColab),
  FOREIGN KEY (IdMetodoPago) REFERENCES MetodosPago(IdMetodoPago)
);

CREATE SEQUENCE Seq_FacturasVentas
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_FacturasVentas
  BEFORE INSERT ON FacturasVentas
  FOR EACH ROW
BEGIN
  SELECT Seq_FacturasVentas.NEXTVAL INTO :NEW.IdFacturaV FROM DUAL;
END;
/

-- Insertar un registro en la tabla FacturasVentas
INSERT INTO FacturasVentas (IdCliente, IdColab, IdMetodoPago, Monto, Descuento)
VALUES (1, 1, 1, 100.5, 0.05);

-- ___________________ FacturaCompras _____________________

CREATE TABLE FacturaCompras (
  IdFacturaC int PRIMARY KEY NOT NULL,
  IdColab int NOT NULL, -- FK
  IdProveedor int NOT NULL, -- FK
  IdMetodoPago int NOT NULL, -- FK
  Fecha date DEFAULT SYSDATE NOT NULL,
  Monto decimal(10, 1) NOT NULL,
  Descuento decimal(5, 2) NOT NULL,
  FOREIGN KEY (IdColab) REFERENCES Colaboradores(IdColab),
  FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
  FOREIGN KEY (IdMetodoPago) REFERENCES MetodosPago(IdMetodoPago)
);

CREATE SEQUENCE Seq_FacturaCompras
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE TRIGGER Trg_FacturaCompras
  BEFORE INSERT ON FacturaCompras
  FOR EACH ROW
BEGIN
  SELECT Seq_FacturaCompras.NEXTVAL INTO :NEW.IdFacturaC FROM DUAL;
END;
/

-- Insertar un registro en la tabla FacturaCompras
INSERT INTO FacturaCompras (IdColab, IdProveedor, IdMetodoPago, Monto, Descuento)
VALUES (1, 1, 1, 100.5, 0.05);
select * from facturacompras;

-- ================================================================
-- ======================   Tablas de Apoyo =======================
-- ================================================================

-- ___________________ Direcciones_Clientes ___________________________

CREATE TABLE Direcciones_Clientes (
  IdCliente int,
  IdDireccion int,
  FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
  FOREIGN KEY (IdDireccion) REFERENCES Direcciones(IdDireccion)
);

-- ___________________ Correos_Clientes ___________________________

CREATE TABLE Correos_Clientes (
  IdCliente int,
  IdCorreo int,
  FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
  FOREIGN KEY (IdCorreo) REFERENCES Correos(IdCorreo)
);

-- ___________________ Telefonos_Clientes ___________________________

CREATE TABLE Telefonos_Clientes (
  IdCliente int,
  IdTelefono int,
  FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente),
  FOREIGN KEY (IdTelefono) REFERENCES Telefonos(IdTelefono)
);

-- ___________________ Direcciones_Colaboradores ___________________________

CREATE TABLE Direcciones_Colaboradores (
  IdColab int,
  IdDireccion int,
  FOREIGN KEY (IdColab) REFERENCES Colaboradores(IdColab),
  FOREIGN KEY (IdDireccion) REFERENCES Direcciones(IdDireccion)
);

-- ___________________ Correos_Colaboradores ___________________________

CREATE TABLE Correos_Colaboradores (
  IdColab int,
  IdCorreo int,
  FOREIGN KEY (IdColab) REFERENCES Colaboradores(IdColab),
  FOREIGN KEY (IdCorreo) REFERENCES Correos(IdCorreo)
);

-- ___________________ Telefonos_Colaboradores ___________________________

CREATE TABLE Telefonos_Colaboradores (
  IdColab int,
  IdTelefono int,
  FOREIGN KEY (IdColab) REFERENCES Colaboradores(IdColab),
  FOREIGN KEY (IdTelefono) REFERENCES Telefonos(IdTelefono)
);


-- ___________________ Direcciones_Proveedores ___________________________

CREATE TABLE Direcciones_Proveedores (
  IdProveedor int,
  IdDireccion int,
  FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
  FOREIGN KEY (IdDireccion) REFERENCES Direcciones(IdDireccion)
);

-- ___________________ Correos_Proveedores ___________________________
CREATE TABLE Correos_Proveedores (
  IdProveedor int,
  IdCorreo int,
  FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
  FOREIGN KEY (IdCorreo) REFERENCES Correos(IdCorreo)
);

-- ___________________ Telefonos_Proveedores ___________________________

CREATE TABLE Telefonos_Proveedores (
  IdProveedor int,
  IdTelefono int,
  FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
  FOREIGN KEY (IdTelefono) REFERENCES Telefonos(IdTelefono)
);

-- ___________________ Productos_Proveedores ___________________________

CREATE TABLE Productos_Proveedor (
  IdProveedor int,
  IdProducto int,
  PrecioCompra int,
  FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
  FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

-- ___________________ Factura_ProductosVentas _________________________

CREATE TABLE Factura_ProductosVentas (
  IdFacturaV int,
  IdProducto int,
  Cantidad int,
  Precio int,
  FOREIGN KEY (IdFacturaV) REFERENCES FacturasVentas(IdFacturaV),
  FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

-- ___________________ Factura_ProductosCompras _______________________

CREATE TABLE Factura_ProductosCompras (
  IdFacturaC int,
  IdProducto int,
  Cantidad int,
  Precio int,
  FOREIGN KEY (IdFacturaC) REFERENCES FacturaCompras(IdFacturaC),
  FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);


-- ________________ COMMIT _____________________

COMMIT;

