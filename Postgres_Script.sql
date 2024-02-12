create table customers (
customer_id	int4,
first_name varchar(50),
last_name varchar(50),
gender varchar(30),	
DOB varchar(50),	
job_title varchar(50),
job_industry_category varchar(50),	
wealth_segment varchar(50),	
deceased_indicator varchar(50),	
owns_car varchar(50),
address varchar(50),
postcode varchar(30),
state varchar(30),
country varchar(30),
property_valuation int4);

create table transactions (
 transaction_id	int4,
 product_id	int4,
 customer_id int4,	
 transaction_date varchar(30),	
 online_order varchar(30),	
 order_status varchar(30),	
 brand varchar(30),	
 product_line varchar(30),	
 product_class varchar(30),
 product_size varchar(30),
 list_price	float4,
 standard_cost float4
);


select distinct brand from transactions where standard_cost > 1500.0;

select * from transactions where order_status = 'Approved' and transaction_date::date between '2017-04-01'::date and '2017-04-09'::date;

select distinct job_title from customers where job_title like 'Senior%' and (job_industry_category = 'IT' or job_industry_category = 'Financial Services');

select distinct brand from transactions where customer_id In 
	(select distinct customer_id from customers where job_industry_category = 'Financial Services');

select * from customers where customer_id In 
	(select distinct customer_id from transactions where online_order = 'True' and brand in ('Giant Bicycles', 'Norco Bicycles', 'Trek Bicycles') )
	limit 10

select * from customers customers left join transactions transactions on customers.customer_id =transactions.customer_id 
	where transactions.customer_id is null 
	
select * from customers where job_industry_category = 'IT' and customer_id in 
	(select customer_id from transactions where standard_cost = (select max(standard_cost) from transactions))
	
select * from customers where (job_industry_category = 'IT' or job_industry_category = 'Health') and customer_id in
	(select distinct customer_id from transactions where order_status = 'Approved' and transaction_date::date between '2017-07-07'::date and '2017-07-17'::date)
