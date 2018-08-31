-- crear base de datos
create database Diario

-- crear tabla de noticias
create table Noticia
(
Id int not null primary key,
Titulo varchar(300) not null,
Fecha date not null
)

-- crear tabla de autores
create table Autor
(
IdAutor int not null,
Nombre varchar(50) not null,
Apellido varchar(50) not null,
FechaNac date not null
)

-- borrar tabla de noticias
drop table Noticia
-- borrar tabla de autores
drop table Autor

-- Me olvide que necesitaba un campo con la nacionalidad:
-- ALTER table nombre 
-- ADD columna tipoDeDato modificadores
alter table Autor add Nacionalidad varchar(100) null
alter table Autor alter column Nombre varchar(80) not null

-- Me olvide que el idAutor es una PK:
alter table Autor add constraint PK_autor primary key (IdAutor)
alter table Noticia add IdAutor int not null
-- IdAutor debe ser FK:
alter table Noticia add constraint FK_autor foreign key (IdAutor) references Autor (IdAutor)
-- Ahora quiero quitar la constraint
alter table Noticia drop constraint FK_autor

-- ayuda sobre las tablas de la base de datos
sp_help Noticia
sp_help Autor

-- SELECT: selecciona datos. Es como una proyeccion en AR.
select * from Autor -- Me trae todo lo de Autor.
select * from Noticia -- me trae todo lo de noticias
select name, dbid from sysdatabases where name = 'master'
select name, dbid from sysdatabases where name like 'm%' or name like 'd%'
select name, dbid from sysdatabases where name in ('master','model')

-- ORDER BY: ordena lo que me devuelve un select, por un campo dado. Siempre se hace al final.
select * from sysdatabases order by dbid
select name from sysdatabases order by name

select * from sysdatabases order by dbid desc -- si le pongo desc me ordena de forma descendente.
select name from sysdatabases order by 1 -- ordena por el primer campo listado.

select s.name from sysdatabases as s

-- select * from tabla1 as t1, tabla2 as t2 where t1.id = t2.id -- es una junta a traves de un producto cartesiano y una seleccion.

-- select * from tabla1 as t1 inner join tabla2 as t2 on t1.id = t2.id -- junta natural.

-- select * from tabla1 as t1 left join tabla2 as t2 on t1.id = t2.id -- me trae todos los datos de la tabla de la izquierda independientemente que
-- esten o no en la tabla derecha.

-- select * from tabla1 as t1 right join tabla2 as t2 on t1.id = t2.id -- me trae todos los datos de la tabla de la derecha independientemente que
-- esten o no en la tabla izquierda.

-- select * from tabla1 as t1 full join tabla2 as t2 on t1.id = t2.id -- me trae todos los datos de la tabla de la izquierda independientemente que
-- esten o no en la tabla derecha, y me trae todos los datos de la tabla de la derecha independientemente que esten o no en la tabla izquierda.

-- select * from tabla1 as t1 cross join tabla2 as t2 -- multiplica de forma cartesiana t1 con t2.

-- select * from tabla1 t1 where t1.id >= all(select t2.id from tabla2 t2) -- la condición de mayor o igual se tiene que cumplir para todos los de
-- la tabla 2.

-- select * from tabla1 t1 where t1.id >= any(select t2.id from tabla2 t2) -- la condición de mayor o igual se tiene que cumplir para al menos uno
-- de la tabla 2 (tambien se puede poner some en lugar de any).

-- select * from tabla1 t1 where t1.id in (select t2.id from tabla2 t2 where t2.id > 4) -- si algun valor de t1 se encuentra en t2 (valores de id > 4)
-- los devuelve.