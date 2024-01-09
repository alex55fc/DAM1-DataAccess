--conexion UD06_EMPLOYEES
/*Subconsultas SIMPLES:
El operador puede ser >, <,>=, <=, !=, = o IN.
Cuando se usan operadores de comparación la subconsulta tiene que devolver un único valor : >, <,>=, <=, !=, = */
/*Subconsultas MULTIPLES
El operador logico especial puede ser ANY, ALL, IN, NOT IN puede devolver multiples filas*/
--ej1
--porque sirve el = si devuelve dos valores
--el in serviria igual?
--puedo relacionarlo tambn con el manager_Id pero me da solo1 resultado
select * from employees where DEPARTMENT_ID = 
    (select DEPARTMENT_ID from departments where department_name like 'Marketing');

--ej2
select * from employees where salary < 
    (select avg(salary) from employees); 

--ej3
-- no entiendo esta subconsulta
select * from countries where region_id = 
    (select region_id from countries where country_name like 'Argentina');
    
--ej4
select * from employees where salary <(
    select avg(salary) from employees where job_id = 'SA_MAN') ;
    
--ej5 
select * from employees where job_id in (
    select job_id from employees where(FIRST_NAME like 'David' and LAST_NAME like 'Austin') );

--ej11
select * from employees where department_id not in (
    select department_id from departments where department_name in ('Marketing','Sales'));
    
--ej12
select * from employees where department_id in (
    select department_id from departments where department_name in ('Marketing','Sales'));
    
--ej13
select country_name from countries where region_id in(
    select region_id from regions where region_name in ('Asia','Europe'));
    
--ej14
select * from employees where first_name like 'H%' and salary > any (
    select salary from employees where department_id = 100);
    
--ej15 
--no entiendo esta subconsulta
select FIRST_NAME, LAST_NAME from employees where employee_id in (
    select manager_id from employees where (FIRST_NAME like 'David' and LAST_NAME like 'Austin') );

--ej16
select * from employees where department_id in (
    select department_id from departments where location_id in (
        select location_id from locations where country_id in(
            select country_id from countries where country_name like 'United States of America' )));

--ej17
select * from employees where job_id in(
    select job_id from jobs where jobs.min_salary = employees.salary);
    
--ej18
--no entiendo esta subconsulta
select * from departments where department_name like 'R%' and department_id not in(
    select department_id from employees where department_id = null );
--otra forma
select * from departments where department_name like 'R%' and department_id  not in(
    select department_id from employees where department_id = departments.department_id);
    
--ej19
--cual es la diferencia entre poner and department_id = departments.department_id y no ponerlo
select * from departments where department_id in(
    select department_id from employees where first_name like 'A%'and department_id = departments.department_id);
    
--ej20
--es necesario poner and department_id = departments.department_id ??
select *
from departments 
where department_id in(
    select department_id 
    from job_history
    where end_date between '01/01/98' and '31/12/98' and department_id = departments.department_id
);