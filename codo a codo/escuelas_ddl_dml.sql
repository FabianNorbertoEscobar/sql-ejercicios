-- esto es un comentario de una sola línea
# esto es un comentario de una sola línea
/* Esto es un 
comentario 
multilinea
*/

-- creación de la base de datos escuelas
CREATE DATABASE escuelas_db;

-- indico la base de datos a utilizar
USE escuelas_db;

-- creamos la tabla escuelas -> CREATE TABLE nombre_tabla
CREATE TABLE escuelas (
    id INT,
    nombre VARCHAR(20)
);

-- insertamos registros a la escuelas -> INSERT INTO nombre_tabla VALUES
INSERT INTO escuelas VALUES (1, 'Normal 1'),(2,'General Belgrano');

-- consultar los registros que tiene mi tabla escuelas
SELECT * FROM escuelas;

-- inserto un nuevo registro que tiene un id que ya está en la taba escuelas
INSERT INTO escuelas VALUES (1, 'Gral. San Martín');

-- eliminar la tabla escuelas -> DROP TABLE table_name
DROP TABLE escuelas;

-- creamos nuevamente la tabla escuelas teniendo la Pk
CREATE TABLE escuelas (
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    localidad VARCHAR(20),
    provincia VARCHAR(15)
);

-- inserto 2 registros en la tabla escuelas
INSERT INTO escuelas VALUES
     (1, 'Normal 1', 'La Plata', 'Bs As'),
     (2,'General Belgrano', 'La Quiaca', 'Jujuy');

-- obtengo las columnas nombre, locaidad de todos los registros
--  de la tabla escuelas 
SELECT nombre, localidad FROM escuelas;


INSERT INTO escuelas VALUES
     (3, 'Tecnica 2', 'La Plata', 'Bs As');

-- necesitamos modificar la col ID para que sea del tipo incremental
ALTER TABLE escuelas MODIFY COLUMN id INT AUTO_INCREMENT;

-- al no especificar el id este lo agrega mysql al tomar le ultimo id
-- e incrementarlo en 1
INSERT INTO escuelas(nombre,localidad) VALUES
     ('Tecnica 2', 'Quilmes');

-- inserto un nuevo registro con id 6 
INSERT INTO escuelas(id, nombre,localidad, provincia) VALUES
     (6,'Normal 5 ', 'Quilmes', 'Bs As');

-- no especifico el id pero dado que el ultimo registro insertado tiene
-- id 6 el nuevo registro se agregará con el id 7
INSERT INTO escuelas (nombre, localidad, provincia) VALUES
	('Normal 5', 'Quilmes', 'Buenos Aires');
