# Final-Project-Transforming-and-Analyzing-Data-with-SQL

## Project/Goals
- Understand the basics + advanced features of PostgreSQL
- Get experience working with real databases
- Put into practice data cleaning  + quality validation 

## Process
1. Data Cleaning
    - Invalid Data: 
Certain columns have null values or data that cannot be used (“(not set)”)
    - Unused columns: 
Certain columns have no values in all rows / majority of rows
2. Data exploration
    - See [Results](##Results)
3. Data quality assurance
    - Major risk areas
        - The data is not complete. There are many NULL values in the dataset.
        - Invalid data types. For example, the type of `date` is `text` instead of `date`.
        - Invalid values. For example, the value of `productPrice` is too large. It should be divided by 1000000.
        - Unusable data: There are some countries that are not valid. For example, "not available in demo dataset" is not a valid country.
        - Invalid product SKU format: The product SKU should be in the format of "GGOEGDHH010399" but there are some product SKUs that are not in this format, such as "9180850"



## Results
- Come up with queries to answer the 5 questions: 
    - Country with most revenue: United states, city: Mountain View
    - Average number of products ordered by country: 74, city: 19
    - Top Product Category: 
City: Home/Shop by Brand/YouTube/ by 13.39%, 
country: Home/Shop by Brand/YouTube/ by 43.31%
    - Top product category bought
Country: "Home/Shop by Brand/YouTube/” (55)
City: "Home/Shop by Brand/YouTube/" (30)
    - Top country by revenue: United States, with all 5 top cities by revenue all in US
- Come up with own questions:
    - What percentage of fullVisitorId are unique? 
around 97.76% of fullVisitorId are unique, which means around 3% of visits are from returning visitors.
    - What the percentages of EVENT and PAGE types are in the dataset?
98.68% are Page type and 1.32% are Event type.
    - What is the percentage of visitors who made a purchase?
Only 13.38% of visitors made a purchase


## Challenges 
- Database basics (i.e. importing the CSVs)
- Relating the different tables together
- Come up with interesting questions to ask about the database


## Future Goals
- Ask more about the data
- Understand the questions better
- Improve data quality early on

