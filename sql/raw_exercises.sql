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
Which artists have a large catalog size?

Purpose:
Identify artists with more than 50 tracks, ordered by total number of tracks.
This can help detect prolific artists or content-heavy catalogs. 

SQL concepts:
    - Aggregation with GROUP BY
    - HAVING for aggregate filter
*/

SELECT 
    ar.Name     AS artist_name, 
    COUNT(*)    AS total_tracks
FROM Track t
    INNER JOIN Album al ON t.AlbumId = al.AlbumId
    INNER JOIN Artist ar ON ar.ArtistId = al.ArtistId
GROUP BY 
    ar.ArtistId, 
    ar.Name
HAVING COUNT(*) > 50
ORDER BY total_tracks ASC;

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
Which tracks belong to more than one playlist?

Purpose:
Identify tracks that are shared between two specific playlists.
This can help detect overlapping content across playlists.

Playlist names are used as examples and can be replaced to analyze different playlist combinations.

SQL concepts:
    - Set operations like INTERSECT

*/

(
    SELECT 
        t.TrackId   AS track_id, 
        t.Name      AS track_name 
    FROM Track t 
        INNER JOIN PlaylistTrack pt ON t.TrackId = pt.TrackId 
        INNER JOIN Playlist p       ON pt.PlaylistId = p.PlaylistId
    WHERE p.Name = 'Classical'
)
    INTERSECT
(
    SELECT 
        t.TrackId   AS track_id, 
        t.Name      AS track_name  
    FROM Track t 
        INNER JOIN PlaylistTrack pt ON t.TrackId = pt.TrackId 
        INNER JOIN Playlist p       ON pt.PlaylistId = p.PlaylistId
    WHERE p.Name = 'Classical 101 - The Basics'
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
Which are the most expensive playlists?

Purpose:
Identify the playlists with the highest total value based on track prices.
This can help compare playlist value and support pricing or promotional strategies.

SQL Concepts:
    - Common Table Expresion (CTE)
    - Aggregation with SUM
    - Scalar subquery with MAX

*/

WITH playlist_total_value AS (
    SELECT 
        pt.PlaylistId       AS playlist_id, 
        SUM(t.UnitPrice)    AS total_value
    FROM PlaylistTrack pt
        INNER JOIN Track t ON pt.TrackId = t.TrackId
    GROUP BY pt.PlaylistId
)
SELECT 
    p.PlaylistId, 
    p.Name              AS playlist_name,
    ptv.total_value     
FROM playlist_total_value ptv
    INNER JOIN Playlist p ON ptv.playlist_id = p.PlaylistId
WHERE ptv.total_value = (
    SELECT MAX(total_value)
    FROM playlist_total_value
);

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