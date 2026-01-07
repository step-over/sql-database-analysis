/*
Query:
Who is the biggest fan of an artist?

Purpose:
Find the customer with the highest number of invoice lines associated with tracks from a specific artist.
This can help detect highly engaged customers for targeted marketing, loyalty programs, or personalized recommendations.

SQL Concepts:
    - Multi-table joins
    - Top-N selection with OFFSET and FETCH

Technical notes:
    - Artist name is used as example and can be replaced to analyze different artists
    - Grouping by CustomerID and full name to uniquely identify each customer

*/

SELECT 
    c.CustomerId                        AS customer_id,
    c.FirstName + ' ' +  c.LastName     AS customer_name,
    COUNT(il.InvoiceLineId)             AS total_invoice_lines
    FROM InvoiceLine il 
        INNER JOIN Invoice i    ON il.InvoiceId = i.InvoiceId
        INNER JOIN Customer c   ON i.CustomerId = c.CustomerId
        INNER JOIN Track t      ON il.TrackId = t.TrackId
        INNER JOIN Album al     ON t.AlbumId = al.AlbumId
        INNER JOIN Artist ar    ON al.ArtistId = ar.ArtistId 
    WHERE ar.Name = 'Iron Maiden' 
    GROUP BY 
        c.CustomerID, 
        c.FirstName, 
        c.LastName
    ORDER BY total_invoice_lines DESC
    OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY
; 