-- Construir un paquete que permita dar de baja un empleado.
-- Validar posibles errores y catchearlos con excepciones.
-- Mostrar cartel con éxito o error del intento de borrado de ese empleado.
-- Validar resultado DML usando cursor implícito.
create or replace package baja_empleado as
procedure delete_empleado (id_emp in employee.employee_id%type);
end;

create or replace package body baja_empleado as
    procedure delete_empleado (id_emp in employee.employee_id%type) 
    is
    begin
        delete from employee where employee_id = id_emp;
        if sql%rowcount = 0 then
            dbms_output.put_line('no se encontro el empleado');
        else
            dbms_output.put_line('se elimino correctamente');
        end if;
    exception 
        when others then
            dbms_output.put_line('hubo un error inesperado'); 
    end;
end;