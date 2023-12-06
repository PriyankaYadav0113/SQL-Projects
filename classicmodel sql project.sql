/* 1.Top 5 customers with the highest number of orders */

select customerName,count(o.orderNumber) as order_count from customers c
join orders o 
on c.customerNumber=o.customerNumber
group by c.customerNumber 
order by order_count desc
limit 5 ;

/* 2.Find the highest number of customer from which country */

select country,count(*) as tot_customer from customers
group by country
order by 2 desc;

 /* 3.Find each year how many orders are places */
 
 select count(ordernumber) as tot_order,year(orderdate) from orders 
 group by year(orderdate);
 
 /* 4.Top 10 most ordered product based on the total quantity ordered */
 
select productname,sum(quantityOrdered) as most_ordered_product from orderdetails od
join products p on p.productcode=od.productcode
group by productName
order by most_ordered_product desc
limit 10;

/* 5.Find the products which are not ordered by any customer */

select productname from products where productcode not in (select productcode from orderdetails);

/* 6.Find the number of customers for each sales representative */ 

select employeenumber,concat(firstname,' ',lastname) as full_name,count(*) as total_customers from customers c 
join employees e on c.salesRepEmployeeNumber=e.employeeNumber 
where salesRepEmployeeNumber is not null 
group by 1 
order by 3 desc;

/* 7.Profit margin of each productline */  

select productline,
sum(quantityinstock) as tot_quantity_in_stock,
sum(quantityordered) as tot_quantity_ordered,
avg(buyprice) as avg_buy_price,
avg(priceeach) as avg_selling_price,
sum(quantityordered*priceeach) as total_sales,
sum(quantityordered*buyprice) as total_cost,
(sum(quantityordered*priceeach)-sum(quantityordered*buyprice)) as total_profit,
concat(round(((sum(quantityordered*priceeach)-sum(quantityordered*buyprice))/sum(quantityordered*priceeach))*100,2),'%') as profit_margin
from products p 
join orderdetails od on od.productcode=p.productcode 
group by productline 
order by profit_margin desc;

/* 8.Total shipped orders,total canceled orders and total on_hold orders  */ 

select sum(case when status='shipped' then 1 end) shipped,
sum(case when status='cancelled' then 1 end) canceled,
sum(case when status='on hold' then 1 end) 'on_hold'
from orders;

/* 9.Total payment by payment category */

select sum(amount) as total_payment,
case 
when amount>80000 then 'High'
when amount>20000 then 'Medium'
else 'Low'
end as Payment_category
from payments
group by payment_category;

/* 10.Counts of employeees by job title */ 

 select sum(case when jobtitle = 'Sales Manager (APAC)' then 1 end) 'sales_manager',
sum(case when jobtitle = 'sales rep' then 1 end) 'sales_rep',
sum(case when jobtitle = 'vp sales' then 1 end) 'vp_sales',
sum(case when jobtitle = 'vp marketing' then 1 end) 'vp_marketing'
from employees;

