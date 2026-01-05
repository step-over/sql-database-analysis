# Bases de Datos    

### SQL
- ***Structured Query Language***
- Lenguaje standard de base de datos
- Descriptivo
- Para **bases de datos relacionales**: información organizada en tablas (relaciones) donde las columnas representan atributos y cada fila una entidad.
- Permite insertar, buscar, actualizar y buscar datos.

### Bases de Datos
- **Datos**: registro de cosas que existen o han sucedido y tienen un significado implícito. 
- Colección de datos relacionados y organizados, con un significado que depende del dominio de aplicación. 
- Software que permite procesar los datos a la misma velocidad de la RAM (RAM infinita)
- Mutable

El **mundo real** es modelado por **modelo de datos** que mapea a **base de datos** administrada por **DBMSs** ***(Database Management System)*** que implementa el modelo de datos. 

El modelo conecta los datos del mundo real con lo que se almacena en la base de datos. 

### Características
- **ACID**: 
    - Atomicity, Consistency, Isolation, Durability
    - propiedades que garantizan la fiabilidad e integridad de las operaciones que se realizan en una base de datos
- Distribuidas
- Documentales
- Veloces
- Resilientes: 
    - la resiliencia de datos es la capacidad de una organización para proteger, mantener y recuperarse ante fallos

**Clave primaria**
- Usos:
    - identificar un elemento dentro de la BD
    - relacionar distintos elementos dentro de la BD
    - relacionar elementos externos de la BD como elementos físicos, dispositivos móviles, bases de datos distribuidas
- por cada elemento del conjunto se espera que sea:
    - única (inconcebible, con poca probabilidad de colisión)
    - siempre debe existir
    - conocida
    - inmutable
    - clave natural (por ejemplo la patente del auto. es preferible usar esto antes que inventar una nueva clave)

En la materia nos basaremos en Logical Relational Design Methodology (LRDM) para diseñar DB Relaciones. Los pasos son:
1. Construcción del Modelo Entidad Relación a partir de los Requerimientos
2. Transformación del Modelo Entidad Relación a Relaciones
3. Normalización de las relaciones
4. Construcción física