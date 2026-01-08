# SQL Analytics Project

## Overview
This project contains a collection of SQL queries built on the [Chinook database](#dataset).

The project focuses on answering realistic business questions related to:
- artist catalogs and content size
- customer spending patterns and engagement with artists
- employee revenue contribution over time
- playlist value and shared track composition
- track sales frequency, inactivity, and unsold content

Each query in this project is built to answer a specific business question.

Along with the SQL implementation, each analysis includes a short explanation of:
- the question being answered
- the purpose of the analysis
- the main SQL concepts and logic used

The goal of the project is to show how SQL can be used to reason about data and answer practical questions, not just to write queries.

## SQL Concepts Used
- SQL Aggregations (`COUNT`, `SUM`, `AVG`)
- JOINs (`INNER JOIN`, `LEFT JOIN`)
- Subqueries and Common Table Expressions (CTEs)
- Set operations (`INTERSECT`)
- Filtering with `HAVING` and `WHERE`

## Project Structure

### queries
- artist_analysis
    - [`artist_catalog_size`](queries/artist_analysis/artist_catalog_size.md)      
- customer_analysis
    - [`customer_average_spending`](queries/customer_analysis/customer_average_spending.md)
    - [`top_costumer_by_artist`](queries/customer_analysis/top_costumer_by_artist.md)
- employee_analysis
    - [`employee_revenue_by_year`](queries/employee_analysis/employee_revenue_by_year.md)
- playlist_analysis
    - [`highest_playlist_value`](queries/playlist_analysis/highest_playlist_value.md)
    - [`playlist_overlap`](queries/playlist_analysis/playlist_overlap.md)
- track_analysis
    - [`track_purchase_frequency`](queries/track_analysis/track_purchase_frequency.md)
    - [`track_sales_inactivity`](queries/track_analysis/track_sales_inactivity.md)
    - [`tracks_without_sales`](queries/track_analysis/tracks_without_sales.md)


Each folder contains:
- `.sql` files with the actual queries
- `.md` files describing the purpose, concepts, and technical details

## Dataset
This project uses the **Chinook database**, a well-known sample relational database that represents a digital music store.

It includes realistic data about:
- artists, albums, playlists, and tracks
- customers, employees, and invoices

Chinook is commonly used for learning and practicing SQL, which makes this project easy to understand and reproduce.

## How to run the queries
1. Download the Chinook database.
2. Open it using your preferred SQL client (for example: SQLite, PostgreSQL, or SQL Server).
3. Navigate to the desired analysis folder inside `queries/`.
4. Open and execute the `.sql` files individually.

Each query is independent and can be run on its own.

The queries use standard SQL syntax. Some functions may require small adjustments depending on the database engine used.

## Technologies
- SQL
- Git
- Markdown