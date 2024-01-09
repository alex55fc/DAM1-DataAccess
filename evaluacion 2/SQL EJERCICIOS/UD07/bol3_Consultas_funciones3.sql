--conexion UD_06VENTAS
/*1. Calcula la cantidad total de productos pedidos cuyo precio de
venta sea mayor a la media del precio de venta del producto cuya
descripción de categoría es componentes.*/
select count(numero_producto)
from detalles_pedidos 
where precio >(
    select avg(precio_venta)
    from productos 
    where id_categoria in(
        select id_categoria
        from categorias 
        where descripcion like 'Componentes'
    )
);
--2. Calcula el precio total de los productos cuya categoría sea ropa.
select sum(precio_venta) 
from productos
where id_categoria in (
    select id_categoria
    from categorias 
    where descripcion like 'Ropa'
    );
    
/*3. Calcula el total de pedidos realizados por los clientes de la ciudad
de Robledo.*/
select count(numero_pedido)
from pedidos 
where id_cliente in (
    select id_cliente 
    from clientes 
    where ciudad like 'Robledo'
    );
/*4. Calcula el total de productos proveídos por los proveedores de
Madrid cuya categoría es Bicicletas.*/
select count(numero_producto)
from productos
where (
    numero_producto in (
        select numero_producto
        from productos_proveedores
        where id_prov in (
            select id_prov 
            from proveedores 
            where provincia like 'MADRID'
        )
    )    
)
and
(
    id_categoria in (
        select id_categoria 
        from categorias
        where descripcion like 'Bicicletas'
    )
);

/*5. Calcula el número de empleados que han realizado un pedido con
el producto que más vale.*/
select count(id_empleado)
from empleados
where id_empleado in (
    select id_empleado
    from pedidos
    where numero_pedido in (
        select numero_pedido 
        from detalles_pedidos
        where numero_producto in (
            select numero_producto
            from productos 
            where precio_venta = (
            select max(precio_venta)
            from productos 
        )
    )
)
);
--6. Muestra la categoría con el producto con menor valor de venta.
select *
from categorias 
where id_categoria in(
    select id_categoria
    from productos 
    where precio_venta = (
        select min(precio_venta)
        from productos
    )
);

/*7. Muestra los clientes que han realizado un pedido entre el 20 y el
23 de Noviembre de 2007.*/
select *
from clientes 
where id_cliente in (
    select id_cliente
    from pedidos
    where fecha_pedido between '20/11/07' and '23/11/07'
);

--8. Muestra el empleado que ha realizado el pedido más tardío.
select *
from empleados
where id_empleado in (
    select id_empleado
    from pedidos
    where fecha_pedido = (
        select max(fecha_pedido)
        from pedidos
    )
);

--9. Muestra el producto con mayor beneficio.

--10. Muestra al proveedor que tarda más en proveer un producto.
select *
from proveedores
where id_prov in (
    select id_prov
    from productos_proveedores
    where dias_envio = (
        select max(dias_envio)
        from productos_proveedores
    )
);