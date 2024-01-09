--1.- Crea un usuario llamado GESTION y asígnale el rol CONNECT
create user GESTION identified by GESTION
default tablespace users
temporary tablespace temp
quota unlimited on users;
grant create session to GESTION;

GRANT CONNECT TO GESTION;

--2.NBA: Concede todos los privilegios de objeto sobre todas las tablas al usuario GESTION
grant all privileges on entrenadores to gestion;
grant all privileges on equipos to gestion;
grant all privileges on estadisticas to gestion;
grant all privileges on jugadores to gestion;
grant all privileges on partidos to gestion;

--3.- GESTION: Realiza una consulta a la tabla EQUPOS.
SELECT * FROM UD9_NBA.EQUIPOS;

--4.- Asigna al usuario GESTION privilegios para crear sinónimos y vistas
grant create view to GESTION;
grant create synonym to GESTION;

--5.- GESTION: Crea un sinónimo a la tabla equipos del esquema NBA.
create synonym sEquipos for UD9_NBA.EQUIPOS;

--6.- GESTION: Realiza una consulta a la tabla equipos utilizando el sinónimo.
SELECT * FROM sEquipos;

--7.- GESTION: Crea una vista que obtenga el nombre de los jugadores del equipo Lakers.
grant CREATE VIEW to UD9_NBA;
create view jugadores_lakers as 
    select nombre from UD9_NBA.jugadores 
        where nombre_equipo like 'Lakers';

SELECT * FROM jugadores_lakers;
--9.- NBA: Crea un índice sobre el campo nombre_equipo de la tabla jugadores.
create index indice on jugadores(nombre_equipo);

--11.- NBA: Crea una secuencia denominada numeroPlanta.
create sequence numeroPlanta
increment by 100
start with 100
maxvalue 2000;

select numeroPlanta.nextval from dual;
--12.- GESTION: Inserta un entrenador utilizando la secuencia.
grant all on numeroPlanta to gestion;
--desde gestion
insert into UD9_NBA.entrenadores
    values(UD9_NBA.numeroPlanta.nextval,'ibai','zgz','Lakers');
--13.- Crea un usuario denominado MEDIO (medio de comunicación) y asígnale el rol de conexión y
--permisos para crear sinónimos.
create user MEDIO identified by MEDIO
default tablespace users
temporary tablespace temp
quota unlimited on users;
grant create session to MEDIO;
GRANT SYNONYM TO MEDIO;
GRANT CONNECT TO MEDIO;

--14.- NBA: Crea una vista que permita consultar el promedio de puntos por partido de cada jugador.
CREATE OR REPLACE VIEW PROMEDIOpuntos as
    select j.nombre, round(avg(e.puntos_por_partido)) as promedio
        from jugadores j join estadisticas e on(j.codigo = e.jugador)
        group by j.nombre;
--15.- NBA: Concede al usuario GESTION permisos para consultar la vista.
grant select on UD9_NBA.PROMEDIOpuntos to GESTION;
--16.- GESTION: Crea un sinónimo a la vista promedio_jugador y realiza una consulta.
create synonym river for UD9_NBA.PROMEDIOpuntos;
select * from river;
--NO FUNCIONA, NO SE PORQUE.