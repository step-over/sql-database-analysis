-- 1.Encontrar para cada compositor la cantidad de tracks compuestos.

SELECT Composer, COUNT(TrackId)
FROM Track
GROUP BY Composer;

-- 2.Encontrar para cada compositor la cantidad de tracks compuestos 
-- mostrando únicamente aquellos compositores con al menos 20 tracks compuestos.

SELECT Composer, COUNT(TrackId)
FROM Track
GROUP BY Composer
HAVING COUNT(TrackId) >= 20;

-- 3. Encontrar quienes son los clientes que tienen facturas con
-- importes promedio más alto. Mostrar a los 10 clientes con mayor
-- importe promedio, mostrando el apellido del cliente, la cantidad
-- de facturas a su nombre y el promedio de esas facturas.

SELECT LastName, COUNT(InvoiceId), AVG(Total)
    FROM Customer c INNER JOIN Invoice i 
    ON c.CustomerId = i.CustomerId
GROUP BY LastName
ORDER BY AVG(Total) DESC    -- De mayor a menor promedio
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY
;

-- 4. ¿Y si quisiéramos saber en cuántas facturas aparece cada track, 
-- pero sólo para aquellos que aparecen en al menos dos facturas?

SELECT t.Name, COUNT(InvoiceLineId) cantidad
    FROM Track t INNER JOIN InvoiceLine il 
    ON t.TrackId = il.TrackId
GROUP BY t.Name
HAVING COUNT(InvoiceId) >= 2
ORDER BY cantidad DESC 
;

-- 5. Encontrar al máximo fan de Iron Maiden, al que definiremos como aquel 
-- que tenga más líneas de factura vinculadas con tracks de la banda. 
-- Mostrar el apellido de dicho usuario y la cantidad de líneas de factura
-- vinculadas con tracks de la banda.

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

-- 6. Encuentre los nombres de los tracks pertenecientes a facturas
-- del cliente que tiene la factura de mayor importe.

SELECT t.Name
FROM Track t INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
             INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
WHERE CustomerId = (SELECT c.CustomerId
                        FROM Invoice i INNER JOIN Customer c ON i.CustomerId = c.CustomerId
                        ORDER BY Total DESC
                        OFFSET 0 ROWS FETCH FIRST 1 ROW ONLY)
;

-- 7. Utilizando una cláusula WITH, listar nombres de playlists que
-- tienen tracks que aparecen en las facturas de menor importe.

WITH cheaper_tracks AS (
    SELECT t.TrackId
    FROM Track t INNER JOIN InvoiceLine il ON il.TrackId = t.TrackId 
                 INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
    WHERE Total = (SELECT MIN(Total) FROM Invoice)
    ) 
SELECT DISTINCT p.Name
    FROM Playlist p INNER JOIN PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
                    INNER JOIN cheaper_tracks t ON t.TrackId = pt.TrackId
; 

-- Consultas anidadas

-- 1.Usando consultas anidadas y la cláusula NOT EXISTS, seleccione
-- nombre del track y composer de los tracks que nunca fueron facturados.

SELECT Name, Composer
FROM Track t
WHERE NOT EXISTS (
    SELECT *
    FROM InvoiceLine il
    WHERE il.TrackId = t.TrackId
);

-- Operaciones de Conjuntos en SQL

-- 2. Encontrar los nombres de los tracks que están tanto en la playlist de nombre ‘Classical’ 
-- como en la de nombre ‘Classical 101 - The Basics’ utilizando operaciones de conjuntos en SQL.

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

-- 3. Encontrar los nombres de los tracks que están o bien en la playlist de nombre 
-- ‘Music Videos’ o bien en la de nombre ‘On-The-Go 1’ utilizando operaciones de conjuntos en SQL.

(SELECT t.TrackId, t.Name 
FROM Track t INNER JOIN PlaylistTrack pt ON t.TrackId = pt.TrackId 
             INNER JOIN Playlist p ON pt.PlaylistId = p.PlaylistId
WHERE p.Name = 'Music Videos')
    UNION
(SELECT t.TrackId, t.Name 
FROM Track t INNER JOIN PlaylistTrack pt ON t.TrackId = pt.TrackId 
             INNER JOIN Playlist p ON pt.PlaylistId = p.PlaylistId
WHERE p.Name = 'On-The-Go 1')
;

-- Outer Join

