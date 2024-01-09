--conex UD06_VENTAS
/*39. Listar todos los números de pedidos en los que se ha vendido algún producto cuyo número
de producto es mayor que el número del producto con nombre 'Shinoman 105 SC Frenos'. No
deben repetirse números de pedido.*/
select distinct numero_pedido 
from detalles_pedidos 
where numero_producto > (
    select numero_producto
    from productos
    where nombre like 'Shinoman 105 SC Frenos'
    );
    
/*40. Selecciona todos los nombres de proveedores que llevan productos que empiezan por la
letra C y se enviaron en pedidos antes del 1 de Marzo del 2008.*/
select nombre 
from proveedores
where id_prov in (
    select id_prov 
    from productos_proveedores 
    where numero_producto in (
        select numero_producto 
        from productos 
        where nombre like 'C%'
        )
    )
    and id_prov in (
    select id_prov 
    from productos_proveedores 
    where numero_producto in (
        select numero_producto 
        from detalles_pedidos
        where numero_pedido in (
            select numero_pedido 
            from pedidos 
            where fecha_envio < '01/03/08'
            )
        )
    );
    
/*41. Selecciona todos los nombres de proveedores que llevan productos que empiezan por la
letra V y no se han vendido. 
No se si esta bien*/
select nombre  
from proveedores 
where id_prov in (
    select id_prov 
    from productos_proveedores 
    where numero_producto in (
        select numero_producto 
        from productos 
        where nombre like 'V%' and numero_producto not in (
            select numero_producto 
            from detalles_pedidos
            )
        )
    );

/*42. Intersección: Listar los clientes que han comprado tanto productos que contengan la
cadena 'Bike' en el nombre como productos que contengan la cadena 'Casco' en el nombre.*/
select nombre
from clientes
where id_cliente in (
    select id_cliente 
    from pedidos
    where numero_pedido in (
        select numero_pedido
        from detalles_pedidos 
        where numero_producto in (
            select numero_producto
            from productos
            where nombre like '%Bike%'
            )
        )
    )
INTERSECT
select nombre
from clientes
where id_cliente in (
    select id_cliente 
    from pedidos
    where numero_pedido in (
        select numero_pedido
        from detalles_pedidos 
        where numero_producto in (
            select numero_producto
            from productos
            where nombre like '%Casco%'
            )
        )
    );
/*43. Diferencia: Listar los clientes que han comprado algún producto que contenga la cadena
'Bike' en el nombre pero ningún producto que contenga la cadena 'Casco' en el nombre.*/
select nombre
from clientes
where id_cliente in (
    select id_cliente 
    from pedidos
    where numero_pedido in (
        select numero_pedido
        from detalles_pedidos 
        where numero_producto in (
            select numero_producto
            from productos
            where nombre like '%Bike%'
            )
        )
    )
MINUS
select nombre
from clientes
where id_cliente in (
    select id_cliente 
    from pedidos
    where numero_pedido in (
        select numero_pedido
        from detalles_pedidos 
        where numero_producto in (
            select numero_producto
            from productos
            where nombre like '%Casco%'
            )
        )
    );
/*44. Unión: Listar los clientes que han comprado algún producto que contenga la cadena 'Bike'
o la cadena 'Casco' en el nombre.*/
select nombre
from clientes
where id_cliente in (
    select id_cliente 
    from pedidos
    where numero_pedido in (
        select numero_pedido
        from detalles_pedidos 
        where numero_producto in (
            select numero_producto
            from productos
            where nombre like '%Bike%'
            )
        )
    )
UNION
select nombre
from clientes
where id_cliente in (
    select id_cliente 
    from pedidos
    where numero_pedido in (
        select numero_pedido
        from detalles_pedidos 
        where numero_producto in (
            select numero_producto
            from productos
            where nombre like '%Casco%'
            )
        )
    );
/*45. Clientes que viven en una ciudad que no coincide con ninguna de los empleados*/
select nombre
from clientes 
where ciudad not in (
    select ciudad
    from empleados
    );
    
/*47. Seleccionar los nombres de los productos que pertenecen a la categoría 'Componentes'*/
select nombre 
from productos
where id_categoria in (
        select id_categoria
        from categorias
        where descripcion like 'Componentes'
    );
/*48. Selecciona los productos cuyo precio sea mayor o igual que el de todos los demás.*/
select * 
from productos
where precio_venta >= all (
    select precio_venta
    from productos
);
/*49. Selecciona los productos cuyo precio sea menor que el producto 'Eagle SA-120 Pedales sin
clip', ordenados por el precio de venta.*/
select * 
from productos
where precio_venta <  (
    select precio_venta
    from productos
    where nombre like 'Eagle SA-120 Pedales sin clip'
)
order by precio_venta asc ;

/*50.Selecciona todos los productos que no pertenecen a las categorías 'Ruedas' ni 'Baca para el coche'.*/
select * 
from productos
where (
    id_categoria not in (
    select id_categoria
    from categorias 
    where id_categoria like 'Ruedas'
    )
)
    and(
    id_categoria not in (
    select id_categoria
    from categorias 
    where id_categoria like 'Baca para el coche'    
    )
);
/*51. Seleccionar los productos cuyo precio de venta sea mayor que cualquier producto de la
categoría 'Componentes'*/
select * 
from productos
where precio_venta > all (
    select precio_venta
    from productos 
    where id_categoria in (
            select id_categoria
            from categorias
            where descripcion like 'Componentes'
        )
    );
/*52. Selecciona los clientes que son de la misma ciudad que el cliente con id 1001, en la lista no
tiene que salir el cliente 1001.*/
select *
from clientes 
where ciudad in (
    select ciudad
    from clientes 
    where id_cliente like '1001'
    )
    and id_cliente not in '1001';
    
/*53. Encuentra los productos que tienen el precio de venta mínimo de su categoría.*/
select p.numero_producto, p.nombre,  p.precio_venta
from productos p 
where p.precio_venta = (
    select min(p2.precio_venta)
    from productos p2
    where p2.id_categoria = p.id_categoria
    );
/*54. Selecciona las categorías que no tienen productos*/
select *
from categorias 
where id_categoria not in (
    select id_categoria
    from productos 
);
