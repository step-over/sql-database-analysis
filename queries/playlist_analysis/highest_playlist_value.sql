WITH playlist_total_value AS (
    SELECT 
        pt.PlaylistId       AS playlist_id, 
        SUM(t.UnitPrice)    AS total_value
    FROM PlaylistTrack pt
        INNER JOIN Track t ON pt.TrackId = t.TrackId
    GROUP BY pt.PlaylistId
)
SELECT 
    p.PlaylistId        AS playlist_id,
    p.Name              AS playlist_name,
    ptv.total_value     AS total_value
FROM playlist_total_value ptv
    INNER JOIN Playlist p ON ptv.playlist_id = p.PlaylistId
WHERE ptv.total_value = (
    SELECT MAX(total_value)
    FROM playlist_total_value
    )
;