-- 4. Para cada track de género “Rock And Roll” muestre el nombre del track y 
-- la cantidad de invoice_lines en las que aparece, asegurándose de que 
-- si un track nunca estuvo en una factura se devuelva cero.

SELECT t.Name, COUNT(InvoiceLineId)
FROM Track t INNER JOIN Genre g ON g.GenreId = t.GenreId
             LEFT JOIN InvoiceLine il ON il.TrackId = t.TrackId
WHERE g.Name = 'Rock And Roll'
GROUP BY t.Name;

/* 1. Devolver los títulos de los álbumes */

SELECT Title 
FROM Album;

/* 2. Devolver la cantidad de facturas que tienen un total mayor o igual a 20.*/

SELECT COUNT(InvoiceId)
FROM Invoice
WHERE Total >= 20;

/* 3. Devolver la cantidad de facturas que existen en la base de datos y su valor total promedio.*/

SELECT COUNT(InvoiceId), AVG(Total)
FROM Invoice;

/* 4. Encontrar todos los tracks de la playlist cuyo id es 5, mostrando el nombre del track, su compositor y su precio.*/

SELECT t.Name, t.Composer, t.UnitPrice 
FROM PlaylistTrack p, Track t 
WHERE p.PlaylistId = 5 
AND p.TrackId = t.TrackId;

/* 5. Devolver las 5 facturas con mayor importe, mostrando el identificador de la factura, su importe, y el nombre del
usuario a quien se emitió cada factura. Ordenar los resultados en forma descendente por importe. */

SELECT i.InvoiceId, i.Total, c.FirstName, c.LastName
FROM Invoice i, Customer c
WHERE i.CustomerId = c.CustomerId
ORDER BY i.Total DESC
OFFSET 0 ROWS
FETCH FIRST 5 ROWS ONLY; 

/* 6. Encontrar el nombre y la duración de los 5 tracks con mayor duración de los que se conozca el compositor y que están en la playlist ‘Classical’ */

SELECT t.Name, Milliseconds  
FROM Track t, Playlist p, PlaylistTrack pt
WHERE pt.TrackId = t.TrackId 
    AND pt.PlaylistId = p.PlaylistId
    AND P.Name = 'Classical'
    AND t.Composer IS NOT NULL --?
ORDER BY Milliseconds
OFFSET 0 ROWS 
FETCH FIRST 5 ROWS ONLY;

/* 7. Obtener los nombres de los tracks, sus compositores, el álbum y el artista al que pertenecen de todos
aquellos tracks que están en facturas con fecha mayor a cuatro años. (4 años de antiguedad al menos ?) */

SELECT t.Name, Composer, Title, ar.Name
FROM Track t, Album al, Artist ar, Invoice i, InvoiceLine il
WHERE t.AlbumId = al.AlbumId 
    AND al.ArtistId = ar.ArtistId
    AND il.TrackId = t.TrackId
    AND i.InvoiceId = il.InvoiceId
    AND i.InvoiceDate < DATEADD(YEAR, -4, GETDATE())  -- DATEADD(interval, number, date)
;

-- Listar para cada track el nombre del mismo, el genero y el media_type

SELECT t.Name track, g.Name genero, mt.Name media_type  
FROM Track t INNER JOIN Genre g ON t.GenreId = g.GenreId
             INNER JOIN MediaType mt ON t.MediaTypeId = mt.MediaTypeId
;

-- Listar la cantidad de tracks que tiene cada genero

SELECT g.Name as genre, COUNT(t.TrackId) as tracks_genre
FROM Track t 
    RIGHT JOIN GENRE g ON t.GenreId = g.GenreId  
    -- RIGHT JOIN para asegurarnos que esten incluidos todos los generos, incluso aquellos que no tienen tracks
GROUP BY g.Name
;

-- Solución de catedra:
-- SELECT g.Name, COUNT(t.TrackId)
-- FROM Genre g
--     LEFT JOIN Track t ON g.GenreId = t.GenreId
-- GROUP BY g.GenreId, g.Name;

-- Obtener los artistas que no tienen álbumes. Dar al menos dos soluciones distintas

SELECT ar.Name
FROM Artist ar 
WHERE NOT EXISTS (
    SELECT *
    FROM Album al 
    WHERE al.ArtistId = ar.ArtistId);

(SELECT ar.Name 
FROM Artist ar)
    EXCEPT
