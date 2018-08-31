-- crear la base de datos
create database ej12_StockDeProductos;

-- usar la base de datos
use ej12_StockDeProductos;

-- crear tablas
create table Proveedor
(
	codProv int not null,
	razonSocial varchar(20) not null,
	fechaInicio date not null,
	primary key(codProv)
);

create table Producto
(
	codProv int not null,
	descripcion varchar(30) not null,
	codProd int not null,
	stockActual int not null,
	primary key(codProd),
	foreign key(codProv) references Proveedor(codProv)
);

create table Stock
(
	nro int not null,
	fecha date not null,
	codProd int not null,
	cantidad int not null,
	primary key(nro, fecha, codProd),
	foreign key(codProd) references Producto(codProd)
);

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

-- consignas

-- 1
drop procedure p_EliminaSinStock;

create procedure p_EliminaSinStock()
as
	begin try
		begin transaction
			delete from Producto
			where stockActual = 0;
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_EliminaSinStock;

-- 2
drop procedure p_ActualizaStock;

create procedure p_ActualizaStock()
as
	begin try
		begin transaction
			update Producto p
			set p.stockActual = s.cantidad
			from Producto p
			inner join Stock s
			on p.codProd = s.codProd
			inner join (
				select s.codProd, max(s.fecha) as ultimaFecha
				from Stock s
				group by s.codProd
			) UltimaActualizacion ua
			on s.codProd = ua.codProd
			and s.fecha = ua.ultimaFecha
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_ActualizaStock;

-- 3
drop procedure p_DepuraProveedor;

create procedure p_DepuraProveedor()
as
	begin try
		begin transaction
			select distinct prov.codProv into #ProveedoresADepurar
			from Proveedor prov
			inner join Producto prod on prov.codProv = prod.codProv
			inner join Stock s on prod.codProd = s.codProd
			inner join (
				select ua.codProd, max(s.fecha) as ultimaFecha
				from Stock s
				group by s.codProd
			) f on s.codProd = f.codProd and s.fecha = f.ultimaFecha
			where s.cantidad = 0 and s.fecha < dateAdd(year, -1, getDate());

			delete from Producto
			where codProv exists (
				select pad.codProv from #ProveedoresADepurar pad
			);

			delete from Proveedor
			where codProv exists (
				select pad.codProv from #ProveedoresADepurar pad
			);
		commit
	end try
	begin catch
		rollback
	end catch;

	execute p_DepuraProveedor;

-- 4
drop procedure p_InsertStock;

create procedure p_InsertStock(@nro int, @fecha date, @codProd int, @cantidad int)
as
	begin try
		begin transaction
			if exists (select p.codProd from Producto p where p.codProd = @codProd)
				if @cantidad > 0
					if @nro = ((select max(s.nro) from Stock s where s.codProd = @codProd) + 1)
						insert into Stock(nro, fecha, codProd, cantidad)
							values(@nro, @fecha, @codProd, @cantidad)
					else
						print 'El número de stock ingresado debe ser correlativo al último ingresado para ese código de producto'
				else
					print 'La cantidad ingresada del producto debe ser mayor a cero'
			else
				print 'El código de producto ingresado no existe'
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_InsertStock 13, '03/11/2017', 10, 0;

-- 5
drop trigger tg_CrearStock;

create trigger tg_CrearStock on Producto
after insert
as
	declare @nro int
	set @nro = ((select max(s.nro) from Stock s where s.codProd = inserted.codProd) + 1)
	insert into Stock(nro, fecha, codProd, cantidad)
		values(@nro, getDate(), inserted.codProd, inserted.stockActual);

-- 6
drop procedure p_ListaSinStock;

create procedure p_ListaSinStock()
as
	begin try
		begin transaction
			select s.codProd, prod.descripcion, prov.razonSocial, s.cantidad
			from Stock s
			inner join (
				select distinct s.codProd, max(s.fecha) as ultimaFecha
				from Stock s
				inner join (
					select distinct s.codProd
					from Stock s
					where s.cantidad = 0 and s.fecha < dateAdd(month, -1, getDate())
				) ss
				on s.codProd = ss.codProd
				where s.cantidad > 0
				group by s.codProd
			) t
			on s.codProd = t.codProd and s.fecha = t.ultimaFecha
			inner join Producto prod
			on s.codProd = prod.codProd
			inner join Proveedor prov
			on prod.codProv = prov.codProv
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_ListaSinStock;

-- 7
drop procedure p_ListaStock;

create procedure p_ListaStock()
as
	begin try
		begin transaction
			select s.fecha,
			(select count(distinct s.codProd) from Stock ss where ss.cantidad > 1000 and ss.fecha <= s.fecha) as '>1000',
			(select count(distinct s.codProd) from Stock ss where ss.cantidad < 1000 and ss.fecha <= s.fecha) as '<1000',
			(select count(distinct s.codProd) from Stock ss where ss.cantidad = 0 and ss.fecha <= s.fecha) as '=0'
			from Stock s
			group by s.fecha
		commit
	end try
	begin catch
		rollback
	end catch;

execute p_ListaStock;

-- 8
drop trigger tg_ActualizarStockActual;

create trigger tg_CargaStock on Stock
after insert
as
	execute p_ActualizaStockActual inserted.codProd, inserted.cantidad;

drop procedure p_ActualizaStockActual;

create procedure p_ActualizaStockActual(@codProd int, @cantidad int)
as
	begin try
		begin transaction
			update Producto
			set stockActual = stockActual + @cantidad
			where codProd = @codProd
		commit
	end try
	begin catch
		rollback
	end catch;

/* necesitaría hacer un trigger instead of update que no permita actualizar producto,
pero yo tampoco podría hecerlo desde este último procedure
-_-
*/