--conexion UD06_EMPLOYEES
--ej15 sale 103
/*1.- Seleccionar los departamentos y la ciudad en la que están situados.*/
select d.department_name, l.city
from departments d join locations l on (d.location_id = l.location_id);

/*2.- Seleccionar todos los empleados con su nombre de departamento.*/
select e.first_name || ' ' || e.last_name as Fullname, d.department_name
from employees e join departments d on (e.manager_id = d.manager_id);

/*3.- Obtener los distintos departamentos de la tabla empleados.*/
select distinct d.department_name
from employees e join departments d on (e.manager_id = d.manager_id);

/*4.- Seleccionar el identificador, apellido y oficio (nombre de oficio) de los empleados que
Pertenezcan al departamento 80.*/
select e.employee_id, e.first_name || ' ' || e.last_name as Fullname , j.job_title
from employees e join jobs j on (e.job_id = j.job_id)
where e.department_id = 80;

/*5.- Obtener el apellido y el oficio de los empleados cuyo oficio no sea Jefe de ventas, Sales
Manager.*/
select e.last_name, j.job_title
from employees e join jobs j on (e.job_id = j.job_id)
where j.job_title not in 'Sales Manager';

/*6.- Selecciona los departamentos, ciudad y país donde están ubicados.*/
select d.department_name, l.city, c.country_name
from departments d join locations l on (d.location_id = l.location_id)
join countries c on (l.country_id = c.country_id);

/*7.- Selecciona el apellido, nombre de oficio y nombre de departamento de todos los empleados
cuyo apellido comienza por a y tiene más de 6 letras.*/
select e.last_name, j.job_title, d.department_name
from employees e join jobs j on (e.job_id = j.job_id)
join departments d on (e.department_id = d.department_id)
where e.last_name like 'A_____%';

/*8.- Selecciona el apellido de los empleados que tengan el mismo oficio que su jefe.*/
select e1.last_name, e2.job_id as puesto_jefe
from employees e1 join employees e2 on (e1.employee_id = e2.manager_id)
where e1.job_id = e2.job_id;
--en el on compara que el empleado tenga el mismo ID que el manager para asi comparar los job_id sean el mismo puesto de trabajo 

/*9.- Obtener el apellido de los empleados junto con el apellido de su correspondiente jefe
ordenado por el apellido del director.*/
select e1.last_name as apellido_empleado, e2.last_name as apellido_jefe
from employees e1 join employees e2 on (e1.manager_id = e2.employee_id)
order by e2.last_name asc;
-- no entiendo esta consulta
