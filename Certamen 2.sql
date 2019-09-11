-- Pregunta 1: CREACIón DE TABLAS	

If exists (Select * from SYSOBJECTS where NAME='Tbl_Region')
Drop Table Tbl_Region;

Create table Tbl_Region(
	F_CodigoRegion varchar(2) not null primary key,
	F_Descripcion varchar(30) not null default ('Sin Region'),
	
	Constraint Tbl_Ciudad_F_CodigoRegion check (Substring(F_CodigoRegion, 0, 1) between 0 and 1 AND
	Substring(F_CodigoRegion, 1, 1) between 0 and 9)
)

If exists (Select * from SYSOBJECTS where NAME='Tbl_Facultad')
Drop Table Tbl_Facultad;

Create table Tbl_Facultad(
	F_CodigoFacultad varchar(2) primary key,
	F_Descripcion varchar(30) not null default ('SIN FACULTAD'),
	
	Constraint Tbl_Facultad_Descripcion unique(F_Descripcion),
	Constraint Tbl_Facultad_CodigoFacultad check (Substring(F_CodigoFacultad, 0, 2) between 00 and 99)
)

If exists (Select * from SYSOBJECTS where NAME='Tbl_Carrera')
Drop Table Tbl_Carrera;

Create table Tbl_Carrera(
	F_CodCarrera char(6) not null primary key,
	F_Descripcion varchar(30) not null default ('SIN CARRERA'),
	
	Constraint Tbl_Carrera_CodCarrera unique(F_CodCarrera)
)

If exists (Select * from SYSOBJECTS where NAME='Tbl_Asignatura')
Drop Table Tbl_Asignatura;

Create table Tbl_Asignatura(
	F_CodigoAsignatura char(4) primary key,
	F_Descripcion varchar(30),
	F_CodigoCarrera char(6) not null,
	F_Creditos smallint not null,
	
	Constraint Tbl_Asignatura_Creditos check(datalength(F_Creditos) > 0)
)

If exists (Select * from SYSOBJECTS where NAME='Tbl_CargaAcademica')
Drop Table Tbl_CargaAcademica;

Create table Tbl_CargaAcademica(
	sF_Rut char(10),
	F_Ano smallint,
	F_Semestre smallint,
	F_CodigoCarrera char(6) not null,
	F_CodigoAsignatura char(4),
	F_Estado smallint,
	
	Constraint Tbl_CargaAcademica_Rut check (Substring(sF_Rut, 10, 1) between 0 and 1 OR 
	Substring(sF_Rut, 10, 1) = 'K' OR Substring(sF_Rut, 10, 1) = 'k' AND
	Substring(sF_Rut, 3, 2) >= 19 AND Substring(sF_Rut, 2, 2) <= 50 OR Substring(sF_Rut, 2, 2) <= 49),
	Constraint Tbl_CargaAcademica_Ano Check (F_Ano >= YEAR(GETDATE())),
	Constraint Tbl_CargaAcademica_Semestre Check (F_Semestre between 0 and 4),
	Constraint Tbl_CargaAcademica_Estado Check (F_Estado between 0 and 1)
)

If exists (Select * from SYSOBJECTS where NAME='Tbl_Ciudad')
Drop Table Tbl_Ciudad;

Create table Tbl_Ciudad(
	F_CodigoCiudad char(4) primary key,
	F_Descripcion varchar(30) not null default ('Sin Ciudad'),
	F_CodigoReg varchar(2) not null,
	
	Constraint Tbl_Ciudad_CodigoReg_Fk foreign key (F_CodigoReg) references Tbl_Region(F_CodigoRegion),
	Constraint Tbl_Ciudad_CodigoCiudad check (Substring(F_CodigoCiudad, 0, 1) between 0 and 1 AND
	Substring(F_CodigoCiudad, 1, 1) between 0 and 9 AND
	Substring(F_CodigoCiudad, 2, 1) between 0 and 49 AND
	Substring(F_CodigoCiudad, 3, 1) between 0 and 49),
	Constraint Tbl_Ciudad_F_CodigoReg check (Substring(F_CodigoReg, 0, 1) between 0 and 1 AND
	Substring(F_CodigoReg, 1, 1) between 0 and 9)
)

If exists (Select * from SYSOBJECTS where NAME='Tbl_Alumno')
Drop Table Tbl_Alumno;

