
create table zepto(
sku_id serial primary key,
category varchar(120),
name varchar (150)not null,
mrp numeric (8,2),
discountpercent numeric(5,2),
availableQuantity integer,
discountedsellingprice numeric(8,2),
weightgms integer,
outofstock boolean,
quantity integer
);		
TRUNCATE TABLE public.zepto RESTART IDENTITY;

select * from zepto;

-- data exploration
select * from zepto
limit 10;

--null values
select* from zepto 
where name is null
or
category is null
or
mrp is null
or
discountpercent  is null
or
availableQuantity is null
or
weightgms is null
or
outofstock is null
or
quantity is null

-- different product caetegory

select distinct category
from zepto
order by category;

-- product in stock vs out of stock

select outofstock, count(sku_id)
from zepto
group by outofstock


-- product names present multiple time
select name,count(sku_id) as "number of skus"
from zepto
group by name 
having count(sku_id)>1
order by count (sku_id)desc


--data cleaning
--product with price =0
select *from zepto
where mrp=0 or discountedsellingprice =0;


delete from zepto where mrp =0



--convert paise to rupeees
 update zepto
 set mrp =mrp/100.0,
 discountedsellingprice = discountedsellingprice/100.0;


select mrp,discountedsellingprice from zepto;

--Q1. Find the top 10 best-value products based on the discount percentage.
select distinct name,mrp, discountpercent
from zepto
order by discountpercent desc
limit 10


--02,What are the Products with High MRP but Out of Stock

select distinct name,mrp from zepto
where outofstock is true and mrp >300
order by mrp desc
--03.Calculate Estimated Revenue for each category
SELECT CATEGORY,
sum(discountedsellingprice * availableQuantity) as total_revenue
from zepto
group by category
order by total_revenue



-- Q4. Find all products where MRP is greater than ,500 and discount is less than 10%.
select distinct name,mrp,discountpercent
from zepto
where mrp> 500 and discountpercent<10
order by mrp desc, discountpercent desc

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category,
round(avg(discountpercent),2)as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5
-- Q6, Find the price per gram for products above 100g and sort by best value. */
select distinct name,weightgms,discountedsellingprice,
round(discountedsellingprice/weightgms,2) as price_per_gram
from zepto where weightgms>=100
order by price_per_gram;



select top 10 discountpercent
from zepto




