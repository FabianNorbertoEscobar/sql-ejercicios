CREATE DATABASE instituto_db;

USE instituto_db;

-- creacion de las tablas
CREATE TABLE generos(
    id_genero INT PRIMARY KEY AUTO_INCREMENT,
    genero VARCHAR(20)
);

CREATE TABLE niveles (
    id_nivel INT AUTO_INCREMENT,
    nivel VARCHAR(5),
    PRIMARY KEY (id_nivel)
);

CREATE TABLE instructores (
    id_instructor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    email VARCHAR(20)
);

DROP TABLE alumnos;

CREATE TABLE alumnos (
    legajo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    email VARCHAR(40),
    genero INT,
    nota1 DECIMAL(3,2),
    nota2 DECIMAL(3,2),
    notaf DECIMAL(3,2),
    nivel INT,
    instructor INT,
    FOREIGN KEY(genero) REFERENCES generos(id_genero),
    FOREIGN KEY(nivel) REFERENCES niveles(id_nivel),
    FOREIGN KEY(instructor) REFERENCES instructores(id_instructor)
);

