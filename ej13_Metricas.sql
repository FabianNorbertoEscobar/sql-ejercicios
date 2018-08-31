-- crear la base de datos
create database ej13_Metricas;

-- usar la base de datos
use ej13_Metricas;

-- 1
drop procedure p_CrearEntidades;

create procedure p_CrearEntidades
as
	begin try
		begin transaction
			create table nivel
			(
				codigo int not null,
				descripcion varchar(30) not null,
				primary key(codigo)
			);

			create table medicion
			(
				fecha date not null,
				hora time not null,
				metrica char(5) not null,
				temperatura float not null,
				presion float not null,
				humedad float not null,
				nivel int not null,
				primary key(fecha, hora, metrica),
				foreign key(nivel) references nivel(codigo)
			);
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_CrearEntidades

-- 2
drop function f_ultimaMedicion;

create function f_ultimaMedicion(metrica char(5))
returns datetime
as
	begin
		declare @fechaHora datetime
		declare @ultimaFecha date
		declare @ultimaHora time

		set @ultimaFecha = (select max(m.fecha) from medicion m where m.metrica = @metrica)
		set @ultimaHora = (select max(m.hora) from medicion m where m.metrica = @metrica and m.fecha = ultimaFecha)
		set @fechaHora = (select convert(datetime, concat(@ultimaFecha, ' ', @ultimaHora)))

		return @fechaHora
	end;

declare @var datetime
set @var = (select dbo.f_ultimaMedicion('M1115'))
select @var;

-- 3
drop view mediciones_ultima_semana;

create view medicionesUltimaSemana
as
	select m.fecha, m.hora, m.metrica, m.nivel, m.temperatura
	from medicion m
	where m.fecha between dateAdd(day, -7, getDate()) AND getDate();

drop view todosLosNiveles;

create view todosLosNiveles
as
	select m.fecha, m.hora, m.metrica, m.temperatura
	from medicion m
	where m.metrica not exists (
		select distinct mus.metrica
		from medicionesUltimaSemana mus, nivel n
		where not exists (
			select mm.fecha from medicion mm
			where mm.metrica = mus.metrica and mm.nivel = n.codigo
		)
	);

drop view temperaturaMaxima;

create view temperaturaMaxima
as
	select max(m.temperatura) as temperatura from todosLosNiveles;


drop view metricaMaxTemp;

create view metricaMaxTemp
as
	select distinct m.metrica, tm.temperatura
	from todosLosNiveles m
	inner join temperaturaMaxima tm on m.temperatura = tm.temperatura;

drop view v_Listado;

create view v_Listado
as
	select m.metrica, mmt.temperatura as temperaturaMaxima, count(*) as cantidadMediciones
	from todosLosNiveles m
	inner join metricaMaxTemp mmt on m.metrica = mmt.metrica
	group by m.metrica, mmt.temperatura;

select * from v_Listado;

-- 4
drop procedure p_ListaAcumulados;

create procedure p_ListaAcumulados(@fechaMin date, @fechaMax date)
as
	begin try
		begin transaction
			select sq.*, sum(sq.acDiarioTemp)
			over (partition by metrica order by metrica, fecha rows unbounded preceding) as acTemp
			from (
				select m.fecha, m.metrica, sum(m.temperatura) as acDiarioTemp
				from medicion m
				where m.fecha between @fechaMin and @fechaMax
				group by m.fecha, m.metrica
			) sq 
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_ListaAcumulados '20/10/2017', '27/10/2017';

-- 5 
drop procedure p_InsertMedicion;

create procedure p_InsertMedicion(@fecha date, @hora time, @metrica char(5), @temperatura float, @presion float, @humedad float, @nivel int)
as
	begin try
		begin transaction
			if not exists (select m.fecha from medicion m where m.fecha = @fecha and m.hora = @hora and m.metrica = @metrica)
				if @humedad between 0 and 100
					if exists (select n.codigo from nivel n where n.codigo = @nivel)
						insert into medicion(fecha, hora, metrica, temperatura, presion, humedad, nivel)
							values(@fecha, @hora, @metrica, @temperatura, @presion, @humedad, @nivel)
						else
							print 'El nivel ingresado no existe'
					else
						print 'El porcentaje de humedad no se encuentra entre 0 y 100'
				else
					print 'Ya existe una medicion para esa métrica en la misma fecha y hora'
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_InsertMedicion '01/02/2017','02:35:20', 1, 100, 80, 99, 4;

-- 6
drop procedure p_DepuraMedicion;

create procedure p_DepuraMedicion(@dias int)
as
	begin try
		begin transaction
			if object_id('Historial','U') is not null
				create table Historial
				(
					fecha date not null,
					hora time not null,
					metrica char(5) not null,
					temperatura float not null,
					presion float not null,
					humedad float not null,
					nivel int not null,
					primary key(fecha, hora, metrica),
					foreign key(nivel) references nivel(codigo)	
				);

			insert into Historial(fecha, hora, metrica, temperatura, presion, humedad, nivel)
			select m.fecha, m.hora, m.metrica, m.temperatura, m.presion, m.humedad, m.nivel
			from medicion m
			where m.fecha < dateAdd(day, -@dias, getDate());

			delete from medicion
			where fecha < dateAdd(day, -@dias, getDate());
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_DepuraMedicion 10;

-- 7
drop trigger tg_descNivel;

create trigger tg_descNivel on nivel
before insert
as
	set inserted.descripcion = upper(inserted.descripcion);