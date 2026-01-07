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