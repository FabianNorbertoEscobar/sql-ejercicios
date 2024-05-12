USE escuelas_db;

-- se insertan valores NULL en cada una de las columnas
-- que admiten NULL (nombre, localidad, provincia y capacidad)
INSERT INTO escuelas VALUES ();

-- muestra todos lo registros de la tabla escuelas
SELECT * FROM escuelas;

-- muestra todos lo registros de la tabla alumnos
SELECT * FROM alumnos;

-- insertamos un alumno cuya escuela no está en la tabla escuelas
/* INSERT INTO alumnos (id_escuela, nombre)
    VALUES (9, "Gral. Belgrano");  devuelve un error*/

-- borramos un registro -> DELETE FROM nombre_tabla -> CUIDADO ya 
-- que borra todos los registros de la tabla
-- DROP TABLE nombre_tabla
DELETE FROM alumnos WHERE id_alumno = 19;

-- ****************** Actividad ******************
-- 1) Seleccionar todos los datos de la tabla alumnos:
SELECT * FROM alumnos;

-- 2) Seleccionar solamente el legajo y el nombre de los alumnos:
SELECT legajo, nombre FROM alumnos;

-- 3) Mostrar todos los datos de aquellos alumnos aprobados (con notas mayores o iguales a 7)
SELECT * FROM alumnos WHERE nota >= 7;

-- 4) Mostrar el id y el nombre de aquellas escuelas cuya capacidad sea inferior a 200 (no mostrar la columna capacidad).
SELECT id_escuela, nombre, capacidad FROM escuelas WHERE capacidad < 200;

-- 5) Mostrar el nombre y la nota de aquellos alumnos cuya nota se encuentre entre 8 y 10
SELECT nombre, nota FROM alumnos WHERE nota >= 8 AND nota <= 10;

-- 6) Repetir el ejercicio anterior, utilizando BETWEEN
SELECT nombre, nota FROM alumnos WHERE nota BETWEEN 8 AND 10;

-- 7) Mostrar el nombre, la localidad y la provincia de aquellas escuelas situadas en Buenos Aires o Jujuy
SELECT nombre, localidad, provincia FROM escuelas WHERE provincia = 'Buenos Aires' OR provincia = 'Jujuy';

-- 8) Mostrar todos los datos de los alumnos llamados Pietra González
SELECT * FROM alumnos WHERE nombre = 'Pietra' AND apellido = 'Gonzalez';

-- 9) Repetir el ejercicio anterior, pero con aquellos que no se llamen Pietra González
SELECT * FROM alumnos WHERE nombre <> 'Pietra' AND apellido != 'Gonzalez'; 
-- <> equivale a != (distinto de)
SELECT * FROM alumnos WHERE apellido != 'Pietra'; 

-- 10) Mostrar todos los datos de los alumnos cuyo nombre comience con R
-- LIKE
SELECT * FROM alumnos WHERE nombre LIKE 'R%';

-- 11) Mostrar todos los datos de los alumnos cuyo apellido termine con Z
SELECT * FROM alumnos WHERE apellido LIKE '%z';

-- 12) Mostrar todos los datos de los alumnos cuyo nombre contenga una M
SELECT * FROM alumnos WHERE nombre LIKE '%m%';
-- 
-- USOS DE JOIN Y ALIAS PARA TABLAS Y CAMPOS
-- 13) Mostrar el legajo, el nombre del alumno y el nombre de la escuela de todos los alumnos
USE escuelas_db;

SELECT alumnos.legajo, alumnos.nombre, escuelas.nombre FROM alumnos INNER JOIN escuelas ON alumnos.id_escuela = escuelas.id_escuela;

SELECT al.legajo, al.nombre, es.nombre FROM alumnos AS al INNER JOIN escuelas AS es ON al.id_escuela = es.id_escuela;
SELECT al.legajo, al.nombre, es.nombre FROM alumnos al INNER JOIN escuelas es ON al.id_escuela = es.id_escuela;

-- ALT + Z

SELECT a.legajo AS 'Legajo', a.nombre AS 'Alumno', e.nombre AS 'Escuela'
    FROM alumnos a INNER JOIN escuelas e ON a.id_escuela = e.id_escuela;

-- 14) Modificar el ejercicio anterior utilizando alias de tablas y alias de columnas de modo tal que los datos se muestren de esta manera:Legajo, Nombre alumno, Nombre escuela

-- 15) Mostrar todos los alumnos, tengan o no escuela asignada.
SELECT a.legajo AS 'Legajo', a.nombre AS 'Alumno', e.nombre AS 'Escuela' FROM alumnos a LEFT JOIN escuelas e ON a.id_escuela = e.id_escuela;

-- 16) Mostrar todas las escuelas con el nombre de cada alumno (aunque a la escuela no asista ningún alumno).
SELECT e.nombre, a.nombre, a.apellido 
    FROM alumnos a 
    RIGHT JOIN escuelas e ON a.id_escuela = e.id_escuela;

SELECT e.nombre, a.nombre, a.apellido 
    FROM escuelas e 
    LEFT JOIN alumnos a ON a.id_escuela = e.id_escuela;

-- USO DE IS NULL / IS NOT NULL

-- 17) Mostrar todos los datos de los alumnos que tengan notas.
SELECT nombre, nota FROM alumnos WHERE nota IS NOT NULL;

-- 18) Mostrar todos los datos de los alumnos que no tengan notas.
SELECT * FROM alumnos WHERE nota IS NULL;

