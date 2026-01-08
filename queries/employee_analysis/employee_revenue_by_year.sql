SELECT 
    YEAR(i.InvoiceDate)                 AS invoice_year,
    e.EmployeeId                        AS employee_id,
    e.FirstName + ' ' + e.LastName      AS employee_name,
    SUM(i.Total)                        AS total_revenue
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
    total_revenue DESC
;