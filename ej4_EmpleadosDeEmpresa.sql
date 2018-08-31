-- crear base de datos
create database ej4_EmpleadosDeEmpresa;

-- usar base de datos
use ej4_EmpleadosDeEmpresa;

-- crear tablas
CREATE TABLE Persona
(
	nombre_persona varchar(64) NOT NULL,
	dni BIGINT NOT NULL,
	telefono varchar(20) NOT NULL,
	PRIMARY KEY (dni)
);

CREATE TABLE Empresa
(
	nombre_empresa varchar(64) NOT NULL,
	telefono varchar(20) NOT NULL,
	PRIMARY KEY (nombre_empresa)
);

CREATE TABLE Situada_En
(
	nombre_empresa varchar(64) NOT NULL,
	ciudad varchar(64) NOT NULL,
	PRIMARY KEY (nombre_empresa),
	FOREIGN KEY (nombre_empresa) REFERENCES
	Empresa(nombre_empresa)
);

CREATE TABLE Supervisa
(
	Dni_per BIGINT NOT NULL,
	Dni_sup BIGINT NOT NULL,
	PRIMARY KEY (Dni_per, Dni_sup),
	FOREIGN KEY (Dni_per) REFERENCES Persona(Dni),
	FOREIGN KEY (Dni_sup) REFERENCES Persona(Dni)
);

CREATE TABLE Trabaja
(
	Dni_per BIGINT NOT NULL,
	nombre_empresa varchar(64) NOT NULL,
	salario int NOT NULL, 
	fecha_ingreso date NOT NULL,
	fecha_egreso date NOT NULL,
	PRIMARY KEY (Dni_per),
	FOREIGN KEY (Dni_per) REFERENCES Persona(dni),
	FOREIGN KEY (nombre_empresa) REFERENCES
	Empresa(nombre_empresa)
);

CREATE TABLE Vive
(
    Dni_per BIGINT NOT NULL,
    calle VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    PRIMARY KEY (Dni_per),
    FOREIGN KEY (Dni_per) REFERENCES Persona (Dni)
); 

-- cargar registros en las tablas
INSERT INTO Persona (nombre_persona, dni, telefono) VALUES 
('persona1', 951456566, '222222111'),
('persona2', 658456566, '23156456'),
('persona3', 165456566, '23156456'),
('persona4', 145654354, '23156456'),
('persona5', 165434562, '23156456'),
('persona6', 165765643, '23156456'),
('persona7', 165876434, '23156456'),
('persona8', 165455654, '23156456'),
('persona9', 165453456, '23156456'),
('persona10', 484453456, '468731321');

select * from persona;

INSERT INTO Empresa (nombre_empresa,telefono) VALUES
('empresa1', '222222111'),
('empresa2', '23156456'),
('empresa3', '23156456'),
('empresa4', '23156456'),
('empresa5', '23156456'),
('empresa6', '23156456'),
('empresa7', '23156456'),
('empresa8', '23156456'),
('empresa9', '23156456'),
('empresa10', '468731321');

select * from empresa;

INSERT INTO Situada_En (nombre_empresa, ciudad) VALUES
('empresa1', 'ciudad1'),
('empresa2', 'ciudad1'),
('empresa3', 'ciudad1'),
('empresa4', 'ciudad1'),
('empresa5', 'ciudad2'),
('empresa6', 'ciudad3'),
('empresa7', 'ciudad4'),
('empresa8', 'ciudad5'),
('empresa9', 'ciudad6'),
('empresa10', 'ciudad8');

select * from situada_en;

INSERT INTO Supervisa (dni_per, dni_sup) VALUES
(951456566, 658456566),
(951456566, 165456566),
(951456566, 145654354), 
(951456566, 165434562),
(951456566, 165765643),
(951456566, 165876434),
(484453456, 951456566),
(165455654, 951456566),
(165455654, 484453456),
(165453456, 165455654);

