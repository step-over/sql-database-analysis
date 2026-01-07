/*
Query: 
Which artists have a large catalog size?

Purpose:
Identify artists with more than 50 tracks, ordered by total number of tracks.
This can help detect prolific artists or content-heavy catalogs. 

SQL concepts:
    - Aggregation using COUNT
    - Filtering using HAVING

Technical notes:
    - Grouping by ArtistID instead of only Name to distinguish between different artists with the same name
    - HAVING is used instead of WHERE to filter by groups, not artists
    - Descending order to see first artists with the largest catalogs
*/

SELECT 
    ar.ArtistId     AS artist_id,
    ar.Name         AS artist_name,
    COUNT(*)        AS total_tracks
FROM Track t
    INNER JOIN Album al     ON t.AlbumId = al.AlbumId
    INNER JOIN Artist ar    ON ar.ArtistId = al.ArtistId
GROUP BY 
    ar.ArtistId, 
    ar.Name
HAVING COUNT(*) > 50
ORDER BY total_tracks DESC
;