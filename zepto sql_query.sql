create database zepto;
use zepto;
rename table zepto_v2 to zepto_details;
select * from zepto_details;
alter table zepto_details
rename column ï»¿category to category;
alter table zepto_details
add column sku_id int auto_increment primary key first;

-- data exploration

-- count rows
select count(*)
from zepto_details;

-- sample data
select * from zepto_details
limit 10;

-- null values

select * from zepto_details
where name is null or
mrp is null or
discountPercent is null or
availableQuantity is null or
discountedSellingPrice is null or
weightInGms is null or
outOfStock is null or
quantity is null or 
category is null;

-- different product categories
select distinct category
from zepto_details
order by category;

-- product in stock vs out of stock
select outOfStock,count(sku_id)
from zepto_details
group by outOfStock;

-- product name present multiple times
select name,count(sku_id) as "number of SKUs"
from zepto_details
group by name
having count(sku_id)>1
order by count(sku_id) desc;

-- data cleaning
-- product with price = zero
select * from zepto_details
where mrp=0 or discountedSellingPrice=0;

delete from zepto_details
where sku_id=3670;

-- convert paise to rupees
update  zepto_details
set mrp=mrp/100.0, discountedSellingPrice=discountedSellingPrice/100.0;

select mrp,discountedSellingPrice from zepto_details;

-- find the top 10 best-value produts based on the discount percentage
select name,mrp,discountPercent
from zepto_details
order by discountPercent desc
limit 10;

-- what are the products with high mrp but out of stock
select name,mrp
from zepto_details
where outOfStock = True and mrp>300
order by mrp desc;

-- calculate estimated revnue for each category

select category , sum(discountedSellingprice*availableQuantity) as total_revenue
from zepto_details
group by category
order by total_revenue;

-- find all products where mrp is greater than 500 and discount is less then 10%

select name ,mrp,discountPercent
from zepto_details
where mrp>500 and discountPercent<10
order by mrp desc,discountPercent desc;

-- Identify the top 5 categoires offering the highest average discount percentage
select category,avg(discountPercent) as average_discount
from zepto_details
group by category
order by average_discount desc
limit 5;

-- find the price per gram for products above 100g and sort by best values

select distinct name ,weightInGms,discountedSellingPrice,discountedSellingPrice/weightInGms as price_per_gram
from zepto_details
where weightInGms>=100
order by price_per_gram; 

-- group theproducts into categories like low ,medium,bulk

select distinct name,weightInGms,
case 
when weightInGms>1000 then 'low'
when weightInGms<5000 then 'medium'
else 'bulk'
end as weight_category
from zepto_details;

-- what is the total inventory weight per category
select category,sum(weightInGms* availableQuantity) as total_weight
from zepto_details
group by category
order by total_weight;
