/* Encontrar quienes son los clientes que tienen facturas con
 importes promedio más alto. Mostrar a los 10 clientes con mayor
 importe promedio, mostrando el apellido del cliente, la cantidad
 de facturas a su nombre y el promedio de esas facturas. */

SELECT LastName, COUNT(InvoiceId), AVG(Total)
FROM Customer c 
    INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY LastName
ORDER BY AVG(Total) DESC    -- De mayor a menor promedio
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY
;
-- GROUP BY, COUNT, ORDER BY, FETCH

/* Listar el nombre y la cantidad de tracks de los artistas con más de 50 tracks, 
 ordenado por cantidad de tracks de forma ascendente */

SELECT ar.Name artist, COUNT(*) cant_track
FROM Track t
    INNER JOIN Album al ON t.AlbumId = al.AlbumId
    INNER JOIN Artist ar ON ar.ArtistId = al.ArtistId
GROUP BY ar.Name
HAVING COUNT(*) > 50  -- HAVING agrega restricciones a grupos
ORDER BY cant_track
;
--  GROUP BY, HAVING, ORDER BY

/* Usando consultas anidadas y la cláusula NOT EXISTS, seleccione
 nombre del track y composer de los tracks que nunca fueron facturados. */

SELECT Name, Composer
FROM Track t
WHERE NOT EXISTS (
    SELECT *
    FROM InvoiceLine il
    WHERE il.TrackId = t.TrackId
);
-- NOT EXISTS

/* Encontrar los nombres de los tracks que están tanto en la playlist de nombre ‘Classical’ 
como en la de nombre ‘Classical 101 - The Basics’ utilizando operaciones de conjuntos en SQL. */

(SELECT t.TrackId, t.Name 
FROM Track t INNER JOIN PlaylistTrack pt ON t.TrackId = pt.TrackId 
             INNER JOIN Playlist p ON pt.PlaylistId = p.PlaylistId
WHERE p.Name = 'Classical')
    INTERSECT
(SELECT t.TrackId, t.Name 
FROM Track t INNER JOIN PlaylistTrack pt ON t.TrackId = pt.TrackId 
             INNER JOIN Playlist p ON pt.PlaylistId = p.PlaylistId
WHERE p.Name = 'Classical 101 - The Basics')
; 
-- Operaciones de Conjuntos en SQL: Intersección

/* Obtener los nombres de los tracks, sus compositores, el álbum y el artista al que pertenecen de todos
aquellos tracks que están en facturas con fecha mayor a cuatro años. (4 años de antiguedad al menos ?) */

SELECT t.Name, Composer, Title, ar.Name
FROM Track t, Album al, Artist ar, Invoice i, InvoiceLine il
WHERE t.AlbumId = al.AlbumId 
    AND al.ArtistId = ar.ArtistId
    AND il.TrackId = t.TrackId
    AND i.InvoiceId = il.InvoiceId
    AND i.InvoiceDate < DATEADD(YEAR, -4, GETDATE())  -- DATEADD(interval, number, date)
;
-- DATEADD

/* Obtener las playlists más caras. (Ayuda: primero obtener el ‘precio’ de cada playlist)*/
WITH Precios AS (
    SELECT pt.PlaylistId, SUM(t.UnitPrice) precio
    FROM PlaylistTrack pt
    JOIN Track t ON pt.TrackId = t.TrackId
    GROUP BY pt.PlaylistId
)
SELECT pr.Precio, p.*
FROM Precios pr
JOIN Playlist p ON pr.PlaylistId = p.PlaylistId
WHERE pr.Precio = (SELECT MAX(precio) FROM Precios)
--  WITH  

/* 
Encontrar al máximo fan de Iron Maiden, al que definiremos como aquel 
 que tenga más líneas de factura vinculadas con tracks de la banda. 
 Mostrar el apellido de dicho usuario y la cantidad de líneas de factura
 vinculadas con tracks de la banda. */

SELECT LastName, COUNT(InvoiceLineId) cantidad
    FROM InvoiceLine il INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
                        INNER JOIN Customer c ON i.CustomerId = c.CustomerId
                        INNER JOIN Track t ON il.TrackId = t.TrackId
                        INNER JOIN Album al ON t.AlbumId = al.AlbumId
                        INNER JOIN Artist ar ON al.ArtistId = ar.ArtistId 
    WHERE ar.Name = 'Iron Maiden'
    GROUP BY LastName
    ORDER BY cantidad DESC
    OFFSET 0 ROWS FETCH FIRST 1 ROW ONLY
; 
-- storytelling

/* Obtener el dinero recaudado por cada empleado durante cada año. 
 ¿Cómo extraer un campo de una fecha? 
 YEAR(), MONTH(), DAY() or Datepart(date, ...) ! */

-- !
SELECT DATEPART(year, i.InvoiceDate) Año, e.LastName, SUM(i.Total) Recaudado 
FROM Employee e 
    INNER JOIN Customer c ON c.SupportRepId = e.EmployeeId
    INNER JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY YEAR(i.InvoiceDate), e.LastName 

/* 
Para cada track de género “Rock And Roll” muestre el nombre del track y 
la cantidad de invoice_lines en las que aparece, asegurándose de que 
si un track nunca estuvo en una factura se devuelva cero. */

SELECT t.Name, COUNT(InvoiceLineId)
FROM Track t INNER JOIN Genre g ON g.GenreId = t.GenreId
             LEFT JOIN InvoiceLine il ON il.TrackId = t.TrackId
WHERE g.Name = 'Rock And Roll'
GROUP BY t.Name; 
-- Outer Join
