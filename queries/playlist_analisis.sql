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