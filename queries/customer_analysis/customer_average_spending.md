# Average Spending per Customer

## Query
> Which customers have the highest average spending per invoice?

## Purpose
Identify **high-value customers** based on their average invoice amount.
This helps detect premium clients who tend to make higher-value purchases, regardless of purchase frequency. 

## SQL concepts 
- Aggregations using `AVG` and `COUNT`
- Ordering
- Top-N selection using `OFFSET` and `FETCH`

## Technical notes
- Grouping by `CustomerId` and full name to uniquely identify customers
- Descending order to see customers with the highest average spending first
- Explicit casting to `DECIMAL(10,2)` is used to control numeric precision

## SQL Implementation
[`customer_average_spending.sql`](customer_average_spending.sql)