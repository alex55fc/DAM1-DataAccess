--1. Crear una vista DEP30 que contiene el APELLIDO, el OFICIO, y el SALARIO de los
--empleados de la tabla EMPLE del departamento 30. Después comprobar
--descripción y contenido.
grant CREATE VIEW to ud9;
create or replace view DEP30 as
    select apellido, oficio, salario 
        from emple
            where dept_no = 30;

select * from DEP30;

--2. Hacer lo mismo que en el ejercicio anterior dando nombres distintos a las
--columnas.
--Para reemplazar la vista, que ya existe al haberla creado en el ejercicio anterior,
--acuérdate de utilizar la sentencia OR REPLACE.
create or replace view DEP30 (PERSONA, TRABAJO, DINEROS) as
    select apellido, oficio, salario 
        from emple
            where dept_no = 30;

select * from DEP30;

--3. Crear la vista VDEP a partir de la tabla DEPART con las columnas dept_no y
--dnombre. A partir de la vista anterior cambiar el nombre del departamento 20 a
--‘nuevo20’.
create or replace view VDEP as
    select dept_no, dnombre from depart;
    
select * from VDEP;
    
update VDEP set dnombre = 'nuevo20'
where dept_no = 20;

--4. Crear una vista a partir de las tablas EMPLE y DEPART que contenga las columnas
--EMP_NO, APELLIDO, DEPT_NO y DNOMBRE. Probar a insertar, a modificar y a
--borrar filas.
create or replace view DATOS as
    select e.emp_no, e.apellido, dep.dept_no, dep.dnombre
        from emple e join depart dep on(e.dept_no = dep.dept_no);

insert into emple values (7898, 'RODRIGUEZ', 'VENTAS', null, '14/08/01', 873568, null, 10);
select * from DATOS;

--5. Crear una vista llamada pagos a partir de las filas de la tabla EMPLE, cuyo
--departamento sea el 10. Las columnas de la vista se llamarán NOMBRE, SAL_MES.
--SAL_AN y DEPT_NO. El NOMBRE es la columna APELLIDO, al que aplicamos la
--función INITCAP(), SAL_MES es el SALARIO, SAL_AN es el salario*12.
--Modificar individualmente cada columna y ver qué ocurre.
create or replace view pagos (nombre, sal_mes, sal_an, dept_no) as
    select initcap(apellido), salario, salario*12, dept_no
        from emple
            where dept_no = 10;
            
select * from pagos;

update pagos
set nombre = 'Auron'
where sal_mes = 650000;
--DA ERROR PORQUE LA VIRTUAL COLUMN NO ESTA PERMITIDA.

--6. Crear la vista VMEDIA a partir de las tablas EMPLE y DEPART. La vista contendrá por
--cada departamento el número de departamento, el nombre, la media de salario y
--el máximo salario.
--Visualizar su contenido y tratar de borrar filas, insertar y modificar.
create or replace view VMEDIA as
    select d.dept_no, d.dnombre, round(avg(emp.salario)) as MEDIA, max(emp.salario) as MAXIMO
        from depart d join emple emp on(d.dept_no = emp.dept_no)
            group by d.dept_no, d.dnombre;

select * from VMEDIA;

--7. Crear el sinónimo DEPARTAMENTOS asociado a la tabla DEPART.
grant CREATE SYNONYM to ud9;
create synonym DEPARTAMENTOS for depart;

--8. Crear un sinónimo llamado Conser asociado a la vista creada antes (vmedia). Hacer
--consultas utilizando este sinónimo.
create synonym Conser for VMEDIA;
SELECT * FROM Conser;
SELECT DEPT_NO FROM Conser WHERE DNOMBRE LIKE 'CONTABILIDAD';

--9. Conectarse como usuario SYSTEM a la base de datos de Oracle y crear un usuario
--llamado “administrador” autentificado por la base de datos con contraseña admin.
--Indicar como "tablespace" por defecto USERS y como "tablespace" temporal TEMP;
--asignar una cuota de 500K en el "tablespace" USERS.
--Consulta después la vista all_users e indica la información que aparece sobre él.
CREATE USER administrador IDENTIFIED BY admin
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp
QUOTA 500K on USERS;
grant create session to administrador;
select * from all_users where username like 'ADMINISTRADOR';

