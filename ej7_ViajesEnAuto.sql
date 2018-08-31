-- crear la base de datos
create database ej7_ViajesEnAuto;

-- usar la base de datos
use ej7_ViajesEnAuto;

-- crear las tablas
CREATE TABLE Auto
(
	Matricula VARCHAR(12) PRIMARY KEY,
	Modelo VARCHAR(50),
	Anio date NOT NULL
);

CREATE TABLE Chofer
(
	Nro_Licencia BIGINT PRIMARY KEY,
	Nombre VARCHAR(20) NOT NULL,
	Apellido VARCHAR(20) NOT NULL,
	Fecha_Ingreso DATE NOT NULL,
	Telefono BIGINT
);

CREATE TABLE Cliente
(
	Nro_Cliente BIGINT PRIMARY KEY,
	Calle VARCHAR(30) NOT NULL,
	Nro INT NOT NULL,
	Localidad VARCHAR(30)
);

CREATE TABLE Viaje
(
	Fecha_Hora_Inicio timestamp NOT NULL,
	Fecha_Hora_Fin timestamp ,
	Chofer BIGINT NOT NULL,
	Cliente BIGINT,
	Auto VARCHAR(12) NOT NULL,
	Km_Totales INT NOT NULL,
	Espera_Total TIME,
	Costo_Espera FLOAT,
	Costo_Kms FLOAT,
	PRIMARY KEY(Fecha_Hora_Inicio, Chofer),
	FOREIGN KEY(Chofer) REFERENCES Chofer(Nro_Licencia),
	FOREIGN KEY(Cliente) REFERENCES Cliente(Nro_Cliente),
	FOREIGN KEY(Auto) REFERENCES Auto(Matricula)
);

-- cargar registros en las tablas
INSERT INTO Auto (Matricula, Modelo, Anio) VALUES
('mat1', 'mod1', '01/01/2010'), ('mat2', 'mod2', '01/01/2000'),
('mat3', 'mod3', '01/01/2001'), ('mat4', 'mod4', '01/01/2003'),
('mat5', 'mod5', '01/01/2002'), ('mat6', 'mod5', '01/01/2004'),
('mat7', 'mod6', '01/01/2006'), ('mat8', 'mod7', '01/01/2000'),
('mat9', 'mod7', '01/01/2007'), ('mat10', 'mod8', '01/01/2010');

INSERT INTO Chofer (Nro_Licencia, Nombre, Apellido,
Fecha_Ingreso, Telefono) VALUES
(1, 'nom1', 'ape1', '2001-1-1', 12341234),
(2, 'nom2', 'ape2', '2002-2-1', 45674567),
(3, 'nom3', 'ape3', '2002-12-31', 98765432),
(4, 'nom4', 'ape4', '2003-2-1', 34567890),
(5, 'nom5', 'ape5', '2003-5-13', 87654321),
(6, 'nom6', 'ape6', '2003-6-5', 33333333),
(7, 'nom7', 'ape7', '2003-7-12', 44444444),
(8, 'nom8', 'ape8', '2003-8-10', 55555555),
(9, 'nom9', 'ape9', '2007-3-2', 66666666),
(10, 'nom10', 'ape10', '2009-6-18', 77777777);

INSERT INTO Cliente (Nro_Cliente, Calle, Nro, Localidad) VALUES
(1, 'Calle1', 1, 'loc1'),(2, 'Calle2', 2, 'loc2'),
(3, 'Calle3', 3, 'loc3'),(4, 'Calle4', 4, 'loc4'),
(5, 'Calle5', 5, 'loc5'),(6, 'Calle6', 6, 'loc6'),
(7, 'Calle7', 7, 'loc7'),(8, 'Calle8', 8, 'loc8'),
(9, 'Calle9', 9, 'loc9'),(10, 'Calle10', 10, 'loc10');