Create table Tbl_Alumno(
	F_Rut char(10) primary key,
	F_Nombre varchar(30) not null default('SIN NOMBRE'),
	F_Paterno varchar(30) not null default('SIN NOMBRE'),
	F_Materno varchar(30) not null default('SIN NOMBRE'),
	F_Sexo char(1) not null,
	F_FechaNacimiento date not null,
	F_CodigoCiu char(4),
	F_CodigoNacion char(4),

	Constraint Tbl_Alumno_Rut check (Substring(F_Rut, 10, 1) between 0 and 1 OR Substring(F_Rut, 10, 1) = 'K' OR 
	Substring(F_Rut, 10, 1) = 'k' AND
	Substring(F_Rut, 3, 2) >= 19 AND Substring(F_Rut, 2, 2) <= 50 OR Substring(F_Rut, 2, 2) <= 49),
	Constraint Tbl_Alumno_Nombre check (datalength(F_Nombre) <= 25),
	Constraint Tbl_Alumno_Paterno check (datalength(F_Paterno) <= 25),
	Constraint Tbl_Alumno_Materno check (datalength(F_Materno) <= 25),
	Constraint Tbl_Alumno_Sexo check (F_Sexo LIKE 'F' OR F_Sexo LIKE 'M'),
	Constraint Tbl_Alumno_FechaNacimiento check (datediff(year,F_FechaNacimiento, getdate()) >= 18),
	Constraint Tbl_Alumno_Ciudad_Fk foreign key (F_CodigoCiu) references Tbl_Ciudad(F_CodigoCiudad),
	Constraint Tbl_Alumno_Nacionalidad_Fk foreign key (F_CodigoNacion) references Tbl_Nacionalidades(F_CodigoNacionalidad)
)

If exists (Select * from SYSOBJECTS where NAME='Tbl_Nacionalidades')
Drop Table Tbl_Nacionalidades;

Create table Tbl_Nacionalidades(
	F_CodigoNacionalidad char(4) primary key,
	F_Descripcion varchar(30) not null default ('Sin Nacionalidad'),

	Constraint TbL_Nacionalidades_Codigonacionalidad1 Check (Substring(F_CodigoNacionalidad, 1 , 2)='AM' OR 
	Substring(F_CodigoNacionalidad, 1, 2)='OC' OR
	Substring(F_CodigoNacionalidad, 1, 2)='AF' OR
	Substring(F_CodigoNacionalidad, 1, 2)='EU' OR
	Substring(F_CodigoNacionalidad, 1, 2)='XT' OR --AGREGADO
	Substring(F_CodigoNacionalidad, 1, 2)='AL' OR --AGREGADO
	Substring(F_CodigoNacionalidad, 1, 2)='AS'),

	Constraint TbL_Nacionalidades_Codigonacionalidad2 Check (Patindex('%[0-9]%',F_CodigoNacionalidad) = 0)
)


--Pregunta 2: POBLAMIENTO DE DATOS

--Inserte datos en tabla Tbl_region
insert into Tbl_Region values('08','Del BioBio')
insert into Tbl_Region values('09','Araucania')
insert into Tbl_Region values('10','Los Lagos')

-- R: no da problemas, se cambio el orden en las inserciones a causa de las FK.

select * from Tbl_Region

-- Inserte datos en la tabla Tbl_Ciudad
insert Tbl_Ciudad values ('0810','No tengo ideaa','08') --Se Agregó
insert Tbl_Ciudad values ('0820','Arauco','08')
insert Tbl_Ciudad values('0830', 'San Pedro de la Paz', '08')
insert Tbl_Ciudad values('0840', 'Penco', '08')
insert Tbl_Ciudad values('0910', 'Temuco', '09')
insert Tbl_Ciudad values('0920', 'Gorbea', '09')
insert Tbl_Ciudad values('0930', 'Freire', '09')
insert Tbl_Ciudad values('1010', 'Valdivia','10')
insert Tbl_Ciudad values('1020', 'Osorno','10')
insert Tbl_Ciudad values('1030','Los Lagos', '10')

--¿Puede insertar los  datos de las ciudades ? Si no puede como se arregla
	-- R: si se pudo ya que cambié el orden de las inserciones a causa de las claves foraneas.

select * from Tbl_Ciudad

-- Inserte datos en la tabla Tbl_Facultad
insert Tbl_Facultad values ('10','Odontologia')
insert Tbl_Facultad values ('20','Humanidades')
insert Tbl_Facultad values ('30','Derecho')
insert Tbl_Facultad values ('40','Ingenieria')

select * from Tbl_Facultad

--Inserte datos en tabla Tbl_Carrera
insert Tbl_Carrera values ('101010','Odontologia')
insert Tbl_Carrera values ('401010','Civil Minas')
insert Tbl_Carrera values ('401020','Materiales')
insert Tbl_Carrera values ('403010','Mecanica')
insert Tbl_Carrera values ('404010','Informartica')
insert Tbl_Carrera values ('404020','Telecomunicaciones')
insert Tbl_Carrera values ('201010','Licenciatura en Español')
insert Tbl_Carrera values ('201010','Parvularia')

select * from Tbl_Carrera

