-- Construir un paquete PA_EMPLEADOS que contenga los siguientes objetos y resuelva las siguientes consignas:
-- Una función que recibe como parámetros el nombre y apellido de un empleado y retorna su id. Contemplar todas las excepciones posibles
-- Un procedure que recibe el id de un empleado y a continuación incrementa su salario en un 10%. Contemplar todas las excepciones posibles. 
-- Mostrar un cartel con el nuevo salario del empleado
-- Un procedure que recibe el id de un departamento y recorre con un cursor cada empleado de dicho departamento, incrementando su salario en un 10% (utilizar el procedure del punto b). 
-- Si el departamento no tiene empleados, el procedure debe cancelar con un error que indique “El departamento no tiene empleados”.
-- Mostrar un cartel que indique cuántos empleados tenía el departamento.
-- Una función que recibe el id de un departamento y retorna el promedio de sueldos de dicho departamento.
create or replace package PA_EMPLEADOS is
    function get_emp_id (nombre in employee.first_name%type, apellido in employee.last_name%type) return employee.employee_id%type;
    
    procedure aumentar_salario (emp_id in employee.employee_id%type);
    
    procedure aumentar_salario_depto (dep_id in employee.department_id%type);

    function avg_salary_dep (dep_id in employee.department_id%type) return employee.salary%type;
end;

create or replace package body PA_EMPLEADOS is
    function get_emp_id (nombre in employee.first_name%type, apellido in employee.last_name%type) 
    return employee.employee_id%type
    is 
        v_id employee.employee_id%type;
    begin
        select employee_id into v_id from employee where first_name = nombre and last_name = apellido;
        return v_id;
    exception
        when no_data_found then
            raise_application_error(-20001, 'No se encontro el empleado');
        when too_many_rows then
            raise_application_error(-20002, 'Se encontro mas de un empleado');
        when others then
            raise_application_error(-20007, 'Hubo un error inesperado');
    end;

    procedure aumentar_salario (emp_id in employee.employee_id%type) 
    is
        v_new_salary employee.salary%type;
    begin
        update employee set salary = salary * 1.1 where employee_id = emp_id;
        if sql%rowcount = 0 then
            raise_application_error(-20004, 'No se encontro ningun empleado con el id ingresado');
        else
            select salary into v_new_salary from employee where employee_id = emp_id;
            dbms_output.put_line('El nuevo salario del empleado es: ' || v_new_salary);
        end if;
    exception
        when no_data_found then
            raise_application_error(-20005, 'No se encontro ningun empleado con el id');
        when value_error then
            raise_application_error(-20006, 'Error en el tipo de datos');
        when others then
            raise_application_error(-20007, 'Hubo un error inesperado');

    end aumentar_salario;


    procedure aumentar_salario_depto (dep_id in employee.department_id%type) 
    is
        emp_count number;
        cursor c_empleados_dep (dep_id in employee.department_id%type) is

            select employee_id from employee where department_id = dep_id;
    begin
        emp_count := 0;
        for i in c_empleados_dep(dep_id) loop
            aumentar_salario(i.employee_id);
            emp_count := emp_count + 1;
        end loop;
        if emp_count = 0 then
            raise_application_error(-20008, 'El departamento no tiene empleados');
        else
            dbms_output.put_line('Se actualizo el salario de ' || emp_count || ' empleados');
        end if;
    exception
        when others then
            raise_application_error(-20007, 'Hubo un error inesperado');
    end aumentar_salario_depto;


    function avg_salary_dep (dep_id in employee.department_id%type) 
    return employee.salary%type
    is 
        v_avg_sal employee.salary%type;
    begin
        select avg(salary) into v_avg_sal from employee where department_id = dep_id;
        return v_avg_sal;
    exception
        when others then
            raise_application_error(-20007, 'Hubo un error inesperado');
    end avg_salary_dep; 

end;