INSERT INTO Viaje (Fecha_Hora_Inicio, Fecha_Hora_Fin, Chofer,
Cliente, Auto, Km_Totales, Espera_Total, Costo_Espera,
Costo_Kms) VALUES
('2011-01-01 00:00:00', '2011-01-01 00:30:00', 1, 1, 'mat1', 23,
'00:00:01', 5, 0.75),
('2011-01-01 00:02:00', '2011-01-01 00:22:00', 2, 1, 'mat1', 20,
'00:00:02', 10, 0.75),
('2011-01-01 01:00:00', '2011-01-01 01:30:00', 3, 3, 'mat4', 25,
'00:00:03', 15, 0.75),
('2011-01-01 03:00:00', '2011-01-01 03:20:00', 4, 3, 'mat5', 25,
'00:00:05', 25, 0.75),
('2011-01-01 04:00:00', '2011-01-01 04:40:00', 5, 2, 'mat3', 30,
'00:00:00', 0, 0.60),
('2011-01-01 05:00:00', '2011-01-01 05:30:00', 6, 4, 'mat5', 28,
'00:00:06', 30, 0.35),
('2011-01-01 06:00:00', '2011-01-01 06:45:00', 7, 5, 'mat7', 40,
'00:00:02', 10, 0.75),
('2011-01-01 07:00:00', '2011-01-01 07:10:00', 8, 7, 'mat8', 20,
'00:00:00', 0, 0.75),
('2011-01-01 08:00:00', '2011-01-01 08:30:00', 9, 8, 'mat9', 24,
'00:00:03', 15, 0.60),
('2011-05-01 00:00:00', '2011-05-01 02:00:00', 10, 4, 'mat10',
100, '00:00:25', 125, 0.75);

-- consultas

-- 1
create view kmPorAutoUltMes
as
	select v.Auto, sum(v.Km_Totales) as km from viaje v
	where v.Fecha_Hora_Inicio between dateAdd(month, -1, getDate()) and getDate();

select km.Auto from kmPorAutoUltMes kma
where kma.km = (
	select max(kma.km) from kmPorAutoUltMes kma
);

-- 2
create view viajesConChofer
as
	select v.Cliente, v.Chofer, count(*) as cantidad
	from viaje v
	group by v.Cliente, v.Chofer;

select distinct vcc.Cliente from viajesConChofer vcc
where vcc.cantidad = (
	select max(v.cantidad) from viajesConChofer v
);

-- 3
create view viajesAñoActual
as
	select v.Cliente, count(*) as cantidad
	from viaje v
	where year(date(v.Fecha_Hora_Inicio)) = year(getDate())
	group by v.Cliente;

select vaa.Cliente from viajesAñoActual vaa
where vaa.cantidad = (
	select max(v.cantidad) from viajesAñoActual v
);

-- 4
create view choferTodos
as
	select c.Nro_Licencia from Chofer c
	where not exists(
		select c.Nro_Licencia, a.Matricula
		from Chofer c, Auto a
		where not exists(
			select v.Chofer, v.Auto from viaje v
		)
	);

select c.Nombre, c.Apellido from Chofer c
inner join choferTodos ct on c.Nro_Licencia <> ct.Nro_Licencia;

-- 5
create view choferTodos
as
	select c.Nro_Licencia from Chofer c
	where not exists(
		select c.Nro_Licencia, a.Matricula
		from Chofer c, Auto a
		where not exists(
			select v.Chofer, v.Auto from viaje v
		)
	);

select c.Nombre, c.Apellido from Chofer c
inner join choferTodos ct on c.Nro_Licencia = ct.Nro_Licencia;

-- 6
select avg(v.Espera_Total) as esperaPromedio from viaje v
where v.Fecha_Hora_Inicio between dateAdd(month, -2, getDate()) and getDate();

-- 7
select v.Auto, sum(v.Km_Totales) as kmRecorridos
from viaje v
group by v.Auto;

-- 8
select v.Auto, avg(v.Costo_Espera + v.Costo_Kms) as costoPromedio
from viaje v
group by v.Auto;

-- 9
select v.Chofer, sum(v.Costo_Espera + v.Costo_Kms) as costoTotal
from viaje v
where v.Fecha_Hora_Inicio between dateAdd(month, -1, getDate()) and getDate()
group by v.Chofer;

-- 10
select date(v.Fecha_Hora_Inicio) as fechaInicial, v.Chofer, v.Cliente
from viaje v
where (v.Fecha_Hora_Fin - v.Fecha_Hora_Inicio) = (
	select max(v.Fecha_Hora_Fin - v.Fecha_Hora_Inicio) from viaje v
	where year(date(v.Fecha_Hora_Inicio)) = year(getDate())
);
