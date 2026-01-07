/*
Query:
Which customers have the highest average spending per invoice?

Purpose:
Identify high-value customers based on their average invoice amount.
This can help detect premium clients who tend to make higher-value purchases, regardless of purchase frequency. 

SQL concepts: 
    - Aggregations using AVG and COUNT
    - Top-N selection using OFFSET and FETCH

Technical notes:
    - Grouping by CustomerID and full name to uniquely identify customers
    - Descending order to see first customers with the highest average spendings
    - Explicit casting to DECIMAL(10,2) is used to round to two decimal places and avoid extra zeros at the end
*/

SELECT 
    c.CustomerId                            AS customer_id,
    c.FirstName + ' ' +  c.LastName         AS customer_name,
    COUNT(i.InvoiceId)                      AS total_invoices,
    CAST(AVG(i.Total) AS DECIMAL(10,2))     AS average_invoice
FROM Customer c 
    INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId, 
    c.FirstName,
    c.LastName
ORDER BY average_invoice DESC    
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
;