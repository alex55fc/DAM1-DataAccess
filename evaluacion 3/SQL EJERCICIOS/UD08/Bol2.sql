    --conexion UD08_JOBS
--1. Dadas las tablas ALUM y NUEVOS, insertar en la tabla ALUM los nuevos alumnos.
insert into alum (
    select * from nuevo
    minus 
    select * from alum
    );
--2. Borrar de la tabla ALUM los ANTIGUOS alumnos.
delete from alum 
where dni in(
    select dni
    from antiguo
);
/*3. EMPLE y DEPART. Insertar un empleado de apellido 'saavedra' con número 200, la
fecha de alta será la actual, el SALARIO será el mismo salario de 'sala' más el 20 por 100 y
el resto de datos serán los mismos que los datos de 'sala'.*/
insert into emple(emp_no,apellido, oficio, dir,fecha_alt,salario, comision, dept_no)
select 200, 'saavedra', oficio, dir, sysdate, salario * 1.20, comision, dept_no
from emple
where apellido like 'SALA';

/*4. Modificar el número de departamento de 'saavedra'. El nuevo departamento será el
Departamento donde hay más empleados cuyo oficio sea 'empleado'.*/
update emple
set dept_no = (
    select dept_no
    from emple
    where oficio like 'EMPLEADO'
    group by dept_no
    having count(*) = (
        select max(count(*))
        from emple
        where oficio like 'EMPLEADO'
        group by dept_no
        )
    )
where apellido like 'saavedra';

/*5. Borrar todos los departamentos de la tabla DEPART para los cuales no existan
empleados en emple.*/
delete from depart
where dept_no not in (
    select dept_no 
    from emple
    group by dept_no
);
/*6. PERSONAL, PROFESORES y CENTROS. Modificar el número de plazas con un valor
igual a la mitad en aquellos centros con menos de dos profesores.*/
update centro
set num_plazas = num_plazas/2
where cod_centro in (
    select cod_centro
    from profesor
    group by cod_centro
    having count(dni) < 2
);
--7. Eliminar los centros que no tengan personal.
delete from centro
where cod_centro not in(
    select cod_centro
    from personal
);
/*8. Borrar el personal que está en centros de menos de 300 plazas y con menos de dos
profesores.*/
delete from personal 
where cod_centro in (
    select cod_centro
    from  centro
    where num_plazas < 300
)
 and cod_centro in (
    select cod_centro
    from profesor
    group by cod_centro
    having count(dni) < 2
);
/*9. Borrar a los profesores que están en la tabla PROFESORES y que no están en la tabla
PERSONAL.*/
delete from profesores 
where dni not in (
    select dni 
    from personal
);
--------------------------------------------------------------------------------------------------
/*12. Dar de alta una tienda en la provincia de Madrid y abastecerla con 20 unidades de cada
uno de los artículos existentes.*/
insert into tienda (nif, nombre,direccion,poblacion,provincia,codpostal)
values ('11','tienda','dir','zgz','madrid','50');

insert INTO pedido(nif,cod_articulo,fecha_pedido,unidades_pedidas)
select '11', cod, sysdate,20
from articulo;

/*13. Dar de alta una tienda en la provincia de Sevilla y abastecerlas con 30 unidades de
artículos de la marca de fabricante gallo.*/
insert into tienda (nif, nombre,direccion,poblacion,provincia,codpostal)
values ('10','tienda','dir','zgz','sevilla','50');

insert INTO pedido(nif,cod_articulo,fecha_pedido,unidades_pedidas)
select '11', cod, sysdate,30
from articulo
where cod in (
    select cod 
    from fabricante 
    where nombre like 'GALLO'
);
--------------------------------------------------------------------------------------------------
--15. Cambiar todos los artículos de 'primera' categoría a 'quinta' del país ITALIA.
update articulo
set categoria = 'quinta'
where categoria like 'primera ' 
and
cod_fabricante in (
    select cod_fabricante  
    from fabricante
    where pais like 'ITALIA'
);
--16. Eliminar los artículos que no hayan tenido ni compras ni ventas.
delete from articulo 
where cod not  in (
    select cod_articulo 
    from venta
)
and cod not in (
    select cod_articulo
    from pedido
);
--17. Restar uno a las unidades de los últimos pedidos de la tienda con nif 5555-B.*/
update pedido
set unidades_pedidas = (unidades_pedidas -1)
where nif  like '5555-B'
and
fecha_pedido in (
    select max (fecha_pedido)
    from pedido
    where nif like '5555-B'
);