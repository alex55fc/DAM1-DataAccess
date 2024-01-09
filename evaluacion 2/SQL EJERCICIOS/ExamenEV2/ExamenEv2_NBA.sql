-- Conexion ExamenEv2_NBA
---EXAMEN
--a)Obt�n el equipo del jugador m�s bajo.
select * 
from equipos 
where nombre in (
    select NOMBRE_EQUIPO
    from jugadores 
    where altura = (
        select min(altura)
        from jugadores
        )
);
--b) Obt�n los equipos que m�s jugadores tienen de la posici�n G, ordenados alfab�ticamente.
select nombre_equipo, count(nombre) 
from jugadores 
where posicion like 'G'
group by nombre_equipo
having count(nombre) in (
    select max (count(*))
    from jugadores
    where posicion like 'G'
    group by nombre_equipo
)
order by nombre_equipo;

--c)Obt�n el nombre del jugador que m�s rebotes por partido ha hecho.
select nombre
from jugadores
where codigo in (
    select jugador
    from ESTADISTICAS
    where REBOTES_POR_PARTIDO = (
        select max(REBOTES_POR_PARTIDO)
        from ESTADISTICAS
    )
);

--D)Obt�n el c�digo de partido y nombre de los equipos visitantes que hicieron m�s de 157 puntos en la temporada 05/06, ordenados por el c�digo del partido.
select codigo, equipo_visitante 
from partidos
where puntos_visitante > 157
and temporada like '05/06'
order by codigo asc;

--e) Obt�n las divisiones en las que haya m�s de 5 equipos, ordenadas alfab�ticamente por divisi�n.
select division 
from equipos 
group by division 
having count(*) > 5
order by division asc;

--f)
select round(avg(puntos_local),1), round(avg(puntos_visitante),1), temporada
from partidos
group by temporada
order by temporada;

--g)
select j.nombre,j.posicion, j.nombre_equipo,
    e.puntos_por_partido ,e. asistencias_por_partido, e.tapones_por_partido, e.rebotes_por_partido
from jugadores j join estadisticas e on (j.codigo = e.jugador)
where e.temporada like '99/00'
    and j.nombre_equipo in (
        select nombre from equipos where conferencia like 'West')
    order by j.nombre_equipo, j.nombre;

--h)
select *
from partidos
where (equipo_local in (
                        select nombre_equipo
                        from jugadores
                        where nombre like 'Kobe Bryant'
                        )
    or
    equipo_visitante in (
                         select nombre_equipo
                        from jugadores
                        where nombre like 'Kobe Bryant'
                          )
        )
        and puntos_local > 150
        and puntos_visitante <= 50
order by codigo, temporada;
--I)
select * 
from (
        select j.nombre, j.nombre_equipo, max(e.puntos_por_partido)
        from jugadores j join estadisticas e on (j.codigo = e.jugador)
            join equipos eq on (eq.nombre = j.nombre_equipo)
        where eq.conferencia like 'East'
        group by j.nombre,j.nombre_equipo
        order by max(e.puntos_por_partido) desc
    )
    where rownum <= 5;
--H)
select count(j1.nombre) , j1.nombre_equipo
from jugadores j1 
where j1.peso < (
    select avg(j2.peso)
    from jugadores j2
    where j2.nombre_equipo = j1.nombre_equipo
    group by j2.nombre_equipo
    )
group by j1.nombre_equipo
order by j1.nombre_equipo;