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
)
; 