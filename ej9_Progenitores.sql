-- crear la base de datos
create database ej9_Progenitores;

-- usar la base de datos
use ej9_Progenitores;

-- crear las tablas
CREATE TABLE Persona
(
	tipo_doc VARCHAR(3),
	nro_doc BIGINT,
	nombre VARCHAR(50),
	direccion VARCHAR(50),
	fecha_nac DATETIME,
	sexo VARCHAR(9),
	PRIMARY KEY (tipo_doc,nro_doc)
);

CREATE TABLE Progenitor
(
	tipo_doc VARCHAR(3),
	nro_doc BIGINT,
	t_doc_hijo VARCHAR(3),
	n_doc_hijo BIGINT,
	PRIMARY KEY (tipo_doc,nro_doc,t_doc_hijo,n_doc_hijo),
	FOREIGN KEY (tipo_doc,nro_doc) REFERENCES persona(tipo_doc,nro_doc),
	FOREIGN KEY (t_doc_hijo,n_doc_hijo) REFERENCES persona(tipo_doc,nro_doc)
);

-- cargar registros
INSERT INTO Persona(tipo_doc,nro_doc,nombre,direccion,fecha_nac,sexo)
VALUES
('LC',12345670,'Persona1','Direccion1','19700302','Masculino'),
('DNI',12345671,'Persona2','Direccion2','19800302','Femenino'),
('LC',12345672,'Persona3','Direccion3','19790602','Masculino'),
('DNI',12345673,'Persona4','Direccion4','19890310','Masculino'),
('LC',12345674,'Persona5','Direccion5','19700302','Femenino'),
('DNI',12345675,'Persona6','Direccion6','19881013','Masculino'),
('LC',12345676,'Persona7','Direccion7','19751223','Femenino'),
('DNI',12345677,'Persona8','Direccion8','19790704','Femenino'),
('DNI',12345678,'Persona9','Direccion9','19831005','Masculino'),
('DNI',12345679,'Persona10','Direccion10','19800312','Masculino'
);

INSERT INTO progenitor(tipo_doc,nro_doc,t_doc_hijo,n_doc_hijo)
VALUES
('LC',12345670,'DNI',12345671),('LC',12345672,'DNI',12345679),
('LC',12345670,'DNI',12345679),('LC',12345676,'DNI',12345678),
('LC',12345676,'DNI',12345677),('LC',12345674,'DNI',12345675),
('LC',12345674,'DNI',12345677),('LC',12345674,'DNI',12345678),
('LC',12345670,'DNI',12345675),('LC',12345672,'DNI',12345678);

-- consultas

-- 1
select p.tipo_doc, p.nro_doc, p.nombre, p.direccion, p.fecha_nac
from progenitor prog
right join persona p
on prog.t_doc_hijo = p.tipo_doc and prog.n_doc_hijo = p.nro_doc
where prog.tipo_doc = "DNI" and prog.nro_doc = "11222333";
-- en el where, dni y 11222333 son solo ejemplos, allí hay que
-- colocar tipo y número de documento de una persona para hallar los datos de todos sus hijos

-- 2a
create view hermanos
as
	select p1.t_doc_hijo as tipoDocP, p1.n_doc_hijo as nroDocP,
	p2.t_doc_hijo as tipoDoc, p2.n_doc_hijo as nroDoc
	from progenitor p1, progenitor p2
	where p1.tipo_doc = p2.tipo_doc and p1.nro_doc = p2.nro_doc
	and p1.t_doc_hijo <> p2.t_doc_hijo and p1.n_doc_hijo <> p2.n_doc_hijo;

select h.tipoDocP, h.nroDocP, h.tipoDoc, h.nroDoc,
p.nombre, p.direccion, p.fecha_nac
from hermanos h
inner join persona p
on h.tipoDoc = p.tipo_doc and h.nroDoc = p.nro_doc;

-- 2b
create view hijoProg
as
	select p.t_doc_hijo, p.n_doc_hijo, p.tipo_doc, p.nro_doc 
	from progenitor p;

select hp.t_doc_hijo, hp.n_doc_hijo, hp.tipo_doc, hp.nro_doc,
p.nombre, p.direccion, p.fecha_nac
from hijoProg hp
inner join persona p
on hp.tipo_doc = p.tipo_doc and hp.nro_doc = p.nro_doc
where p.sexo = 'Femenino';

-- 2c
create view hijoProg
as
	select p.t_doc_hijo, p.n_doc_hijo, p.tipo_doc, p.nro_doc 
	from progenitor p;

create view hijoPadre
as
	select hp.t_doc_hijo, hp.n_doc_hijo, hp.tipo_doc, hp.nro_doc
	from hijoProg hp
	inner join persona p
	on hp.tipo_doc = p.tipo_doc and hp.nro_doc = p.nro_doc
	where p.sexo = 'Masculino';

create view hijoMadre
as
	select hp.t_doc_hijo, hp.n_doc_hijo, hp.tipo_doc, hp.nro_doc
	from hijoProg hp
	inner join persona p
	on hp.tipo_doc = p.tipo_doc and hp.nro_doc = p.nro_doc
	where p.sexo = 'Femenino';

create view nietoAbuelo
as
	select hm.t_doc_hijo as t_doc_nieto, hm.n_doc_hijo as n_doc_nieto,
	hp.tipo_doc, hp.nro_doc
	from hijoMadre hm
	inner join hijoPadre hp
	on hm.tipo_doc = hp.t_doc_hijo and hm.nro_doc = hp.n_doc_hijo;

select na.t_doc_nieto, na.n_doc_nieto, na.tipo_doc, na.nro_doc,
p.nombre, p.direccion, p.fecha_nac
from nietoAbuelo na
inner join persona p
on na.tipo_doc = p.tipo_doc and na.nro_doc = p.nro_doc;

-- 2d
create view abueloNieto
as
	select p1.tipo_doc, p1.nro_doc,
	p2.t_doc_hijo as t_doc_nieto, p2.n_doc_hijo as n_doc_nieto
	from progenitor p1, progenitor p2
	where p1.t_doc_hijo = p2.tipo_doc and p1.n_doc_hijo = p2.nro_doc;

select an.tipo_doc, an.nro_doc, an.t_doc_nieto, an.n_doc_nieto,
p.nombre, p.direccion, p.fecha_nac
from abueloNieto an
inner join persona p
on an.tipo_doc = p.tipo_doc and an.nro_doc = p.nro_doc;