--Inserte datos en tabla Tbl_Asignatura
insert Tbl_Asignatura values ('1010','odonto1','101010',4)
insert Tbl_Asignatura values ('1020','odonto2','101010',6)
insert Tbl_Asignatura values ('1030', 'odonto3','101010',4)
insert Tbl_Asignatura values ('4010','programacion1','404010',4)
insert Tbl_Asignatura values ('4020','base de datos ','404010', 4)
insert Tbl_Asignatura values ('4030','modelamiento','404010', 4)
insert Tbl_Asignatura values ('4030','inteligencia de negocios','404010', 4)
insert Tbl_Asignatura values ('2010','lectura 1','201010', 4)
insert Tbl_Asignatura values ('2020','Español instrumental','201010', 4)

select * from Tbl_Asignatura

--Inserte datos en tabla Tbl_Nacionalidades
insert Tbl_Nacionalidades values ('AMCL', 'CHILENA')
insert Tbl_Nacionalidades values ('AMBR', 'BRASILEÑA')
insert Tbl_Nacionalidades values ('ALAR', 'ARGENTINA')
insert Tbl_Nacionalidades values ('EUHO','HOLANDESA')
insert Tbl_Nacionalidades values ('EUIT', 'ITALIANA')
insert Tbl_Nacionalidades values ('XTSZ', 'SUIZA')
insert Tbl_Nacionalidades values ('AMPE', 'PERUANA')
insert Tbl_Nacionalidades values ('AFNI', 'NIGERIANA')

-- R: se añadieron a la restricción las nacionalidades Argentina y Suiza.

select * from Tbl_Nacionalidades

-- Inserte datos en tabla Tbl_CargaAcademica
insert Tbl_CargaAcademica values ('0087814955',2017,1,'404010','4010',0)
insert Tbl_CargaAcademica values ('0087814955',2017,1,'404010','4020',0)
insert Tbl_CargaAcademica values ('001232344k',2017,1,'404010','4010',0)

select * from Tbl_CargaAcademica

-- Inserte un registro en la tabla Tbl_Alumno
insert Tbl_Alumno values ('0087814955', 'Patricio', 'Pampaloni', 'Soto', 'M', '1960-08-09','0810', 'AMCL')

select * from Tbl_Alumno

-- R: se añadió la región 0810.

/*Cree una relacion entre tablas 
relacion entre tabla Tbl_CargaAcademica y la tabla Tbl_Alumnos*/

select * from Tbl_CargaAcademica INNER JOIN Tbl_Alumno ON Tbl_CargaAcademica.sF_Rut = Tbl_Alumno.F_Rut


--2.4 

select Tbl_Alumno.F_Rut, Tbl_Alumno.F_Nombre, Tbl_Alumno.F_Paterno, Tbl_Alumno.F_Materno, 
Tbl_Carrera.F_Descripcion, Tbl_Asignatura.F_Descripcion AS Desc_Asignatura,
Tbl_Asignatura.F_Creditos 
from Tbl_Alumno INNER JOIN Tbl_CargaAcademica ON Tbl_Alumno.F_Rut = Tbl_CargaAcademica.sF_Rut INNER JOIN Tbl_Carrera
ON Tbl_Carrera.F_CodCarrera = Tbl_CargaAcademica.F_CodigoCarrera 
INNER JOIN Tbl_Asignatura ON Tbl_Asignatura.F_CodigoAsignatura = Tbl_CargaAcademica.F_CodigoAsignatura


--2.5 ¿Cuántos créditos tiene cada alumno este año?	

Select Tbl_Alumno.F_Nombre, Tbl_Alumno.F_Paterno,
Tbl_Asignatura.F_Creditos from Tbl_Alumno INNER JOIN Tbl_CargaAcademica ON Tbl_Alumno.F_Rut = Tbl_CargaAcademica.sF_Rut 
INNER JOIN Tbl_Carrera ON Tbl_Carrera.F_CodCarrera = Tbl_CargaAcademica.F_CodigoCarrera INNER JOIN Tbl_Asignatura
ON Tbl_Asignatura.F_CodigoAsignatura = Tbl_CargaAcademica.F_CodigoAsignatura


-- 2.6 ¿Cuántas Ciudades no tiene región?	

Select COUNT(*) from Tbl_Region AS R CROSS JOIN Tbl_Ciudad where Tbl_Ciudad.F_CodigoReg = NULL;

-- 2.7

Select Tbl_Ciudad.F_CodigoCiudad, Tbl_Ciudad.F_Descripcion, Tbl_Region.F_Descripcion from Tbl_Ciudad 
CROSS JOIN Tbl_Region where Tbl_Ciudad.F_CodigoReg = Tbl_Region.F_CodigoRegion;

-- 2.8

-- R. falta añadir la región:

Insert into Tbl_Region values ('07','Maule');

-- Luego insertar de manera normal:

insert into Tbl_Ciudad values ('0710','Curico','07');