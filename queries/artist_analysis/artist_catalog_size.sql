SELECT 
    ar.ArtistId     AS artist_id,
    ar.Name         AS artist_name,
    COUNT(t.TrackId)        AS total_tracks
FROM Track t
    INNER JOIN Album al     ON t.AlbumId = al.AlbumId
    INNER JOIN Artist ar    ON ar.ArtistId = al.ArtistId
GROUP BY 
    ar.ArtistId, 
    ar.Name
HAVING COUNT(*) > 50
ORDER BY total_tracks DESC
;