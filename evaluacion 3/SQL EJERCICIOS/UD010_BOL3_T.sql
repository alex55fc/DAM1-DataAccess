create or replace NONEDITIONABLE PROCEDURE TPUD10 (
    v_nombrepj jugadores.nombre%type
)
is
    v_temp estadisticas.temporada%type;
    v_temp2 estadisticas.temporada%type;
    v_puntos number;
    v_nombre jugadores.nombre%type;
    v_contador number := 0;
    v_suma number := 0;
    v_media number := 0;
    control jugadores.nombre%type;
CURSOR cur_pj IS
    select es.temporada, es.puntos_por_partido
    from estadisticas es join jugadores j on(es.jugador = j.codigo)
    where j.nombre = v_nombrepj;
vaux cur_pj%rowtype;
begin
select nombre into control
    from jugadores
    where nombre =v_nombrepj;
dbms_output.put_line('Estadisticas de ' ||v_nombrepj||':');
open cur_pj;
fetch cur_pj into vaux;
while cur_pj%found loop
    dbms_output.put_line(cur_pj%rowcount||'-'|| 'Temporada: ' || vaux.temporada ||'.Puntos por partido: ' || vaux.puntos_por_partido);
    v_contador := v_contador +1;
    v_suma := v_suma + vaux.puntos_por_partido;
    fetch cur_pj into vaux;
end loop;
v_media := round(v_suma/v_contador,1);
dbms_output.put_line(v_nombrepj || ' ha jugado un total de: ' || v_contador || ' temporadas y a anotado una media de: ' || v_media || ' de puntos por partido.' );
close cur_pj;
exception
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No existe el jugador: ' || v_nombrepj ||'.');
end TPUD10;

execute TPUD10('Pau Gasol');

--4.- Escribe un procedimiento que reciba el nombre de un jugador y muestre su máximo de punto por partido, mínimo y media.
create or replace NONEDITIONABLE PROCEDURE Ejercicio4 (
    v_nombrepj jugadores.nombre%type
)
is
    v_min number := 0;
    v_max number := 0;
    v_media number := 0;
    control jugadores.nombre%type;
CURSOR cur_es IS
    select max(es.puntos_por_partido), min(puntos_por_partido),round(avg(es.puntos_por_partido))
    from estadisticas es join jugadores j on(es.jugador = j.codigo)
    where j.nombre = v_nombrepj;

begin
select nombre into control
    from jugadores
    where nombre =v_nombrepj;
dbms_output.put_line('Estadisticas de ' ||v_nombrepj||':');
open cur_es;
fetch cur_es into v_max, v_min, v_media;
while cur_es%found loop
    dbms_output.put_line(cur_es%rowcount||'-'|| 'Maximo: ' || v_max ||'Minimo ' || v_min || 'Media: ' || v_media);
    fetch cur_es into v_max, v_min, v_media;
end loop;
close cur_es;
exception
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No existe el jugador: ' || v_nombrepj ||'.');
end Ejercicio4;

execute Ejercicio4('Pau Gasol');

--5.- Escribe un procedimiento que muestre los datos de cada equipo junto a los nombres de los dos
--jugadores que más puntos por partido han marcado
create or replace NONEDITIONABLE PROCEDURE Ejercicio5 
is
CURSOR cur_equipo IS
    select nombre 
        from equipos;
        
v_equipo cur_equipo%rowtype;

CURSOR cur_jugadores is
select * from (
    select j.codigo, j.nombre
        from jugadores j join equipos e on (j.nombre_equipo = e.nombre)
)
where rownum <=2;
v_jugadores cur_jugadores%rowtype;      
begin
open cur_equipo;
fetch cur_equipo into v_equipo;
while cur_equipo%found loop
    open cur_jugadores;
    fetch cur_jugadores into v_jugadores;
    while cur_jugadores%found loop
    DBMS_OUTPUT.PUT_LINE('Los maximos anotadores de: '||v_equipo.nombre || ' son:' || v_jugadores.codigo ||', '||v_jugadores.nombre);
    fetch cur_jugadores into v_jugadores;
    end loop;
    close cur_jugadores;  
    fetch cur_equipo into v_equipo;
end loop;
close cur_equipo;      
end Ejercicio5;

execute Ejercicio5;

--1.- Escribe un procedimiento que reciba el nombre de un equipo y muestre su ciudad, conferencia y
--división.
create or replace NONEDITIONABLE PROCEDURE Ejercicio1(v_nombre equipos.nombre%type)
is
CURSOR cur_equipo is
    select ciudad, conferencia, division
        from equipos
            where nombre = v_nombre;
            
v_info cur_equipo%rowtype;

begin
 open cur_equipo;
    fetch cur_equipo into v_info;
    while cur_equipo%found loop
        DBMS_OUTPUT.PUT_LINE('Nombre equipo: '|| v_nombre);
        DBMS_OUTPUT.PUT_LINE('Ciudad: ' || v_info.ciudad);
        DBMS_OUTPUT.PUT_LINE('Conferencia: ' || v_info.conferencia);
        DBMS_OUTPUT.PUT_LINE('Division: ' || v_info.division);
    fetch cur_equipo into v_info;
    end loop;
    close cur_equipo;  
end;

execute Ejercicio1('Celtics');

--2.- Escribe un procedimiento que muestre los datos de cada equipo y el número de jugadores que
--tiene.
create or replace NONEDITIONABLE PROCEDURE Ejercicio2(v_nombre equipos.nombre%type)
is
CURSOR cur_equipo is
    select e.ciudad, e.conferencia, e.division, count(j.nombre) as numero_jugadores
        from equipos e join jugadores j on(e.nombre = j.nombre_equipo)
         where e.nombre = v_nombre
        group by  e.ciudad, e.conferencia, e.division;
            
v_info cur_equipo%rowtype;

begin
 open cur_equipo;
    fetch cur_equipo into v_info;
    while cur_equipo%found loop
        DBMS_OUTPUT.PUT_LINE('Nombre equipo: '|| v_nombre);
        DBMS_OUTPUT.PUT_LINE('Ciudad: ' || v_info.ciudad);
        DBMS_OUTPUT.PUT_LINE('Conferencia: ' || v_info.conferencia);
        DBMS_OUTPUT.PUT_LINE('Division: ' || v_info.division);
        DBMS_OUTPUT.PUT_LINE('Numero de jugadores: ' || v_info.numero_jugadores);
    fetch cur_equipo into v_info;
    end loop;
    close cur_equipo;  
end;

execute Ejercicio2('Celtics');
/*Crea los siguientes procedimientos y funciones sobre la base de datos NBA:
1.- Escribe un procedimiento que reciba el nombre de un equipo y muestre su ciudad, conferencia y
división.
2.- Escribe un procedimiento que muestre los datos de cada equipo y el número de jugadores que
tiene.
3.- Escribe un procedimiento que reciba como parámetro el nombre de un jugador y muestre todas
sus estadísticas.
4.- Escribe un procedimiento que reciba el nombre de un jugador y muestre su máximo de punto por
partido, mínimo y media.
5.- Escribe un procedimiento que muestre los datos de cada equipo junto a los nombres de los dos
jugadores que más puntos por partido han marcado.
6.- Escribe un procedimiento que reciba los siguientes parámetros de entrada (código, nombre,
procedencia y nombre equipo) y los inserte en la tabla entrenador. Deberá manejar los errores que
puedan ocurrir durante la ejecución de la operación.
7.- Escribe un procedimiento que actualice el campo salario de cada jugador de forma que su salario
sea igual a la suma de todos sus puntos por partidos multiplicado por 50.*/
