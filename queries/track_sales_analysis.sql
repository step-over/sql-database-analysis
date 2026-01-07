/*
Query:
Which tracks have never generated revenue?

Purpose:
Identify tracks that were never included in any invoice, which could indicate low popularity or unused catalog entries.

SQL concepts:
    - Correlated subquery
    - Anti-join pattern with NOT EXISTS
*/

SELECT 
    t.Name     AS track_name, 
    t.Composer AS composer_name
FROM Track t
WHERE NOT EXISTS (
    SELECT 1
    FROM InvoiceLine il
    WHERE il.TrackId = t.TrackId
);

/*
Query:
Which tracks have not been purchased recently?

Purpose:
Identify tracks whose most recent purchase occurred more than four years ago.
This helps detect catalog entries with no recent commercial activity.

SQL concepts:
    - Time-based aggregation
    - HAVING with MAX
*/

SELECT 
    t.Name      AS track_name,
    t.Composer  AS composer_name,
    al.Title     AS album_title, 
    ar.Name     AS artist_name
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
HAVING MAX(i.InvoiceDate) < DATEADD(YEAR, -4, GETDATE());

/*
Query: 
How many times has each track been purchased?

Purpose:
Display the amount of invoice lines in which a track appears.
This can help identify popular tracks as well as tracks with no sales.

SQL concepts:
    - Outer join for row preservation
    - Aggregation 

*/

SELECT 
    t.Name                  AS track_name, 
    COUNT(InvoiceLineId)    AS total_invoice_lines
FROM Track t
    LEFT JOIN InvoiceLine il    ON il.TrackId = t.TrackId
GROUP BY 
    t.TrackID, 
    t.Name; 