CREATE DATABASE sql_project_p2;

DROP TABLE IF EXISTS reatil_sales;
CREATE TABLE retail_sales (
                        transactions_id INT PRIMARY KEY,
						sale_date DATE,	
						sale_time TIME,	
						customer_id	INT,
						gender VARCHAR(15),	
						age INT,
						category VARCHAR(15), 	
						quantiy INT,
						price_per_unit FLOAT,
						cogs FLOAT,	
						total_sale FLOAT,
						   );

INSERT INTO retail_sales
SELECT *
  FROM [sql_project_p1].[dbo].[SQL - Retail Sales Analysis_utf ];

select * from retail_sales


SELECT
     COUNT (*)
FROM retail_sales

--#DATA CLEANING--

SELECT * FROM retail_sales
WHERE transactions_id IS NULL

--#--

SELECT * FROM retail_sales
WHERE sale_date IS NULL

--#--

SELECT * FROM retail_sales
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

--#--

DELETE FROM retail_sales
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

--#DATA EXPPLORATION
--HOW MANY SAILS WE HAVE--

SELECT COUNT(*) as total_sale FROM retail_sales 

--HOW MANY UNIQUE CUSTOMER WE HAVE

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales 

--HOW MANY UNIQUE CATEGORY WE HAVE

SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales
SELECT DISTINCT category FROM retail_sales


--DATA ANALYSIS AND BUSINESS PROBLEMS--

--Write a SQL query to retrieve all columns for sales made on '2022-11-05--

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
    AND
	month(sale_date) = 11 and year(sale_date) = 2022 and  quantiy > 3

-- Write a SQL query to calculate the total sales (total sale) for each category.

SELECT 
      category,
	  SUM(total_sale) as net_sales
FROM retail_sales
GROUP BY category;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
      AVG(age)
	  FROM retail_sales
WHERE category = 'Beauty';
 
--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000. 

SELECT *
     FROM retail_sales
WHERE total_sale > 1000


--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
      category,
	  gender,
	  COUNT(*) as total_tranjection
FROM retail_sales
GROUP BY 
       category,
	   gender
ORDER BY category;


-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
      YEAR(sale_date) as year,
	  MONTH(sale_date) as month,
	  AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY 
    YEAR(sale_date),
    MONTH(sale_date)
ORDER BY
    YEAR(sale_date),
	AVG(total_sale)DESC;

-- Write a SQL query to find the top 5 customers based on the highest total sales

SELECT TOP 5
      customer_id,
	  SUM(total_sale) as max_sale
FROM  retail_sales
GROUP BY 
      customer_id
ORDER BY
      SUM(total_sale)DESC


-- Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
      category,
	  COUNT(DISTINCT customer_id)  as unq_customer
FROM retail_sales
GROUP BY category

-- Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening


WITH shift_wise
AS
(
SELECT *,
     CASE
	     WHEN DATEPART(HOUR, sale_time) <12 THEN 'Morning'
		 WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		 ELSE 'Evening'
		 END as shift
FROM retail_sales
)

SELECT 
     shift,
	 COUNT(transactions_id) as total_order
FROM shift_wise
GROUP BY shift

--Project Ends--
