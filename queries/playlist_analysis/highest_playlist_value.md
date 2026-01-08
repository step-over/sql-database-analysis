#  Highest Playlist Value

## Query
> Which are the most expensive playlists?

## Purpose
Identify the playlists with the **highest total value** based on track prices.
This can help compare playlist value and support pricing or promotional strategies.

## SQL Concepts
- Common Table Expression using `WITH`
- Subqueries

## Technical notes
- Subquery is used to filter only the playlists with the maximum total value
- CTE is used to calculate total playlist value once and reuse it, improving readability and avoiding duplicated logic

## SQL Implementation
[`highest_playlist_value.sql`](highest_playlist_value.sql)