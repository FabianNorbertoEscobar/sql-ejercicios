-- elimino la BD escuelas_db
DROP DATABASE escuelas_db;

-- creo nuevamente la base de datos escuelas_db
-- para si crear en está las tablas con la nueva estructura
CREATE DATABASE escuelas_db;

-- le indico que DB utilizar
USE escuelas_db;

-- creo la tabla escuelas
CREATE TABLE escuelas (
  id_escuela INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(45) DEFAULT NULL,
  localidad VARCHAR(45) DEFAULT NULL,
  provincia VARCHAR(45) DEFAULT NULL,
  capacidad INT DEFAULT NULL
);

-- creo la tabla alumnos
CREATE TABLE alumnos (
  id_alumno INT NOT NULL AUTO_INCREMENT,
  id_escuela INT DEFAULT NULL,
  legajo VARCHAR(40) DEFAULT NULL,
  nombre VARCHAR(20) DEFAULT NULL,
  apellido VARCHAR(20) DEFAULT NULL,
  nota decimal(3,2) DEFAULT NULL,
  grado VARCHAR(5),
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_alumnos),
  FOREIGN KEY (id_escuela) REFERENCES escuelas(id_escuela)
);