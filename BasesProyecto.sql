-- Crear las tablas de Proveedor que ya está en 3FN
-- Se crea después de crear las tablas con relaciones
create table Proveedor(
	Id_Proveedor varchar(50) primary key,
	Contacto varchar(50),
	Id_direccion varchar(50),
	foreign key (Contacto) references Contacto_Proveedor (Contacto) on delete cascade on update cascade,
	foreign key (Id_direccion) references Direccion_Proveedor (Id_direccion) on delete cascade on update cascade
);
--Se crea primero esta
create table Producto_Proveedor(
	Id_Proveedor varchar(50),
	Id_Producto varchar(50),
	Tipo_prenda varchar(50),
	Precio_unidad int,
	primary key(Id_Proveedor, Id_Producto), -- clave compuesta
	foreign key (Id_Proveedor) references Proveedor(Id_proveedor) on delete cascade on update cascade
);
--Se crea primero esta
create table Contacto_Proveedor(
	Contacto varchar(50) primary key,
	Nombre varchar(50),
	telefono int,
	Correo_Electronico varchar(50)
);
-- Se crea normal
create table Direccion_Proveedor(
	Id_direccion varchar(50) primary key,
	Ciudad varchar(30),
	Tipo_via varchar(10),
	#_via varchar(5),
	Nomenclatura varchar(20)
);

--Elimar tablas por si acaso
DROP TABLE IF EXISTS Producto_Proveedor;
DROP TABLE IF EXISTS Proveedor;
DROP TABLE IF EXISTS Direccion_Proveedor;
DROP TABLE IF EXISTS Contacto_Proveedor;

-- Para cambiar el tipo de dato de una tabla
ALTER TABLE Contacto_Proveedor 
ALTER COLUMN Telefono BIGINT;

-- Comando para eliminar filas de las tablas
delete from Contacto_Proveedor
where Contacto = 'C001';
delete from Direccion_Proveedor
where Id_direccion = 'D001';
delete from Proveedor
where Id_Proveedor = 'P001';
delete from Producto_Proveedor
where Id_Proveedor = 'P001';
--

-- Revisar las tablas
select * from Contacto_Proveedor;
select * from Proveedor;
select * from Direccion_Proveedor;
select * from Producto_Proveedor;


-- Inserción de datos

INSERT INTO Contacto_Proveedor(Contacto,Nombre,Telefono,Correo_Electronico)
VALUES 
	('CONT_01', 'Alejandro Martinez', 3106091050, 'alejandroproveedor@gmail.com'),
	('CONT_02', 'Felipe Miranda', 3146776365, 'felipeproveedor@gmail.com'),
	('CONT_03', 'Andres Garzon', 3205169913, 'andresproveedor@gmail.com'),
	('CONT_04', 'Angel Rojas', 3167843083, 'angelproveedor@gmail.com'),
	('CONT_05', 'Kevin Ramos', 3102680397, 'kevinproveedor@gmail.com')
	;


