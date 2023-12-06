/* 1.Count the number of characters except for the spaces for each actor.Returns the first 10 actors name length along with their names.*/

select concat(first_name,' ',last_name) as full_name ,
length(trim(concat(first_name,'',last_name))) as name_length
from actor
order by name_length asc
limit 10;


/* 2.List all actor awardees ( actors who received the Oscar award) with their full names and the length oftheir names.*/

select concat(first_name,' ',last_name) as full_name, length(concat(first_name,last_name)) as name_length,awards
from actor_award
where awards like '%oscar%';


/* 3.Find the actors who have acted in the film 'Frost Head'.*/

select a.first_name,a.last_name,f.title
from actor a
join film_actor fa 
on a.actor_id=fa.actor_id 
join film f 
on f.film_id=fa.film_id
where f.title='Frost Head';


/* 4.Pull all the films acted by the actor 'Will Willson'.*/

select f.title,a.first_name,a.last_name 
from actor a
join film_actor fa
on a.actor_id=fa.actor_id
join film f
on fa.film_id=f.film_id 
where a.first_name= 'Will' and a.last_name= 'Wilson';


/* 5.Pull all the films which were rented and return then in the month of May.*/

select f.title,r.return_date,r.rental_date
from film f 
join inventory i
on f.film_id=i.film_id 
join rental r 
on r.inventory_id=i.inventory_id 
where r.return_date like '%-05-%';


/* 6.Pull all the films with 'Comedy' category.*/

select f.title,ca.name
from film f 
join film_category fc 
on f.film_id=fc.film_id 
join category ca 
on ca.category_id=fc.category_id 
where ca.name = 'comedy';

