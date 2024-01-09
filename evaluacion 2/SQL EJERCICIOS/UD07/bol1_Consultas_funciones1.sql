--conexion UD06_EMPLOYEES
/*42) Selecciona los datos de los empleados que trabajan en el departamento 80, pero la
columna de la comisión tiene que aparecer redondeado a un decimal.*/
select first_name || ' ' || last_name as nombre_completo ,round(COMMISSION_PCT,1)
from employees
where department_id = 80;

--43) Crea una consulta que calcule la raíz cuadrada de 49.
select sqrt(49) from dual;

--44) Crea una consulta que calcule la raíz cuadrada de 36 y le sume el valor absoluto de (-9).
select sqrt(36) + abs(-9) from dual;

/*45) Muestra el título de los trabajos de los empleados del departamento de “Accounting”
pero debe aparecer totalmente en mayúsculas.*/
select upper(job_title)
from jobs 
where job_id in (
    select job_id 
    from employees
    where department_id in (
        select department_id 
        from departments 
        where department_name like 'Accounting'
        )
    );
    
/*46) Ahora muestra el nombre y apellidos de todos los empleados en una sola columna,
ordenados primero por apellido y luego por nombre y que aparezca todo en minúsculas.*/
select lower(first_name) || ' ' || lower(last_name)
from employees
order by last_name, first_name;

/*47) Obtén los datos de los empleados cuyo nombre tenga una longitud mayor de 5
caracteres.*/
select *
from employees
where length(first_name) > 5;

/*48) Obtén los datos de los empleados cuyo jefe trabaje en un departamento que tenga
un nombre de más o igual de 10 caracteres.*/
select * 
from employees 
where manager_id in (
    select manager_id
    from departments
    where length(department_name) >= 10
);
/*49) Muestra todos los empleados cuyo nombre empieza por A, pero debes sustituir la
primera letra b que aparezca en esos nombres por v en todos.*/
select replace(first_name, 'z', 'm')
from employees 
where first_name like 'A%';

