-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title, length, rank() over (order by length) as 'rank'
from film
 where length is not null and length > 0;
 
 -- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
 -- In your output, only select the columns title, length, rating and rank.
 
select title, length ,rating, rank() over (partition by rating order by length desc) as "Ranks"
from film
where length is not null and length > 0;
 
 -- 3. How many films are there for each of the categories in the category table? 
 -- Hint: Use appropriate join between the tables "category" and "film_category".
 
select c.category_id, c.name, count(fc.film_id) as film_count
from category c
join film_category as fc on c.category_id = fc.category_id
group by c.category_id, c.name
order by c.category_id;


-- 4. Which actor has appeared in the most films?
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select actor.actor_id, actor.first_name, actor.last_name, count(*) as film_count
from actor
join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id, actor.first_name, actor.last_name
order by film_count desc
limit 1;

-- same code 

select a.actor_id, a.first_name, a.last_name, count(*) as film_count
from actor a
join film_actor on a.actor_id = film_actor.actor_id
group by a.actor_id, a.first_name, a.last_name
order by film_count desc
limit 1;


-- 5. Which is the most active customer (the customer that has rented the most number of films)?
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select c.customer_id, c.first_name, c.last_name, count(rental.rental_id) as rental_count
from customer c
join rental on c.customer_id = rental.customer_id
group by c.customer_id, c.first_name, c.last_name
order by rental_count desc
limit 1;


-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

select f.film_id, f.title, count(rental.rental_id) as rental_count
from film f
join inventory on f.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by f.film_id, f.title
order by rental_count desc
limit 1;