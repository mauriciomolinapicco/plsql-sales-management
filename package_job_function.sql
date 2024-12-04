-- Crear un paquete PA_Trabajos que contenga lo siguiente:
-- 1)Procedimiento que permita modificar la tarea de un empleado.
-- ·Se recibe por parámetro:
-- oId del empleado
-- oId o Nombre de la nueva tarea
-- ·En caso de recibir el nombre de la tarea, utilizar la función del punto 2
-- ·Informar que se modificó correctamente
-- ·Si no pudo realizar la tarea, indicar el motivo correcto. No Cancelar
-- 2)Función privada que valide la existencia de un job, la cual recibe el nombre de la tarea y devuelve el id correspondiente o cancela.


-- 3)Procedimiento listar que muestre los empleados por función.
-- Recibirá por parámetro Id o nombre de la función o no recibirá parámetro alguno.
-- ·En caso de no recibir parámetro mostrar todas las funciones y los empleados
-- ·Ordenar por nombre de función y apellido del empleado
-- ·Mostrar de la siguiente manera:
-- Tarea: 999 - VENDEDOR
--      Nombre          Apellido
--      AAAAA           Aaaaa
--      BBBBB          Bbbbb
-- Cantidad de empleados: 99 
create or replace PA_TRABAJOS body is
    function get_job_id (p_function in job.function%type)
    return job.job_id%type
    is
        v_job_id job.function%type;
    begin
        select job_id into v_job_id from job where function = p_function;
        return v_job_id;
    exception
        when no_data_found then
            raise_application_error(-20001, 'No se encontro trabajo con esa funcion');
        when too_many_rows then
            raise_application_error(-20002, 'Hay mas de un trabajo con esa funcion');
        when others then
            raise_application_error(-20003, 'Ocurrio un error insesperado');
    end;


    procedure modificar_tarea (emp_id in employee.employee_id%type, tarea in job.function%type) 
    is
        e_not_found exception;
        pragma exception_init(e_not_found, -20001);
        e_demasiadas_filas exception;
        pragma exception_init(e_demasiadas_filas, -20002);
        e_error exception;
        pragma exception_init(e_error, -20003);

        v_job_id job.job_id%type;
    begin
        v_job_id := get_job_id(tarea);
        update employee set job_id = v_job_id where employee = emp_id;
    exception 
        when e_not_found then
            dbms_output.put_line('No se encontro la funcion con ese nombre');
        when e_demasiadas_filas then 
            dbms_output.put_line('mas de un trabajo con esa funcion');
        when e_error then
            dbms_output.put_line('Error en la funcion');
        when others then
            dbms_output.put_line('Hubo un error');
    end;

    procedure empleados_por_funcion (p_job_id in job.job_id%type) 
    is
        cursor get_employees(p_job_id in employee.job_id%type) is
            select e.first_name as nombre, j.function as funcion
                from employee e inner join job j on e.job_id = j.job_id
                where job_id = p_job_id;
    begin

        for i in get_employees(p_job_id) loop
        
            dbms_output.put_line('Nombre: ' || i.nombre || ' Tarea: ' || i.funcion);
        end loop;
    end;


    procedure empleados_por_funcion (job_function in job.function%type)
    is
        v_id job.job_id%type;
    begin
        v_id := get_job_id(job_function);
        empleados_por_funcion(v_id);
    end;

end;
--FALTA COMPLETAR
