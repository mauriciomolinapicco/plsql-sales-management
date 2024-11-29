declare 
    cursor c_cursor_emp(dep_id number) is
        select * from EMPLOYEE where 
        department_id = dep_id;
begin 
    for e in c_cursor_emp(30) loop
        dbms_output.put_line('Nombre: ' || e.first_name || ' ' || e.last_name);
        dbms_output.put_line('Salario: ' || e.salary);
    end loop;
end;