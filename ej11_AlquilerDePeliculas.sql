-- 1
-- crear la base de datos
create database ej11_AlquilerDePeliculas;

-- usar la base de datos
use ej11_AlquilerDePeliculas;

-- plantilla procedimiento con transactions
/*
CREATE PROCEDURE
AS
BEGIN TRY
	BEGIN TRANSACTION
		
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
*/

-- 1
-- crear las tablas
CREATE TABLE Genero
(
	id INT PRIMARY KEY,
	nomb_genero VARCHAR(20)
);

CREATE TABLE Director
(
	id INT PRIMARY KEY,
	nya VARCHAR(50)
);

CREATE TABLE Pelicula
(
	cod_pel INT PRIMARY KEY,
	titulo VARCHAR(50),
	duracion VARCHAR(10),
	cod_genero INT,
	id_director INT,
	FOREIGN KEY (cod_genero) REFERENCES Genero(id),
	FOREIGN KEY (id_director) REFERENCES Director(id)
);

CREATE TABLE Ejemplar
(
	nro_ej INT,
	cod_pel INT,
	estado INT,
	PRIMARY KEY (nro_ej, cod_pel),
	FOREIGN KEY (cod_pel) REFERENCES Pelicula(cod_pel)
);

CREATE TABLE Cliente
(
	cod_cli INT PRIMARY KEY,
	nya VARCHAR(50),
	direccion VARCHAR(30),
	tel VARCHAR(15),
	email VARCHAR(30),
	borrado INT
);

CREATE TABLE Alquiler
(
	id INT PRIMARY KEY,
	nro_ej INT ,
	cod_pel INT,
	cod_cli INT,
	fecha_alq DATE,
	fecha_dev DATE,
	FOREIGN KEY (nro_ej, cod_pel) REFERENCES Ejemplar(nro_ej,
	cod_pel),
	FOREIGN KEY(cod_cli) REFERENCES Cliente(cod_cli)
);

