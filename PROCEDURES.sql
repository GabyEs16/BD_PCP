
DELIMITER $$

drop procedure if exists p_Registroalumnos;
CREATE PROCEDURE p_Registroalumnos(
in _curp varchar(20),
in _nombre varchar(100),
in _apellidop varchar(100),
in _apellidom varchar(100),
in _sexo varchar(10),
in _fechaNacimiento varchar(50),
in opcion int,
out mensaje varchar(50))
begin

declare existe int;

if opcion = 1 then

  select count(*) from alumno
  where CURP = _curp into existe;
  
  if existe = 0 then
    insert into alumno values(_curp, _nombre, _apellidop, _apellidom, _sexo, _fechaNacimiento);
    select "Registro Correcto" into mensaje;
  end if;
  
  if existe = 1 then  
    select "El Usuario ya Existe" into mensaje;  
  end if;

end if;

if opcion = 2 then

  update alumno set
  Nombre = _nombre,
  ApellidoP = _apellidop,
  ApellidoM = _apellidom,
  Sexo = _sexo,
  FechaNacimiento = _fechaNacimiento
  where CURP = _curp;


end if;

if opcion = 3 then

  delete from alumno
  where CURP = _curp;

end if;

end$$
DELIMITER ;


DELIMITER $$
drop procedure if exists p_alumnoAsistencia;
create PROCEDURE p_alumnoAsistencia(
in p_num_lista int,
in p_num_control bigint,
in p_nombre_completo varchar(200),
in p_opcion int
)
begin 
declare existe int;
select count(*) from alumnos 
where num_control = p_num_control into existe;
/*Inserta*/
if existe = 0 then
if p_opcion = 1 then
  insert into alumnos values
  (p_num_lista, p_num_control, p_nombre_completo);
end if;
end if;

if existe = 1 then
select "se inserto correctamente";
end if;

/*modifica*/
 if p_opcion =2 then 
    update alumnos
    set num_lista = p_num_lista,
    p_nombre_completo = p_nombre_completo
        where num_control = p_num_control;
end if;
/*elimina*/
if p_opcion = 3 then
  delete from alumnos
  where num_control = p_num_control;
end if;
end$$
DELIMITER ;


DELIMITER $$
drop procedure if exists p_maestros;
create PROCEDURE p_maestros(
in _RFC varchar(50),
in _Nombre varchar(100),
in _ApellidoP varchar(100),
in _ApellidoM varchar(100),
in _Fecha_Nan varchar(50),
in _Sexo varchar(10),
in _Email varchar(250),
in _Telefono varchar(10),
in _opcion int
)
begin 
declare existe int;
select count(*) from maestros
where RFC = _RFC into existe;
/*Inserta*/
if existe = 0 then
if p_opcion = 1 then
  insert into maestros values
  (_RFC, _Nombre, _ApellidoP, _ApellidoM, _Fecha_Nan, _Sexo, _Email, _Telefono );
end if;
end if;

if existe = 1 then
select "se inserto correctamente";
end if;

/*modifica*/
 if p_opcion =2 then 
    update maetros
    set Nombre = _Nombre,
    ApellidoP = _ApellidoP, 
    ApellidoM = _ApellidoM, 
    Fecha_Nan = _Fecha_Nan,
    sexo = _Sexo, 
    Email = _Email,
    Telefono = _Telefono
        where RFC = _RFC;
end if;
/*elimina*/
if p_opcion = 3 then
  delete from maestros
  where RFC = _RFC;
end if;
end$$
DELIMITER ;