--10. Abrir una nueva conexión en sql developer e intentar conectarse como usuario
--“administrador”, ¿qué sucede?, ¿por qué?

--FALTAN PERMISOS.

--11. Averiguar qué privilegios de sistema, roles y privilegios sobre objetos tiene
--concedidos el usuario “administrador” consultando las vistas dba_role_privs,
--dba_tab_privs, dba_sys_privs (busca en Internet qué contienen cada una de estas
--vistas).

select * from dba_role_privs where grantee like 'ADMINISTRADOR';
select * from dba_tab_privs where grantee like 'ADMINISTRADOR';
select * from dba_sys_privs where grantee like 'ADMINISTRADOR';

--12. Otorgar el privilegio “CREATE SESSION” al usuario “administrador” e intentar de
--nuevo la conexión sqlplus o sqldeveloper.

--hecho en el ejrcicio 9.

--13. Modifica la contraseña del usuario administrador por admi y vuelve a acceder a
--Oracle con el usuario administrador. Comprueba que se ha modificado la
--contraseña.
grant alter user to ADMINISTRADOR;
ALTER USER ADMINISTRADOR IDENTIFIED BY admi;

--14. Modifica el usuario administrador de forma que su cuenta esté bloqueada.
--Accede de nuevo con este usuario y comprueba que efectivamente no puede
--acceder a su cuenta.
alter user administrador account lock;
alter user administrador account unlock;

--15. Conectarse como usuario “administrador” y crear un usuario llamado “prueba00”
--que tenga como "tablespace" por defecto USERS y como "tablespace" temporal
--TEMP; asignar una cuota de 500K en el "tablespace" USERS. ¿Es posible hacerlo?
CREATE USER prueba00 IDENTIFIED BY prueba00
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp
QUOTA 500K on USERS;
--NO FUNCIONA PQ EL USUARIO ADMINISTRADOR NO TIENE PERMISOS.

--16. Conectado como usuario SYSTEM, otorgar el privilegio “create user” al usuario
--“administrador” y repetir el ejercicio anterior.
alter session set "_ORACLE_SCRIPT"=true;
grant create user to administrador;
CREATE USER prueba00 IDENTIFIED BY prueba00
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp
QUOTA 500K on USERS;
grant create session to prueba00;

--17.Crea un nuevo usuario prueba1 con clave prueba1 y tablespace users.
--Concédele el privilegio de connectarse a la BD. Trata de crear una tabla ¿Has
--podido? ¿Por qué? Concédele el privilegio CREATE TABLE y trata de crear de nuevo
--la tabla ¿Has podido?
CREATE USER prueba1 IDENTIFIED BY prueba1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp
QUOTA 500K on USERS;
grant create session to prueba1;

CREATE TABLE prueba1 (
 nombre  varchar2(10) NOT NULL,
 DNOMBRE  VARCHAR2(14), 
 LOC      VARCHAR2(14) );
 
grant create table to prueba1;

--18. Asígnale una cuota de 500 K al usuario prueba1.
--desde system.
alter user prueba1 quota 500k on users;

--19. Como usuario prueba1, modifica su propia contraseña a pru1. ¿Puede modificar el
--propio usuario prueba1 su espacio de tablas por defecto? ¿Qué privilegio necesita?
--Asígnale dicho privilegio desde el usuario System y comprueba que ahora el
--usuario prueba1 puede modificarse a sí mismo su espacio de tabla o su cuota, por
--ejemplo.
alter user prueba1 identified by pru1;
--No puede
--Necesita el privilegio de alter profile
grant alter profile to prueba1;

--20. Como usuario administrador crea un nuevo usuario llamado ora1 con contraseña
--ora1 cuota 500k y espacios users y temp. Este nuevo usuario deberá poder
--conectarse a la BD y crear tablas. Crea una tabla para el usuario ora1. ¿Puedes
--insertar datos o manipular la tabla ? ¿Puedes crear procedimientos, triggers? Indica
--qué privilegios necesitarías.
CREATE USER oral IDENTIFIED BY oral
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp
QUOTA 500K on USERS;
grant alter session to oral;

