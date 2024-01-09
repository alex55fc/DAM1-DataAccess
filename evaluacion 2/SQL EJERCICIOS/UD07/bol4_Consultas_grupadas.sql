--conexion UD07_VENTAS
--71) Calcula cuánto se ha recaudado en total con todos los pedidos.
select sum(precio_total) as precio_total
from pedidos;

/* suma de los precios totales de todos los productos comprados en cada categoría de productos para pedidos activos.*/
select c.id_categoria, sum(p.precio_total)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
join detalles_pedidos d on (p.numero_producto = d.numero_producto)
join pedidos p on (d.numero_pedido = p.numero_pedido)
group by c.id_categoria;

/*72) Muestra el precio del producto más alto de cada categoría y el identificador de la categoría a la que
pertenece ese precio.*/
select c.id_categoria, max(p.precio_venta)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria
order by c.id_categoria asc;

/*73) Calcula el precio de venta medio de los productos de cada categoría, junto con el
identificador de la categoría.*/
select c.id_categoria, avg(p.precio_venta)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria
order by c.id_categoria asc;

/*74) Muestra el precio más alto de cada categoría junto con el identificador y la descripción
de la categoría a la que pertenece ese precio, ordenado por identificador de la
categoría.*/
select c.id_categoria,c.descripcion, max(p.precio_venta)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria, c.descripcion
order by c.id_categoria asc;

--75) Muestra el número de productos que hay en cada categoría.
select c.id_categoria, count(p.numero_producto)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria 
order by c.id_categoria asc;

/*76) Ahora muestra la descripción e identificador de la categoría que tiene más productos
junto con el número de productos que tiene.*/
select *
from (
    select c.id_categoria,c.descripcion, count(p.numero_producto)
    from categorias c join productos p on (c.id_categoria = p.id_categoria)
    group by c.id_categoria,c.descripcion
    order by count(p.numero_producto) desc
    )

where rownum <= 1;

/*77) Selecciona cuánto dinero se ha gastado en total en cada categoría el cliente con
identificador 1001.*/
select c.id_categoria, sum(d.precio*d.cantidad)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
join detalles_pedidos d on (p.numero_producto = d.numero_producto)
join pedidos p on (d.numero_pedido = p.numero_pedido)
where p.id_cliente like '1001'
group by c.id_categoria
order by p.id_categoria;

--78) Muestra la descripción de las categorías que tengan más de 5 productos en venta.
select c.descripcion, count(p.stock)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.descripcion 
having count(p.stock) > 5;
--Muestra la descripción de las categorías que tengan más de 5 productos de stock.
select c.descripcion, sum(p.stock) as "PRODUCTOS EN VENTA"
from categorias c join productos p on (c.id_categoria=p.id_categoria)
group by c.descripcion
having sum(p.stock) > 5;

/*79) Muestra nombre, apellidos e identificador de los clientes que se han gastado más de
14000 € en productos de la categoría 1.*/
select c.id_cliente ,c.nombre, c.apellidos,sum(d.precio * d.cantidad)
from clientes c join pedidos p on (c.id_cliente = p.id_cliente)
join detalles_pedidos d on (p.numero_pedido = d.numero_pedido) 
join productos pr on (d.numero_producto = pr.numero_producto)
where pr.id_categoria = 1
group by c.id_cliente ,c.nombre, c.apellidos
having sum(d.precio * d.cantidad) > 14000;

--80) Muestra para cada empleado cuánto dinero ha hecho en pedidos.
select e.id_empleado, e.nombre, sum(p.precio_total)
from empleados e join pedidos p on (e.id_empleado = p.id_empleado)
group by e.id_empleado, e.nombre;

--81) Muestra cuánto han recaudado en pedidos los empleados 701,702 y 703.
select e.id_empleado, e.nombre, sum(p.precio_total)
from empleados e join pedidos p on (e.id_empleado = p.id_empleado)
where e.id_empleado in (701,702,703)
group by e.id_empleado, e.nombre;

/*82) Ahora muestra los 3 empleados que más dinero han recaudado en pedidos. Debe
aparecer el identificador del empleado, el nombre y el dinero recaudado*/
select *
from (
    select e.id_empleado, e.nombre, sum(p.precio_total)
    from empleados e join pedidos p on (e.id_empleado = p.id_empleado)
    group by e.id_empleado, e.nombre
    order by sum(p.precio_total) desc
)
where rownum <=3;

/*83) Busca el proveedor o proveedores junto con el nombre del producto que tiene menos
días de envío. Debes mostrar nombre de proveedor junto con el nombre del producto
que tiene menos días de envío.*/
select p.id_prov, pr.nombre, pro.dias_envio
from proveedores p join productos_proveedores pro on (p.id_prov = pro.id_prov)
join productos pr on (pro.numero_producto = pr.numero_producto)
where dias_envio = (
    select min(dias_envio)
    from productos_proveedores
);

