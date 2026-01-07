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