CREATE DATABASE pizza_project ;

USE pizza_project ;

select * from order_details

select * from orders

select * from pizza_types

select * from pizzas

----------Retrieve the total number of orders placed. 
select count(order_id) from orders

----------Calculate the total revenue generated from pizza sales
select Round(sum(o.quantity*p.price),2) as total_revenue
from order_details as o
inner join pizzas as p
on o.pizza_id=p.pizza_id

----------Identify the highest-priced pizza
select pizza_type_id ,price as Highest_price from pizzas order by price desc limit 1

---------Identify the most common pizza size ordered.
select size, count(size) from pizzas group by size 

------------List the top 5 most ordered pizza types along with their quantities. 

select p.pizza_type_id , sum(o.quantity) as total_qty from order_details as o
join pizzas as p
on o.pizza_id=p.pizza_id
group by p.pizza_type_id
order by total_qty desc limit 5

------------Join the necessary tables to find the total quantity of each pizza category ordered. 

select pt.category , count(o.quantity) as total_qty from pizza_types as pt
join pizzas as p
on p.pizza_type_id=pt.pizza_type_id
join order_details as o
on o.pizza_id = p.pizza_id
group by category

---------------Determine the distribution of orders by hour of the day. 
select count(*) as order_count, Hour(time) as order_hour 
from orders
group by order_hour
order by order_hour

--------------Join relevant tables to find the category-wise distribution of pizzas. 
select pt.category,count(pizza_id) from pizza_types as pt
join pizzas as p
on pt.pizza_type_id=p.pizza_type_id
group by category

------------------Group the orders by date and calculate the average number of pizzas ordered per day.
Select O.Date ,AVG(SUM(Quantity)) Over() Average_Pizza
From Orders O 
JOIN Order_details OD 
ON O.Order_id = OD.Order_id
Group BY O.Date 
Order by Date

-------------Determine the top 3 most ordered pizza types based on revenue. 
select p.pizza_type_id , sum(od.quantity*p.price) as Revenue from pizzas as p
join order_details as od
on p.pizza_id=od.pizza_id
group by pizza_type_id
order by Revenue desc limit 3

-------------Calculate the percentage contribution of each pizza type to total revenue. 
select n.name as pizza_type, 
       sum(od.quantity * p.price) as total_revenue,
       sum(od.quantity * p.price) * 100 / SUM(SUM(od.quantity * p.price)) over() as revenue_percentage
from order_details od
join pizzas p on od.pizza_id = p.pizza_id
join pizza_types n on p.pizza_type_id = n.pizza_type_id
group by n.name
order by total_revenue desc

----------------Analyze the cumulative revenue generated over time.
select o.date, sum(p.price*od.quantity) over(order by o.date) as cumulative_revenue
from orders as o
join order_details as od
on o.order_id=od.order_id
join pizzas as p
on p.pizza_id=od.pizza_id
order by date

----------Determine the top 3 most ordered pizza types based on revenue for each pizza category. 
select pt.pizza_type_id, pt.category , sum(od.quantity*p.price) as Revenue from pizzas as p
join order_details as od
on p.pizza_id=od.pizza_id
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
group by pt.category,pt.pizza_type_id
order by Revenue desc limit 3



