/*
Query:
How much revenue does each employee generate per year?

Purpose: 
Calculate the total invoice amount associated with customers supported by each employee, grouped by year.
This can help evaluate employee performance over time and compare revenue contribution across employees.

SQL concepts:
    - Time-based analysis

Technical notes:
    - Grouping by EmployeeID and full name to uniquely identify each employee
    - Sort by invoice_year to analyze historical progression
    - Sort by revenue amount in descending order to see the top-selling employees first

*/

SELECT 
    YEAR(i.InvoiceDate)                 AS invoice_year,
    e.EmployeeId                        AS employee_id,
    e.FirstName + ' ' + e.LastName      AS employee_name,
    SUM(i.Total)                        AS revenue_amount
FROM Employee e 
    INNER JOIN Customer c   ON c.SupportRepId = e.EmployeeId
    INNER JOIN Invoice i    ON i.CustomerId = c.CustomerId
GROUP BY 
    YEAR(i.InvoiceDate),
    e.EmployeeId,
    e.FirstName, 
    e.LastName
ORDER BY 
    invoice_year ASC,
    revenue_amount DESC
;