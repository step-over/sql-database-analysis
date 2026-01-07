/*
Query:
Which tracks belong to more than one playlist?

Purpose:
Identify tracks that are shared between two specific playlists.
This can help detect overlapping content across playlists.

SQL concepts:
    - Set operations like INTERSECT

Technical concepts:
    - Playlist names are used as examples and can be replaced to analyze different playlist combinations
    - INTERSECT is used to return only tracks that appear in both playlists

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
)
; 

/*
Query:
Which are the most expensive playlists?

Purpose:
Identify the playlists with the highest total value based on track prices.
This can help compare playlist value and support pricing or promotional strategies.

SQL Concepts:
    - Common Table Expresion using WITH
    - Subqueries

Technical Concepts:
    - Subquery is used to select only the playlists with the maximum total value
    - CTE is used to calculate total playlist value once and reuse it, improving readability and modularity

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
    p.PlaylistId        AS playlist_id,
    p.Name              AS playlist_name,
    ptv.total_value     AS price
FROM playlist_total_value ptv
    INNER JOIN Playlist p ON ptv.playlist_id = p.PlaylistId
WHERE ptv.total_value = (
    SELECT MAX(total_value)
    FROM playlist_total_value
    )
;