--conexion hr
drop table EMPLEADOS3 cascade constraints;
drop table DEPARTAMENTOS2 cascade constraints;
drop table DEPARTAMENTOS cascade constraints;
drop table TIENDA cascade constraints;
--EJERCICIO 1
/*La estructura para crear una tbala a partir de otra es:
create table  nombre_tabla as (consulta) *para seleccionar todo*/
create table EMPLEADOS3 as(select * from EMPLOYEES where DEPARTMENT_ID = 100);
/*La estructura de los datos es la misma (mismo tipo de datos)
pero no se hean heredado restricciones ,  por lo que no hay clave primaria*/
--EJERCICIO 2
create table DEPARTAMENTOS2 as(select * from DEPARTMENTS);

--EJERCICIO 3
--para añadir columnas solo con un add
alter table EMPLEADOS3 add(hobby VARCHAR2(40), nhijos NUMBER(2));

--EJERCICIO 4 y 5
/*alter table EMPLEADOS3 add(edad NUMBER(3) not null);
No funciona porque la tabla debe estar vacia para agregar una columna obligatoria
Como la tabla tiene datos dentro, ademas de not null tenemos que agregar un valor
por defecto para que no este vacia la columna al agregarla*/
alter table EMPLEADOS3 add(EDAD NUMBER(3) default 18 not null);

--Ejercicio 6
--borrar columnas con drop
alter table EMPLEADOS3 drop (EDAD,nhijos);

--Ejercicio 7
--modificar datos de un campo de una tabla
alter table EMPLEADOS3 modify (hobby VARCHAR2(30));

--Ejercicio 8
/*alter table EMPLEADOS3 modify (first_name VARCHAR2(5)
No funciona porque el valor del nombre de algun empleado es superior a 5 caracteres */

--Ejerciicio 9
/*alter table EMPLEADOS3 modify (employees_id NUMBER (5,0));
No puedo reducir el tamaño del tipo de numero si no esta vacia.
Sin embargo, si puedo ampliar a 6 digitos o mas*/
alter table EMPLEADOS3 modify(employee_id number(8,0));

--Ejercicio 10 
/*alter table DEPARTMENTS DROP (department_id);
No deja borrar porque es una PK. O borro todas las claves ajenas que referencia
primero,o especifico cascade constraints para que se elimine todo   */

--Ejercicio 11
--asi se añade una constraint de una columna de una tabla
alter table EMPLEADOS3 add constraint PK_EMPLE3 primary key(employee_id);

--Ejercicio 12
--asi se añade una constraint con check
alter table EMPLEADOS3 add constraint SALARIO check(salary between 1000 and 20000);

--Ejercicio 13
create table DEPARTAMENTOS as(select * from DEPARTMENTS);

--Ejercicio 14 
--asi ponemos datos en la fila
--porque no ponemos insert into DEPARTAMENTOS (department_id, department_name, manager_id, location_id) values (20,'Admin',203,1700);
insert into DEPARTAMENTOS values (10,'Admin',203,1700);
--asi se borra una linea con todos sus valores
DELETE FROM DEPARTAMENTOS WHERE department_id = 20 AND department_name = 'Admin' AND manager_id = 203 AND location_id = 1700;

--Ejercicio 15
/*alter table DEPARTAMENTOS ass constrsint DEPARTAMENTOS_PK primary key(department_id );
No funciona porque el valor 10 para id es duplcado ya que en el ej 14 la creamos.
Vamos a eliminar ese registro porque esta duplicado. Para no borrar ambos que tengan ID 10,
vamos a borrar el que hemos insertado con nombre Admin, ya que el resto de datos se 
repiten en otros registros.Usaremos*/
delete from DEPARTAMENTOS where department_name='Admin';
alter table DEPARTAMENTOS add constraint department_id_pk primary key (department_id);
--Ejercicio 16
alter table EMPLEADOS3 add constraint COMISION check(COMMISSION_PCT <= 0.05);

--Ejercicio 17
/*Para actualizar un registro se utiliza el comando update
UPDATE nombre_tabla set columna = valor [WHERE ...]
Tenemos que pones una comision como mucho del 5% tal y como hemos restringido en el ej anterior*/
update EMPLEADOS3 set COMMISSION_PCT =0.02;

--ejercicio18
--asi hacemos una foreign
alter table EMPLEADOS3 add constraint fk_emple3 foreign key (department_id) references DEPARTAMENTOS(department_id) on delete cascade;

--ejercicio 19
create table tienda(
NIF varchar2(9),
NOMBRE varchar2(10),
DIRECCION varchar2(10),
POBLACION varchar2(10),
CIUDAD varchar2(10),
PROVINCIA varchar2(10),
CODPOSTAL varchar2(10)
);

alter table tienda add(
constraint nif_pk primary key(NIF),
constraint provin_ck check(PROVINCIA = UPPER(PROVINCIA)),
constraint nombre_ck check(NOMBRE is not null),
constraint ciudad_ck check (ciudad in ('Zaragoza','Huesca','Teruel'))
);




