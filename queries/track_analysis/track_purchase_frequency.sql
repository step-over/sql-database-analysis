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