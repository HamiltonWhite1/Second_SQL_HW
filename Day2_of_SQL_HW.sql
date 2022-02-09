-- List all customers who live in Texas (use JOINS) -Come back to this one to figure out Joins
select first_name, last_name, district 
from customer
join address on customer.address_id = address.address_id 
where district = 'Texas'

-- Get all payments above $6.99 with the Customer's full name
select first_name, last_name, amount
from payment, customer c 
where amount > 6.99

-- Show all customers names who have made payments over $175 (use subqueries)
select * 
from ( 
	select customer.customer_id, first_name, last_name, SUM(amount) as "Total Payments"
	from payment
	join customer on payment.customer_id = customer.customer_id 
	group by customer.customer_id
	) as aggregated_stuff
where "Total Payments" > 175 

-- List all customers that live in Nepal (use city table)
select first_name, last_name 
from customer 
join address on customer.address_id = address.address_id 
join city on address.city_id = city.city_id 
join country on country.country_id = city.country_id 
where country = 'Nepal'

-- Which staff member had the most transactions?
select count(staff_id)
from rental	
group by staff_id 

-- How many movies of each rating are there?
select rating, count(film_id) as "Number of Films in Category"
from film f 
group by rating 


-- Show all customers who made a single payment above 6.99.
select count(amount), payment.customer_id 
from payment 
where amount > 6.99
group by customer_id  --This solution takes every customer who has made payments above 6.99, even if it's only once. 

--OR--

select *
from (
	select first_name, last_name, payment.customer_id, amount  
	from payment
	join customer on payment.customer_id = customer.customer_id
	where payment.amount > 6.99
	group by payment.customer_id, customer.first_name, customer.last_name, payment.amount  
	) as "Stuff and Things"



-- How many free movies did our stores give away? 24 total, but grouped by customer ID to add a little flavor to the data table
select payment.customer_id as "Member #", count(amount) as "Free Movies"
from payment 
where amount < 0.99
group by customer_id 






