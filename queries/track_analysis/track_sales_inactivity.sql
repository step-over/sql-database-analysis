SELECT 
    t.TrackId               AS track_id,
    t.Name                  AS track_name,
    t.Composer              AS composer_name,
    al.Title                AS album_title, 
    ar.Name                 AS artist_name,
    MAX(i.InvoiceDate)      AS last_purchase_date
FROM Track t
    INNER JOIN Album al         ON t.AlbumId = al.AlbumId
    INNER JOIN Artist ar        ON al.ArtistId = ar.ArtistId
    INNER JOIN InvoiceLine il   ON t.TrackId = il.TrackId
    INNER JOIN Invoice i        ON il.InvoiceId = i.InvoiceId
GROUP BY 
    t.TrackId,
    t.Name,
    t.Composer,
    al.Title,
    ar.Name
HAVING MAX(i.InvoiceDate) < DATEADD(YEAR, -4, GETDATE())
ORDER BY last_purchase_date ASC
;