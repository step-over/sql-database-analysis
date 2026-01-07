/*
Query:
How much revenue does each employee generate per year?

Purpose: 
Calculate the total invoice amount associated with customers supported by each employee, grouped by year.
This can help evaluate employee performance over time and compare revenue contribution across employees.

SQL concepts:
    - Time-based grouping
*/

SELECT 
    YEAR(i.InvoiceDate)           AS invoice_year, 
    e.LastName                    AS employee_name, 
    SUM(i.Total)                  AS collected
FROM Employee e 
    INNER JOIN Customer c   ON c.SupportRepId = e.EmployeeId
    INNER JOIN Invoice i    ON i.CustomerId = c.CustomerId
GROUP BY 
    YEAR(i.InvoiceDate),
    e.LastName
;