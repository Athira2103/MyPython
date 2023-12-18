 select upper(concat(first_name,' ',last_name)) as 'Actor_name' from actor order by first_name;
 
 
select concat(first_name,' ',last_name) as 'Actor_name'
from actor
where last_name like '%Gen%';


select country_id, country
from country 
where country in ('Afghanistan', 'Bangladesh','China');

select last_name, count(last_name) 
from actor group by last_name;

select last_name, count(last_name) as 'CNT' 
from actor  group by last_name having CNT > 2;


update actor set first_name = 'HARPO' 
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

select first_name, last_name
from actor
where first_name = 'HARPO' and last_name = 'WILLIAMS';



select s.first_name, s.last_name ,a.address as 'Staff details'
from
staff as s
join
address a
on s.address_id = a.address_id;


select f.title, count(fct.actor_id) as 'No of Actors'
from film as f inner join film_actor as fct on f.film_id = fct.film_id group by f.title;

select f.title, count(inv.film_id) as 'No.of books available'
from film as f inner join inventory as inv
on f.film_id = inv.film_id group by f.title having f.title = 'Hunchback Impossible';



select c.first_name, c.last_name, sum(p.amount)
from customer as c join payment as p
on c.customer_id = p.customer_id
group by  c.first_name,c.last_name
order by c.last_name;


select f.title from film as f 
where f.language_id in
(select lng.language_id from language lng where name = 'English')
and f.title rlike '^[K,Q]';




select a.first_name,a.last_name from actor as a where a.actor_id in
(select fm.actor_id  from film_actor as fm where fm.film_id in 
(select f.film_id from film as f where f.title='Alone Trip'));



select cx.email,cx.first_name,cx.last_name from customer as cx inner join address as ad on ad.address_id=cx.customer_id
inner join city on ad.city_id = city.city_id inner join country on city.country_id = country.country_id
where country.country = 'Canada';


select f.title from film as f join film_category as fcat on f.film_id=fcat.film_id 
inner join category on category.category_id=fcat.category_id where name='Family'; 


delimiter $$
 
CREATE PROCEDURE pr_filmcnt(IN cat_name VARCHAR(255), OUT cnt INT)
BEGIN
    SELECT COUNT(*) INTO cnt FROM film_category as fc
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = cat_name;
END $$
delimiter ;
call pr_filmcnt('Family',@cnt);
select @cnt;


SELECT title, COUNT(rental_id) as 'mostrentedcount'
FROM rental 
JOIN inventory
ON (rental.inventory_id = inventory.inventory_id)
JOIN film 
ON (inventory.film_id = film.film_id)
GROUP BY film.title
ORDER BY COUNT(rental_id) DESC;

SELECT 
    s.store_id, c.city, cn.country
FROM
    store AS s
        INNER JOIN
    address AS ad ON s.address_id = ad.address_id
        JOIN
    city AS c
on
    c.city_id=ad.city_id
    inner join country cn on cn.country_id=c.country_id;
    
    
    
    
    
    
select ctg.name,sum(p.amount) as 'Gross Revenue' from category ctg inner join film_category fc on ctg.category_id = fc.category_id
inner join inventory i on fc.film_id = i.film_id inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id group by ctg.name order by sum(p.amount) desc limit 5; 
    
    
    
create view top5 as
select ctg.name,sum(p.amount) as 'Gross Revenue' from category ctg inner join film_category fc on ctg.category_id = fc.category_id
inner join inventory i on fc.film_id = i.film_id inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id group by ctg.name order by sum(p.amount) desc limit 5; 
    
select * from top5
    
    
    