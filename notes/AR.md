# Algebra Relacional
- lenguaje formal de consultas para recuperar datos almacenados en un modelo relacional
- procedural: se detallan las operaciones
- las consultas reciben como entrada una o dos instancias de relación y devuelven una instancia de relación
- las consultas se pueden representar en **árboles canonicos**: los nodos internos representan las operaciones del AR y las hojas, las relaciones originales sobre las que actúan las operaciones

## Operaciones
- Se pueden secuenciar operaciones con operaciones intermedias (renombres)

### Unarias

- **Proyección π**: <code>π<sub>\<lista de atributos\></sub>(R)</code>
    - permite recuperar algunos atributos de una relación R
    - devuelve una nueva relación que contiene un subconjunto vertical de R (columnas) y eliminando duplicados
- **Selección σ**: <code>σ<sub>\<predicado\></sub>(R)</code>
    - permite recuperar algunas filas de una relación
    - define una nueva relación que contiene únicamente aquellas tuplas de R que satisfacen el predicado
- **Renombre ρ**: 
    - de atributos: <code>ρ(viejoA -> nuevoA, R)</code> 
    - de relaciones

### Binarias
- <ins>De conjunto</ins>:
    - Solo posibles si las relaciones son unión compatibles: misma cantidad de atributos y mismo dominio atributo a atributo
    - **Unión**: <code>R ∪ S</code>
        - incluye a las tuplas que están en la primera relación, en la segunda, o en ambas, eliminando tuplas duplicadas
    - **Intersección**: <code>R ∩ S</code> 
        - incluye a las tuplas que están en ambas relaciones
    - **Resta**: <code>R − S</code> 
        - incluye a las tuplas que están en R pero no es S

- <ins>De combinación</ins>:
    - **Producto Cartesiano**: <code>R × S</code>
        - cada elemento es la concatenación de cada tupla de R con cada tupla de S
    - **Theta join**: <code>R ⋈ <sub>\<predicado></sub> S</code>
        - contiene las tuplas del producto cartesiano que cumplen con predicado
    - **Equijoin**: <code>R ⋈ <sub>\<predicado></sub> S</code>
        - el predicado está compuesto de comparaciones de igualdad
    - **Natural Join**: <code>R ⋈ S</code>
        - combina las tuplas de dos relaciones que cumplen que todos los atributos de mismo nombre tienen igual valor
    - **Right Outer Join**: <code>R <span style="font-size: 2em;">⟖</span> S</code>
        - conserva todas las tuplas de S y las combina con las de R (si hay atributos que no matchean se completa con null)
    - **Left Outer Join**: <code>R <span style="font-size: 2em;">⟕</span> S</code>
        - conserva todas las tuplas de R y las combina con las de S (se completa con null si no hay match)
    - **Full Outer Join**: <code>R <span style="font-size: 2em;">⟗</span> S</code>
        - conserva todas las tuplas de ambas y se completa con null si no hay JOIN
    - **División**: `R(Z) ÷ S(X)`
        - sea Y el conjunto de atributos de R tal que Y = Z-X (los que no están en S)
        - la división es una relación T(Y) con tuplas t tal que ...
        -  t ∈ π<sub>Y</sub> (R) (la tupla aparece en R)
        - y para toda tupla t<sub>S</sub> ∈ S hay una tupla t<sub>R</sub> ∈ R tal que t<sub>R</sub>[S] = t<sub>S</sub>[S] y t<sub>R</sub>[R − S] = t (para cada valor de X en S, la combinación (Y,X) está en R)