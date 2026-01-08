# Tracks Without Sales

## Query
> Which tracks have never generated revenue?

## Purpose
Identify tracks that were **never included in any invoice**, which could indicate low popularity or unused catalog entries.

## SQL concepts
- Subqueries
- Anti-join logic using `NOT EXISTS`

## Technical Concepts
- `SELECT 1` is used instead of `SELECT *` to efficiently check for the existence of records, not to retrieve actual data
- `NOT EXISTS` filters tracks that do not appear in any invoice line, ensuring only unsold tracks are returned

## SQL Implementation
[`tracks_without_sales.sql`](tracks_without_sales.sql)