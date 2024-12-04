1. Listar todos los nodos
match(n) return n

2. Contar el número de películas

match(m:Movie) return count(m)

3. Encontrar actores específicos: Keanu Reeves

match(n:Person {name:'Keanu Reeves'})-[:ACTED_IN]->(m:Movie) return n

4. Listar todas las relaciones del actor del punto 3

match(n:Person {name:'Keanu Reeves'})-[r]-(m) return r

5. Contar películas por año de lanzamiento:

match(n:Movie) with n.released as anio, count(n) as cantidad_pelis return anio, cantidad_pelis

6. Crear un nuevo nodo para un director

create(n:Person {name:'Mauricio', born:2003})

7. Crear una relación entre el actor del punto 3 y una película

match(n:Person {name:'Mauricio'}), (m:Movie {name:'The Matrix 2'}) create (n)-[:DIRECTED]->(m)

8. Actualizar el año de lanzamiento de la película The Polar Express (colocar 2005)

match(m:Movie {title: 'The Polar Express'}) set m.released = 2005

9. Eliminar la relación creada entre el actor y la película del punto 7

match(n:Person {name:'Mauricio'})-[r:DIRECTED]->(m:Movie {title:'The Matrix'})

10. Listar todas las películas y sus géneros

match(n:Movie) return n.title, n.genre

11. Encontrar actores que han trabajado con un director específico: Andy Wachowski

match(n:Person)-[]-(m:Movie), (:Person {name: 'Andy Wachowski'})-[:DIRECTED]->(m) return n

12. Crear un subgrafo de películas lanzadas en un año específico: 1999

match(n:Movie {released: 1999}) return n 

13. Encontrar las 5 películas más populares

match(n:Movie)<-[r:REVIEWED]-() with n.title as pelicula, count(r) as cant_reviews return pelicula, cant_reviews order by cant_reviews desc limit 5

14. Contar el número de películas por cada Director

match(n:Person)-[:DIRECTED]-(m:Movie) with n.name as director, count(m) as cant_pelis return director, cant_pelis

16. Crear una relación de amistad entre dos actores
match(n:Person {name:'Mauricio'}), (m:Person {name:'Tom Hanks'}) create (n)-[:IS_FRIEND]->(m)


17. Encontrar subgrafos de actores que han trabajado juntos
match(n:Person)-[:ACTED_IN]-(m:Movie), (n2:Person)-[:ACTED_IN]-(m) return n,n2


18. Crear un informe de actores, películas y géneros
match(n:Person)-[:ACTED_IN]-(m:Movie) with n.name as actor, collect(m.title) as peliculas return actor, peliculas

19. mostrar dos actores buscandolos por los nombres 
match(n:Person {name:'Mauricio'}) return n as actor union match(m:Person {name:'Keanu Reeves'}) return m as actor