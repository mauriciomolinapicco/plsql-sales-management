-- Escribir una función que recibe como parámetro un nombre de una función (function) y retorna su ID (job_id) 
-- o cancela con excepciones propias indicando el error en el mensaje del error.
-- Contemplar todo error posible.
-- select * from job
create or replace function f_get_job_id (p_name in job.function%type)
return job.job_id%type
is
    v_id job.job_id%type;
begin
    select job_id into v_id from job
    where function = p_name;
    return v_id;
exception
    when no_data_found then
        dbms_output.put_line('No se encontro el job');
    when too_many_rows then
        dbms_output.put_line('Se encontro mas de un job con esa funcion');
    when others then
        dbms_output.put_line('Ocurrio un error');
end;