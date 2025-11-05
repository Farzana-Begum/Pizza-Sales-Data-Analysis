use [Pizza DB]

select * from pizza_sales

#1 Total Revenue:

select sum(total_price) As Total_Revenue from pizza_sales

#2 Average Order Value:

select sum(total_price) / count(Distinct order_id) as Avg_order_value from pizza_sales

#3 Total Pizzas Sold:

select sum(quantity) as Total_pizza_sold  from pizza_sales

#4 Total Orders:


select count(Distinct order_id) as Total_orders  from pizza_sales

#5 Average Pizzas Per Order:

select CAST(CAST(sum(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT  order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_pizzas_per_order from pizza_sales


#Daily trend for total orders:

select DATENAME(DW, order_date) as order_day, COUNT(Distinct order_id) AS Total_orders
from pizza_sales
group by DATENAME(DW, order_date)


#Hourly trend for orders:

select DATEPART(Hour, order_time) AS order_hours, COUNT(Distinct order_id) AS Total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)

# % of Sales by Pizza Category:

SELECT pizza_category, sum(total_price) as total_sales, sum(total_price) *100 / 
(select sum(total_price) from pizza_sales where MONTH(order_date) = 1) AS PCT
from pizza_sales
where MONTH(order_date) = 1
group by pizza_category


# % of Sales by Pizza Size:

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter, order_date)=1)
AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(quarter, order_date)=1
GROUP BY pizza_size
order by PCT DESC


# Total Pizzas Sold by Pizza Category:

SELECT pizza_category,sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_category

# Top 5 Best Sellers by Total Pizzas Sold:
SELECT TOP 5 pizza_name,sum(quantity) as Total_pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) DESC