--conexion UD06_PEDIDOS
--ej1
select IDFAB, IDPRODUCTO,DESCRIPCION, PRECIO, PRECIO * 1.16 as PRECIO_IVA from productos;

--ej2
--asi se hace el precio unitario, dividiendo importe por cantidad
select NUMPEDIDO, FAB, PRODUCTO, CANT, IMPORTE/CANT as precio_unitario from pedidos;

--ej3
select * from clientes order by REPCLIE asc;

--ej4 
select * from oficinas order by region asc, ciudad desc, oficina desc;

--ej5
select * from pedidos order by FECHAPEDIDO asc;

--ej6
select NUMEMP from empleados where oficina is not null order by NUMEMP desc;

--ej7
select OFICINA from oficinas where DIR is null order by OFICINA desc ;

--ej8
select * from oficinas where REGION in ('norte', 'este') order by REGION desc;
--otra opcion 
select * from oficinas where REGION like 'norte' or REGION like 'este' order by REGION desc;

--ej9
select * from EMPLEADOS where NOMBRE like '%Julia%';
select * from CLIENTES where NOMBRE like '%Julia%';

--ej10
--asi se hace para cuando queramos que acabe en x con RTRIM
select * from productos where rtrim(IDPRODUCTO) like '%x';

--ej11
select * from productos where IDPRODUCTO like '4%';