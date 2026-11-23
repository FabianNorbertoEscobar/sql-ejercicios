# SQL-ejercicios

Repositorio de práctica del curso de bases de datos y SQL. Reúne apuntes ejecutables, modelos de datos, cargas de ejemplo y consultas resueltas sobre distintos escenarios. No es una aplicación: el objetivo es practicar cómo diseñar y modificar bases relacionales, cargar información y consultarla.

## Stack y herramientas

- **Bases de datos relacionales** y **SQL** como lenguaje de definición, manipulación y consulta de datos.
- Los ejercicios combinan sintaxis de **MySQL** (por ejemplo, `AUTO_INCREMENT`, `LIMIT` y `MODIFY COLUMN`) y de **Microsoft SQL Server / T-SQL** (por ejemplo, procedimientos con parámetros, tablas temporales `#...`, `TRY/CATCH`, transacciones y `DATEADD`). La sintaxis varía entre archivos; no todos los scripts son portables entre motores.
- Los archivos están escritos en texto plano (`.sql`), con comentarios y ejemplos de datos. En `codo a codo/` también hay archivos `.csv` de datos y consignas en texto, además de un PDF de práctica.
- No hay una aplicación, framework ni dependencias de proyecto que instalar. Para ejecutar los ejemplos se necesita un servidor SQL compatible con el dialecto del archivo y un cliente, como MySQL Workbench o SQL Server Management Studio.

## Contenido del repositorio

### Ejercicios SQL

Los archivos `ej00_...sql` a `ej14_...sql` presentan casos independientes. En general, cada ejercicio define su propia base de datos, crea tablas y plantea consultas sobre el escenario:

| Archivo | Escenario principal |
| --- | --- |
| `ej00_Diario.sql` | Diario, noticias y autores; creación y modificación de tablas, claves, consultas y relaciones. |
| `ej01_ArticulosDeAlmacen.sql` | Almacenes, artículos, materiales y proveedores; relaciones muchos-a-muchos y consultas. |
| `ej02_ProveedoresDeArticulos.sql` | Proveedores, artículos, clientes, pedidos y stock; vistas, agregaciones y consultas de conjuntos. |
| `ej03_VendedoresDeProductos.sql` | Ventas, clientes, vendedores, productos, direcciones y detalles de factura. |
| `ej04_EmpleadosDeEmpresa.sql` | Consultas sobre empleados y estructura de empresa. |
| `ej05_PrestamoDePeliculas.sql` | Películas, ejemplares, clientes y préstamos; vistas, subconsultas y conteos. |
| `ej06_PasajerosDeVuelos.sql` | Vuelos, aviones y pasajeros; vistas y consultas agregadas. |
| `ej07_ViajesEnAuto.sql` | Datos y consultas relacionados con viajes en automóvil. |
| `ej08_Bares.sql` | Modelo y consultas de bares. |
| `ej09_Progenitores.sql` | Personas y vínculos de progenitor; consultas de relaciones familiares mediante vistas. |
| `ej10_RequestedWebPages.sql` | Páginas web, ambientes, métodos y solicitudes; consultas de actividad y fechas. |
| `ej11_AlquilerDePeliculas.sql` | Alquiler de películas y operaciones sobre sus datos. |
| `ej12_StockDeProductos.sql` | Productos, proveedores e historial de stock; procedimientos almacenados, transacciones y triggers. |
| `ej13_Metricas.sql` | Consultas de métricas. |
| `ej14_ServiciosParaFestejos.sql` | Servicios contratados para festejos; procedimientos, transacciones y triggers. |
| `ej00_anexo_COST_Metodos_de_Junta.sql` | Anexo de datos para experimentar con métodos de junta y el volumen de resultados. |
| `pruebas.sql` | Consultas y pruebas auxiliares. |

### Prácticas de `codo a codo/`

Esta carpeta contiene una práctica centrada en escuelas y alumnos, junto con otros ejercicios de definición de tablas:

- `escuelas_ddl_dml.sql`, `escuelas_ddl.sql` y `escuelas_dml.sql`: creación y evolución del esquema de escuelas, inserciones y ejemplos iniciales. Hay variantes del material; revisá el contenido antes de ejecutarlas en conjunto.
- `escuelas_dml.sql`: datos de ejemplo para escuelas y alumnos.
- `queries.sql`, `queries_completo.sql`: consignas y consultas de selección, filtros, joins y agregaciones.
- `enunciados_escuelas.txt`: consignas de las consultas.
- `alumnos.csv` e `instructores.csv`: datos tabulares de ejemplo.
- `instituto_ddl.sql`: definición de tablas para una base de datos de instituto.

`PrácticaSQL.pdf` acompaña el material de ejercicios.

## Temas y funcionalidades practicadas

- **Modelado relacional:** tablas, tipos de datos, claves primarias y foráneas, restricciones, relaciones uno-a-muchos y muchos-a-muchos.
- **DDL (definición de datos):** `CREATE DATABASE`, `CREATE TABLE`, `ALTER TABLE` y `DROP`; agregar y modificar columnas, definir claves y cambiar estructuras.
- **DML (manipulación de datos):** `INSERT`, `UPDATE` y `DELETE`, con datos de prueba y referencias entre tablas.
- **Consultas:** `SELECT`, proyección de columnas, alias, `DISTINCT`, `WHERE`, operadores de comparación y lógicos, `BETWEEN`, `IN`, `LIKE`, `IS NULL`, y ordenamiento y paginación con `ORDER BY` y `LIMIT`.
- **Combinación de tablas:** `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` y ejemplos comentados de otras juntas; uso de claves para relacionar tablas.
- **Consultas anidadas y conjuntos:** subconsultas correlacionadas y no correlacionadas, `EXISTS`, `NOT EXISTS`, `ANY`/`ALL` e intersecciones expresadas mediante condiciones.
- **Agregación:** `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY` y `HAVING`.
- **Abstracción y lógica de base de datos:** vistas, procedimientos almacenados, parámetros, tablas temporales, triggers y lógica condicional.
- **Transacciones y errores:** ejemplos de `BEGIN TRANSACTION`, `COMMIT`, `ROLLBACK` y bloques `TRY/CATCH` en T-SQL.
- **Fechas y datos de negocio:** filtros por períodos, cálculos y resúmenes para pedidos, préstamos, vuelos, solicitudes web, stock y servicios.

## Cómo usar los ejercicios

1. Abrí el archivo que quieras estudiar y verificá qué motor SQL y dialecto requiere.
2. Revisá las instrucciones del script: algunos crean una base de datos, cambian de esquema o eliminan objetos existentes.
3. Ejecutá el DDL antes de las inserciones y consultas que dependan de esas tablas. Los archivos son prácticas independientes y pueden reutilizar nombres de bases u objetos; ejecutalos por separado en una base de pruebas.
4. En `codo a codo/`, cargá primero el esquema y los datos de ejemplo que correspondan; después probá las consultas.

Los scripts son material didáctico en evolución: algunos contienen alternativas comentadas, ejemplos incompletos o consultas que dependen de datos y objetos creados en otros archivos. Es normal tener que adaptar la sintaxis o completar el contexto antes de ejecutarlos en otro motor.
