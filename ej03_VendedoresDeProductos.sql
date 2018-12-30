-- crear base de datos
CREATE DATABASE ej3_vendedoresDeProductos;

-- usar la base de datos
USE ej3_vendedoresDeProductos;

-- crear tablas
CREATE TABLE Proveedor
(
	 Id_proveedor INT,
	 Nombre VARCHAR(50),
	 Responsabilidad_civil VARCHAR(50),
	 Cuit BIGINT,
	 PRIMARY KEY(id_proveedor)
);

CREATE TABLE Producto
(
	 Id_producto INT,
	 Nombre VARCHAR(50),
	 Descripcion VARCHAR(50),
	 Estado VARCHAR(50),
	 Id_proveedor INT,
	 PRIMARY KEY(id_producto),
	 FOREIGN KEY(id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE Cliente
(
	 Id_cliente INT,
	 Nombre VARCHAR(50),
	 Resp_iva VARCHAR(50),
	 Cuit BIGINT,
	 PRIMARY KEY(id_cliente)
);

CREATE TABLE Direccion
(
	 Id_dir INT,
	 Id_pers INT,
	 Calle VARCHAR(100),
	 nro INT,
	 piso INT,
	 dpto CHAR,
	 PRIMARY KEY(id_dir),
	 FOREIGN KEY(id_pers) REFERENCES cliente(id_cliente)
);

CREATE TABLE Vendedor
(
	 Id_vendedor INT,
	 Nombre VARCHAR(50),
	 Apellido VARCHAR(50),
	 Dni BIGINT,
	 PRIMARY KEY(id_vendedor)
);

CREATE TABLE Venta
(
	 Nro_factura BIGINT,
	 Id_cliente INT,
	 Id_vendedor INT,
	 Fecha DATE ,
	 PRIMARY KEY(nro_factura),
	 FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
	 FOREIGN KEY(id_vendedor) REFERENCES vendedor(id_vendedor)
);

CREATE TABLE Detalle_venta
( 
	Nro_factura BIGINT,
	Nro_detalle BIGINT,
	Id_producto INT,
	Cantidad INT,
	Precio_unitario INT,
	PRIMARY KEY(nro_factura, nro_detalle),
	FOREIGN KEY(nro_factura)REFERENCES venta(nro_factura),
	FOREIGN KEY(id_producto)REFERENCES producto(id_producto)
); 

-- cargar registros en las tablas
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(1, 'Juan','123qw',3095513451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(2, 'Hernan','143qw',3325513451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(3, 'Sergio','163qw',30953243451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(4, 'Jesica','183qw',3095223451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(5, 'Fernando','1893qw',30946783451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit) 
VALUES(6, 'Esteban','1673qw',3095456451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(7, 'Gustavo','1793qw',3326423451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(8, 'Ruben','1676w',309234243451);
INSERT INTO Cliente (id_cliente, nombre,resp_iva,cuit)
VALUES(9, 'Ariel','18378',3097788451);

SELECT * FROM Cliente;

INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (1, 1, 'Villegas','1780',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (2, 1, 'Aquino','1790','3','B');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (3, 1, 'Morlaco','1250','7','A');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (4, 1, 'Fornuloco','8980',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (5, 1, 'Galmarini','280','3','C');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (6, 1, 'Leandro Alem','80',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (7, 1, 'Santa Rosa','180','8','D');
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (8, 1, 'Budaguest','10',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (9, 1, 'Rivadavia','3520',null,null);
INSERT INTO Direccion (Id_dir, Id_pers, calle,nro,piso,dpto)
VALUES (10, 1, 'Rolchart','2580',null,null);

SELECT * FROM Direccion;

INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(1,'Ricardo','223qw',3094413451);
INSERT INTO Proveedor (Id_proveedor, nombre,responsabilidad_civil,cuit)
VALUES(2,'Daniel','223qw',3094413451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(3,'Ines','243qw',3324413451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(4,'Nancy','263qw',30943243451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(5,'Jesica','283qw',3094223451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(6,'Fernando','2893qw',30944583451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(7,'Esteban','2673qw',3095546451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(8,'Gustavo','2793qw',3426423451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(9,'Ruben','2676w',329234243451);
INSERT INTO Proveedor (Id_proveedor,nombre,responsabilidad_civil,cuit)
VALUES(10,'Ariel','28378',3297788451);

SELECT * FROM Proveedor;

INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(1, 1,'goma','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(2, 2, 'libro','libreria','sin stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(3, 3,'hojas','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(4, 2,'birome','libreria','sin stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(5, 3,'lapicera','libreria','sin stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado) 
VALUES(6, 3,'cuaderno','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(7, 4,'clip','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(8, 5,'cartuchera','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(9, 6,'carpeta','libreria','stock');
INSERT INTO Producto (Id_producto, Id_proveedor,nombre,descripcion,estado)
VALUES(10,7, 'secante','libreria','stock');

SELECT * FROM Producto;

INSERT INTO Vendedor
VALUES (1, 'Sergio', 'Adamoli', 35204761);
INSERT INTO Vendedor 
VALUES (2, 'hernan', 'Bruno', 32204761);
INSERT INTO Vendedor 
VALUES (5, 'jesica', 'Sieiro', 31204761);
INSERT INTO Vendedor 
VALUES (6, 'Roberto', 'Granja', 34204761);
INSERT INTO Vendedor 
VALUES (7, 'Gustavo', 'Fornica', 45204761);
INSERT INTO Vendedor 
VALUES (8, 'Ariel', 'Zerpa', 25204761);
INSERT INTO Vendedor 
VALUES (9, 'Rafael', 'Miceli', 55204761);
INSERT INTO Vendedor 
VALUES (10, 'Daniel', 'Bustamante',35204661);
INSERT INTO Vendedor 
VALUES (11, 'Ingrid', 'Vadala', 35204561);
INSERT INTO Vendedor 
VALUES (12, 'Alberto', 'Fernandez',35204731);

SELECT * FROM Vendedor;

INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (1, 4,2,'2011-06-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (2, 2,2,'2011-05-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (3, 3,5,'2011-04-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (4, 1,6,'2011-03-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (5, 5,7,'2011-02-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (6, 1,8,'2011-01-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (7, 3,9,'2011-07-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (8, 4,10,'2011-08-26');
INSERT INTO Venta (Nro_factura, id_cliente,id_vendedor,fecha)
VALUES (9, 5,11,'2011-09-26');

SELECT * FROM Venta;

INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (1, 1, 1, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (1, 2, 2, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (1, 3, 3, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (2, 1, 4, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (2, 2, 1, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (3, 1, 5, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (4, 1, 6, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle, Id_producto, Cantidad, Precio_unitario )
VALUES (5, 1, 1, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (6, 1, 4, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (7, 1, 1, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (7, 2, 2, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (8, 1, 1, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (9, 1, 3, 10,30);
INSERT INTO Detalle_venta (Nro_factura, Nro_detalle,Id_producto, Cantidad, Precio_unitario )
VALUES (9, 2, 1, 10,30); 
 
SELECT * FROM Detalle_venta;
 
-- consultas

-- 1
select count(*) as cantidadProductos from producto;

-- 2
select count(*) as cantidadProductosEnStock from producto p
where p.estado = 'stock';

-- 3
select p.id_producto as productosNoVendidos from producto p
where not exists(
	select distinct dv.id_producto from detalle_venta dv
);

-- en mysql la diferencia debe hacerse con left outer join
select p.id_producto as productosNoVendidos from producto p
left outer join detalle_venta dv
on p.id_producto = dv.id_producto
where dv.nro_factura is null;

-- 4
select dv.id_producto, sum(dv.cantidad) as unidadesVendidas
from detalle_venta dv
group by dv.id_producto;

-- 5
select dv.id_producto, avg(dv.cantidad) as promedioUnidadesVendidas
from detalle_venta dv
group by dv.id_producto;

-- 6
create view ventasPorVendedor
as
	select v.id_vendedor, count(*) as cantidadVentas
    from venta v
    group by v.id_vendedor;
    
select vv.id_vendedor as vendedorConMasVentas from ventasPorVendedor vv
where vv.cantidadVentas = (
	select max(v.cantidadVentas) from ventasPorVendedor v
);

-- 7
select dv.id_producto
from detalle_venta dv
group by dv.id_producto
having sum(dv.cantidad) > 15000;

-- 8
create view unidadesVendidasPorVendedor
as
	select v.id_vendedor, sum(dv.cantidad) as unidadesVendidas
    from venta v
    inner join detalle_venta dv on v.nro_factura = dv.nro_factura
    group by v.id_vendedor;
    
select vv.id_vendedor as vendedorConMasUnidadesVendidas
from unidadesVendidasPorVendedor vv
where vv.unidadesVendidas = (
	select max(v.unidadesVendidas) from unidadesVendidasPorVendedor v
);

