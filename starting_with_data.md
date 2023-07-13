Question 1: What percentage of `fullVisitorId` are unique?

SQL Queries:
```sql
select 
	ROUND(count(distinct("fullVisitorId"))::numeric 
		  / (select count(*) from all_sessions)::numeric
		  * 100, 2)
from all_sessions
```
Answer: 
around 97.76% of `fullVisitorId` are unique, which means around 3% of visits are from returning visitors.

Question 2: What the percentages of `EVENT` and `PAGE` types are in the dataset?

SQL Queries:
```sql
select distinct("type"),
	Round(count(*) over (partition by "type")::numeric / count(*) over ()::numeric * 100, 2)
from all_sessions
```

Answer:
98.68% are `Page` type and 1.32% are `Event` type.

Question 3: What is the percentage of visitors who made a purchase?

SQL Queries:
```sql
select 
	ROUND(count(distinct("fullVisitorId"))::numeric 
		  / (select count(distinct("fullVisitorId")) from analytics where "fullVisitorId" is not null)::numeric
		  * 100, 2)
from analytics 
where "fullVisitorId" is not null
and "units_sold" is not null
```

Answer:
Only 13.38% of visitors made a purchase.

