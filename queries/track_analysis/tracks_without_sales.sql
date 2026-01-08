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