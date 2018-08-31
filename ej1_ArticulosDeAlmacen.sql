-- crear base de datos
create database ej1_ArticulosDeAlmacen;

-- usar la base de datos
use ej1_ArticulosDeAlmacen;

-- crear tablas
create table almacen
(
	nro int not null,
	responsable varchar(50) not null,
	primary key(nro)
);

create table articulo
(
	codArt int not null,
	descripcion varchar(50) not null,
	precio float not null,
	primary key(codArt)
);

create table material
(
	codMat int not null,
	descripcion varchar(50) not null,
	primary key(codMat)
);

create table proveedor
(
	codProv int not null,
	nombre varchar(50) not null,
	domicilio varchar(50) not null,
	ciudad varchar(50) not null,
	primary key(codProv)
);

create table tiene
(
	nro int not null,
	codArt int not null,
	primary key(nro, codArt),
	foreign key(nro) references almacen(nro),
	foreign key(codArt) references articulo(codArt)
);

create table compuesto_por
(
	codArt int not null,
	codMat int not null,
	primary key(codArt, codMat),
	foreign key(codArt) references articulo(codArt),
	foreign key(codMat) references material(codMat)
);

create table provisto_por
(
	codMat int not null,
	codProv int not null,
	primary key(codMat, codProv),
	foreign key(codMat) references material(codMat),
	foreign key(codProv) references proveedor(codProv)
);

-- cargar registros en tabla almacen
insert into almacen(nro, responsable) values
(1, 'Chino'),
(2, 'Don Manuel'),
(3, 'Kuki'),
(4, 'Tuerto'),
(5, 'Joaquín');

select * from almacen;

-- cargar registros en tabla articulo
insert into articulo(codArt, descripcion, precio) values
(1,'Pan lactal Bimbo chico', 30),
(2,'Arvejas Marolio', 12),
(3,'Arroz Gallo extrafino', 18),
(4,'Cerveza Quilmes', 32),
(5,'Leche La Serenísima', 25);

select * from articulo;

-- cargar registros en tabla material
insert into material(codMat, descripcion) values
(1, 'Harina'),
(2, 'Levadura'),
(3, 'Leche pasteurizada'),
(4, 'Hierro'),
(5, 'Zinc');

select * from material;

-- cargar registros en tabla proveedor
insert into proveedor(codProv, nombre, domicilio, ciudad) values
(1, 'Panaderia Adrián', 'Spiro 5623', 'Laferrere'),
(2, 'Marolio', 'Artigas 5689', 'La Plata'),
(3, 'La Serenísima', 'Echeverría 6899', 'Longchamps'),
(4, 'Quilmes', 'Figueroa 4744', 'Quilmes'),
(5, 'Bimbo', 'Lautaro Gutiérrez 1657', 'Martínez'),
(6, 'Gallo', 'Puerto Mexico 2625', 'Gral. Rodríguez');

select * from proveedor;

-- cargar registros en tabla tiene
insert into tiene(nro, codArt) values
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 2),
(2, 5),
(4, 2),
(4, 3),
(4, 5),
(5, 4),
(5, 5);

select * from tiene;

-- cargar registros en tabla compuesto_por
insert into compuesto_por(codArt, codMat) values
(1, 1),
(1, 2),
(1, 5),
(3, 3),
(5, 3),
(5, 4),
(5, 5);

select * from compuesto_por;

-- cargar registros en tabla provisto_por
insert into provisto_por(codMat, codProv) values
(1, 1),
(1, 2),
(1, 3),
(2, 2),
(3, 5);

select * from provisto_por;

-- concultas
-- algunas consultas piden que el código de artículo sea una letra
-- pero en la tabla este dato fue definido como int, así que dará error

-- 1
select p.nombre from proveedor p where p.ciudad = 'La Plata';

-- 2
select a.codArt from articulo a where a.precio < 10;

-- 3
select a.responsable from almacen a;

-- 4
select pp10.codMat from provisto_por pp10 where pp10.codProv = 10
and not exists(
select pp15.codMat from provisto_por pp15 where pp15.codProv = 15
);

-- 5
select t.nro from tiene t where t.codArt = 'A';

