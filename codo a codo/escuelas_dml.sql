INSERT INTO escuelas(nombre, localidad, provincia, capacidad) 
    VALUES ('Normal 1','Quilmes','Buenos Aires',250),
        ('Gral. San Martín','San Salvador','Jujuy',100),
        ('Belgrano','Belgrano','Córdoba',150),
        ('EET Nro 2','Avellaneda','Buenos Aires',500),
        ('Esc. N° 2 Tomás Santa coloma','Capital Federal','Buenos Aires',250); 

INSERT INTO alumnos(id_escuela, legajo, nombre, apellido, nota, grado, email) VALUES (2,'1000','Ramón','Mesa',8,'1','rmesa@mail.com'),
        (2,'1002','Tomás', 'Smith',8,'1',''),
        (1,'101','Juan','Perez',10,3,''),
        (1,'105','Pietra', 'González',9,3,''),
        (5,'190','Roberto Luis', 'Sánchez',8,3,'robertoluissanchez@gmail.com'),(2,'106','Martín', 'Bossio',NULL,3,''),
        (4,'100','Paula', 'Remmi',3,1,'mail@mail.com'),
        (4,'1234','Pedro', 'Gómez',6,2,''),
        (NULL,'555','Arturo', 'Albarran', 6.75,'5','alba@gmail.com');
