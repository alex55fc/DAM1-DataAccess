--1. Desarrollar un procedimiento que visualice el apellido del cliente y la fecha de
--pedido de todos los pedidos ordenados por apellido.
create or replace NONEDITIONABLE PROCEDURE Ejercicio1
is
CURSOR cur_cli is
    select c.apellidos, pd.fecha_pedido
        from clientes c join pedidos pd on(c.id_cliente = pd.id_cliente)
        order by c.apellidos;
            
v_cli cur_cli%rowtype;

begin
 open cur_cli;
    fetch cur_cli into v_cli;
    while cur_cli%found loop
        DBMS_OUTPUT.PUT_LINE('Nombre cliente: '|| v_cli.apellidos);
        DBMS_OUTPUT.PUT_LINE('Fecha pedido: '|| v_cli.fecha_pedido);
    fetch cur_cli into v_cli;
    end loop;
    close cur_cli;  
end;

execute Ejercicio1();

--2. Codificar un procedimiento que muestre la descripción de cada categoría y el
--número de productos que tiene.
create or replace NONEDITIONABLE PROCEDURE Ejercicio2
is
CURSOR cur_cat is
    select c.descripcion, count(pr.nombre) as cantidad
        from categorias c join productos pr on(c.id_categoria = pr.id_categoria)
        group by c.descripcion;
            
v_cat cur_cat%rowtype;

begin
 open cur_cat;
    fetch cur_cat into v_cat;
    while cur_cat%found loop
        DBMS_OUTPUT.PUT_LINE('La categoria: '|| v_cat.descripcion || ' tiene' || v_cat.cantidad || ' productos.');
    fetch cur_cat into v_cat;
    end loop;
    close cur_cat;  
end;

execute Ejercicio2();

--3. Escribir un procedimiento que reciba una cadena y visualice el apellido y el
--identificador de empleado de todos los empleados cuyo apellido contenga la cadena
--especificada. Al finalizar visualizar el número de empleados mostrados.
create or replace NONEDITIONABLE PROCEDURE Ejercicio3(cadena varchar)
is
CURSOR cur_cadena is
    select id_cliente, apellidos
        from clientes where apellidos like cadena;
            
v_cad cur_cadena%rowtype;
contador number := 0;

begin
 open cur_cadena;
    fetch cur_cadena into v_cad;
    while cur_cadena%found loop
        DBMS_OUTPUT.PUT_LINE(v_cad.id_cliente || ', ' || v_cad.apellidos);
        contador := contador + 1;
    fetch cur_cadena into v_cad;
    end loop;
    DBMS_OUTPUT.PUT_LINE('Se han consultado ' || contador || ' clientes.');
    close cur_cadena;  
end;

execute Ejercicio3('Viescas');
