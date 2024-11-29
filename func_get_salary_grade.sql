-- Construir una función que recibe un salario y devuelve el valor del id de la escala de salarios.
-- Construir un bloque anónimo que liste todos los empleados que pertenecen a esa escala de salarios 
-- (utilizando la función creada en este punto)
-- select * from salary_grade
declare 
    grade number;
    lower number;
    upper number;
    cursor c_emp (lower in number, upper in number) is
        select * from employee
            where salary between lower and upper;
begin
    grade := f_escala_salario(-2000);
    if grade is not null then
        select lower_bound, upper_bound into lower, upper
        from salary_grade where grade_id = grade;

        dbms_output.put_line('Empleados en la escala ' || grade);
        for i in c_emp(lower, upper) loop
            dbms_output.put_line('Nombre: ' || i.first_name);
        end loop;
    else 
        dbms_output.put_line('no se encontro rango salarial');
    end if;
exception
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('La consulta devolvió más de una fila.');
    when others then
        DBMS_OUTPUT.PUT_LINE('ocurrio un error');
end;


create or replace function f_escala_salario (p_salary in employee.salary%type)
return salary_grade.grade_id%type
is
    grade number;
begin
    select grade_id into grade
    from salary_grade 
    where p_salary between lower_bound and upper_bound;
    return grade;
exception
    when no_data_found then
        dbms_output.put_line('No se encontro el grade');
        return null;
    when others then 
        dbms_output.put_line('Ocurrio un error');
        return null;
end;