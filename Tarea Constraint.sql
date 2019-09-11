Create Table Tbl_Empleado(
	F_Rut varchar(10) not null Primary Key,
	F_Paterno varchar(30) not null Default 'Sin Paterno',
	F_Materno varchar(30) not null Default 'Sin Materno',
	F_Nombre varchar(30) not null Default 'Sin Nombre',
	F_Nacimiento datetime not null,
	F_Sueldo money not null Default 300,
	F_COD_Ddepto char(4) not null,
	F_COD_Cargo char(4) not null,
	F_COD_Sucursal char(4) not null,
	F_DD_Ingreso smallint not null,
	F_MM_Ingreso smallint not null,
	F_AA_Ingreso smallint not null,

	Constraint Tbl_Emp_Pat_Largo Check (DATALENGTH(F_Paterno)<=25),
	Constraint Tbl_Emp_Mat_Largo Check (DATALENGTH(F_Materno)<=25),
	Constraint Tbl_Emp_Nom_Largo Check (DATALENGTH(F_Nombre)<=25),
	Constraint Tbl_Empleado_Edad Check (DATEDIFF(YEAR,GETDATE(),F_Nacimiento)>=25),
	Constraint Tbl_Empleado_Sueldo_Positivo Check (F_Sueldo >= 0),
	Constraint Tbl_Empleado_Dia Check (F_DD_Ingreso between 1 and 31),
	Constraint Tbl_Empleado_Mes Check (F_MM_Ingreso between 1 and 12),
	Constraint Tbl_Empleado_Años Check (F_AA_Ingreso between 1900 and YEAR(GETDATE()))
);

Create Table Tbl_Cargo(
	F_COD_Cargo char(4) not null Primary Key,
	F_Descripcion varchar(30) not null,

	Constraint TBL_Cargo_Cod Check (F_Cod_Cargo Like ('1010', '2010', '3010'))
);

Create Table Tbl_Departamento(
	F_Cod_Depto char(4) not null+ Primary Key,
	F_Descripcion varchar(30) not null Default 'Sin Descripcion',
	F_Rut_Jefe_Departamento varchar(10),
	F_Fecha_Creacion datetime Default getdate(),
	F_Usuario_Creacion integer Default user_id(),

	Constraint TBL_DEPARTAMENTO_COD Check (F_Cod_Depto between 1000 and 6699),
	Constraint TBL_DEPARTAMENTO_CREACION Check(F_Usuario_Creacion between 1 and 1000),
	Constraint TBL_DEPARTAMENTO_RUT_JEFE Foreign Key(F_Rut_JefeDepartamento) References Tbl_Empleado(F_Rut) 
);

Create Table Tbl_Region(
	F_Cod_Region char(2) not null Primary Key,
	F_Nom_Region varchar(30) not null Default 'Sin Descripcion',

	Constraint TBL_REGION_VALOR_COD Check (F_Cod_Region between 0 and 20)
);

Create Table Tbl_Ciudad(
	F_Cod_Ciudad char(4) not null Primary Key,
	F_Nombre_Ciudad varchar(30) not null Default 'Sin Descripcion',
	F_Cod_Region char(2) not null,

	Constraint TBL_CIUDAD_REGION_FK Foreign Key (F_Cod_Region) References Tbl_Region(F_Cod_Region),
	Constraint TBL_CIUDAD_VALOR_REGION Check (F_Cod_Region between 0 and 20)
);

Create Table Tbl_Sucursal(
	F_Cod_Sucursal char(4) not null Primary Key,
	F_Descripcion varchar(30) not null default 'Sin Descripcion',
	F_Cod_Ciudad char(4) not null,
	Constraint TBL_SUCURSAL_CIUDAD_FK foreign key (F_Cod_Ciudad) references Tbl_Ciudad(F_Cod_Ciudad)
);


Alter Table Tbl_Empleado add constraint 
TBL_EMPLEADO_COD_DEPTO_FK foreign key (F_Cod_Depto) references Tbl_Departamento(F_Cod_Depto);

Alter Table Tbl_Empleado add constraint
TBL_EMPLEADO_COD_CARGO_FK foreign key (F_Cod_Cargo) references Tbl_Cargo(F_Cod_Cargo);

ALTER TABLE Tbl_Empleado add constraint
TBL_EMPLEADO_COD_SUCU_FK foreign key (F_Cod_SucursalL) references Tbl_Sucursal(F_Cod_Sucursal);