-- 6
select p.codProv from proveedor p
where p.ciudad = 'Pergamino' and p.nombre = 'Pérez';

-- 7
select t1.nro from tiene t1 where t1.codArt = 'A'
and exists(
select t2.nro from tiene t2 where t2.codArt = 'B'
);

-- 7
select distinct t1.nro from tiene t1, tiene t2
where t1.codArt = 'A' and t2.codArt = 'B';

-- 8
select a.codArt from articulo a, compuesto_por cp
where (a.precio > 100 or cp.codMat = '1') and a.codArt = cp.codArt;

-- 8
select a.codArt from articulo a
inner join compuesto_por cp on a.codArt = cp.codArt
where a.precio > 100 or cp.codMat = '1';

-- 9
select m.codMat, m.descripcion from material m
inner join provisto_por pp on m.codMat = pp.codMat
inner join proveedor p on pp.codProv = p.codProv
where p.ciudad = 'Rosario';

-- 10
select a.* from tiene t
inner join articulo a on t.codArt = a.codArt
where t.nro = '1';

-- 11
select m.descripcion from material m
inner join compuesto_por cp on m.codMat = cp.codMat
where cp.codArt = 'B';

-- 12
select p.nombre from proveedor p
inner join provisto_por pp on p.codProv = pp.codProv
inner join compuesto_por cp on pp.codMat = cp.codMat
inner join tiene t on cp.codArt = t.codArt
inner join almacen a on t.nro = a.nro
where a.responsable = 'Martín Gómez';

-- 13
select a.codArt, a.descripcion from articulo a
inner join compuesto_por cp on a.codArt = cp.codArt
inner join provisto_por pp on cp.codMat = pp.codMat
inner join proveedor p on pp.codProv = p.codProv
where p.nombre = 'López';

-- 14
select p.codProv, p.nombre from proveedor p
inner join provisto_por pp on p.codProv = pp.codProv
inner join compuesto_por cp on pp.codMat = cp.codMat
inner join articulo a on cp.codArt = a.codArt
where a.precio > 100;

-- 15
select distinct a1.nro from almacen a1
where not exists (
	select a2.nro, art.codArt from almacen a2, articulo art
	where not exists (
		select t.* from tiene t
		left join compuesto_por cp on t.codArt = cp.codArt
		where cp.codMat = 123
	)
);

-- 16
select distinct pp.codProv from provisto_por pp
inner join (
	select pp.codMat from provisto_por pp
	group by pp.codMat having count(pp.codMat) = 1
) matUnicoProv
on pp.codMat = matUnicoProv.codMat
inner join proveedor p on pp.codProv = p.codProv
where p.ciudad = 'Capital Federal';

-- 17
select a.codArt from articulo a
where not exists (
	select a1.codArt from articulo a1, articulo a2
	where a1.precio < a2.precio
);

-- 18
select a.codArt from articulo a
where not exists (
	select a1.codArt from articulo a1, articulo a2
	where a1.precio > a2.precio
);

-- 19
select a.nro, avg(art.precio) as promedio_de_precios from almacen a
inner join tiene t on a.nro = t.nro
inner join articulo art on t.codArt = art.codArt
group by a.nro;

-- 20
select t1.nro from tiene t1
group by t1.nro having(
	count(t1.codArt) = (
		select max(articulosEnAlmacen.cantidad)
		from (
			select t.nro, count(t.codArt) as cantidad
			from tiene t group by t.nro
		) articulosEnAlmacen
	)
);

-- 21
select cp.codArt from compuesto_por cp
group by cp.codArt
having(count(cp.codMat) >= 2);

-- 22
select cp.codArt from compuesto_por cp
group by cp.codArt
having(count(cp.codMat) = 2);

-- 23
select cp.codArt from compuesto_por cp
group by cp.codArt
having(count(cp.codMat) <= 2);

-- 24
select cp.codArt from compuesto_por cp
group by cp.codArt
having(count(cp.codMat) = (
	select count(distinct m.codMat) from material m)
);

-- 25
select distinct p.ciudad from proveedor p
inner join provisto_por pp on p.codProv = pp.codProv
group by p.codProv, p.ciudad
having(count(pp.codMat) = (
	select count(distinct m.codMat) from material m)
);
