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