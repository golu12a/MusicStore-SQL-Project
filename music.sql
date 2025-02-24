use music;
select * from album2;

-- 1.Who is the senior most employee based on job title?
select * from employee
order by levels desc
limit 1;

-- 2.Which countries have the most invoices?
select billing_country, count(*) as c 
from invoice
group by billing_country
order by c desc;

-- 3.What are top 3 values of total invoice?
select total from invoice
order by total desc
limit 3;

-- 4.Which city has the best customers? 
-- We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals

select billing_city, sum(total) as sum_of_invoice 
from invoice
group by billing_city
order by sum_of_invoice desc
limit 1;

-- 5.Who is the best customer? 
-- The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money

select c.customer_id, c.first_name, c.last_name, sum(i.total) as total  
from customer c
join invoice i on c.customer_id = i.customer_id
group by c.customer_id
order by total desc
limit 1;

-- 6.Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A

select c.email, c.first_name, c.last_name
from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
where track_id in(
               select track_id from track t
               join genre g on t.genre_id = g.genre_id
               where g.name like "Rock"
)
order by c.email;

-- 7.Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands

select a.artist_id, a.name, count(a.artist_id) as no_of_songs
from track t
join album2 al on t.album_id = al.album_id
join artist a on al.artist_id = a.artist_id
join genre g on t.genre_id = g.genre_id
where g.name like "Rock"
group by a.artist_id
order by no_of_songs desc
limit 10;

-- 8.Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. 
-- Order by the song length with the longest songs listed first

select name, milliseconds
from track
where milliseconds > (
                select avg(milliseconds) as avg_length
                from track
)
order by milliseconds desc;