declare 
    cursor c_cursor_emp is
        select * from EMPLOYEE where 
        department_id = 30;
begin 
    for e in c_cursor_emp loop
        dbms_output.put_line('Nombre: ' || e.first_name || ' ' || e.last_name);
        dbms_output.put_line('Salario: ' || e.salary);
    end loop;
    
end;