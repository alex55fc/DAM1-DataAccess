--conexion UD9_EMPDEP
                                --VISTAS
/*1. Crear una vista DEP30 que contiene el APELLIDO, el OFICIO, y el SALARIO de los
empleados de la tabla EMPLE del departamento 30. Después comprobar
descripción y contenido.*/
create view dep30 as
select apellido, oficio , salario 
from emple
where dept_no = 30;

desc dep30;

select * from dep30;

/*2. Hacer lo mismo que en el ejercicio anterior dando nombres distintos a las
columnas.
Para reemplazar la vista, que ya existe al haberla creado en el ejercicio anterior,
acuérdate de utilizar la sentencia OR REPLACE.*/

--Al poner los parentesis lo que haya dentro seran los alias de las columnas solo para la vista.
create or replace view dep30(ape,ofi,sal) as
select apellido, oficio , salario 
from emple
where dept_no = 30;

/*3. Crear la vista VDEP a partir de la tabla DEPART con las columnas dept_no y
dnombre. A partir de la vista anterior cambiar el nombre del departamento 20 a
‘nuevo20’.*/
create or replace view vdep as 
select dept_no, dnombre 
from depart;

desc vdep;
select *from vdep;

update vdep
set nombre = 'nuevo20'
where dept_no = 20;
--Sobre vistas compuestas no puedo hacer DML inserción, modificacion y borrado.

/*5. Crear una vista llamada pagos a partir de las filas de la tabla EMPLE, cuyo
departamento sea el 10. Las columnas de la vista se llamarán NOMBRE, SAL_MES.
SAL_AN y DEPT_NO. El NOMBRE es la columna APELLIDO, al que aplicamos la
función INITCAP(), SAL_MES es el SALARIO, SAL_AN es el salario*12.
Modificar individualmente cada columna y ver qué ocurre.*/
create or replace view pagos(nombre,sal_mes,sal_an,dept_no) as
select apellido,salario, salario * 12 , dept_no
from emple 
where dept_no = 10;

select * from pagos;

update pagos
set nombre= 'Marquez'
where sal_mes = 1;
                           --SINONIMOS
--Comprobar los permisos de sinonimos 
select * from user_synonyms;

--7. Crear el sinónimo DEPARTAMENTOS asociado a la tabla DEPART.
--ejecutando desde el usuario UD09_EMPDEP sin privilegios, me dice que no tengo privilegios 
create synonym departamentos for depart;
--desde SYS OTORGO PRIVILEGIOS DE CREACION DE SINONIMOS  
grant create synonym to UD09_EMPDEP;
--AHORA con el privilefio desde UD09_EMPDEP ejecutamos wl sinonimo
create synonym departamentos for depart;

/*8. Crear un sinónimo llamado Conser asociado a la vista creada antes (vmedia). Hacer
consultas utilizando este sinónimo.*/
create synonym conser for vmedia;
--consulta 
select * from conser 
where sal_med > 250000;
                        --CREACION USUARIO
--EJECUTAR LO SIGUIENTE SI NO ME DEJA CREAR USUARIOS 
alter session set "_ORACLE_SCRIPT"= true;
--para ver todos los usuarios 
select * from all_users;
/*9. Conectarse como usuario SYSTEM a la base de datos de Oracle y crear un usuario
llamado “administrador” autentificado por la base de datos con contraseña admin.
Indicar como "tablespace" por defecto USERS y como "tablespace" temporal TEMP;
asignar una cuota de 500K en el "tablespace" USERS.
Consulta después la vista all_users e indica la información que aparece sobre él.*/
CREATE USER administrador IDENTIFIED BY admin
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500k on USERS;
--comprobacion 
select * from all_users;
                        --PERMISOS USUARIOS
--obtiene información sobre los roles asignados
select * from dba_role_privs where grantee like 'administrador';
--muestra información sobre los privilegios de tablas asignados
select * from dba_tab_privs where grantee like 'administrador';
--información sobre los privilegios del sistema asignados
select * from dba_sys_privs where grantee like 'administrador';

/*11. Averiguar qué privilegios de sistema, roles y privilegios sobre objetos tiene
concedidos el usuario “administrador” consultando las vistas dba_role_privs,
dba_tab_privs, dba_sys_privs (busca en Internet qué contienen cada una de estas
vistas).*/
select * from dba_role_privs where grantee like 'administrador';
select * from dba_tab_privs where grantee like 'administrador';
select * from dba_sys_privs where grantee like 'administrador';


