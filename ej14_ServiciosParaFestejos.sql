-- crear base de datos
create database ej14_ServiciosParaFestejos;

-- usar la base de datos
use ej14_ServiciosParaFestejos;

-- crear tablas
create table servicio
(
	nroServicio int not null,
	descripcion varchar(20) not null,
	precio float not null,
	primary key(nroServicio)
);

create table cliente
(
	nroCliente int not null,
	razonSocial varchar(20) not null,
	primary key(nroCliente)
);

create table festejo
(
	nroFestejo int not null,
	descripcion varchar(30) not null,
	fecha date not null,
	nroCliente int not null,
	primary key(nroFestejo),
	foreign key(nroCliente) references cliente(nroCliente)
);

create table contrata
(
	nroFestejo int not null,
	item int not null,
	nroServicio int not null,
	horaDesde time not null,
	horaHasta time not null,
	primary key(nroFestejo, item),
	foreign key(nroFestejo) references festejo(nroFestejo),
	foreign key(nroServicio) references servicio(nroServicio)
);

-- 1
drop procedure p_Servicios;

create procedure p_Servicios(@fechaDesde time, @fechaHasta time)
as
	begin try
		begin transaction
			insert into #festejoPeriodo
			select * from festejo f
			where f.fecha between @fechaDesde and @fechaHasta;

			insert into #servicioTodos
			select distinct s.nroServicio from servicio s
			where not exists(
				select s.nroServicio, f.nroFestejo
				from servicio s, festejoPeriodo f
				where not exists(
					select f.nroServicio, f.nroFestejo
					from festejoPeriodo f
				)
			);

			select s.descripcion as nombreServicio, sum(c.horaHasta - c.horaDesde) as horasContratadas
			from servicio s
			inner join #servicioTodos st
			on s.nroServicio = st.nroServicio
			inner join contrata c
			on s.nroServicio = c.nroServicio
			inner join #festejoPeriodo fp
			on fp.nroFestejo = c.nroFestejo
			group by s.descripcion
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_Servicios '1/11/2017','7/11/2017';

-- 2
alter table contrata add column tiempo smallint not null default 0;

-- 3
drop trigger tg_Tiempo;

create trigger tg_Tiempo on contrata
after insert
as
	begin try
		begin transaction
			if inserted.horaDesde < inserted.horaHasta
				set inserted.tiempo = dateDiff(minute, inserted.horaDesde, inserted.horaHasta)
		commit
	end try
	begin catch
		print 'Las horas de contratación están al revés'
		rollback
	end catch;
