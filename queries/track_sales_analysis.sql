/*
Query:
Which tracks have never generated revenue?

Purpose:
Identify tracks that were never included in any invoice, which could indicate low popularity or unused catalog entries.

SQL concepts:
    - Subqueries
    - Anti-join pattern using NOT EXISTS

Technical Concepts:
    - SELECT 1 FROM is used instead of SELECT * to efficiently check for the existence of records, not to retrieve actual data
    - NOT EXISTS is used to filter tracks that do not appear in any invoice line

*/

SELECT 
    t.Name      AS track_name, 
    t.Composer  AS composer_name
FROM Track t
WHERE NOT EXISTS (
    SELECT 1
    FROM InvoiceLine il
    WHERE il.TrackId = t.TrackId
    )
;

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

/*
Query: 
How many times has each track been purchased?

Purpose:
Display the amount of invoice lines in which a track appears.
This can help identify popular tracks as well as tracks with no sales.

SQL concepts:
    - LEFT JOIN

Technical Concepts:
    - Grouping by TrackID instead of only name to identify each track uniquely
    - LEFT JOIN is used to preserve tracks with no invoices related
    - Sort by amount of times each track has been purchased in descending order to see top-selling tracks first

*/

SELECT 
    t.TrackId                   AS track_id,
    t.Name                      AS track_name, 
    COUNT(il.InvoiceLineId)     AS total_invoice_lines
FROM Track t
    LEFT JOIN InvoiceLine il    ON il.TrackId = t.TrackId
GROUP BY 
    t.TrackID, 
    t.Name
ORDER BY total_invoice_lines DESC
;