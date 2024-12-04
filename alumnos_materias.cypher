create (n:Estudiante {nombre:'mauricio', apellido:'molina', edad:21, dni:11111, nacionalidad:'Argentina'})

create (n:Materia {codigo:1, descripcion:'Fisica', cursa:'Lunes', modalidad:'online'})

match(n:Materia {descripcion:'Fisica'}), (m:Estudiante {nombre:'mauricio'}) create (m)-[:CURSA]->(n)

match (n:Profesor {nombre:'Carlos'}), (m:Estudiante {nombre:'mauricio'}) create (n)-[:ES_TUTOR]->(m)

match (n:Profesor {nombre:'Carlos'})-[r]-(m:Estudiante {nombre:'mauricio'}) delete r

2.- Ejecutar una consulta que devuelva todas las materias cuya modalidad sea “Virtual”
match (n:Materia {modalidad:'Virtual'}) return n

3.- Que hace la siguiente operación: 
MATCH (s:Estudiante)-[:CURSA]->(m:Materia)
RETURN s.Apellido, m.Modalidad
    Respuesta: devuelve el apellido y la modalidad de todos los alumnos que cursan alguna materia

Ejecutar una consulta que devuelva todos los Profesores que tengan mas de 10 años de antiguedad
match(n:Profesor) where n.antiguedad > 10 return n