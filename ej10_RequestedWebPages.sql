-- crear la base de datos
create database ej10_RequestedWebPages;

-- usar la base de datos
use ej10_RequestedWebPages;

-- crear tablas
CREATE TABLE Ambiente
(
	ID int PRIMARY KEY,
	Descripcion varchar(100) NOT NULL
);

CREATE TABLE Metodo
(
	ID int PRIMARY KEY,
	Clase varchar(45) NOT NULL,
	Metodo varchar(45) NOT NULL
);

CREATE TABLE Page
(
	IP varchar(45) PRIMARY KEY,
	WebPage varchar(45) NOT NULL,
	ID_Ambiente int,
	FOREIGN KEY (ID_Ambiente) REFERENCES Ambiente(ID)
);

CREATE TABLE Request
(
	NoRequest int PRIMARY KEY,
	IP varchar(45) NOT NULL,
	Fecha date NOT NULL,
	Hora time NOT NULL,
	ID_Metodo int,
	FOREIGN KEY(IP) REFERENCES Page(IP),
	FOREIGN KEY(ID_Metodo) REFERENCES Metodo(ID)
);

-- cargar registros
INSERT INTO Ambiente (ID,Descripcion) VALUES (1,'DESC_AMB_1');
INSERT INTO Ambiente (ID,Descripcion) VALUES (2,'DESC_AMB_2');
INSERT INTO Ambiente (ID,Descripcion) VALUES (3,'DESC_AMB_3');
INSERT INTO Ambiente (ID,Descripcion) VALUES (4,'DESC_AMB_4');
INSERT INTO Ambiente (ID,Descripcion) VALUES (5,'DESC_AMB_5');
INSERT INTO Ambiente (ID,Descripcion) VALUES (6,'DESC_AMB_6');
INSERT INTO Ambiente (ID,Descripcion) VALUES (7,'DESC_AMB_7');
INSERT INTO Ambiente (ID,Descripcion) VALUES (8,'DESC_AMB_8');
INSERT INTO Ambiente (ID,Descripcion) VALUES (9,'DESC_AMB_9');
INSERT INTO Ambiente (ID,Descripcion) VALUES (10,'DESC_AMB_10');

INSERT INTO Metodo (ID,Clase,Metodo) VALUES (1,'Clase 1','Metodo 1');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (2,'Clase 2','Metodo 2');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (3,'Clase 3','Metodo 3');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (4,'Clase 4','Metodo 4');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (5,'Clase 5','Metodo 5');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (6,'Clase 6','Metodo 6');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (7,'Clase 7','Metodo 7');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (8,'Clase 8','Metodo 8');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (9,'Clase 9','Metodo 9');
INSERT INTO Metodo (ID,Clase,Metodo) VALUES (10,'Clase 10','Metodo 10');

INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.1','Pagina 1',1);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.2','Pagina 2',2);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.3','Pagina 3',3);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.4','Pagina 4',4);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.5','Pagina 5',5);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.6','Pagina 6',6);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.7','Pagina 7',7);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.8','Pagina 8',8);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.9','Pagina 9',9);
INSERT INTO Page (IP,WebPage,ID_Ambiente) VALUES
('10.0.0.10','Pagina 10',10);

INSERT INTO Request VALUES (1,'10.0.0.1','2011-01-01','12:45:00',1);
INSERT INTO Request VALUES (2,'10.0.0.2','2011-04-24','13:17:21',2);
INSERT INTO Request VALUES (3,'10.0.0.3','2010-05-30','09:26:15',3);
INSERT INTO Request VALUES (4,'10.0.0.4','2011-10-08','11:06:54',4);
INSERT INTO Request VALUES (5,'10.0.0.5','2011-09-08','05:14:23',5);
INSERT INTO Request VALUES (6,'10.0.0.6','2011-07-15','23:02:11',6);
INSERT INTO Request VALUES (7,'10.0.0.7','2011-06-17','22:50:11',7);
INSERT INTO Request VALUES (8,'10.0.0.8','2011-08-29','18:45:52',8);
INSERT INTO Request VALUES (9,'10.0.0.9','2011-08-22','15:36:12',9);
INSERT INTO Request VALUES (10,'10.0.0.10','2010-12-15','20:02:31',10);

-- consultas

-- 1
Select P.IP, count(distinct fecha), count(distinct IDMetodo),
max(fecha)
From Page P Inner join Request R on P.IP=R.IP
Group by P.IP;

-- 2
Select *
From Ambiente A
Where id not in
(Select idambiente
From Page P
Where not exists (
Select 1 From Request R
Where R.IP=P.IP and fecha>= date()-7));

-- 3
Select Fecha, count(*)
From Request R
Where hora between '00:00' and '04:00'
and not exists(
select 1 from Page P
inner join Ambiente A on P.IDAmbiente = A.ID
where R.IP=P.IP AND A.Descripcion='Desarrollo' )
Group by fecha
Having count(*) >= 10;

-- 4
Select W.WebPage, A.Descripcion, max(R.fecha), 'S'
From Request R
Inner join WebPage W on R.IP=W.IP
Inner join Ambiente A on A.id=W.IDAmbiente
Where R.Fecha>=date()-7 and W.Webpage like 'www%'
Group by W.WebPage, A.Descripcion
Having count(distinct fecha)>=7;

-- 5
Select W.WebPage, A.Descripcion,
max(case when R2.fecha is null then ‘01/01/1900’ else R2.fecha
end), 'N'
From WebPage W Left join (
Select IP, max(fecha)From Request R
Group by IP )
R2 on R2.IP = W.IP
Where W.Webpage like 'ftp%' and
not exists (
Select 1
from Request R
where R.IP=W.IP and R.Fecha>=date()-7
group by R.IP
having count(*)>=7)
Group by W.WebPage, A.Descripcion;

-- 6
insert into Page
select IP, 'Web ' + IDMetodo, '?'
from request R
where not exists (
Select 1 from Page P
where R.IP=P.IP )
and IDMetodo in (select ID from Metodo)
and fecha>=date()-30;
