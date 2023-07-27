Answer the following questions and provide the SQL queries used to find the answer.

    
**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**


SQL Queries:
```sql
select 
	als.country,
	ROUND(SUM(als."productPrice" * sr."total_ordered")) as total_revenue
from sales_report sr
left join all_sessions als
on als."productSKU" = sr."productSKU"
where als.country is not null
group by als.country
order by total_revenue desc
limit 5;

select 
	als.city,
	ROUND(SUM(als."productPrice" * sr."total_ordered")) as total_revenue
from sales_report sr
left join all_sessions als
on als."productSKU" = sr."productSKU"
where als.city is not null
group by als.city
order by total_revenue desc
limit 5;
```

Answer:

| Country      | Total Transaction Revenue |
| ----------- | ----------- |
| United States      | 5046730       |
| United Kingdom   | 247238        |
| Canada   | 164467        |
| India   | 117786        |
| Italy   | 91548        |

| City      | Total Transaction Revenue |
| ----------- | ----------- |
| Mountain View      | 1159671       |
| San Francisco   | 356436        |
| Sunnyvale   | 350573        |
| Palo Alto   | 326389        |
| New York   | 307256        |


**Question 2: What is the average number of products ordered from visitors in each city and country?**


SQL Queries:
```sql
select 
	'country' as country,
	AVG(stats."products_ordered") as average_products
FROM
(
select 
	als.country,
	count(als."productSKU") as products_ordered
from sales_report sr
left join all_sessions als
on als."productSKU" = sr."productSKU"
where als.country is not null
group by als.country
) stats


```
| Category      | Average Product SKUs Ordered |
| ----------- | ----------- |
|"country"	|74|
|"city"	|19|
Answer:






**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**

SQL Queries:
```sql
WITH city_product_category_view AS (
select distinct
	als.city,
	als."v2ProductCategory" as product_category,
	SUM(sr."total_ordered") OVER (PARTITION BY als."v2ProductCategory", als.city) as order_sum
from sales_report sr
left join all_sessions als
on als."productSKU" = sr."productSKU"
where als.city is not null
and als."v2ProductCategory" is not null
order by order_sum desc),

product_category_count AS(

SELECT 
	product_category,
	count(*) as city_count
from city_product_category_view
where (city, order_sum) in (
	select city, max(order_sum)
	from city_product_category_view
	group by city
)
group by product_category
order by city_count desc
)

SELECT 
	product_category,
	ROUND(city_count::numeric / (select sum(city_count) from product_category_count)::numeric * 100, 2)
from product_category_count


WITH country_product_category_view AS (
select distinct
	als.country,
	als."v2ProductCategory" as product_category,
	SUM(sr."total_ordered") OVER (PARTITION BY als."v2ProductCategory", als.country) as order_sum
from sales_report sr
left join all_sessions als
on als."productSKU" = sr."productSKU"
where als.country is not null
and als."v2ProductCategory" is not null
order by order_sum desc),

product_category_count AS(

SELECT 
	product_category,
	count(*) as country_count
from country_product_category_view
where (country, order_sum) in (
	select country, max(order_sum)
	from country_product_category_view
	group by country
)
group by product_category
order by country_count desc
)

SELECT 
	product_category,
	ROUND(country_count::numeric / (select sum(country_count) from product_category_count)::numeric * 100, 2)
from product_category_count
```

Answers:
Top Product Category by City: Home/Shop by Brand/YouTube/ by 13.39%
Top Product Category by Country: Home/Shop by Brand/YouTube/ by 43.31%



**Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**


SQL Queries:
```sql
WITH city_product_category_view AS (
select distinct
	als.city,
	als."v2ProductCategory" as product_category,
	SUM(sr."total_ordered") OVER (PARTITION BY als."v2ProductCategory", als.city) as order_sum
from sales_report sr
left join all_sessions als
on als."productSKU" = sr."productSKU"
where als.city is not null
and als."v2ProductCategory" is not null
order by order_sum desc)

SELECT 
	product_category,
	count(*) as city_count
from city_product_category_view
where (city, order_sum) in (
	select city, max(order_sum)
	from city_product_category_view
	group by city
)
group by product_category
order by city_count desc

WITH country_product_category_view AS (
select distinct
	als.country,
	als."v2ProductCategory" as product_category,
	SUM(sr."total_ordered") OVER (PARTITION BY als."v2ProductCategory", als.country) as order_sum
from sales_report sr
left join all_sessions als
on als."productSKU" = sr."productSKU"
where als.country is not null
and als."v2ProductCategory" is not null
order by order_sum desc)

SELECT 
	product_category,
	count(*) as country_count
from country_product_category_view
where (country, order_sum) in (
	select country, max(order_sum)
	from country_product_category_view
	group by country
)
group by product_category
order by country_count desc
```

Answer:
Top 3 products bought by city count:
| Product Category      | City Count |
| ----------- | ----------- |
| "Home/Shop by Brand/YouTube/"	| 30 |
|"Home/Nest/Nest-USA/"|	21|
|"Home/Apparel/Men's/Men's-T-Shirts/"|	20|

Top 3 products bought by country count:
| Product Category      | Country Count |
| ----------- | ----------- |
|"Home/Shop by Brand/YouTube/"	|55|
|"Home/Apparel/Men's/Men's-T-Shirts/"|	10|
|"Home/Shop by Brand/Google/"|	10|



**Question 5: Can we summarize the impact of revenue generated from each city/country?**

SQL Queries:
```sql
WITH country_revenue AS (
	select 
		als.country,
		ROUND(SUM(als."productPrice" * sr."total_ordered")) as total_revenue
	from sales_report sr
	left join all_sessions als
	on als."productSKU" = sr."productSKU"
	where als.country is not null
	group by als.country
	order by total_revenue desc
)

SELECT 
	country,
	ROUND(total_revenue::numeric / (select SUM(total_revenue) from country_revenue)::numeric * 100, 2) as pct
from country_revenue

WITH city_revenue AS (
	select 
		als.city,
		ROUND(SUM(als."productPrice" * sr."total_ordered")) as total_revenue
	from sales_report sr
	left join all_sessions als
	on als."productSKU" = sr."productSKU"
	where als.city is not null
	group by als.city
	order by total_revenue desc
)

SELECT 
	city,
	ROUND(total_revenue::numeric / (select SUM(total_revenue) from city_revenue)::numeric * 100, 2) as pct
from city_revenue

```

Answer:
Top 5 cities by revenue:
| City      | Revenue Percentage |
| ----------- | ----------- |
|"Mountain View"|	28.39|
|"San Francisco"|	8.73|
|"Sunnyvale"|	8.58|
|"Palo Alto"|	7.99|
|"New York"|	7.52|

Top 5 countries by revenue:
| Country      | Revenue Percentage |
| ----------- | ----------- |
|"United States"|	77.09|
|"United Kingdom"|	3.78|
|"Canada"|	2.51|
|"India"|	1.80|
|"Italy"|	1.40|

As we can see, North America has about 80% of global sales (United States + Canada), and the top 5 cities are all in North America. This is not surprising, as the dataset is from a North American company. However, it is interesting to note that the top 5 countries by revenue are all English-speaking countries. This may indicate that the company should focus on expanding to other English-speaking countries in other continents, such as Australia, New Zealand, and South Africa.