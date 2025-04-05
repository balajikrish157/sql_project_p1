CREATE TABLE retail_sales (
    `transactions_id` INT PRIMARY KEY,
    `sale_date` DATE,
    `sale_time` TIME,
    `customer_id` INT,
    `gender` VARCHAR(10),
    `age` INT,
    `category` VARCHAR(50),
    `quantity` INT,
    `price_per_unit` DECIMAL(10,2),
    `cogs` DECIMAL(10,2),
    `total_sale` DECIMAL(10,2)
);

select * from retail_sales;

select count(*) from retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR 
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;

-- Data Exploration

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How many unique customers we have?
select count(distinct customer_id) as total_sale from retail_sales;

-- How many unique categories we have?
select distinct category from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- Q1. write a sql query to retrive all columns for sales made on '2022-11-05'

select *
from retail_sales
where sale_date = '2022-11-05';

/* Q2. write a sql query to retrive all transactions where the category is 'clothing' and 
the quantity sold is more than 3 in the month of Nov-2022 */

select *
from retail_sales	
where category = 'Clothing' and sale_date between '2022-11-01' and '2022-11-30'
and quantity > 3;

-- Q3. write a sql query to calculate  the total sales (total_sale) for each category

select category, sum(total_sale) as totalsales,
count(*) as total_orders	
from retail_sales
group by category;

-- Q4. write a sql query to find the average age of customers who purchased items from the 'Beauty' category

select category, round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty';

-- Q5. write a sql query to find all transactions where the total_sale is greater than 1000

select * from retail_sales
where total_sale > 1000;

-- Q6. write a sql query to find the total number of transactions (transaction_id) made by each gender in each category

select category, gender, count(transactions_id) as transactions
from retail_sales
group by category, gender
order by category;

-- Q7. write a sql query to calculate the average sale for each month. Find out best selling month in each year

select YEAR, MONTH, avg_revenue from
(
select YEAR(sale_date) as year, MONTH(sale_date) as month, avg(total_sale) as avg_revenue,
Rank() over(partition by YEAR(sale_date) order by avg(total_sale) desc) as ranks 
from retail_sales  
group by YEAR, MONTH
) as t1
where ranks = 1;

-- Q8. write a sql query to find the top 5 customers based on the highest total sale

select customer_id, sum(total_sale) as Highest_Sale 
from retail_sales
group by customer_id
order by Highest_Sale desc
limit 5;

-- Q9. write a sql query to find the number of unique customers who purchased items from each category

select category, count(distinct customer_id) as unique_customers 
from retail_sales
group by category;

SELECT DISTINCT customer_id, category
FROM retail_sales
ORDER BY customer_id, category;

-- Q10. write a sql query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) 

with hourly_sale
as
(
select *,
	case
		when hour(sale_time) < 12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	end as shift
from retail_sales
)
select shift, count(*) as total_orders
from hourly_sale	
group by shift; 

-- End of Project

