--conex trabajo_NBA
/*a. Inserción de datos a partir del resultado de una consulta simple.
Inserta un jugasor con codigo 11111, nombre juan perez, de florida, altura 6-9 peso 85, posicion F que sea del equipo de Kobe Bryant y cobre 50000 */
insert into jugadores (codigo, nombre, procedencia, altura, peso, posicion, nombre_equipo, salario)
select 11111, 'Juan Pérez', 'Florida', '6-9', 85, 'F',nombre_equipo , 50000
from jugadores 
where nombre like 'Kobe Bryant';


/*b. Inserción de datos a partir del resultado de una consulta agrupada.
Inserta un jugador con codigo 2222 nombre pepe phone y que tenga el salario maximo de todos los jugadores*/
insert into jugadores (codigo, nombre,salario)
select 22222, 'Pepe Phone', salario
from jugadores
where salario = (
select max(salario) 
from jugadores)
group by salario;


/*c. Modificación de datos utilizando la cláusula WHERE junto con una
subconsulta.
Hubo un error en los puntos por partido a lo largo de la carrera de Kobe bryant hay que sumar 10 puntos por partido a los partidos de Kobe Bryant*/
update estadisticas
set puntos_por_partido = puntos_por_partido + 10
where jugador in (
    select codigo
    from jugadores 
    where nombre = 'Kobe Bryant'
);

/*d. Modificación de datos, de forma que el nuevo valor se obtenga mediante una
subconsulta.
Los bulls tienen una penalizacion y se les resta 5 puntos por partidos en las estadisticas */
update estadisticas
set rebotes_por_partido = rebotes_por_partido -5
where jugador in (
    select codigo
    from jugadores 
    where nombre_equipo = 'Bulls'
);
/*e. Eliminación de datos utilizando una consulta correlacionada. 
Por una sancion eliminamos los datos de estadisticas del equipo Bulls*/

delete from estadisticas
where jugador in (
    select codigo 
    from jugadores 
    where nombre_equipo = 'Bucks'
    )