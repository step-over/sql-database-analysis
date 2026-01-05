# Modelo Relacional

- Modelo Lógico Relacional
- Define a la base de datos como un conjunto de relaciones
- Una relación se puede pensar como una **tabla** con filas y columnas, y un nombre
    - Cada columna representa un atributo que toma valores atómicos
    - Cada fila o tupla representa un hecho que se corresponde con una entidad o interrelación del mundo real
- Cada relación tiene un esquema (intención, estructura) y una extensión (estado, instancia)
    - **R(A1,...,An)** es el esquema de la relación R con atributos A1,...,An
    - **r(R)** es la extensión de la relación R. es un conjunto de tuplas de valores de atributos (incluye el null)
- **Aridad:** cantidad de atributos que tiene la relación
- **Clave**: 
    - conjunto minimal de atributos que definen unívocamente a las tuplas
    - las relaciones pueden tener varias claves conocidas como **Claves Candidatas (CK)**
    - solamente una clave es **Clave Primaria (PK)**
    - **Claves Foraneas**: referencian a claves de otras relaciones
- **Esquema de una DB relacional**:
    - conjunto de esquemas de relación S 
    - conjunto de integrity constraints IC (restricciones)
- **Estado de una DB relacional**:
    - conjunto de estados de relación DB que satisface las constraints 
- **Integridad referencial**:
    - se definen restricciones adicionales entre dos relaciones para mantener consistencia en la base de datos
    - cuando la clave foranea de una relación referencia a la clave primaria de la otra

# Transformación del MER al MR

## Entidades
- Por cada entidad de un MER 
    - se define un esquema de relación en el modelo relacional de la forma Entidad(Atributos, FK) 
    - para cada esquema se especifica las claves candidatas (CK), primarias (PK) y foraneas (FK) en caso de existir
- En el caso de atributos compuestos se los transforma en atributos simples y se descarta la raíz
- En el caso de atributos multivaluados, se crea una nueva relación que se identifica con la PK de la entidad
- En el caso de entidades débiles, su clave primaria esta formada por la PK de la entidad fuerte asociada junto con su PK

## Interrelaciones
- En el caso de **interrelaciones 1:1** ... 
    - se incorpora la PK de una de las entidades como FK de la otra entidad
    - para el lugar de la FK, elegir aquel que minimice la cantidad de valores nulos (por ejemplo donde la participación sea total)
- En el caso de **interrelaciones 1:N** ...
    - se incorpora la PK de la entidad con cardinalidad 1 en la entidad con cardinalidad N como FK 
- En el caso de **interrelaciones N:M** ... 
    - se toma a la interrelación como otro esquema aparte con PK (puede incluir atributo identificatorio de la relación), CK (claves compuestas) y FK (PK de las entidades que relaciona)
- Para las **interrelaciones unarias** 
    - se tiene una sola entidad y se añade como FK la PK haciendo referencia a la interrelación
- Se establecen restricciones adicionales que hacen referencia a la participación en el MER

### Para las ternarias ...
- siempre se genera un esquema aparte para la interrelación
- la clave del esquema dependerá de la cardinalidad: 
    - en el caso que una entidad tenga una cardinalidad N, su PK debe pertenecer si o si al conjunto de claves posibles de la interrelación
    - para el caso de ternarias 1:1:1 se elige la clave primaria de todas las candidatas posible en base al relevamiento del problema

### Para las agregaciones ...
- se transforman considerando a la agregación como si fuera una entidad (se arma un esquema solo para la entidad no para la interrelación)
- tiene como FK las PK de las entidades de la agregación

## Jerarquias
- la PK de la superentidad funciona como PK y FK de las subentidades
- disjuntas: 
    - se agrega el discriminante como atributo a la entidad padre
    - no se genera un esquema para las subentidades que no tengan atributos ni relaciones 
- con solapamiento:
    - no se agrega el discriminante
    - se genera un esquema para todas las subentidades
