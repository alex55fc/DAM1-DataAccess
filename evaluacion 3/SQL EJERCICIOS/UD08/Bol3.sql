--conex_UD08_VENTA
--Comprueba que tienes desactivada la confirmaci�n autom�tica (show autocommit)
show autocommit;
/*84. Incrementa el precio de venta de todos los productos en un 10%. El departamento de
ventas quiere deshacer los cambios lo antes posible.*/
update productos
set precio_venta = precio_venta * 1.10;
rollback;

/*85. Tenemos que subir un 4% los precios de los productos de la categor�a 'Ropa' y deshacerlos
lo m�s tarde posible.
a) Mostrar un listado con los nombres de los productos, el precio actual y el precio que
tendr�n despu�s de la subida.
b) Actualizar los precios de venta de dichos productos subi�ndolos un 4%.*/
--A)
select nombre,precio_venta, precio_venta * 1.04  as precio_nuevo 
from productos 
where id_categoria in (
    select id_categoria 
    from categorias 
    where descripcion like 'Ropa'
);
--B)
update productos 
set precio_venta = precio_venta * 1.04
where id_categoria in (
    select id_categoria 
    from categorias 
    where descripcion like 'Ropa'
);
------------------------------------------------------------------------------------------------------------------------------
/*86. Comprueba si la precisi�n de los campos num�ricos de las tablas PEDIDOS y
PEDIDOS_HISTORICO coincide. Si no es as� modifica la tabla PEDIDOS_HISTORICO para que
haya coincidencia.*/
/*COMO VAMOS A USAR DDL  Y ESO LLEVA UN COMMIT IMPLICITO hacemos antes un rollback ya quen nos decia  de deshacer
los cambios lo mas tarde posibles*/
rollback;
alter table pedidos_historico
modify precio_total number (7,2);
-------------------------------------------------------------------------------------------------------------------------------
/*87. Nuestra empresa es l�der del mercado y puede permitirse hacer lo que le apetezca. Por eso
ha decidido que aplicar� con efecto retroactivo las �ltimas subidas de precio.
Para eso los datos que hasta ahora ten�amos en la tabla PEDIDOS los guardaremos en la
tabla PEDIDOS_HISTORICO.              Confirmarlo lo m�s tarde posible.*/
insert into pedidos_historico
select * 
from pedidos;
--no hacemos commit esperamos a hacerlo mas tarde
/*88. Incrementar un 5% los precios de los productos de la categor�a 'Ropa' y a continuaci�n
actualizar en la tabla PEDIDOS el precio total de cada pedido de acuerdo a los nuevos
precios de los productos y lo mismo en la tabla DETALLES_PEDIDOS. **** Confirmarlo lo
m�s tarde posible. ******* */
update productos 
set precio_venta = precio_venta * 1.05
where id_categoria in (
    select id_categoria 
    from categorias 
    where descripcion like 'Ropa'
);
update DETALLES_PEDIDOS 
set precio = precio * 1.05
where numero_producto in (
    select numero_producto 
    from productos 
    where id_categoria in (
        select id_categoria 
        from categorias 
        where descripcion like 'Ropa'
    ) 
);
update pedidos 
set precio_total=(
    select sum(detped.precio * detped.cantidad)
    from detalles_pedidos detped
    where detped.numero_pedido = pedidos.numero_pedido
    group by detped.numero_pedido
)
where numero_pedido in(
    select numero_pedido
    from detalles_pedidos
    where numero_producto in (
        select numero_producto
        from productos 
        where id_categoria in (
            select id_categoria
            from categorias 
            where descripcion like 'Ropa'
        )
    )
);
