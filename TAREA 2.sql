/*Creación de las Bases de Datos*/

CREATE DATABASE DB_ABASTECIMIENTOS 
ON
( NAME = DB_ABASTECIMIENTOS_DAT, 
FILENAME = 'C:\Ercoli_Sepulveda\ABASTECIMIENTOS\DB_ABASTECIMIENTOS.mdf',
SIZE = 150MB, 
MAXSIZE = 450MB, 
FILEGROWTH = 5%)
LOG ON
( NAME = DB_ABASTECIMIENTOS_LOG, 
filename = 'c:\Ercoli_Sepulveda\ABASTECIMIENTOS\DB_ABASTECIMIENTOS.ldf',
size = 50MB,
MAXSIZE = 150MB,
FILEGROWTH = 5%)

sp_helpdb DB_ABASTECIMIENTOS

CREATE DATABASE DB_VENTAS 
ON PRIMARY
( NAME = DB_VENTAS_PRI, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS.mdf',
SIZE = 500MB, MAXSIZE = 1500MB, FILEGROWTH = 5%),

FILEGROUP DATOS
( NAME = DB_VENTAS_DAT, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS.ndf', 
SIZE = 200MB, MAXSIZE = 600MB, FILEGROWTH = 5%),

FILEGROUP INDICES
( NAME = DB_VENTAS_IND, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS_IND01.ndf',
SIZE = 50MB, MAXSIZE = 150MB, FILEGROWTH = 5%),
( NAME = VENTAS02_IND, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS_IND02.ndf',
SIZE = 50MB, MAXSIZE = 150MB, FILEGROWTH = 5%),

FILEGROUP TABLAS01
( NAME = DB_VENTAS_TAB01, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS_TAB01.ndf', 
SIZE = 10MB, MAXSIZE = 30MB, FILEGROWTH= 5%),
( NAME = DB_VENTAS_TAB02, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS_TAB02.ndf', 
SIZE = 10MB, MAXSIZE = 30MB, FILEGROWTH= 5%),
( NAME = DB_VENTAS_TAB03, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS_TAB03.ndf', 
SIZE = 10MB, MAXSIZE = 30MB, FILEGROWTH= 5%),

FILEGROUP TABLAS02
( NAME = DB_VENTAS_TAB04, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS_TAB04.ndf', 
SIZE = 10MB, MAXSIZE = 30MB, FILEGROWTH= 5%),
( NAME = DB_VENTAS_TAB05, FILENAME = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS_TAB05.ndf', 
SIZE = 10MB, MAXSIZE = 30MB, FILEGROWTH= 5%)

LOG ON
( NAME = DB_VENTAS_LOG, filename = 'C:\Ercoli_Sepulveda\VENTAS\DB_VENTAS.ldf',
size = 150MB, MAXSIZE = 450MB, FILEGROWTH = 5%)

sp_helpdb DB_VENTAS

CREATE DATABASE DB_FINANZAS 
ON
( NAME = DB_FINANZAS_DAT, 
FILENAME = 'C:\Ercoli_Sepulveda\FINANZAS\DB_FINANZAS.mdf',
SIZE = 150MB, 
MAXSIZE = 450MB, 
FILEGROWTH = 5%)

LOG ON
( NAME = DB_FINANZAS_LOG, 
filename = 'c:\Ercoli_Sepulveda\FINANZAS\DB_FINANZAS.ldf',
size = 50MB,
MAXSIZE = 150MB,
FILEGROWTH = 5%)

sp_helpdb DB_FINANZAS

/*Creación de tablas*/

Use DB_VENTAS

Create table Tbl_Ventas(
	Id_Venta int primary key,
	Fecha date,
	Id_Producto int,
	Descripcion varchar(50)

)

Create table Tbl_Clientes(
	Rut char(10) primary key,
	Nombre varchar(30) not null default('SIN NOMBRE'),
	Paterno varchar(30) not null default('SIN NOMBRE'),
	Materno varchar(30) not null default('SIN NOMBRE'),
	Sexo char(1) not null,
	Dirección varchar(20)

)	

Create table Tbl_Correlativo(
	Id_Correlativo int primary key

)

Create table Tbl_Sesion(
	Usuario varchar(10) primary key,
	Contraseña varchar(10)

)

Create table Tbl_Sucursal(
	Dirección varchar(30) primary key,
	Teléfono int

)

Use DB_ABASTECIMIENTOS

Create table Tbl_Maestro(
	Rut int primary key,
	Nombre varchar(20),
	Apellido varchar(20),
	Dirección varchar(30)
)

Create table Tbl_Producto(
	Id_Producto int primary key,
	Nombre varchar(20),
	Descripción varchar(50)
)

Create table Tbl_Movimientos(
	Id_Movimiento int primary key,
	Descripción varchar(50)

)

Use DB_FINANZAS

Create table Tbl_Movimientos(
	Id_Movimientos int primary key,
	Descripción varchar(50)

)

