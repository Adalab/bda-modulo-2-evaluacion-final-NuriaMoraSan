'''1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.'''
SELECT distinct(title)
FROM sakila.film;
'''2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".'''
SELECT distinct(title) AS PeliculasPG13
FROM sakila.film
WHERE rating ='PG-13';
'''3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
descripción.'''
SELECT title AS PeliculasBuenas
FROM sakila.film
WHERE description LIKE'%amazing%';
'''4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.'''
SELECT title AS PeliculasMas2horas
FROM sakila.film
WHERE length>120;
'''5. Recupera los nombres de todos los actores.'''
SELECT distinct(first_name) AS Nombre
FROM sakila.actor
order by first_name;
'''6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.'''
SELECT first_name AS Nombre, last_name AS Apellido
FROM sakila.actor
WHERE last_name ='Gibson';
'''7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.'''
SELECT first_name AS Nombre
FROM sakila.actor
WHERE actor_id BETWEEN 10 AND 20
ORDER BY first_name;
'''8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación.'''
SELECT title AS Peliculas_NO_RyPG13
FROM sakila.film
WHERE rating NOT IN('R','PG-13');
'''9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación
junto con el recuento.'''
SELECT rating AS Clasificacion, COUNT(*) AS Recuento
FROM sakila.film
GROUP BY rating
ORDER BY RECUENTO DESC;
'''10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.'''
SELECT t1.customer_id AS ID_Cliente, t1.first_name AS Nombre, t1.last_name AS Apellido, COUNT(t2.rental_id) AS PeliculasAlquiladas
FROM sakila.customer t1
INNER JOIN sakila.rental t2 
	ON t1.customer_id = t2.customer_id
INNER JOIN sakila.inventory t3 
	ON t2.inventory_id = t3.inventory_id
INNER JOIN sakila.film t4 
	ON t3.film_id = t4.film_id
GROUP BY t1.customer_id
ORDER BY PeliculasAlquiladas DESC;
'''11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres.'''
SELECT t1.name AS Categoria, COUNT(distinct(t5.rental_id)) AS RecuentoAlquileres
FROM sakila.category t1
INNER JOIN sakila.film_category t2 
	ON t1.category_id = t2.category_id
INNER JOIN sakila.film t3 
	ON t2.film_id = t3.film_id
INNER JOIN sakila.inventory t4 
	ON t3.film_id = t4.film_id
INNER JOIN sakila.rental t5 
	ON t4.inventory_id = t5.inventory_id
GROUP BY t1.name
ORDER BY RecuentoAlquileres DESC;
'''12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
clasificación junto con el promedio de duración.'''
SELECT rating AS Clasificacion, AVG(length) AS PromedioDuracion
FROM sakila.film
GROUP BY rating
ORDER BY PromedioDuracion DESC;
'''13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".'''
SELECT t1.first_name AS Nombre, t1.last_name AS Apellido
FROM sakila.actor t1
INNER JOIN sakila.film_actor t2 
	ON t1.actor_id = t2.actor_id
INNER JOIN sakila.film t3 
	ON t2.film_id = t3.film_id
WHERE t3.title like 'Indian Love'
ORDER BY t1.first_name;

'''14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.'''
SELECT title AS PeliculasMascotas
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

'''15. Encuentr a el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.'''
SELECT title AS Peliculas2005a2010
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

'''16. Encuentra el título de todas las películas que son de la misma categoría que "Family".'''
SELECT t1.title AS PeliculasFamiliares
FROM film t1
INNER JOIN film_category t2 
	ON t1.film_id = t2.film_id
INNER JOIN category t3 
	ON t2.category_id = t3.category_id
WHERE t3.name = 'Family';

'''17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla
film.'''
SELECT title AS Titulo_RyMas2horas
FROM film
WHERE rating = 'R' AND length > 120;

'''18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.'''
SELECT t1.first_name AS Nombre, t1.last_name AS Apellido
FROM sakila.actor t1
INNER JOIN sakila.film_actor t2 
	ON t1.actor_id = t2.actor_id
GROUP BY t1.actor_id
HAVING COUNT(distinct(t2.film_id)) > 10
ORDER BY t1.first_name;

'''19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.'''
SELECT t1.first_name AS Nombre, t1.last_name AS Apellido
FROM sakila.actor t1
LEFT JOIN sakila.film_actor t2 
	ON t1.actor_id = t2.actor_id
WHERE t2.film_id IS NULL;

'''20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración.'''
SELECT t1.name AS Categoria, AVG(t3.length) AS DuracionPromedioMin
FROM sakila.category t1
INNER JOIN sakila.film_category t2 
	ON t1.category_id = t2.category_id
INNER JOIN sakila.film t3 
	ON t2.film_id = t3.film_id
GROUP BY t1.category_id, t1.name
HAVING AVG(t3.length) > 120;

'''21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con
la cantidad de películas en las que han actuado.'''
SELECT t1.first_name AS Nombre, t1.last_name AS Apellido, COUNT(distinct(t2.film_id)) AS PeliculasActuado
FROM sakila.actor t1
INNER JOIN sakila.film_actor t2 
	ON t1.actor_id = t2.actor_id
GROUP BY t1.actor_id
HAVING COUNT(t2.film_id) >= 5
ORDER BY t1.first_name;

'''22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes.'''
SELECT distinct(t1.title) AS PeliculasAlquiladasMas5Dias
FROM sakila.film t1
INNER JOIN sakila.inventory t2 
	ON t1.film_id = t2.film_id
WHERE t2.inventory_id IN 
	(
    SELECT inventory_id
    FROM sakila.rental
    WHERE DATEDIFF(return_date, rental_date) > 5 # Devuelve la diferencia numérica entre una fecha de inicio y de finalización
	);

'''23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores.'''
SELECT first_name AS Nombre, last_name AS Apellido
FROM sakila.actor
WHERE actor_id NOT IN (
    SELECT t1.actor_id
    FROM sakila.film_actor t1
    INNER JOIN sakila.film t2 
		ON t1.film_id = t2.film_id
    INNER JOIN sakila.film_category t3 
		ON t2.film_id = t3.film_id
    INNER JOIN sakila.category t4 
		ON t3.category_id = t4.category_id
    WHERE t4.name = 'Horror'
)ORDER BY first_name;

'''24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
tabla film.'''
SELECT t1.title AS TituloComedias
FROM sakila.film t1
INNER JOIN sakila.film_category t2 
	ON t1.film_id = t2.film_id
INNER JOIN sakila.category t3 
	ON t2.category_id = t3.category_id
WHERE t3.name = 'Comedy'
  AND t1.length > 180;