select * from supervisa;

INSERT INTO Trabaja (dni_per, nombre_empresa, salario,fecha_ingreso, fecha_egreso) VALUES
(951456566, 'empresa1', 1000, '2011-11-04', '2011-11-11'),
(658456566, 'empresa2', 1500, '2011-11-06', '2011-11-24'),
(165456566, 'empresa3', 2000, '2011-11-17', '2011-11-29'),
(145654354, 'empresa4', 6500, '2011-11-08', '2011-11-29'),
(165434562, 'empresa5', 6000, '2011-11-13', '2011-12-06'),
(165765643, 'empresa6', 7000, '2011-11-01', '2014-11-05'),
(165876434, 'empresa7', 5000, '2011-11-14', '2013-11-15'),
(165455654, 'empresa8', 9500, '2011-11-15', '2014-11-20'),
(165453456, 'empresa9', 6520, '2011-11-14', '2016-11-08'),
(484453456,'empresa10', 65120, '2011-11-28', '2013-11-13');

select * from trabaja;

INSERT INTO Vive (dni_per, calle, ciudad) VALUES
(951456566, 'calle1', 'ciudad1'),
(658456566, 'calle2', 'ciudad2'),
(165456566, 'calle3', 'ciudad3'),
(145654354, 'calle4', 'ciudad4'),
(165434562, 'calle5', 'ciudad5'),
(165765643, 'calle6', 'ciudad6'),
(165876434, 'calle7', 'ciudad7'),
(165455654, 'calle8', 'ciudad8'),
(165453456, 'calle9', 'ciudad9'),
(484453456, 'calle10', 'ciudad10'); 

select * from vive;

-- consultas

-- a
select p.nombre_persona from persona p
inner join trabaja t on p.dni = t.dni_per
where t.nombre_empresa = 'Banelco';

-- b
select p.nombre_persona, v.ciudad from persona p
inner join trabaja t on p.dni = t.dni_per
inner join vive v on p.dni = v.dni_per
where t.nombre_empresa = 'Telecom';

-- c
select p.nombre_persona, v.calle, v.ciudad
from persona p
inner join trabaja t on p.dni = t.dni_per
inner join vive v on p.dni = v.dni_per
where t.nombre_empresa = 'Paulinas' and t.salario > 1500;

-- d
select t.dni_per from trabaja t
inner join vive v on t.dni_per = v.dni_per
inner join situada_en s on t.nombre_empresa = s.nombre_empresa
where v.ciudad = s.ciudad;

-- e
select s.dni_per from supervisa s
inner join vive vp on s.dni_per = vp.dni_per
inner join vive vs on s.dni_sup = vs.dni_per
where vp.ciudad = vs.ciudad and vp.calle = vs.calle;

-- f
select t.dni_per from trabaja t
where t.salario > all(
	select tt.salario from trabaja tt
    where tt.nombre_empresa = 'Clarin'
);

-- g
select v.ciudad from vive v
where not exists(
	select vv.ciudad, t.dni_per from vive vv, trabaja t
    where not exists(
		select tt.dni_per from trabaja tt
        where tt.salario > 1500
    )
);

-- h
select t.dni_per from trabaja t
where t.fecha_ingreso = (
	select min(tt.fecha_ingreso) from trabaja tt
    where tt.nombre_empresa = 'Sony'
) and t.nombre_empresa = 'Sony';

-- i
create view ingresanteMasivoEnPeriodo
as
	select t.dni_per from trabaja t
	where t.fecha_ingreso between '01-01-2000' and '31-03-2004'
	group by t.dni_per
	having count(t.nombre_empresa) > 4;

create view empleadoMuySupervisado
as
	select s.dni_per from supervisa s
    group by s.dni_per
    having count(*) >= 5;
    
select i.dni_per from ingresanteMasivoEnPeriodo i
where exists(
	select e.dni_per from empleadoMuySupervisado e
);
