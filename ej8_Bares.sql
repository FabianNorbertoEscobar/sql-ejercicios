-- crear la base de datos
create database ej8_Bares;

-- usar la base de datos
use ej8_Bares;

-- crear las tablas
CREATE TABLE persona
(
	persona VARCHAR(30),
	sexo VARCHAR(20),
	PRIMARY KEY(persona)
);

CREATE TABLE bar
(
	bar VARCHAR(30),
	ciudad VARCHAR(30),
	PRIMARY KEY (bar)
);

CREATE TABLE cerveza
(
	cerveza VARCHAR(30),
	tipo VARCHAR(15),
	PRIMARY KEY (cerveza)
);

CREATE TABLE frecuenta
(
persona VARCHAR(30),
bar VARCHAR(30),
PRIMARY KEY (persona, bar),
FOREIGN KEY (persona) REFERENCES persona(persona),
FOREIGN KEY (bar) REFERENCES bar(bar));

CREATE TABLE sirve
(
	bar VARCHAR(25),
	cerveza VARCHAR(30),
	PRIMARY KEY (bar,cerveza),
	FOREIGN KEY(bar) REFERENCES bar(bar),
	FOREIGN KEY(cerveza) REFERENCES cerveza(cerveza)
);

CREATE TABLE gusta
(
	persona VARCHAR(50),
	cerveza VARCHAR(15),
	PRIMARY KEY (persona,cerveza),
	FOREIGN KEY(persona) REFERENCES persona(persona),
	FOREIGN KEY(cerveza) REFERENCES cerveza(cerveza)
);

-- cargar registros
INSERT INTO Persona (persona,sexo) VALUES
('Persona1','Masculino'), ('Persona2','Masculino'),
('Persona3','Femenino'),
('Persona4','Masculino'), ('Persona5','Masculino'),
('Persona6','Masculino'),
('Persona7','Femenino'), ('Persona8','Femenino'),
('Persona9','Masculino'),
('Persona10','Femenino');

INSERT INTO Bar (bar,ciudad) VALUES
('Bar1','Palermo'), ('Bar2','Palermo'), ('Bar3','Palermo'),
('Bar4','Belgrano'),('Bar5','Belgrano'), ('Bar6','Caballito'),
('Bar7','Caballito'), ('Bar8','Flores'), ('Bar9','San Telmo'),
('Bar10','Recoleta');

INSERT INTO Cerveza (cerveza,tipo) VALUES
('Cerveza1','rubia'), ('Cerveza2','rubia'),
('Cerveza3','rubia'),
('Cerveza4','negra'), ('Cerveza5','negra'), ('Cerveza6','roja'),
('Cerveza7','roja'), ('Cerveza8','rubia'), ('Cerveza9','negra'),
('Cerveza10','roja');

INSERT INTO Frecuenta(persona, bar) VALUES
('Persona1','Bar1'), ('Persona1','Bar2'), ('Persona2','Bar5'),
('Persona3','Bar3'), ('Persona3','Bar1'), ('Persona4','Bar6'),
('Persona4','Bar2'), ('Persona4','Bar3'), ('Persona4','Bar4'),
('Persona5','Bar7');

INSERT INTO Sirve (bar, cerveza) VALUES
('Bar1','Cerveza1'), ('Bar1','Cerveza2'), ('Bar1','Cerveza3'),
('Bar2','Cerveza4'), ('Bar2','Cerveza3'), ('Bar3','Cerveza1'),
('Bar7','Cerveza2'), ('Bar4','Cerveza1'), ('Bar5','Cerveza1'),
('Bar6','Cerveza3');

INSERT INTO Gusta (persona, cerveza) VALUES
('Persona1','Cerveza1'), ('Persona1','Cerveza3'),
('Persona2','Cerveza4'),
('Persona3','Cerveza2'), ('Persona4','Cerveza1'),
('Persona4','Cerveza2'),
('Persona4','Cerveza3'), ('Persona4','Cerveza4'),
('Persona5','Cerveza2'),
('Persona5','Cerveza4');

-- consultas

-- 1
select distinct f.persona from frecuenta f
where not exists(
	select f.persona, f.bar from frecuenta f
	where not exists(
		select g.persona, s.bar from gusta g
		inner join sirve s on g.cerveza = s.cerveza
	)
);

-- 2
select f.persona from frecuenta f
where not exists(
	select f.persona from frecuenta f
	inner join sirve s on f.bar = s.bar
	inner join gusta g on f.persona = g.persona
	and s.cerveza = g.cerveza
);

-- 3
select distinct f.persona from frecuenta f
where not exists(
	select p.persona from (
		select f.persona, f.bar, g.cerveza
		from frecuenta f
		inner join gusta g on f.persona = g.persona
		where not exists(
			select f.persona, f.bar, s.cerveza
			from frecuenta f
			inner join sirve s on f.bar = s.bar
		)
	) p
);

-- 4
create view noGusta
as
	select f.persona, s.cerveza
	from frecuenta f, sirve s
	where not exists(
		select g.persona, g.cerveza
		from gusta g
	);

create view personaNo
as
	select f.persona from frecuenta f
	inner join sirve s on f.bar = s.bar
	inner join noGusta ng on f.persona = ng.persona
	and s.cerveza = ng.cerveza;

select distinct f.persona from frecuenta f
where not exists(
	select pn.persona from personaNo pn
);
