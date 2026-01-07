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