-- crear base de datos
create database ej5_PrestamoDePeliculas;

-- usar la base de datos
use ej5_PrestamoDePeliculas;

-- crear tablas
create table rubro
(
	codRubro int not null,
	nombRubro varchar(30) not null,
	primary key(codRubro)
);

create table pelicula
(
	codPel int not null,
	titulo varchar(30) not null,
	duracion time not null,
	año int not null,
	codRubro int not null,
	primary key(codPel),
	foreign key(codRubro) references rubro(codRubro)
);

create table ejemplar
(
	codEj int not null,
	codPel int not null,
	estado varchar(10),
	ubicacion varchar(30) not null,
	primary key(codEj, codPel),
	foreign key(codPel) references pelicula(codPel)
);

create table cliente
(
	codCli int not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	direccion varchar(30) not null,
	tel int not null,
	email varchar(40) not null,
	primary key(codCli)
);

create table prestamo
(
	codPrest int not null,
	codEj int not null,
	codPel int not null,
	codCli int not null,
	fechaPrest date not null,
	fechaDev date null,
	primary key(codPrest),
	foreign key(codEj) references ejemplar(codEj),
	foreign key(codPel) references pelicula(codPel),
	foreign key(codCli) references cliente(codCli)
);

-- consultas

-- 1
select distinct pr.codCli
from prestamo pr
inner join pelicula pel on pr.codPel = pel.codPel
inner join rubro r on pel.codRubro = r.codRubro
where r.nombRubro <> 'Policial';

-- 2
create view peliculaDeMayorDuracion
as
	select * from pelicula p
	where p.duracion = (
		select max(pel.duracion)
		from pelicula pel
	);

select pmd.codPel from peliculaDeMayorDuracion pmd
where exists(
	select distinct pr.codPel from prestamo pr
);

-- 3
select pr.codCli, pr.codPel, count(*) as cantidadPrestamos
from prestamo pr
group by pr.codCli, pr.codPel
having count(*) > 1;

-- 4
select distinct pr.codCli
from prestamo pr
inner join pelicula pel on pr.codPel = pel.codPel
where pel.titulo = 'Rey León'
and exists(
	select distinct pr.codCli
	from prestamo pr
	inner join pelicula pel on pr.codPel = pel.codPel
	where pel.titulo = 'Terminator 3'
);

-- 5
create view peliculasVistasPorMes
as
	select pr.codPel, month(pr.fechaPrest) as mes, year(pr.fechaPrest) as año, count(*) as cantidad
	from prestamo pr
	group by pr.codPel, month(pr.fechaPrest), year(pr.fechaPrest);

create view maxCantVistaPorMes
as
	select p.mes, p.año, max(p.cantidad) as cantidad
	from peliculasVistasPorMes p
	group by p.mes, p.año;

select pvm.mes, pvm.año, pvm.cantidad, pvm.codPel
from peliculasVistasPorMes pvm
left join maxCantVistaPorMes mvm
on pvm.mes = mvm.mes
and pvm.año = mvm.año
and pvm.cantidad = mvm.cantidad;

-- 6
select c.codCli from cliente c
where not exists(
	select c.codCli, p.codPel from cliente c, pelicula p
	where not exists(
		select distinct pr.codPel from prestamo pr
	)
);

-- 7
select p.codPel from pelicula p
where not exists(
	select distinct pr.codPel from prestamo pr
);

-- 8
select distinct pr.codPel
from prestamo pr
where pr.fechaDev is null;

-- 9
create view prestamosPorPelicula
as
	select pr.codPel, count(*) as cantidadPrestamos
	from prestamo pr
	group by pr.codPel;

select pel.titulo from pelicula pel
inner join prestamo pr on pel.codPel = pr.codPel
group by pr.codPel
having count(*) = (
	select max(pp.cantidadPrestamos)
	from prestamosPorPelicula pp
);

-- 10
select p.codPel from pelicula p
where not exists(
	select e.codPel, e.codEj from ejemplar e
	where not exists(
		select pr.codPel, pr.codEj from prestamo pr
	)
);
