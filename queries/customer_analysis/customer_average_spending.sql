SELECT 
    c.CustomerId                            AS customer_id,
    c.FirstName + ' ' +  c.LastName         AS customer_name,
    COUNT(i.InvoiceId)                      AS total_invoices,
    CAST(AVG(i.Total) AS DECIMAL(10,2))     AS avg_invoice_amount
FROM Customer c 
    INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId, 
    c.FirstName,
    c.LastName
ORDER BY avg_invoice_amount DESC    
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY
;