Create table Tbl_Balance(
	Id_Balance int primary key,
	Descripción varchar(50)

)

Create table Tbl_Factura(
	Id_Factura int primary key,
	Descripción varchar(50)

)

Create table Tbl_FacturaDet(
	Id_FacturaDet int primary key,
	Descripción varchar(50)

)

/*Creación de los Procedimientos Almacenados*/


/*Para los clientes*/

Use DB_VENTAS

Create procedure Ingresa_Cliente
	@rut char(10), @nombre varchar(30), @paterno varchar(30), @materno varchar(30), @sexo char(1), @dirección varchar(10)
As
	Insert into Tbl_Clientes Values (@rut, @nombre, @paterno, @materno, @sexo, @dirección);

exec Ingresa_Cliente 1234567890, Sergio, Ercoli, Cárdenas, M, 'Al fin del mundo'


Create procedure Elimina_Cliente
	@rut char(10)
As
	Delete from Tbl_Clientes Where rut = @rut;

exec Elimina_Cliente 1234567890


Create procedure Actualiza_Cliente
	@rut char(10), @nombre varchar(30), @paterno varchar(30), @materno varchar(30), @sexo char(1), @dirección varchar(10)
As
	Update Tbl_Clientes Set rut = @rut, nombre = @nombre, paterno = @paterno, materno = @materno, sexo = @sexo, dirección = @dirección Where rut = @rut;

exec Actualiza_Cliente 1234567890, Sergio, Ercoli, Cárdenas, M, 'En mi casita'


/*Para los Productos*/

Use DB_ABASTECIMIENTOS

Create procedure Ingresa_Producto
	@id_Producto int, @nombre varchar(20), @descripción varchar(50)
As
	Insert into Tbl_Producto Values (@id_Producto, @nombre, @descripción);

exec Ingresa_Producto 1, Guitarra, Eléctrica


Create procedure Elimina_Producto
	@id_Producto int
As
	Delete from Tbl_Producto Where id_Producto = @id_Producto;

exec Elimina_Producto 1


Create procedure Actualiza_Producto
	@id_Producto int, @nombre varchar(20), @descripción varchar(50)
As
	Update Tbl_Producto Set id_Producto = @id_Producto, nombre = @nombre, descripción = @descripción Where id_Producto = @id_Producto;

exec Actualiza_Producto 1, Guitarra, Bonita


/*Para las Facturas*/

Use DB_FINANZAS

Create procedure Ingresa_Factura
	@id_Factura int, @descripción varchar(50)
As
	Insert into Tbl_Factura Values (@id_Factura, @descripción);

exec Ingresa_Factura 1, "Precio caro"


Create procedure Elimina_Factura
	@id_Factura int
As
	Delete from Tbl_Factura Where id_Factura = @id_Factura;

exec Elimina_Factura 1


Create procedure Actualiza_Factura
	@id_Factura int, @descripción varchar(50)
As
	Update Tbl_Factura Set id_Factura = @id_Factura, descripción = @descripción Where id_Factura = @id_Factura;

exec Actualiza_Factura 1, "Producto barato"


/*Procedimientos de Consultas*/

Use DB_ABASTECIMIENTOS

Create procedure Consulta_Producto
	@id_Producto int
As
	Select * From Tbl_Producto Where id_Producto = @id_Producto;

exec Consulta_Producto 1


Create procedure Consulta_Cliente_Factura
	@rut char(10), @id_Factura int
As
	Select * From Tbl_Cliente INNER JOIN Tbl_Factura ON @rut = @id_Factura;

exec Consulta_Cliente_Factura 1234567890, 1


/*Creando los Usuarios*/

/*Respaldando datos*/

/*Respaldo Full*/

Alter database DB_ABASTECIMIENTOS Set Recovery Full

Backup Database DB_ABASTECIMIENTOS  
    To Disk = 'C:\Ercoli_Sepulveda\ABASTECIMIENTOS\Respaldo.bak'   
    With Format; 


Alter database DB_FINANZAS Set Recovery Full

Backup Database DB_FINANZAS  
    To Disk = 'C:\Ercoli_Sepulveda\FINANZAS\Respaldo.bak'   
    With Format; 


Alter database DB_VENTAS Set Recovery Full

Backup Database DB_VENTAS  
    To Disk = 'C:\Ercoli_Sepulveda\VENTAS\Respaldo.bak'   
    With Format; 


/*Respaldo Incremental (LOG)*/

Backup Log DB_ABASTECIMIENTOS To Disk = 'C:\Ercoli_Sepulveda\ABASTECIMIENTOS\Respaldo.dmp' 

Backup Log DB_FINANZAS To Disk = 'C:\Ercoli_Sepulveda\FINANZAS\Respaldo.dmp'  

Backup Log DB_VENTAS To Disk = 'C:\Ercoli_Sepulveda\VENTAS\Respaldo.dmp'  