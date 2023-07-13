What issues will you address by cleaning the data?





Queries:
Below, provide the SQL queries you used to clean your data.

`all_sessions` table:
- To divide all prices by 1000000:
```sql
ALTER TABLE all_sessions
ALTER COLUMN "productPrice"
TYPE double precision;

UPDATE all_sessions
SET "productPrice" = "productPrice" / 1000000;
```

- To find how many distinct values of `transactions` there are and the number of rows:
```sql
SELECT 
distinct(transactions),
count(*) over (partition by transactions)
from all_sessions
```

- To find distinct values of `totalTransactionRevenue` and the number of rows:
```sql
SELECT 
distinct("totalTransactionRevenue"),
count(*) over (partition by "totalTransactionRevenue")
from all_sessions where "totalTransactionRevenue" is null or "totalTransactionRevenue" is not null
order by "totalTransactionRevenue" desc
```

- Change the type of `date` to DATE:
```sql
ALTER TABLE all_sessions 
ALTER COLUMN "date" TYPE DATE 
USING TO_DATE("date"::text, 'YYYY-MM-DD');
```

- To remove duplicate `visitId`:
```sql
DELETE FROM all_sessions
WHERE visitId IN (SELECT visitId FROM 
(SELECT visitId, 
ROW_NUMBER() OVER(PARTITION BY visitId
ORDER BY visitId ASC) AS row_num
FROM all_sessions) visit
WHERE visit.row_num > 1 );

ALTER TABLE all_sessions
ALTER COLUMN visitId TYPE bigint USING visitId::bigint;
```

- To replace cities and countries with "not available in demo dataset" with NULL:
```sql
UPDATE all_sessions
SET city = null
WHERE city = 'not available in demo dataset'
or city = '(not set)'

UPDATE all_sessions
SET country = null
WHERE country = 'not available in demo dataset'
or country = '(not set)'
```

- To replace `v2ProductCategory` with "(not set)" with NULL:
```sql
UPDATE all_sessions
SET "v2ProductCategory" = null
WHERE "v2ProductCategory" = '(not set)'
```

- To find the percentages of `EVENT` and `PAGE` types:
```sql
select distinct("type"),
cast (count(*) over (partition by "type") as double precision) / cast (count(*) over () as double precision) * 100
from all_sessions
```

select "productRefundAmount", count("productRefundAmount")
from all_sessions
group by "productRefundAmount"

- Drop `itemQuantity`, `itemRevenue` and `productRefundAmount` columns:
```sql
ALTER TABLE all_sessions DROP COLUMN "itemRevenue"
ALTER TABLE all_sessions DROP COLUMN "itemQuantity"
ALTER TABLE all_sessions DROP COLUMN "productRefundAmount"
```

Analytics table:
- To reduce the scale of the unit price
```sql
select 
cast(unit_price as double precision) / cast(1000000 as double precision) as unit_cost 
from analytics;


```

