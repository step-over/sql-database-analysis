# Catalog Size by Artist

## Query
> Which artists have a large catalog size?

## Purpose
Identify artists with **more than 50 tracks**, ordered by total number of tracks.
This helps detect **prolific artists** or content-heavy catalogs. 

## SQL concepts
- Aggregation using `COUNT`
- Filtering using `HAVING`

## Technical notes
- Grouping by `ArtistID` instead of only `Name` to distinguish between different artists with the same name
- `HAVING` is used instead of `WHERE` to filter by groups, not artists
- Sort by amount of tracks in descending order to see artists with the largest catalogs first

## SQL Implementation
[`artist_catalog_size.sql`](artist_catalog_size.sql)