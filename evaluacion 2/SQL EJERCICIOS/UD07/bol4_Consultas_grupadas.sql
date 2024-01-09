--conexion UD07_VENTAS
--71) Calcula cu�nto se ha recaudado en total con todos los pedidos.
select sum(precio_total) as precio_total
from pedidos;

/* suma de los precios totales de todos los productos comprados en cada categor�a de productos para pedidos activos.*/
select c.id_categoria, sum(p.precio_total)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
join detalles_pedidos d on (p.numero_producto = d.numero_producto)
join pedidos p on (d.numero_pedido = p.numero_pedido)
group by c.id_categoria;

/*72) Muestra el precio del producto m�s alto de cada categor�a y el identificador de la categor�a a la que
pertenece ese precio.*/
select c.id_categoria, max(p.precio_venta)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria
order by c.id_categoria asc;

/*73) Calcula el precio de venta medio de los productos de cada categor�a, junto con el
identificador de la categor�a.*/
select c.id_categoria, avg(p.precio_venta)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria
order by c.id_categoria asc;

/*74) Muestra el precio m�s alto de cada categor�a junto con el identificador y la descripci�n
de la categor�a a la que pertenece ese precio, ordenado por identificador de la
categor�a.*/
select c.id_categoria,c.descripcion, max(p.precio_venta)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria, c.descripcion
order by c.id_categoria asc;

--75) Muestra el n�mero de productos que hay en cada categor�a.
select c.id_categoria, count(p.numero_producto)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.id_categoria 
order by c.id_categoria asc;

/*76) Ahora muestra la descripci�n e identificador de la categor�a que tiene m�s productos
junto con el n�mero de productos que tiene.*/
select *
from (
    select c.id_categoria,c.descripcion, count(p.numero_producto)
    from categorias c join productos p on (c.id_categoria = p.id_categoria)
    group by c.id_categoria,c.descripcion
    order by count(p.numero_producto) desc
    )

where rownum <= 1;

/*77) Selecciona cu�nto dinero se ha gastado en total en cada categor�a el cliente con
identificador 1001.*/
select c.id_categoria, sum(d.precio*d.cantidad)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
join detalles_pedidos d on (p.numero_producto = d.numero_producto)
join pedidos p on (d.numero_pedido = p.numero_pedido)
where p.id_cliente like '1001'
group by c.id_categoria
order by p.id_categoria;

--78) Muestra la descripci�n de las categor�as que tengan m�s de 5 productos en venta.
select c.descripcion, count(p.stock)
from categorias c join productos p on (c.id_categoria = p.id_categoria)
group by c.descripcion 
having count(p.stock) > 5;
--Muestra la descripci�n de las categor�as que tengan m�s de 5 productos de stock.
select c.descripcion, sum(p.stock) as "PRODUCTOS EN VENTA"
from categorias c join productos p on (c.id_categoria=p.id_categoria)
group by c.descripcion
having sum(p.stock) > 5;

/*79) Muestra nombre, apellidos e identificador de los clientes que se han gastado m�s de
14000 � en productos de la categor�a 1.*/
select c.id_cliente ,c.nombre, c.apellidos,sum(d.precio * d.cantidad)
from clientes c join pedidos p on (c.id_cliente = p.id_cliente)
join detalles_pedidos d on (p.numero_pedido = d.numero_pedido) 
join productos pr on (d.numero_producto = pr.numero_producto)
where pr.id_categoria = 1
group by c.id_cliente ,c.nombre, c.apellidos
having sum(d.precio * d.cantidad) > 14000;

--80) Muestra para cada empleado cu�nto dinero ha hecho en pedidos.
select e.id_empleado, e.nombre, sum(p.precio_total)
from empleados e join pedidos p on (e.id_empleado = p.id_empleado)
group by e.id_empleado, e.nombre;

--81) Muestra cu�nto han recaudado en pedidos los empleados 701,702 y 703.
select e.id_empleado, e.nombre, sum(p.precio_total)
from empleados e join pedidos p on (e.id_empleado = p.id_empleado)
where e.id_empleado in (701,702,703)
group by e.id_empleado, e.nombre;

/*82) Ahora muestra los 3 empleados que m�s dinero han recaudado en pedidos. Debe
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
d�as de env�o. Debes mostrar nombre de proveedor junto con el nombre del producto
que tiene menos d�as de env�o.*/
select p.id_prov, pr.nombre, pro.dias_envio
from proveedores p join productos_proveedores pro on (p.id_prov = pro.id_prov)
join productos pr on (pro.numero_producto = pr.numero_producto)
where dias_envio = (
    select min(dias_envio)
    from productos_proveedores
);

