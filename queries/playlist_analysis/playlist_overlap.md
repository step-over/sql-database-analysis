# Playlist Content Overlap

## Query
> Which tracks belong to more than one playlist?

## Purpose
Identify tracks that are shared between **two specific playlists**.
This can help detect overlapping content across playlists.

## SQL concepts
- Set operations like `INTERSECT`

## Technical concepts
- Playlist names are used as examples and can be replaced to analyze different playlist combinations
- `INTERSECT` is used to return only tracks that appear in both playlists

## SQL Implementation
[`playlist_overlap.sql`](playlist_overlap.sql)