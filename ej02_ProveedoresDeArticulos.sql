-- crear base de datos
create database ej2_ProveedoresDeArticulos;

-- usar la base de datos
use ej2_ProveedoresDeArticulos;

-- crear tablas
create table proveedor
(
	nroProv int not null,
	nomProv varchar(50) not null,
	categoria int not null,
	ciudadProv varchar(50) not null,
	primary key(nroProv)
);

create table articulo
(
	nroArt int not null,
	descripcion varchar(50) not null,
	ciudadArt varchar(50) not null,
	precio float not null,
	primary key(nroArt)
);

create table cliente
(
	nroCli int not null,
	nomCli varchar(50) not null,
	ciudadCli varchar(50) not null,
	primary key(nroCli)
);

create table pedido
(
	nroPed int not null,
	nroArt int not null,
	nroCli int not null,
	nroProv int not null,
	fechaPedido date not null,
	cantidad int not null,
	precioTotal float not null,
	primary key(nroPed),
	foreign key(nroArt) references articulo(nroArt),
	foreign key(nroCli) references cliente(nroCli),
	foreign key(nroProv) references proveedor(nroProv)
);

create table stock
(
	nroArt int not null,
	fecha date not null,
	cantidad int not null,
	primary key(nroArt)
);

-- consultas

-- 1
select distinct p.nroProv from pedido p where p.nroArt = 146;

-- 2
select distinct p.nroCli from pedido p where p.nroProv = 15;

-- 3
select distinct ped.nroCli from pedido ped
inner join proveedor prov on ped.nroProv = prov.nroProv
where prov.categoria > 4;

-- 4
select p.nroPed from pedido p
inner join articulo a on p.nroArt = a.nroArt
inner join cliente c on p.nroCli = c.nroCli
where c.ciudadCli = 'Rosario' and a.ciudadArt = 'Mendoza';

-- 5
select p1.nroPed from pedido p1, pedido p2
where p1.nroArt = p2.nroArt and p1.nroCli = 23 and p2.nroCli = 30;

-- 6
create view articuloPrecioSuperiorPromedioLaPlata
as
	select a.nroArt from articulo a
	where a.precio >= (
		select avg(a.precio) as prom from articulo a
		where a.ciudadArt = 'La Plata'
	);

select p.nroProv from pedido p
inner join articuloPrecioSuperiorPromedioLaPlata a
on a.nroArt = p.nroArt
group by p.nroProv
having count(distinct p.nroArt) >= (
	select count(*) from articuloPrecioSuperiorPromedioLaPlata
);

-- 7
create view clienteDeJunin
as
	select c.nroCli as idCli, c.ciudadCli
    from cliente c;

create view pedidoClienteDeJunin
as
	select * from pedido p
	left join clienteDeJunin c on p.nroCli = c.idCli;

create view proveedorDeTodoJunin
as
	select p.nroProv from proveedor p
	where not exists (
		select p.nroProv, c.nroCli from proveedor p, cliente c
		where not exists (
			select pj.nroProv, pj.nroCli from pedidoClienteDeJunin pj
		)
	);

select p.nroProv, count(distinct p.nroArt) as cantidadArticulos
from pedidoClienteDeJunin p
left join proveedorDeTodoJunin prov on p.nroProv = prov.nroProv
group by p.nroProv;

-- 8
select p.nomProv from proveedor p
where p.categoria > (
	select max(pr.categoria) as categoria
    from pedido p, articulo a, proveedor pr
	where p.nroArt = a.nroArt and p.nroProv = pr.nroProv
	and a.descripcion = 'cuaderno'
    );

-- 9
select p.nroProv from pedido p
where p.nroArt between 1 and 100
group by p.nroProv
having sum(p.cantidad) > 1000;

-- 10
select p.nroCli, p.nroArt, p.nroProv,
sum(p.cantidad) as cantidad, sum(p.precioTotal) as precioTotal
from pedido p
where p.fechaPedido between '01-01-2004' and '31-03-2004'
group by p.nroCli, p.nroArt, p.nroProv;

-- 11
create view pedidoCliArtProv
as
	select p.nroCli, p.nroArt, p.nroProv,
	sum(p.cantidad) as cantidad, sum(p.precioTotal) as precioTotal
	from pedido p
	where p.fechaPedido between '01-01-2004' and '31-03-2004'
	group by p.nroCli, p.nroArt, p.nroProv;

select * from pedidoCliArtProv p
where p.cantidad >= 1000 or p.precioTotal > 1000;

-- 12
create view cantidadArticulosPedidosPorFecha
as
	select p.nroArt, p.fechaPedido, sum(p.cantidad) as cantidad
	from pedido p
	group by p.nroArt, p.fechaPedido;

create view articuloSinStockSuficiente
as
	select c.nroArt from cantidadArticulosPedidosPorFecha c
	inner join stock s on c.nroArt = s.nroArt and c.fechaPedido = s.fecha
	where c.cantidad > s.cantidad;

select a.descripcion from articulo a
left join articuloSinStockSuficiente st
on a.nroArt = st.nroArt;

-- 13
create view pedidoUltimoMes
as
	select * from pedido p
	where p.fechaPedido between '24-09-2017' and '24-10-2017';

create view proveedorTodosArticulos
as
	select pr.nroProv from proveedor pr
	where not exists (
		select p.nroProv, a.nroArt from pedidoUltimoMes p, articulo a
		where not exists (
			select ped.nroProv, ped.nroArt from pedidoUltimoMes ped
		)
	);
	
select * from proveedor p
left join proveedorTodosArticulos pt
on p.nroProv = pt.nroProv;

-- 14
select distinct p.nroProv from pedido p
where p.nroPed not in(
	select pp.nroPed from pedido pp
	where pp.fechaPedido between '24-09-2017' and '24-10-2017'
) and p.nroPed in(
	select pp.nroPed from pedido pp
	where pp.fechaPedido between '24-09-2016' and '24-10-2016'
);

-- 15
create view pedidoConsiderado
as
	select p.nroPed, p.nroArt, p.nroCli
	from pedido p, articulo a, proveedor pr
	where a.precio < 100 and pr.ciudadProv = 'Capital Federal';

create view clienteConAlMenos2PedidosCons
as
	select p1.nroCli from pedidoConsiderado p1, pedidoConsiderado p2
	where p1.nroPed <> p2.nroPed and p1.nroArt <> p2.nroArt
	and p1.nroCli = p2.nroCli;

select c.nomCli from cliente c
left join clienteConAlMenos2PedidosCons cc
on c.nroCli = cc.nroCli;