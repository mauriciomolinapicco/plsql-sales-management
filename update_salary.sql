declare 
    v_numero_empleado number;
    v_sueldo number;
    cursor c_sueldo (emp_id number) is
        select salary from employee 
        where employee_id = emp_id;

begin 
    v_numero_empleado := :INGRESE_NRO_EMPLEADO;
    for i in c_sueldo(v_numero_empleado) loop
        if i.salary < 1300 then
            update employee 
                set salary = salary * 1.1
                where employee_id = v_numero_empleado;
        end if;
        
    end loop;
end;