(SELECT ar.Name
FROM Artist ar 
    INNER JOIN Album al ON ar.ArtistId = al.ArtistId);

-- Solucion de catedra
-- SELECT ar.*
-- FROM Artist ar 
--     LEFT OUTER JOIN Album al ON al.ArtistId = ar.ArtistId
-- WHERE al.AlbumId IS NULL;

-- SELECT ar.*
-- FROM Artist ar 
-- WHERE ar.ArtistId NOT IN (
--     SELECT DISTINCT ArtistId FROM Album
-- );

-- Listar el nombre y la cantidad de tracks de los artistas con más de 50 tracks, 
-- ordenado por cantidad de tracks de forma ascendente

SELECT ar.Name artist, COUNT(*) cant_track
FROM Track t
    INNER JOIN Album al ON t.AlbumId = al.AlbumId
    INNER JOIN Artist ar ON ar.ArtistId = al.ArtistId
GROUP BY ar.Name
HAVING COUNT(*) > 50  -- HAVING agrega restricciones a grupos
ORDER BY cant_track;

-- Para cada cliente obtener la cantidad de empleados que viven en la misma ciudad 
-- ordenados descendentemente por cantidad de empleados.

select C.CustomerId, count(E.EmployeeId) as Cant_Employee_City
from Customer C
    left outer join Employee E on -- incluyo todos los clientes, incluso los que no tienen empleados que vivan en la misma ciudad
        C.Country = E.Country and
        C.State = E.State and
        C.City = E.City
group by C.CustomerId   --- los clientes van a estar repetidos por cada empleado que viva en la misma ciudad
order by count(E.EmployeeId) desc;

-- Obtener el dinero recaudado por cada empleado durante cada año. 
-- ¿Cómo extraer un campo de una fecha? 
-- YEAR(), MONTH(), DAY() or Datepart(date, ...)

SELECT DATEPART(year, i.InvoiceDate) Año, e.LastName, SUM(i.Total) Recaudado 
FROM Employee e 
    INNER JOIN Customer c ON c.SupportRepId = e.EmployeeId
    INNER JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY YEAR(i.InvoiceDate), e.LastName

-- Obtener la cantidad de pistas de audio que tengan una duración superior 
-- a la duración promedio de todas las pistas de audio.
-- Además, obtener la sumatoria de la duración de todas esas pistas en minutos.

SELECT COUNT(t.TrackId) Longer_than_average, SUM(t.Milliseconds/(1000*60)) Average_duration_min -- /1000 para pasar de ms a s y luego /60 para pasar de s a min
FROM Track t
    INNER JOIN MediaType m ON t.MediaTypeId = m.MediaTypeId 
WHERE 
    m.Name LIKE '%audio%' AND  -- Debe ser una pista de audio
    t.Milliseconds > (
        SELECT AVG(t2.Milliseconds) 
        FROM Track t2
            INNER JOIN MediaType m2 ON t2.MediaTypeId = m2.MediaTypeId
        WHERE m2.Name LIKE '%audio%')

-- a. Crear una vista que devuelva las playlists que tienen al menos una pista del género “Rock”

-- Una vista SQL es una tabla virtual o una consulta almacenada que permite simplificar consultas complejas
-- No almacenan datos fisicamente, solo guardan la definición de consulta. 
-- CREATE VIEW view_name AS SELECT ... FROM ... WHERE;

IF OBJECT_ID('Playlists_Rock', 'V') IS NOT NULL 
    DROP VIEW Playlists_Rock
GO -- para evitar problemas con CREATE VIEW

CREATE VIEW Playlists_Rock AS 
SELECT p.PlaylistId, p.Name
FROM Playlist p 
WHERE EXISTS (SELECT *
    FROM Track t 
        INNER JOIN PlaylistTrack pt ON pt.TrackId = t.TrackId
        INNER JOIN Genre g ON t.GenreId = g.GenreId
    WHERE pt.PlaylistId = p.PlaylistId AND g.Name = 'Rock');

GO

-- b. Obtener de forma concisa la cantidad de playlists que no poseen pistas de dicho género.

SELECT COUNT(p.PlaylistId) Playlists_No_Rock
FROM Playlist p 
WHERE p.PlaylistId NOT IN (SELECT PlaylistId FROM Playlists_Rock)

-- Obtener las playlists más caras. (Ayuda: primero obtener el ‘precio’ de cada playlist)

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