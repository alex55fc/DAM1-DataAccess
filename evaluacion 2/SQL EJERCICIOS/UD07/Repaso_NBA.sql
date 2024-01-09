--Ejercicio 1
--pau gasol = 321
select j.nombre, sum(e.puntos_por_partido) as "PUNTOS" 
from jugadores j join partidos p using (codigo)
join estadisticas e using (temporada)
where j.nombre = 'Pau Gasol'
group by j.nombre;

--Ejercicio 2:
select count(*)
from equipos 
where conferencia='West';

--Ejercicio 3:
select e.nombre, count(j.codigo) as "Número de jugadores"
from jugadores j join equipos e on (j.nombre_equipo = e.nombre)
where conferencia = 'West'
group by e.nombre;

--Ejercicio 4: ¿Máximo de puntos hechos por un jugador en un partido en toda la temporada?
select j.codigo,j.nombre,max(e.puntos_por_partido) as "Puntos máximos"
from jugadores j join estadisticas e on (j.codigo = e.jugador)
group by j.codigo,j.nombre
order by j.codigo;

--Ejercicio 5:
select codigo, nombre, length(nombre)
from jugadores j
where nombre_equipo = 'Grizzlies';

--Ejercicio 6:
select j.nombre, avg(e.puntos_por_partido) as "PROMEDIO DE PUNTOS POR PARTIDO"
from estadisticas e join jugadores j on (e.jugador=j.codigo)
where j.nombre_equipo = 'Cavaliers'
group by j.nombre;

--Ejercicio 7:
select distinct procedencia, count(procedencia) as "JUGADORES DE LUGAR DE PROCEDENCIA" 
from jugadores
group by procedencia
ORDER BY count(procedencia) desc;

--Ejercicio 8:
select j.nombre, avg(e.puntos_por_partido) as "MEDIA PUNTOS"
from jugadores j join estadisticas e on (j.codigo=e.jugador)
group by j.nombre
having avg(e.puntos_por_partido) > 25;

--Ejercicio 9:
select j.nombre
from jugadores j join estadisticas e on(j.codigo=e.jugador)
where nombre_equipo = 'Lakers' 
group by j.nombre
having avg(e.rebotes_por_partido) > (
    select avg(e2.rebotes_por_partido)
    from estadisticas e2 join jugadores j2 on (e2.jugador=j2.codigo)
    where j2.nombre_equipo = 'Lakers');
    
--Ejercicio 10:
select j.nombre_equipo, sum(p.puntos_local) as "Puntos Local", sum(p.puntos_visitante) as "Puntos Visitantes"
from jugadores j join partidos p using (codigo)
group by j.nombre_equipo
having sum(puntos_local) > sum(puntos_visitante);

--Ejercicio 11:
select * from(
     select e.nombre, count(j.posicion)
     from equipos e join jugadores j on (e.nombre=j.nombre_equipo)
     where e.conferencia = 'East' and j.posicion like 'G'
     group by e.nombre
     order by count(j.posicion) desc)
where rownum <= 2;
    
--Ejercicio 12:
select j.nombre
from jugadores j
where procedencia like 'Spain' and j.posicion = 'F'
union
select j.nombre
from jugadores j
where procedencia like 'France' and j.posicion = 'F';

--Ejercicio 13:
select distinct j.nombre
from jugadores j join estadisticas e on (j.codigo=e.jugador)
where j.nombre_equipo = 'Lakers' and procedencia like 'Spain' and e.puntos_por_partido < 25;

--Ejercicio 14:
select distinct j.nombre
from jugadores j join estadisticas e on (j.codigo=e.jugador)
where j.nombre_equipo = 'Lakers' and procedencia like 'Spain' and e.puntos_por_partido > 25;