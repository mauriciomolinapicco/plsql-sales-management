create (n:Estudiante {nombre:'mauricio', apellido:'molina', edad:21, dni:11111, nacionalidad:'Argentina'})

create (n:Materia {codigo:1, descripcion:'Fisica', cursa:'Lunes', modalidad:'online'})

match(n:Materia {descripcion:'Fisica'}), (m:Estudiante {nombre:'mauricio'}) create (m)-[:CURSA]->(n)

match (n:Profesor {nombre:'Carlos'}), (m:Estudiante {nombre:'mauricio'}) create (n)-[:ES_TUTOR]->(m)

match (n:Profesor {nombre:'Carlos'})-[r]-(m:Estudiante {nombre:'mauricio'}) delete r
