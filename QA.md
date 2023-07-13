What are your risk areas? Identify and describe them.

Risk areas:
- The data is not complete. There are many NULL values in the dataset.
- Invalid data types. For example, the type of `date` is `text` instead of `date`.
- Invalid values. For example, the value of `productPrice` is too large. It should be divided by 1000000.
- Unusable data: There are some countries that are not valid. For example, "not available in demo dataset" is not a valid country.
- Invalid product SKU format: The product SKU should be in the format of "GGOEGDHH010399" but there are some product SKUs that are not in this format, such as "9180850"


QA Process:
Describe your QA process and include the SQL queries used to execute it.

SQL Queries:
- To find the number of NULL values in each column:
```sql
```
