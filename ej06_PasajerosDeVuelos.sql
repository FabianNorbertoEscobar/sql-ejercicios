-- crear base de datos
create database ej6_PasajerosDeVuelos;

-- usar la base de datos
use ej6_PasajerosDeVuelos;

-- crear tablas

create table vuelo
(
	nroVuelo int not null,
	desde varchar(30) not null,
	hasta varchar(30) not null,
	fecha date not null,
	primary key(nroVuelo, desde)
);

create table avion_utilizado
(
	nroVuelo int not null,
	tipoAvion varchar(20) not null,
	nroAvion int not null,
	primary key(nroVuelo),
	foreign key(nroVuelo) references vuelo(nroVuelo)
);

create table info_pasajeros
(
	nroVuelo int not null,
	documento int not null,
	nombre varchar(30) not null,
	origen varchar(30) not null,
	destino varchar(30) not null,
	primary key(nroVuelo, documento),
	foreign key(nroVuelo) references vuelo(nroVuelo)
);

-- consultas

-- 1
select v.nroVuelo from vuelo v
where v.desde = 'A' and v.hasta = 'F';

-- 2
create view vueloQueNoPasaPorB
as
	select v.nroVuelo from vuelo v
	where v.desde <> 'B' and v.hasta <> 'B';

select distinct a.tipoAvion
from avion_utilizado a
inner join vueloQueNoPasaPorB v on a.nroVuelo = v.nroVuelo;

-- 3
select ip.nroVuelo, ip.documento, ip.nombre
from info_pasajeros ip, info_pasajeros ip2
where ip.origen = 'A' and ip.destino = 'B'
and ip2.origen = 'B' and ip2.destino = 'D';

-- 4
create view vueloQuePasaPorC
as
	select v.nroVuelo from vuelo v
	where v.desde = 'C' or v.hasta = 'C';

select distinct a.tipoAvion
from avion_utilizado a
left join vueloQuePasaPorC v on a.nroVuelo = v.nroVuelo;

-- 5
select a.nroVuelo, count(*) as cantidadVuelos
from avion_utilizado a
group by a.nroAvion;

-- 6
create view vueloConDestinoH
as
	select v.nroVuelo from vuelo v
	where v.hasta = 'H';

select a.tipoAvion, a.nroAvion
from avion_utilizado a
left join vueloConDestinoH v on a.nroVuelo = v.nroVuelo;

-- 7
create  view vuelosUltimoAño
as
	select v.nroVuelo from vuelo v
	where v.fecha between dateAdd(month, -1, getDate()) and getDate();

create view vuelosPorPasajeroUltimoAño
as
	select ip.documento, count(*) as cantidadVuelos
	from info_pasajeros ip
	inner join vuelosUltimoAño v on ip.nroVuelo = v.nroVuelo
	group by ip.documento;

select vpp.documento from vuelosPorPasajeroUltimoAño vpp
where vpp.cantidadVuelos = (
	select max(v.cantidadVuelos) from vuelosPorPasajeroUltimoAño v
);

-- 8
create view vuelosEnB777
as
	select a.nroVuelo from avion_utilizado a
	where a.tipoAvion = 'B-777';

create view vuelosEnB777PorPasajero
as
	select ip.documento, count(*) as cantidadVuelos
	from info_pasajeros ip
	inner join vuelosEnB777 v on ip.nroVuelo = v.nroVuelo
	group by ip.documento;

select v.documento from vuelosEnB777PorPasajero v
where v.cantidadVuelos = (
	select max(vv.cantidadVuelos) from vuelosEnB777PorPasajero vv
);

-- 9
create view vueloMasAntiguo
as
	select v.nroVuelo from vuelo v
	where v.fecha <= all (
		select v.fecha from vuelo v
	);

create view cantVuelosPasajeroMasAntiguo
as
	select ip.documento, count(*) as cantidad
	from info_pasajeros ip
	inner join vueloMasAntiguo v on ip.nroVuelo = v.nroVuelo
	group by ip.documento;

create view vuelosPasajeroMasAntiguo
as
	select ip.nroVuelo from info_pasajeros ip
	inner join cantVuelosPasajeroMasAntiguo cv
	on ip.documento = cv.documento
	group by ip.documento
	having count(*) = (
		select max(cv.cantidad) from cantVuelosPasajeroMasAntiguo cv
	);

select distinct a.nroAvion
from vuelosPasajeroMasAntiguo v
inner join avion_utilizado a on v.nroVuelo = a.nroVuelo;

-- 10
create view pasajerosPorVuelo
as
	select ip.nroVuelo, count(*) as pasajeros
	from info_pasajeros ip
	group by ip.nroVuelo;

select a.nroAvion, avg(ppv.pasajeros)
from avion_utilizado a
inner join pasajerosPorVuelo ppv
group by a.nroAvion;

-- 11
create view vuelosPorPasajero
as
	select ip.documento, count(*) as vuelos
	from info_pasajeros ip
	group by ip.documento;

create function promedio()
returns float
as
begin
	declare	@promedio float
	set @promedio = avg(vpp.vuelos) from vuelosPorPasajero vpp
	return @promedio
end;

select vpp.documento from vuelosPorPasajero vpp
where vpp.vuelos between promedio() - 0.1 * promedio() and promedio() + 0.1 * promedio();
