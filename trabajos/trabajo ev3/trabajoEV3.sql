--conexion trbajoEV3 Hecho por Alexander Fuela
/*1. Escribe un procedimiento que reciba como parámetro el nombre de un
jugador y muestre todas sus temporadas y puntos por partido de cada una de
ellas.
2. Además, después debe mostrar una frase del estilo "El jugador nombre_jug
ha jugado num_temp temporadas anotando media_puntos puntos de media",
donde nombre_jug, num_temp y media_puntos se los pasa el procedimiento.

3. Por último, debe incluir una excepción para cuando no se encuentra el
nombre del jugador en la base de datos.*/
set serveroutput on;
create or replace procedure ejercicioTrabajoAlexFuela (nombreJug jugadores.nombre%type)
as
    control jugadores.nombre%type;
    
    cursor cur is 
    select e.temporada, e.puntos_por_partido 
    from jugadores j join estadisticas e on(j.codigo = e.jugador)
    where j.nombre =  nombreJug;
    
    cur_aux cur%rowtype;
    contador NUMBER := 0;
    puntos_medios NUMBER := 0;
begin
    select nombre into control
    from jugadores 
    where nombre = nombreJug;
    dbms_output.put_line('Estadisticas de '||nombreJug );
    
    open cur;
    fetch cur into cur_aux;
    while cur%found loop
    dbms_output.put_line(cur%rowcount ||' Temporada: '|| cur_aux.temporada || ' Puntos por partido: '|| cur_aux.puntos_por_partido );
    contador := contador + 1; 
    puntos_medios := puntos_medios + cur_aux.puntos_por_partido;
    fetch cur into cur_aux;
    end loop;
    puntos_medios := round((puntos_medios / contador),1);
    dbms_output.put_line(nombreJug || ' ha jugado ' || contador || ' temporadas, anotando una media de ' || puntos_medios || ' puntos por partido');
    
exception
    when no_data_found then
    dbms_output.put_line('El jugador '|| nombreJug || ' no se encuentra en la base de datos.');
    when others then
    dbms_output.put_line('Ha habido otro error');
end ejercicioTrabajoAlexFuela;
execute ejercicioTrabajoAlexFuela('Pau Gasol');
execute ejercicioTrabajoAlexFuela('JAJA');