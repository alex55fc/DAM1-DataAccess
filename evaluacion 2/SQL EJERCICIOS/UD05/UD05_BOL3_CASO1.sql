--conexion UD05_BOL3_CASO1
drop table PROVEEDORES cascade constraints;
drop table CATEGORIAS cascade constraints;
drop table PRODUCTOS cascade constraints;
drop table PRODUCTOS_PROVEEDORES cascade constraints;
drop table CLIENTES cascade constraints;
drop table EMPLEADOS cascade constraints;
drop table PEDIDOS cascade constraints;
drop table DETALLES_PEDIDOS cascade constraints;

CREATE TABLE PROVEEDORES(
ID_PROV number(10) primary key,
NOMBRE varchar2(15),
TELEFONO number(9) unique,
MAIL varchar2(20)
);

CREATE TABLE CATEGORIAS (
ID_CATEGORIAS number(10) primary key,
DESCRIPCION varchar2(20)

);

CREATE TABLE PRODUCTOS( 
NUMERO_PRODUCTO number(10) primary key,
NOMBRE varchar2(15),
PRECIO_VENTA decimal(3,2),
STOCK number(9),
--cuando haya varias claves primarias hay que hacerlo con una prymary key
ID_CATEGORIAS number(10),
    constraint CATEGORIAS_FK foreign key(ID_CATEGORIAS)
        references CATEGORIAS(ID_CATEGORIAS)
);


CREATE TABLE PRODUCTOS_PROVEEDORES( 
ID_PROV number(10),
NUMERO_PRODUCTO number(10),
    constraint PRODUCTOS_PROV_PK primary key (ID_PROV, NUMERO_PRODUCTO),
    constraint PROV_FK foreign key (ID_PROV)
        references PROVEEDORES(ID_PROV),
     constraint NUMERO_PRODUCTO_FK foreign key (NUMERO_PRODUCTO)
        references PRODUCTOS(NUMERO_PRODUCTO)
        
);

CREATE TABLE CLIENTES( 
ID_CLIENTE number(10) primary key,
NOMBRE varchar2(15),
APELLIDO varchar2(15),
DIRECCION varchar2(30),
TELEFONO number(9) unique
);

CREATE TABLE EMPLEADOS( 
ID_EMPLEADO number(10) primary key,
NOMBRE varchar2(15),
APELLIDO varchar2(15),
DIRECCION varchar2(30),
CODIGO_AREA number(6)
);

CREATE TABLE PEDIDOS( 
NUMERO_PEDIDO number(6) primary key,
FECHA_PEDIDO varchar2(15),

ID_EMPLEADO number(10),
ID_CLIENTE number(10),
    constraint CLIENTE_FK foreign key (ID_CLIENTE) 
        references CLIENTES(ID_CLIENTE),
    constraint EMPLEADO_FK foreign key (ID_EMPLEADO)
        references EMPLEADOS (ID_EMPLEADO)
);

CREATE TABLE DETALLES_PEDIDOS(
CANTIDAD number(3),
PRECIO_VENTA number(3,2),

NUMERO_PEDIDO number(6),
NUMERO_PRODUCTO number(10),
    constraint detalles_pedidso_pk primary key (NUMERO_PEDIDO, NUMERO_PRODUCTO),
    constraint numero_pedido1_fk foreign key (NUMERO_PEDIDO) references PEDIDOS(NUMERO_PEDIDO),
    constraint numero_producto1_fk foreign key (NUMERO_PRODUCTO) references PRODUCTOS(NUMERO_PRODUCTO)
);
alter table DETALLES_PEDIDOS add constraint cantidad_ck check(cantidad between 1 and 100);