-- ALTER TABLE
-- 19) Realizar lo siguiente:
--   a) Agregar a través de Alter Table una en la tabla escuelas columna llamada “Partido”, a la derecha de Localidad con una cadena vacía como valor por defecto (armar la sentencia a través de Alter Table y ejecutar desde la consulta).
--   b) Ejecutar una consulta donde se vean todos los campos para confirmar que se ha agregado el campo “partido”.
--   c) Eliminar esa columna utilizando Alter Table, no es necesario ejecutarlo desde la consulta.
ALTER TABLE escuelas ADD COLUMN partido VARCHAR(20) DEFAULT "" AFTER localidad;

-- b)
SELECT * FROM escuelas;

-- c)
ALTER TABLE escuelas DROP COLUMN partido;

-- LIMIT Y ORDER BY
-- 22) Obtener un ranking de las primeras 3 escuelas de mayor capacidad.
SELECT * FROM escuelas ORDER BY capacidad DESC, localidad  LIMIT 3;

-- FUNCIONES DE AGREGACIÓN Y AGRUPAMIENTO / USO DE IN
-- 23) Contar la cantidad de alumnos de la tabla homónima. Llamar a la columna “Cantidad de alumnos”.
SELECT COUNT(*) AS Cant_Alumnos FROM alumnos;
SELECT COUNT(id_escuela) AS Cant_Alumnos FROM alumnos;

SELECT * FROM alumnos;

-- COUNT(*) nos cuentas todas las filas sin importar los NULL
-- COUNT(col_name) me saca los NULL

-- 24) Repetir la consulta anterior consultando solamente cuya nota sea menor a 7.
SELECT COUNT(*) "Cantidad de alumnos con nota menor a 7" FROM alumnos WHERE nota < 7;

-- 25) Obtener la capacidad total de las escuelas de la provincia de Buenos Aires
SELECT SUM(capacidad) FROM escuelas WHERE provincia = 'Buenos Aires';

SELECT * FROM escuelas;

-- 26) Repetir el ejercicio anterior pero solamente con las escuelas de Córdoba y Jujuy
SELECT SUM(capacidad)  FROM escuelas 
    WHERE provincia ='Cordoba' OR provincia = 'Jujuy';

SELECT SUM(capacidad)  FROM escuelas 
    WHERE provincia IN ('Cordoba', 'Jujuy');

SELECT SUM(capacidad)  FROM escuelas 
    WHERE provincia IN ('Jujuy','Cordoba');

-- 27) Obtener el promedio de notas de los alumnos aprobados con más de 7
-- AVG -> Average
SELECT AVG(nota) FROM alumnos WHERE nota > 7;

-- 28) Obtener la capacidad máxima y la capacidad mínima de alumnos
SELECT MAX(capacidad), MIN(capacidad) FROM escuelas;

-- 29) Obtener el total de capacidad de las escuelas por provincia
SELECT * FROM escuelas;

SELECT provincia, SUM(capacidad) FROM escuelas GROUP BY provincia;

-- 30) Obtener la cantidad de alumnos por grado
SELECT nombre, grado FROM alumnos;
SELECT grado,COUNT(*) FROM alumnos GROUP BY grado;

-- DIFERENCIAS ENTRE HAVING Y WHERE
-- 31) Mostrar las escuelas y la nota máxima para cada una siempre y cuando sean mayores o iguales a 7.
SELECT a.nombre, e.nombre, MAX(a.nota)
    FROM alumnos a INNER JOIN escuelas e
    ON a.id_escuela = e.id_escuela WHERE nota >= 7;

SELECT a.nombre, e.nombre, a.nota
    FROM alumnos a INNER JOIN escuelas e
    ON a.id_escuela = e.id_escuela WHERE nota >= 7;

SELECT a.nombre, e.nombre, MAX(a.nota)
    FROM alumnos a INNER JOIN escuelas e
    ON a.id_escuela = e.id_escuela 
    WHERE nota >= 7
    GROUP BY e.nombre;

SELECT e.nombre,a.nombre, MAX(a.nota),a.nombre 
    FROM alumnos a INNER JOIN escuelas e 
    ON a.id_escuela = e.id_escuela  
    GROUP BY e.nombre
    HAVING MAX(a.nota) >=7;

SELECT provincia,SUM(capacidad) 
    FROM escuelas
    GROUP BY provincia
    HAVING SUM(capacidad) > 100;

-- SUBCONSULTAS
-- 32) Mostrar la información de las escuelas cuyos alumnos tengan una nota igual a 10(9.99), utilizando una subconsulta.

-- primero obtenemos el/los alumnos que tengan una nota igual a 9.99
SELECT * FROM alumnos WHERE nota = 9.99;

-- alumnos tiene la FK id_escula
-- obtengo el id_escuela(de la tabla alumnos) para el cual el alumno tiene una nota de 9.99
SELECT id_escuela FROM alumnos WHERE nota = 9.99;

SELECT nombre FROM escuelas 
    WHERE id_escuela = (SELECT id_escuela FROM alumnos WHERE nota = 9.99);
-- lo anterior equivale a SELECT * FROM escuelas WHERE id_escuela = 1; 

-- obtengo el mismo resultado al realizar un INNER JOIN
SELECT e.nombre FROM escuelas e
    INNER JOIN alumnos a
    ON e.id_escuela = a.id_escuela
    WHERE a.nota = 9.99;

-- se realizar el inciso 28) haciendo uso de subconsulta
SELECT nombre, capacidad 
    FROM escuelas WHERE capacidad = (SELECT MAX(capacidad) FROM escuelas);
-- lo anterior equivale a SELECT nombre, capacidad FROM escuelas WHERE capacidad = 500;

SELECT * FROM escuelas;


