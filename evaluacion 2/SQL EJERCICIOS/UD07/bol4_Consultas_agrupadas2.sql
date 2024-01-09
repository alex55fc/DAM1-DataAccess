--conexion UD07_VENTAS
/*1. Muestra el producto más pedido de entre todos los pedidos.*/
select *
from (
    select *
    from productos
    where numero_producto in (
        select numero_producto
        from detalles_pedidos
        where numero_pedido in(
            select numero_pedido
            from pedidos
        )
    )
)
where rownum <= 1;

/*2. Muestra los proveedores que han proveído menos productos que
la media de productos proveídos.*/
select distinct p.nombre, count(pp.numero_producto)
from proveedores p join productos_proveedores pp on (p.id_prov = pp.id_prov)
group by p.nombre
having count(pp.numero_producto) < (
    select avg(count(pp.numero_producto))
    from productos_proveedores pp
    group by pp.id_prov);
    
--3. Lista los pedidos de menos a más productos pedidos.
select numero_pedido , sum(cantidad)
from detalles_pedidos
group by numero_pedido
order by sum(cantidad) asc;

/*4. Muestra el número de pedido, la cantidad total de productos del
pedido y el nombre del cliente y del empleado de cada pedido.*/
select dp.numero_pedido, sum(dp.cantidad) as "TOTAL PEDIDO", c.nombre as "CLIENTE", e.id_empleado, e.nombre as "EMPLEADO"
from detalles_pedidos dp join pedidos p on (dp.numero_pedido=p.numero_pedido)
    join clientes c on (p.id_cliente=c.id_cliente)
    join empleados e on (p.id_empleado=e.id_empleado)
group by dp.numero_pedido, c.nombre, e.id_empleado, e.nombre
order by dp.numero_pedido asc;

--5. Muestra el cliente que menos pedidos ha realizado
select c.id_cliente, c.nombre, count(p.numero_pedido) as "PEDIDOS"
from clientes c join pedidos p on (c.id_cliente=p.id_cliente)
group by c.id_cliente, c.nombre 
having count(p.numero_pedido) = (
    select min(count(p.numero_pedido))
    from pedidos p
    group by p.id_cliente);
--6. Muestra el empleado que más pedidos ha pedido.
select e.id_empleado, e.nombre, count(p.numero_pedido) as "PEDIDOS"
from empleados e join pedidos p on (e.id_empleado=p.id_empleado)
group by e.id_empleado, e.nombre 
having count(p.numero_pedido) = (
    select max(count(p.numero_pedido))
    from pedidos p
    group by p.id_empleado);
/*7. Encuentra los productos que tienen el precio de venta mínimo de
cada pedido.*/
select d.numero_pedido, d.numero_producto, p.nombre, min(d.precio)
from detalles_pedidos d join productos p on (p.numero_producto=d.numero_producto)
where d.precio = (
    select min(precio)
    from detalles_pedidos d2
    where d.numero_pedido=d2.numero_pedido
    group by numero_pedido)
group by  d.numero_pedido, d.numero_producto, p.nombre
order by  d.numero_pedido;