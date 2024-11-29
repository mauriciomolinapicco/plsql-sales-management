DECLARE
	v_nombre VARCHAR2(15);
	
BEGIN
	SELECT last_name INTO v_nombre
	FROM employee WHERE UPPER(first_name) = 'JOHN';
	DBMS_OUTPUT.PUT_LINE ('El Apellido de John es: ' ||v_nombre);
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('La consulta no arrojo resultados. No había empleados con ese nombre');
									
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE ('Existe mas de un empleado con ese nombre');
		
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE ('Ocurrió un error inesperado con la consulta');
END