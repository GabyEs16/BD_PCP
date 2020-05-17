drop DATABASE if exists prescolar;
create database prescolar;
use prescolar;

/*Inicio de sesion*/
create table usuarioSesion(
    id_user int auto_increment primary key,
    nivel_user int,
    nombre_user varchar(20),
    contraseña_user varchar(20));

/* Atributos en comun*/
create table persona(
    curp varchar(18) primary key,
     nombre varchar(50),
     apellidoP varchar(50),
     apellidoM varchar(50), 
     direccion varchar(50),
     fecha_nac date, 
     sexo varchar(5));

/* Tablas para acceso con usuario */
/*Directora*/
create table directora (
    rfc_dire varchar(13) primary key,
    fkusersesion_dire int,
    fkpersona_dire varchar(18),
    foreign key (fkpersona_dire) references persona(curp),
    foreign key (fkusersesion_dire) references usuarioSesion(id_user));

/*Maestros*/
create table maestros(
    rfc_mtra varchar(13) primary key,
    email_mtra varchar(100),
    telefono_mtra varchar(10),
    fkusersesion_mtra int,
    fkpersona_mtra varchar(18),
    foreign key (fkpersona_mtra) references persona(curp),
    foreign key (fkusersesion_mtra) references usuarioSesion(id_user));

/* Tablas usuarios */
/* Alumnos */
CREATE TABLE alumno (
    id_al int (10) primary key,
    fkpersona_al varchar(18),
    foreign key (fkpersona_al) references persona(curp));
/* Padres */
create table padres(
    id_padre int auto_increment primary key,
    fkpersona_padre varchar(18),
    foreign key (fkpersona_padre) references persona(curp));

/*Relacion alumno Padre F */
create table AlumnoxPadre(
    idaxp int auto_increment primary key,
    fkid_al int(10),
    fkid_padre int,
    foreign key (fkid_padre) references padres(id_padre)    
    foreign key (fkid_al) references alumno(id_al));

/* Ciclo escolar */
Create table CicloEscolar(
    primary key (fechaIniCiclo, fechaFinCiclo),
    fechaIniCiclo date,
    fechaFinCiclo date
);
/* Creación de grados y grupos */

create table grado(
    idgrado int (1) primary key);

create table grupo(
    idgrupo int auto_increment primary key,
    letra_grupo varchar(5), /* A-B-C*/
    fkrfc_mtra varchar(13),
    fkgrado int,
    CicloIni date,
    CicloFin date,
    foreign key (CicloIni, CicloFin) references CicloEscolar(fechaIniCiclo, fechaFinCiclo),
    foreign key (fkrfc_mtra) references maestros (rfc_mtra),
    foreign key (fkgrado) references grado(idgrado));

/*Relación entre alumnos y grupo */
/*Los alumnos pertenecen a un grupo*/
create table GrupoAlumno(
    id_grupo int primary key,
    fkid_al int(10),
    fkid int, 
    foreign key (fkid_al) references alumno (id_al),
    FOREIGN key (fkid) references grupo(id));

/*Tablas para evaluacion alumnos*/
/* lenuaje y comunicacion, socio emocional, logico matematico*/
create table Materia(
    id int(1)primary key,
    nombre varchar(50));
/*Cada Materia tiene un aprendizaje esperado*/
create table APES
(
  id_apes int(11) primary key,
  aprendizaje_apes varchar(250),
  fkperiodo int,
  fkgrupo_apes int,
  fkmateria_apes int(1),
  foreign key (fkgrupo_apes) references grupo (idgrupo),
  foreign key (fkmateria_apes) references Materia(id));
/* cada aprendizaje debe tener un nivel de aprendizaje */
create table nivel_apre(
    nivel_apre int (1) primary key,
    descripcion varchar(100)
);
/* Se califica trimestralmente -> 1 periodo tiene 4 trimestres*/
create table periodo(
    periodo date primary key,
    trimestre_p int (1)
);
/*  cada trimestre se relaciona a una evaluacion diagnostica, inicial, media, final */
create table evaluaciones(
    ide int auto_increment primary key,
    nombre_evalacion varchar(50),
    comentario varchar(200),
    fechaperiodo date,
    periodo int,
    nivel int,
    fkmate int,
    fkid_apes int(11),
    foreign key (fkmate) references Materia(id),
    foreign key (fechaperiodo) references periodo(periodo),
    foreign key (fkid_apes) references APES (id_apes));

/*Todos los grupos tienen materias*/
create table GrupoMateria(
    idGM int primary key,
    fkidM int(1),
    fkidgrupo int,
    foreign key (fkidM) references Materia(id),
    foreign key (fkidgrupo) references grupo(id));


/**/

create table listaAsistencia(
num_lista int,
num_control bigint primary key,
nombre_completo varchar(200));

CREATE TABLE INASISTENCIA
(
  id_inas INT(11) NOT NULL PRIMARY KEY,
  fecha_inas DATETIME NOT NULL,
  justificada_inas INT(1) #[1]SI [0]NO
);

/* Relacion Maestros Eventos*/
create table evento(
    id_eve int auto_increment primary key,
    nombre_eve varchar(30),
    descripcion_eve varchar(200),
    fecha_eve date,
    fkrfc_dire varchar(13),
    fkrfc_mtra varchar(13),
    foreign key (fkrfc_dire) references directora(rfc_dire),
    foreign key (fkrfc_mtra) references maestros(rfc_mtra));

/* Tablas para cuotas */
create table cuotaxciclo(
    id_cuota int auto_increment primary key,
    cantidad double,
    CicloIni date,
    CicloFin date,
    foreign key (CicloIni, CicloFin) references CicloEscolar(fechaIniCiclo, fechaFinCiclo));

CREATE TABLE cuotascondescuento
(
  id_desc int(11) auto_increment primary key,
  montoaprovado_desc double,
  fkid_padres int,
  fkcuota_desc int(11),
  foreign key (fkid_padres) references padres(id_padre),
  foreign key (fkcuota_desc) references cuotaxciclo(id_cuota));

create table pagos
(
  id_pago int(11) auto_increment primary key,
  monto_pago double,
  fecha_pago date,
  fkalumno_pago,
);