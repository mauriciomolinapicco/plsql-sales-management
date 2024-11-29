-- Escribir un procedimiento que permita modificar la función de un empleado.
create or replace procedure proc_cambiar_funcion (p_funcion in job.function%type, p_emp_id in employee.employee_id%type) 
is
    v_job_id employee.job_id%type;
begin
    select job_id into v_job_id 
    from job 
    where UPPER(function) = UPPER(p_funcion);
    
    update employee set job_id = v_job_id where employee_id = p_emp_id;
    if sql%rowcount = 0 then
        dbms_output.put_line('No se encontro el trabajador con ese id');
    end if;
exception
    when no_data_found then
        dbms_output.put_line('no se encontro el job con esa funcion');
    when too_many_rows then
        dbms_output.put_line('Hay mas de un trabajo con esa funcion');
    when value_error then
        dbms_output.put_line('Error de tipos de valores incompatibles');
    when others then 
        dbms_output.put_line('Hubo un error: ' || sqlerrm);
end;