CREATE TABLE oral (
 nombre  varchar2(10) NOT NULL,
 DNOMBRE  VARCHAR2(14), 
 LOC      VARCHAR2(14) );
 
grant create table to administrador;

--21. Como usuario administrador borra el usuario ora1. Indica los pasos que has tenido
--que realizar para poder hacerlo.
grant drop user to administrador;
drop user oral;

--22. Averiguar qué usuarios de la base de datos tienen asignado el privilegio “create
--user” de forma directa, ¿qué vista debe ser consultada? ¿Qué significa la opción
--ADMIN OPTION?
select * from dba_sys_privs where privilege like 'CREATE USER';

--23. Hacer lo mismo para el privilegio “create session”.
select * from dba_sys_privs where privilege like 'CREATE session';

--25. Concede permisos al usuario oracle4 para ejecutar consultas sobre la tabla
--employees del usuario hr (Crea previamente el usuario oracle4 con clave oracle4 a
--500k y tablespace users y temp, concédele privilegios para conectarse y crear
--tablas, crea una tabla en el usuario oracle4) Nota: previamente concede
--definitivamente al administrador el rol dba.
create user oracle4 identified by oracle4
default tablespace users
temporary tablespace temp
quota 500k on users;
grant create session to oracle4;
grant create table to oracle4;
drop user oracle4;
create table tablaprueba (
campo1 varchar2(10),
campo2 number);
grant select on hr.employees to oracle4;
--/*26. Consulta los datos de la tabla employees (habiéndote conectado como usuario
--oracle4). Crear la tabla empleados a partir de la consulta anterior.*/
select * from hr.employees;
create table empleados as select * from hr.employees;
--/*27. Consulta los datos de la tabla countries de hr ¿Has podido? ¿Por qué?
select * from hr.countries;
--no se puede por no tener privilegios de consulta sobre countries
--/*28. Concede permisos a oracle4 para insertar registros en la tabla countries de hr.*/
grant insert on hr.countries to oracle4;
/*29. Inserta el país España con código ES de Europa en la tabla countries como usuario
oracle4.*/
insert into hr.countries VALUES('ES', 'ESPAÑA',1);
/*30. Trata de borrar como usuario oracle4 la fila que has insertado.*/
delete from hr.countries where country_id like 'ES';
--da error ya que el usuario oracle no tiene privilegios de borrado
/*
31. Crea la tabla país como copia de countries desde el usuario HR. */
CREATE TABLE PAIS AS SELECT * FROM HR.COUNTRIES;
/*32. Concede al usuario oracle4 permisos para borrar tablas de cualquier usuario. 
Borra desde el usuario oracle4 la tabla país del usuario hr. */
grant drop any table to oracle4;
--.32 Oracle4 concede a todos los usuarios (actuales y futuros) cualquier tipo de
--privilegio sobre la tabla que ha creado en el ejercicio 25.
grant all privileges on oracle4.tablaprueba to public;

--34.Crea en oracle4 una segunda tabla2 con 3 campos (campo1, campo2 y campo3)
--concede al usuario hr permisos para modificar solo la columna campo2. Trata
--ahora de modificar como usuario hr dos columnas de esa tabla, ¿permite hacerlo?
create table tabla2 (
campo1 varchar2(10),
campo2 number,
campo3 number);
grant update (campo2) on tabla2 to hr;
insert into oracle4.tabla2 values(
'hola', 'que_tal', 'adios');
update oracle4.tabla2 set oracle4.tabla2.campo2 ='adios';
--En campo1 da error debido a que hr no tiene permisos para modificar campo1 (solo tiene permisos de modificacion del campo2).

--35. Comprueba que desde oracle 4 puedes borrar la tabla countries
drop table hr.countries cascade constraints;
--al tener el privilegio se pudo borrar la tabla.