-- 2
-- cargar registros en las tablas
INSERT INTO Genero (id, nomb_genero) VALUES (1,'Terror');
INSERT INTO Genero (id, nomb_genero) VALUES (2,'Comedia');
INSERT INTO Genero (id, nomb_genero) VALUES (3,'Drama');
INSERT INTO Genero (id, nomb_genero) VALUES (4,'Accion');
INSERT INTO Genero (id, nomb_genero) VALUES (5,'Infantil');
INSERT INTO Genero (id, nomb_genero) VALUES (6,'Ciencia
Ficción');
INSERT INTO Director (id, nya) VALUES (1,'David Lynch');
INSERT INTO Director (id, nya) VALUES (2,'Martin Scorsese');
INSERT INTO Director (id, nya) VALUES (3,'Pedro Almodovar');
INSERT INTO Director (id, nya) VALUES (4,'Quentin Tarantino');
INSERT INTO Director (id, nya) VALUES (5,'Larry and Andy
Wachowski');
INSERT INTO Director (id, nya) VALUES (6,'Clint Eastwood');
INSERT INTO Director (id, nya) VALUES (7,'James Cameron');
INSERT INTO Director (id, nya) VALUES (8,'Steven Spielberg');
INSERT INTO Cliente (cod_cli, nya, direccion, tel, email,
borrado)
VALUES (1,'Cosme, Fulanito', 'CalleFalsa 123', '3344-5325',
'cosme@email.com', 2);
INSERT INTO Cliente(cod_cli, nya, direccion, tel, email,
borrado)
VALUES (2,'Perez, Jorge', 'Cerrito 223', '9834-3385',
'perez@email.com', 2);
INSERT INTO Cliente (cod_cli, nya, direccion, tel, email,
borrado)
VALUES (3,'Suarez, Pepe', 'Uruguay 2322', '4594-9482',
'suarez@email.com', 2);
INSERT INTO Cliente (cod_cli, nya, direccion, tel, email,
borrado)
VALUES (4,'Fernandez, Juancito', 'Pueyrredon 2343', '7833-5893',
'fernandez@email.com', 2);
INSERT INTO Cliente (cod_cli, nya, direccion, tel, email,
borrado)
VALUES (5,'Torres, Pepe', 'Rivadavia 7897', '7484-3298',
'torres@email.com', 2);
INSERT INTO Pelicula(cod_pel, titulo, duracion, cod_genero,
id_director)
VALUES (1,'Terminator', '1:30:00', 4, 1);
INSERT INTO Pelicula(cod_pel, titulo, duracion, cod_genero,
id_director)
VALUES (2,'Avatar', '2:30:00', 4, 7);
INSERT INTO Pelicula(cod_pel, titulo, duracion, cod_genero,
id_director)
VALUES (3,'Kill Bill', '1:45:00', 4, 4);
INSERT INTO Pelicula(cod_pel, titulo, duracion, cod_genero,
id_director)
VALUES (4,'Matrix', '1:30:00', 4, 5);
INSERT INTO Pelicula(cod_pel, titulo, duracion, cod_genero,
id_director)
VALUES (5,'Volver al Futuro', '1:20:00', 5, 8);
INSERT INTO Pelicula(cod_pel, titulo, duracion, cod_genero,
id_director)
VALUES (6,'300', '1:40:00', 4, 3);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (1,1,1);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (2,1,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (1,2,1);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (2,2,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (1,3,1);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (2,3,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (1,4,1);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (2,4,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (1,5,1);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (2,5,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (1,6,1);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (2,6,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (3,2,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (4,2,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (5,2,0);
INSERT INTO Ejemplar (nro_ej,cod_pel,estado) VALUES (6,2,0);
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (1,1,1,4,'2011-06-11', Null);
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (2,1,2,2,'2011-06-15', Null);
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (3,1,3,3,'2011-06-22',Null);
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (4,1,4,5,'2011-06-30',Null);
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (5,1,5,4,'2011-07-01',Null);
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (6,1,6,1,'2011-07-06',Null);
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (7,1,2,4,'2011-05-11','2011-05-13');
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (8,2,2,2,'2011-05-15','2011-05-17');
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (9,3,2,3,'2011-06-12','2011-06-14');
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (10,4,2,5,'2011-06-23','2011-06-25');
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (11,5,2,4,'2011-06-06','2011-06-08');
INSERT INTO Alquiler (id, Nro_Ej, Cod_Pel, Cod_Cli, Fecha_alq,
Fecha_dev) VALUES (12,6,2,1,'2011-06-22','2011-06-24');

-- 3
alter table Pelicula add column año int null;

-- 4
create view peliculaEnStock
as
	select e.cod_pel from ejemplar e
	where e.estado = 0
	group by e.cod_pel
	having count(*) > 0;

-- 5
drop trigger t_eliminar_pelicula;

create trigger t_eliminar_pelicula
	on Pelicula
	before delete
	as
	begin
		delete from ejemplar
		where cod_pel = deleted.cod_pel
	end;

-- 6
drop trigger t_baja_logica_cliente;

create trigger t_baja_logica_cliente
	on Cliente
	instead of delete
	as
	begin
		update Cliente
		set borrado = 1
		where cod_cli = deleted.cod_cli
	end;

-- 7

drop procedure sp_eliminar_peliculas_no_alquiladas;

create procedure sp_eliminar_peliculas_no_alquiladas()
as
	begin try
		begin transaction
			delete from Pelicula
			where not exists(
				select a.cod_pel from Alquiler a
			)
		commit
	end try
	begin catch
		rollback
	end catch;

-- 8
drop procedure sp_eliminar_clientes_sin_alquileres;

create procedure sp_eliminar_clientes_sin_alquileres
as
	begin try
		begin transaction
			delete from Cliente
			where not exists(
				select a.cod_cli from Alquiler a
			)
		commit
	end try
	begin catch
		rollback
	end catch;
