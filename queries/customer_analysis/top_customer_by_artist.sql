SELECT 
    c.CustomerId                        AS customer_id,
    c.FirstName + ' ' +  c.LastName     AS customer_name,
    COUNT(il.InvoiceLineId)             AS purchased_tracks
    FROM InvoiceLine il 
        INNER JOIN Invoice i    ON il.InvoiceId = i.InvoiceId
        INNER JOIN Customer c   ON i.CustomerId = c.CustomerId
        INNER JOIN Track t      ON il.TrackId = t.TrackId
        INNER JOIN Album al     ON t.AlbumId = al.AlbumId
        INNER JOIN Artist ar    ON al.ArtistId = ar.ArtistId 
    WHERE ar.Name = 'Iron Maiden' 
    GROUP BY 
        c.CustomerId, 
        c.FirstName, 
        c.LastName
    ORDER BY purchased_tracks DESC
    OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY
; 