INSERT INTO Direccion_Proveedor (Id_direccion, Ciudad, Tipo_via, #_via, Nomenclatura)
VALUES 
	('DIR01', 'Medellín', 'Calle','1','#12-54'),
	('DIR02', 'Bogotá', 'Calle','2', '#56-78'),
	('DIR03', 'Cali', 'Carrera', '45','#22-10'),
	('DIR04', 'Medellín', 'Avenida','10', '#15-20'),
	('DIR05', 'Barranquilla', 'Carrera','50', '#10-25')
	;

INSERT INTO Proveedor (Id_Proveedor, Contacto, Id_direccion)
VALUES 
	('PR001', 'CONT_01', 'DIR01'),
	('PR002', 'CONT_02', 'DIR02'),
	('PR003', 'CONT_03', 'DIR03'),
	('PR004', 'CONT_04', 'DIR04'),
	('PR005', 'CONT_05', 'DIR05')
	;

INSERT INTO Producto_Proveedor (Id_Proveedor, Id_Producto, Tipo_prenda, Precio_unidad)
VALUES 
	('PR001', 'PROD_001', 'Camisas', 20000),
	('PR002', 'PROD_002', 'Tangas', 7000),
	('PR003', 'PROD_003', 'Tenis', 60000),
	('PR004', 'PROD_004', 'Collares', 15000),
	('PR005', 'PROD_005', 'Brasieres', 8000)
	;

-- Ver los datos

SELECT p.Id_Proveedor, c.Nombre, d.Ciudad, d.Nomenclatura
FROM Proveedor p
JOIN Contacto_Proveedor c ON p.Contacto = c.Contacto
JOIN Direccion_Proveedor d ON p.Id_direccion = d.Id_direccion;

SELECT pp.Id_Producto, pp.Tipo_prenda, pp.Precio_unidad
FROM Producto_Proveedor pp
WHERE pp.Id_Proveedor = 'PR001';

-- ############################################################################################################################################################################

-- Crear las tablas de Compra que ya está en 3FN

--Elimar tablas por si acaso
DROP TABLE IF EXISTS Compra;
DROP TABLE IF EXISTS Productos_comprados;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Realiza_compra;
DROP TABLE IF EXISTS Cliente;


create table Compra(
	Id_compra varchar(50) primary key,
	Fecha date,
	Id_cliente int,
	Total_venta float,
	foreign key (Id_cliente) references Realiza_compra(Cliente) on delete cascade on update cascade
);

create table Productos_comprados(
	Id_compra varchar(50),
	Id_producto varchar(50),
	Cantidades smallint,
	primary key (Id_compra, Id_producto),
	foreign key (Id_producto) references Productos(Id_producto) on delete cascade on update cascade,
	foreign key (Id_compra) references Compra(Id_compra) on delete cascade on update cascade
);

create table Productos(
	Id_producto varchar(50) primary key,
	Nombre_producto varchar(50),
	Precio_unitario float
);

create table Realiza_compra(
	Cliente int primary key,
	Id_cliente varchar(50),
);

-- Settear valores
INSERT INTO Compra(Id_compra, Fecha, Id_cliente,Total_venta)
VALUES 
	('VNT001', '2024-10-28', 1,225000),
	('VNT002', '2024-11-11', 2,340000),
	('VNT003', '2024-12-02', 3,325000),
	('VNT004', '2024-12-02', 4,410000),
	('VNT005', '2024-12-05', 5,215000)
	;
select * from Compra;

insert into Productos_comprados(Id_compra,Id_producto,Cantidades)
values
	('VNT001','PROD_001',3),
	('VNT001','PROD_005',2),
	('VNT001','PROD_002',5),
	('VNT002','PROD_001',1),
	('VNT002','PROD_003',1),
	('VNT002','PROD_006',3),
	('VNT002','PROD_010',2),
	('VNT003','PROD_004',1),
	('VNT003','PROD_009',2),
	('VNT004','PROD_003',2),
	('VNT004','PROD_007',2),
	('VNT004','PROD_008',1),
	('VNT005','PROD_008',1),
	('VNT005','PROD_009',1),
	('VNT005','PROD_005',1),
	('VNT005','PROD_002',1),
	('VNT005','PROD_006',1)
	;
select * from Productos_comprados;

insert into Productos(Id_producto,Nombre_producto,Precio_unitario)
values
	('PROD_001','Camisa',40000),
	('PROD_002','Tanga',15000),
	('PROD_003','Tenis',120000),
	('PROD_004','Collar',35000),
	('PROD_005','Brasier',15000),
	('PROD_006','Short',20000),
	('PROD_007','Pantalon',75000),
	('PROD_008','Falda',20000),
	('PROD_009','Vestido',145000),
	('PROD_010','Leggins',60000)
	;
select * from Productos;

insert into Realiza_compra(Cliente,Id_cliente)
values
	(1,1206904821),
	(2,1007841324),
	(3,40788615),
	(4,110888371),
	(5,100075084)
	;
select * from Realiza_compra;

-- Tabla para Cliente

create table Cliente(
	Id_cliente varchar(50) primary key,
	Nombre varchar(50),
	Apellido varchar(50)
);

insert into Cliente(Id_cliente,Nombre,Apellido)
values
	(10007841324,'Maria','Luna'),
	(110888371,'Carlos','Muñoz'),
	(40788615,'Miguel','Martinez'),
	(100075084,'Angel','Sierra'),
	(1206904821,'Sandra','Pimienta')
	;
select * from Cliente;

-- Pruebas - Productos comprados relacionados con compras y productos
SELECT 
    pc.Id_compra, 
    c.Fecha, 
    c.Total_venta, 
    p.Nombre_producto, 
    pc.Cantidades, 
    p.Precio_unitario
FROM Productos_comprados pc
INNER JOIN Compra c ON pc.Id_compra = c.Id_compra
INNER JOIN Productos p ON pc.Id_producto = p.Id_producto;

-- Pruebas - Compras realcionadas con Clientes 
SELECT 
    c.Id_compra, 
    c.Fecha, 
    c.Total_venta, 
    r.Id_cliente, 
    cl.Nombre, 
    cl.Apellido
FROM Compra c
INNER JOIN Realiza_compra r ON c.Id_cliente = r.Cliente
INNER JOIN Cliente cl ON r.Id_cliente = cl.Id_cliente;

-- Suma total de ventas por cliente
SELECT 
    cl.Id_cliente, 
    cl.Nombre, 
    cl.Apellido, 
    SUM(c.Total_venta) AS Total_Gastado
FROM Cliente cl
INNER JOIN Realiza_compra r ON cl.Id_cliente = r.Id_cliente
INNER JOIN Compra c ON r.Cliente = c.Id_cliente
GROUP BY cl.Id_cliente, cl.Nombre, cl.Apellido;

-- Cantidad total de cada producto vendido
SELECT 
    p.Id_producto, 
    p.Nombre_producto, 
    SUM(pc.Cantidades) AS Total_Vendido
FROM Productos_comprados pc
INNER JOIN Productos p ON pc.Id_producto = p.Id_producto
GROUP BY p.Id_producto, p.Nombre_producto;

-- Productos vendidos en una compra específica
SELECT 
    pc.Id_compra, 
    p.Nombre_producto, 
    pc.Cantidades, 
    p.Precio_unitario
FROM Productos_comprados pc
INNER JOIN Productos p ON pc.Id_producto = p.Id_producto
WHERE pc.Id_compra = 'VNT001';

--Todas las compras realizadas por un cliente específico
SELECT 
    cl.Nombre, 
    cl.Apellido, 
    c.Id_compra, 
    c.Fecha, 
    c.Total_venta
FROM Cliente cl
INNER JOIN Realiza_compra r ON cl.Id_cliente = r.Id_cliente
INNER JOIN Compra c ON r.Cliente = c.Id_cliente
WHERE cl.Nombre = 'Sandra' AND cl.Apellido = 'Pimienta';

-- Compras sin cliente asociado
SELECT *
FROM Compra
WHERE Id_cliente NOT IN (SELECT Cliente FROM Realiza_compra);

-- ########################################################################################################################################################################

-- Tabla para Producto 

-- Eliminar por si acaso
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Caracteristicas_producto;
DROP TABLE IF EXISTS Identificador_color;
DROP TABLE IF EXISTS Identificador_talla;
DROP TABLE IF EXISTS Categorias;

create table Producto(
	Id_producto varchar(50),
	Id_categoria varchar(50),
	Stock int,
	Precio float,
	foreign key (Id_producto) references Caracteristicas_producto(Id_producto) on delete cascade on update cascade,
	foreign key (Id_categoria) references Categorias(Id_categoria) on delete cascade on update cascade
);

create table Caracteristicas_producto(
	Id_producto varchar(50) primary key,
	Nombre varchar(50),
	Color_id int,
	Talla_id int,
	foreign key (Color_id) references Identificador_color(Color_id) on delete cascade on update cascade,
	foreign key (Talla_id) references Identificador_talla(Talla_id) on delete cascade on update cascade
);

create table Identificador_color(
	Color_id int primary key,
	Color varchar(50)
);

create table Identificador_talla(
	Talla_id int primary key,
	Talla varchar(50)
);

create table Categorias(
	Id_categoria varchar(50) primary key,
	Categoria varchar(50)
);

-- Settear datos

insert into Categorias(Id_categoria,Categoria)
values
	('CAT_1','Camisas'),
	('CAT_2','Ropa interior'),
	('CAT_3','Calzado'),
	('CAT_4','Accesorios'),
	('CAT_5','Vestidos'),
	('CAT_6','Pantalones')
	;
select * from Categorias;

insert into Identificador_color(Color_id,Color)
values
	(1,'Azul'),
	(2,'Blanco'),
	(3,'Verde'),
	(4,'Escarlata'),
	(5,'Beige'),
	(6,'Rojo'),
	(7,'Rosado'),
	(8,'Gris')
	;
select * from Identificador_color;

insert into Identificador_talla(Talla_id,Talla)
values
	(1,'L'),
	(2,'M'),
	(3,'30'),
	(4,'43'),
	(5,'32'),
	(6,'S'),
	(7,'38')
	;
select * from Identificador_talla;

insert into Caracteristicas_producto(Id_producto,Nombre,Color_id,Talla_id)
values
	('PROD_001','Camisa',1,1),
	('PROD_002','Tanga',2,2),
	('PROD_003','Tenis',3,3),
	('PROD_004','Collar',4,4),
	('PROD_005','Brasier',2,2),
	('PROD_006','Short',2,2),
	('PROD_007','Pantalon',5,5),
	('PROD_008','Falda',6,1),
	('PROD_009','Vestido',7,6),
	('PROD_010','Leggins',8,7)
	;
select * from Caracteristicas_producto;

insert into Producto(Id_producto,Id_categoria,Stock,Precio)
values
	('PROD_001','CAT_1',40,40000),
	('PROD_002','CAT_2',40,40000),
	('PROD_003','CAT_3',10,40000),
	('PROD_004','CAT_4',15,40000),
	('PROD_005','CAT_2',40,40000),
	('PROD_006','CAT_6',20,40000),
	('PROD_007','CAT_6',35,40000),
	('PROD_008','CAT_6',45,40000),
	('PROD_009','CAT_5',15,40000),
	('PROD_010','CAT_6',15,60000)
	;
select * from Producto;

-- Verificar integridad

-- Productos con sus características completas
SELECT 
    p.Id_producto, 
    c.Nombre AS Nombre_producto, 
    ic.Color, 
    it.Talla, 
    p.Stock, 
    p.Precio
FROM Producto p
INNER JOIN Caracteristicas_producto c ON p.Id_producto = c.Id_producto
INNER JOIN Identificador_color ic ON c.Color_id = ic.Color_id
INNER JOIN Identificador_talla it ON c.Talla_id = it.Talla_id;

-- Productos con sus categorias
SELECT 
    p.Id_producto, 
    c.Nombre AS Nombre_producto, 
    cat.Categoria
FROM Producto p
INNER JOIN Caracteristicas_producto c ON p.Id_producto = c.Id_producto
INNER JOIN Categorias cat ON p.Id_categoria = cat.Id_categoria;

-- Total stock por categoria
SELECT 
    cat.Categoria, 
    SUM(p.Stock) AS Total_Stock
FROM Producto p
INNER JOIN Categorias cat ON p.Id_categoria = cat.Id_categoria
GROUP BY cat.Categoria;

-- Productos por color
SELECT 
    ic.Color, 
    COUNT(c.Id_producto) AS Total_Productos
FROM Caracteristicas_producto c
INNER JOIN Identificador_color ic ON c.Color_id = ic.Color_id
GROUP BY ic.Color;

-- Productos por talla
SELECT 
    it.Talla, 
    COUNT(c.Id_producto) AS Total_Productos
FROM Caracteristicas_producto c
INNER JOIN Identificador_talla it ON c.Talla_id = it.Talla_id
GROUP BY it.Talla;

-- Productos con bajo stock (<20)
SELECT 
    p.Id_producto, 
    c.Nombre AS Nombre_producto, 
    p.Stock, 
    p.Precio
FROM Producto p
INNER JOIN Caracteristicas_producto c ON p.Id_producto = c.Id_producto
WHERE p.Stock < 20;

-- Detalle completo de un producto en específico
SELECT 
    p.Id_producto, 
    c.Nombre AS Nombre_producto, 
    ic.Color, 
    it.Talla, 
    cat.Categoria, 
    p.Stock, 
    p.Precio
FROM Producto p
INNER JOIN Caracteristicas_producto c ON p.Id_producto = c.Id_producto
INNER JOIN Identificador_color ic ON c.Color_id = ic.Color_id
INNER JOIN Identificador_talla it ON c.Talla_id = it.Talla_id
INNER JOIN Categorias cat ON p.Id_categoria = cat.Id_categoria
WHERE p.Id_producto = 'PROD_007';

-- #################################################################################################################################################################################


-- Tablas en 3FN de Recibo de abastecimiento

-- Eliminar por si acaso
DROP TABLE IF EXISTS Recibo_proveedor;
DROP TABLE IF EXISTS Recibo_de_abastecimiento;
DROP TABLE IF EXISTS Precios_unidad;
DROP TABLE IF EXISTS Identificacion_proveedor;


create table Recibo_proveedor(
	Id_recibo varchar(50),
	Proveedor int,
	Cantidad_encargada int,
	Fecha_envio date,
	Fecha_recepcion date,
	foreign key (Id_recibo) references Recibo_de_abastecimiento(Id_recibo) on delete cascade on update cascade,
	foreign key (Proveedor) references Identificacion_proveedor(Proveedor) on delete cascade on update cascade
);

create table Recibo_de_abastecimiento(
	Id_recibo varchar(50) primary key,
	Precio_total float,
);

create table Precios_unidad(
	Id_proveedor int,
	Precio_unidad float
	foreign key (Id_proveedor) references Identificacion_proveedor(Proveedor) on delete cascade on update cascade
);

create table Identificacion_proveedor(
	Proveedor int primary key,
	Id_proveedor varchar(50)
);

-- Settear datos

insert into Identificacion_proveedor(Proveedor,Id_proveedor)
values
	(1,'PR001'),
	(2,'PR002'),
	(3,'PR003'),
	(4,'PR004'),
	(5,'PR005')
	;
SELECT * FROM Identificacion_proveedor;

insert into Precios_unidad(Id_proveedor,Precio_unidad)
values
	(1,20000),
	(1,20000),
	(2,70000),
	(3,60000),
	(3,60000),
	(4,15000),
	(5,8000),
	(5,8000),
	(5,8000)
	;
select * from Precios_unidad;

insert into Recibo_de_abastecimiento(Id_recibo,Precio_total)
values
	('0624PR1',400000),
	('0625PR1',400000),
	('0524PR2',105000),
	('0824PR3',1800000),
	('0825PR3',1800000),
	('0924PR4',150000),
	('0624PR5',400000),
	('0625PR5',400000),
	('0626PR5',400000)
	;
select * from Recibo_de_abastecimiento;

insert into Recibo_proveedor(Id_recibo,Proveedor,Cantidad_encargada,Fecha_envio,Fecha_recepcion)
values
	('0624PR1',1,20,'2024-06-21','2024-06-26'),
	('0625PR1',1,20,'2024-06-23','2024-06-28'),
	('0524PR2',2,15,'2024-05-10','2024-05-16'),
	('0824PR3',3,30,'2024-08-09','2024-08-20'),
	('0825PR3',3,30,'2024-09-09','2024-09-28'),
	('0924PR4',4,10,'2024-09-17','2024-09-20'),
	('0624PR5',5,50,'2024-06-21','2024-06-26'),
	('0625PR5',5,50,'2024-06-30','2024-07-04'),
	('0626PR5',5,50,'2024-07-15','2024-07-25')
	;
select * from Recibo_proveedor;

-- Pruebas de integridad referencial

-- proveedores y sus recibos
SELECT rp.Id_recibo, rp.Proveedor, ip.Id_proveedor 
FROM Recibo_proveedor rp
JOIN Identificacion_proveedor ip ON rp.Proveedor = ip.Proveedor;

-- Precios unitarios de cada proveedor
SELECT pu.Id_proveedor, ip.Id_proveedor, pu.Precio_unidad
FROM Precios_unidad pu
JOIN Identificacion_proveedor ip ON pu.Id_proveedor = ip.Proveedor;

-- Recibos y precios totales
SELECT ra.Id_recibo, ra.Precio_total, rp.Cantidad_encargada
FROM Recibo_de_abastecimiento ra
JOIN Recibo_proveedor rp ON ra.Id_recibo = rp.Id_recibo;

-- Proveedores con múltiples recibos
SELECT ip.Id_proveedor, COUNT(rp.Id_recibo) AS Recibos_totales
FROM Identificacion_proveedor ip
JOIN Recibo_proveedor rp ON ip.Proveedor = rp.Proveedor
GROUP BY ip.Id_proveedor;

-- Total de productos encargados por proveedor
SELECT ip.Id_proveedor, SUM(rp.Cantidad_encargada) AS Total_encargado
FROM Identificacion_proveedor ip
JOIN Recibo_proveedor rp ON ip.Proveedor = rp.Proveedor
GROUP BY ip.Id_proveedor;

-- Recibos enviados y recibidos en un rango de fechas
SELECT *
FROM Recibo_proveedor
WHERE Fecha_envio BETWEEN '2024-06-01' AND '2024-07-01';

--Recibos con un precio total mayor a un valor específico
SELECT ra.Id_recibo, ra.Precio_total
FROM Recibo_de_abastecimiento ra
WHERE ra.Precio_total > 300000;
