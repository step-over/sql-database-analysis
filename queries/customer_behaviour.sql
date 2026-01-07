/*
Query:
Which customers have the highest average spending per invoice?

Purpose:
Identify high-value customers based on their average invoice amount.
This can help detect premium clients who tend to make higher-value purchases, regardless of purchase frequency. 

SQL concepts: 
    - Aggregation with AVG, COUNT
    - Top-N selection with ORDER BY + FETCH
*/

SELECT 
    c.LastName              AS customer_name,
    COUNT(i.InvoiceId)      AS total_invoices,
    AVG(i.Total)            AS average_invoice
FROM Customer c 
    INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId, 
    c.FirstName,
    c.LastName
ORDER BY average_invoice DESC    
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

/*
Query:
Who is the biggest fan of an artist?

Purpose:
Find the customer with the highest number of invoice lines associated with tracks from a specific artist.
This can help detect highly engaged customers for targeted marketing, loyalty programs, or personalized recommendations.

Artist name is used as example and can be replaced to analyze different artists.


SQL Concepts:
    - Aggregation with COUNT
    - Top-N selection
    - Multi-table joins

*/

SELECT 
    c.LastName              AS customer_name,
    COUNT(InvoiceLineId)    AS total_invoice_lines
    FROM InvoiceLine il 
        INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
        INNER JOIN Customer c ON i.CustomerId = c.CustomerId
        INNER JOIN Track t ON il.TrackId = t.TrackId
        INNER JOIN Album al ON t.AlbumId = al.AlbumId
        INNER JOIN Artist ar ON al.ArtistId = ar.ArtistId 
    WHERE ar.Name = 'Iron Maiden' 
    GROUP BY 
        c.CustomerID, 
        c.FirstName, 
        c.LastName
    ORDER BY total_invoice_lines DESC
    OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY
; 