drop DATABASE if exists prescolar;
create database prescolar;
use prescolar;


create table grado(
    idgrado int auto_increment primary key,
    grado int,
    FechaIniGrado date,
    FechaFinGrado date
);

create table grupo(
    id int auto_increment primary key,
    nomgrupo varchar(5),
    fkgrado int,
    FOREIGN key (fkgrado) references grado(idgrado));

create table Materia(
    id int auto_increment primary key,
    nombre varchar(20));

create table evaluaciones(
    ide int auto_increment primary key,
    fechaperiodo date,
    periodo int,
    nivel int,
    fkmate int,
    foreign key (fkmate) references Materia(id));

CREATE TABLE alumno (
  CURP varchar(20) PRIMARY KEY,
  Nombre varchar(100),
  ApellidoP varchar(100),
  ApellidoM varchar(100),
  Sexo varchar(10),
  FechaNacimiento varchar(50));

create table maestros(
RFC varchar(50) primary key,
Nombre varchar(100),
ApellidoP varchar(100),
ApellidoM varchar(100),
Fecha_Nan varchar(50),
Sexo varchar(10),
Email varchar(250),
Telefono varchar(10));

create table GrupoMateria(
    fkidM int,
    fkidgrupo int,
    foreign key (fkidM) references Materia(id),
    foreign key (fkidgrupo) references grupo(id));

create table GrupoAlumno(
    curp varchar (20),
    fkid int, 
    foreign key (curp) references alumno (CURP),
    FOREIGN key (fkid) references grupo(id));

create table GrupoMaestros(
    fkrfc varchar(50),
    fkid int,
    FOREIGN key (fkid) references grupo(id),
    foreign key (fkrfc) references maestros(RFC));
    
# tablas que no llevan relacion  #

create table alumnos(
num_lista int,
num_control bigint primary key,
nombre_completo varchar(200));

create table usuarioSesion(
    idus int auto_increment primary key,
    nivel int,
    nombre varchar(20),
    contraseña varchar(10));

create table evento(
    ide int auto_increment primary key,
    nombree varchar(20),
    descripcion varchar(200),
    fkidus int,
    fecha date);
