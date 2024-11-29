declare
    v_id number;
    v_nombre_cargo varchar2(100);
    cursor c_max_job_id is
        select max(job_id) as maximo from job;
begin 
    for i in c_max_job_id loop
        v_id := i.maximo + 1;
    end loop;
    
    v_nombre_cargo := :INGRESE_CARGO;
    insert into job values (v_id, UPPER(v_nombre_cargo));
end;