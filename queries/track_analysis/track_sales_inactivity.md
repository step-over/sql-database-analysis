# 

## Query
> Which tracks have not been purchased recently?

## Purpose
Identify tracks whose **most recent purchase occurred more than four years ago**.
This helps detect catalog entries with no recent commercial activity.

## SQL concepts
- Time-based functions like `DATEADD`
- Filtering using `HAVING`

## Technical Concepts
- Grouping by `TrackID` to uniquely identify each track
- `HAVING` is used instead of `WHERE` to filter on aggregated values such as the most recent purchase date
- Tracks are sorted by last purchase date in ascending order to see the longest inactive tracks first

## SQL Implementation
[`track_sales_inactivity.sql`](track_sales_inactivity.sql)