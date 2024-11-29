-- Crear un procedimiento para dar de alta un departamento, teniendo en cuenta que el mismo recibe por parámetros el nombre y el id de 
-- localidad y devuelve por parámetro en id del nuevo departamento creado.
-- Contemplar todos los errores posibles y nunca cancelar (es decir, validar las excepciones y mostrar mensajes de error llegado el caso, 
-- pero no utilizar raise exception error en este caso). 
-- *Para generar el nuevo id, se le suma 1 al máximo existente en la tabla.
-- select * from department

create or replace procedure alta_depto 
(p_name in department.name%type, p_location in department.location_id%type, p_new_id out department.DEPARTMENT_ID%type)
is
    -- v_id department.DEPARTMENT_ID%type;
    cursor c_max_id is
        select max(department_id)+1 as id from department;
begin
    for i in c_max_id loop
        p_new_id := i.id;
    end loop;
    insert into department values 
        (p_new_id, p_name, p_location);
exception
    when dup_val_on_index then
        dbms_output.put_line('La clave ya existia');
    when others then
        dbms_output.put_line('Ha ocurrido un error inesperado');
        dbms_output.put_line(SQLERRM);
end;