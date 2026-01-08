# Top Customer By Artist

## Query:
> Who is the biggest fan of an artist?

## Purpose
Find the customer with the **highest number of purchases tracks** associated with a specific artist.
This helps identify highly engaged customers for targeted marketing, loyalty programs, or personalized recommendations.

## SQL Concepts
- Multi-table joins
- Top-N selection with `OFFSET` and `FETCH` 

## Technical notes
- The artist name is hardcoded for demonstration purposes and can be replaced to analyze different artists
- Grouping by `CustomerID` and full name to uniquely identify each customer

## SQL Implementation
[`top_customer_by_artist.sql`](top_customer_by_artist.sql)