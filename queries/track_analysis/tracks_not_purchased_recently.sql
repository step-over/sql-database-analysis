/*
Query:
Which tracks have not been purchased recently?

Purpose:
Identify tracks whose most recent purchase occurred more than four years ago.
This helps detect catalog entries with no recent commercial activity.

SQL concepts:
    - Time functions like DATEADD
    - Filtering using HAVING

Technical Concepts:
    - Grouping by TrackID to uniquely identify each track
    - HAVING is used instead of WHERE to filter on aggregated values such as the most recent purchase date
    - Sort by last purchase date in ascending order to see the tracks purchased the longest time ago first

*/

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