
-- inserto un registro vacio para verificar que todas
-- aquellas columnas DEFAULT NULL asignen por defecto el valor NULL
INSERT INTO escuelas VALUES ();

-- muestra todos lo registros de la tabla escuelas
SELECT * FROM escuelas;

-- muestra todos lo registros de la tabla alumnos
SELECT * FROM alumnos;

-- insertamos un alumno cuya escuela no está en la tabla escuelas
INSERT INTO alumnos(id_escuela, nombre) VALUES(9, 'Jose'); -- devuelve un error

--  1) Seleccionar todos los datos de la tabla alumnos:
SELECT * FROM alumnos;

--  2) Seleccionar solamente el legajo y el nombre de los alumnos:
SELECT legajo, nombre FROM alumnos;

--  3) Mostrar todos los datos de aquellos alumnos aprobados (con notas mayores o iguales a 7)
SELECT * FROM alumnos WHERE nota >= 7;

--  4) Mostrar el id y el nombre de aquellas escuelas cuya capacidad sea inferior a 200 (no mostrar la columna capacidad).
SELECT id_escuela, nombre FROM escuelas WHERE capacidad < 200;

--  5) Mostrar el nombre y la nota de aquellos alumnos cuya nota se encuentre entre 8 y 10
SELECT nombre, nota FROM alumnos WHERE nota >= 8 AND nota <= 10;
-- 
SELECT nombre, nota FROM alumnos WHERE nota > 6 AND nota < 10;

--  6) Repetir el ejercicio anterior, utilizando BETWEEN
SELECT nombre, nota FROM alumnos WHERE nota BETWEEN 8 AND 10;
SELECT nombre, nota FROM alumnos WHERE nota BETWEEN 6.7 AND 10;

--  7) Mostrar el nombre, la localidad y la provincia de aquellas escuelas situadas en Buenos Aires o Jujuy
SELECT nombre, localidad, provincia FROM escuelas WHERE provincia = 'Buenos Aires' OR provincia = 'Jujuy';

-- quiero todas aquellas escuelas que NO estén en Buenos Aires o Jujuy 
SELECT nombre, localidad, provincia FROM escuelas WHERE NOT provincia = 'Buenos Aires' AND NOT provincia = 'Jujuy';
-- forma alterna al NOT -> Operador distinto de !=/<>
SELECT nombre, localidad, provincia FROM escuelas WHERE provincia != 'Buenos Aires' AND provincia <> 'Jujuy';

-- 8) Mostrar todos los datos de los alumnos llamados Pietra González
SELECT * FROM alumnos WHERE nombre = 'Pietra' AND apellido = 'González';
SELECT * FROM alumnos WHERE nombre LIKE 'Pi%' AND apellido LIKE 'G%';

-- 9) Repetir el ejercicio anterior, pero con aquellos que no se llamen Pietra González
SELECT * FROM alumnos WHERE nombre NOT LIKE 'Pi%' AND apellido NOT LIKE 'G%'

-- 10) Mostrar todos los datos de los alumnos cuyo nombre comience con R
SELECT * FROM alumnos WHERE nombre LIKE 'Ra%';

-- 11) Mostrar todos los datos de los alumnos cuyo apellido termine con Z
SELECT * FROM alumnos WHERE apellido LIKE '%alez';

-- 12) Mostrar todos los datos de los alumnos cuyo nombre contenga una M
SELECT * FROM alumnos WHERE nombre LIKE '%m%';





