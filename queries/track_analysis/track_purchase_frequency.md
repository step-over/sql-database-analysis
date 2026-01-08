# Track Purchase Frequency

## Query
> How many times has each track been purchased?

## Purpose
Measure how often each track appears in **invoice lines**, including tracks with zero purchases.
This helps identify popular tracks as well as tracks with no sales.

## SQL concepts
- `LEFT JOIN`

## Technical Concepts
- Grouping by `TrackID` instead of only name to identify each track uniquely
- `LEFT JOIN` is used to preserve tracks with no invoices related
- Results are sorted by purchase frequency in descending order to see top-selling tracks first

## SQL Implementation
[`track_purchase_frequency.sql`](track_purchase_frequency.sql)