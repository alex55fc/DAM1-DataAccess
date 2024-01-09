--conexion UD08_EMP
----------------------------------------------------------------------------------------------------------------------
/*1. Comprueba que tienes desactivada la confirmaci�n autom�tica, si no es as� desact�vala
para poder continuar.*/
show autocommit;
set autocommit off;
----------------------------------------------------------------------------------------------------------------------
/*2. Introduce en la tabla departments, un nuevo departamento con identificador 300, nombre
Finanzas su jefe tiene el c�digo 110 y su c�digo de localizaci�n es 1800.
Comprueba que la fila se ha insertado correctamente en la tabla, si es as�, confirma la
operaci�n.*/
insert into departments values(300,'Finanzas', 110,1800);
commit;

/*3. Introduce en la tabla department, un nuevo departamento con identificador 400, nombre
Finanzas2 su jefe tiene el c�digo 389 y su c�digo de localizaci�n es 1800.
�Qu� respuesta obtienes? �Por qu�?*/

--no podemos introducir este datos ya que 389 es clave ajena y no existe en la tabla de employees
insert into departments values (400, 'Finanzas2', 389, 1800);

/*4. Introduce en la tabla employees el empleado Ricardo Marcelo con identificador 401, su
mail es rmarcelo@gmail.com , la fecha de contrataci�n es la actual, va a ganar 1600 � y
trabajar� de Jefe de Ventas ,SA_MAN. No confirmes los cambios.*/
insert into employees (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID,SALARY)
values(401, 'Ricardo', 'Marcelo','rmarcelo@gmail.com', sysdate, 'SA_MAN', 1600 );

--5. Aborta la operaci�n anterior y comprueba que la fila ha desaparecido de la tabla.
rollback;

--6. Crea una nueva tabla llamada prueba seg�n la siguiente sintaxis:
--esto es ddl el create table, aqui no podriamos hcaer rollback
create table prueba(
id number(6) primary key,
name varchar2(20),
hire_date date,
salary number(8,2));

/*7. Introduce en la tabla prueba los datos correspondientes de todos los empleados del
departamento 50*/
insert into prueba (id,name,hire_date,salary)
select employee_id, first_name || ' ' || last_name as nombre,hire_date, salary
from employees
where department_id = 50;
----------------------------------------------------------------------------------------------------------------------
/*8. Introduce en la tabla prueba un nuevo empleado con identificador 390, nombre Julio y el
resto de datos son los mismos que los del empleado con identificador 119.*/
insert into prueba (id,name,hire_date,salary)
select 390, 'Julio', hire_date, salary
from employees
where employee_id = 119;
----------------------------------------------------------------------------------------------------------------------
--9. Introduce en la tabla prueba los datos de los empleados del departamento 90.
insert into prueba 
select employee_id, first_name || ' ' || last_name as nombre,hire_date, salary
from employees
where department_id = 90;
----------------------------------------------------------------------------------------------------------------------
--10. Borra todas las filas de la tabla prueba. Confirma la operaci�n.
delete from prueba;--se puede  deshacer con un rollback;
truncate table prueba; -- NO se puede deshacer con rollback ya que es DDL
----------------------------------------------------------------------------------------------------------------------
/*11. Introduce en la tabla prueba los datos de los empleados con el menor salario de cada uno
de sus departamentos.*/
insert into prueba 
select employee_id, first_name || ' ' || last_name as nombre,hire_date, salary
from employees e1
where salary = (
    select min(salary)
    from employees e2
    where e1.department_id = e2.department_id
);
----------------------------------------------------------------------------------------------------------------------
--12. Modifica el salario del empleado 200 de la tabla prueba a 5000 �.
update prueba 
set salary = 5000
where id = 200;
----------------------------------------------------------------------------------------------------------------------
--13. Modifica los salarios de la tabla prueba y aum�ntalos un 3%.
update prueba
set salary = salary * 1.03;

/*14. Modifica la fecha de contrataci�n de los empleados de la tabla prueba y aum�ntala 1 a�o
(Utiliza la funci�n ADD_MONTHS(fecha,n)).*/
update prueba
set hire_date = add_months(hire_date, 12);

--15. El empleado de la tabla employees 105 ha sido trasladado al departamento 100.
update employees
set department_id = 100
where employee_id = 105;

/*16. El empleado 107 de la tabla prueba cambia su nombre y salario por el nombre y salario del
empleado 100.*/
update prueba
set (name,salary)= (
    select first_name || ' ' || last_name as nombre, salary
    from employees
    where employee_id = 100
)
where id = 107;
----------------------------------------------------------------------------------------------------------------------
/*17. El empleado 107 ha cambiado al departamento de Daniel Faviet(109) y su salario ha
cambiado al salario m�ximo correspondiente a su puesto de trabajo. Ejecuta la sentencia
que modifique los datos.*/
update employees
set department_id =(
    select department_id 
    from employees
    where employee_id = 109
    )
    ,salary = (
        select max_salary
        from jobs
        where jobs.job_id = employees.job_id
    )
where employee_id = 107;
----------------------------------------------------------------------------------------------------------------------
/*18. Ejecuta la siguiente sentencia �Qu� respuesta da Oracle? �Por qu�?
insert into employees (employee_id, last_name, email, job_id)values
(800, 'Lopez', 'lopez@hotmail.com', 'SA_PAT')*/
--No podemos dejar campos nulos como el first_name
insert into employees (employee_id, last_name, email, job_id)
values (800, 'Lopez', 'lopez@hotmail.com', 'SA_PAT');

/*20. Ejecuta la siguiente orden �Qu� respuesta da Oracle?�Como es est� definida la columna
comisi�n_pct? Consulta la estructura de la tabla desde el explorador de objetos.
Update employees set commission_pct =300 where employee_id =100*/
--No podemos ya que comission_pct solo acepta hasta 2(00,00) cifras no 3(000,000)
Update employees 
set commission_pct =300 
where employee_id =100;
---------------------------------------------------------------------------------------------------------------------
/*21. Crea la tabla jobs2 con la siguiente sintaxis:
Comprueba su estructura mediante la orden Desc jobs2. Comprueba ahora qu� datos tiene
la tabla jobs2*/
Create table jobs2 as select * from jobs;
----------------------------------------------------------------------------------------------------------------------
--comprobar apartir de aqui 
/*22. Actualiza el salario m�nimo de la tabla jobs de modo que sea igual al salario m�ximo
multiplicado por 0.75 para todos aquellos puestos de trabajo cuyo nombre empieza por A*/
update jobs2
set min_salary = (
    select max_salary * 0.75
    from jobs2
    )
where job_id like 'A%';

--23. Borra la fila de la tabla job correspondiente trabajo Sales Manager.
delete from jobs2
where job_title = 'Sales Manager';

/*24. Borra los trabajos de la tabla jobs2 en los que el salario m�ximo sea  mayor que 1.7 veces el
salario m�nimo.*/
delete from jobs2
where max_salary > (
    select min_salary * 1.7
    from jobs2
);
--25. Crea la tabla pa�ses de forma que sea una copia de la tabla countries (ver ejercicio21).
create table paises as select * from countries;

/*26. Borra de la tabla regions el continente 3, region_id=3 �Qu� ocurre?�Por qu�? Borra todos
los datos de la tabla paises de dos formas distintas.*/  

--27. Borra todos los datos de la tabla paises de dos formas distintas.
delete from paises;--se puede  deshacer con un rollback;
truncate table paises; -- NO se puede deshacer con rollback ya que es DDL
--28. Confirma las operaciones*/
commit;