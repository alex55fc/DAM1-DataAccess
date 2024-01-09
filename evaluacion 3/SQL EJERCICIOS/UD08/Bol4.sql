--conex_UD08_VENTA
/*95. Hacer un descuento del 2% en los pedidos que se han enviado con una demora superior a
30 días desde la fecha del pedido.
Hay que modificar el precio en cada línea de detalles_pedidos y luego, a partir de
detalles_pedidos recalcular el precio_total del pedido*/
update detalles_pedidos
set precio = precio * 0.98
where numero_pedido in (
    select numero_pedido
    from pedidos
    where fecha_envio-fecha_pedido > 30
);
update pedidos ped
set ped.precio_total= (
    select sum(precio *cantidad)
    from detalles_pedidos detped
    where detped.numero_pedido = ped.numero_pedido
    group by numero_pedido
)
where fecha_envio-fecha_pedido > 30;
-- la forma de complicarlo es es solo que en el where jtengas  que hacer otra consulta ese es el caso del 96

/*97. Hacer que el precio de venta de todos los productos de la categoría 2 sea al menos un 45%
superior al precio del proveedor que tenga el precio más barato para dicho producto.
Redondear los precios sin decimales.*/
update productos prod
set prod.precio_venta = round(1.45 *(
    select min(precio_por_mayor)
    from productos_proveedores prodprov
    where prodprov.numero_producto = prod.numero_producto
), 0)
where prod.id_categoria = 2
and
prod.precio_venta <= round(1.45 * (
    select min(precio_por_mayor)
    from productos_proveedores prodprov
    where prodprov.numero_producto =prod.numero_producto
) ,0);

/*98. Poner como precio de venta de los productos de la categoría 'Accesorios' el máximo precio
al por mayor que nos pongan los proveedores para ese producto más un 35%.*/
update productos prod 
set prod.precio_venta = (
    select max(precio_por_mayor)
    from productos_proveedores prod_prov
    where prod_prov.numero_producto = prod.numero_producto
) * 1.35
where prod.id_categoria = (
    select id_categoria
    from  categorias
    where descripcion = 'Accesorios'
);
/*99. Añadir una nueva empleada con los siguientes datos: Susana Maroto, Pinares 16,
Villamanta, MADRID, 28610, código de área 425 y número de teléfono 555-7825.*/
insert into empleados(ID_EMPLEADO, NOMBRE, APELLIDOS, DIRECCION, CIUDAD, PROVINCIA, COD_POSTAL, CODIGO_AREA, TELEFONO)
values (
    (select max(id_empleado) from empleados) + 1, 'a','a','a','a','a', 'a', 425,'a'
);