# SQL
- Structured Query Languaje: lenguaje estructurado de consulta
- permite la consulta de una base de datos, modificar su estructura, crear estructuras y determinar reglas de seguridad e integridad.

# Statements

## DDL: Data Definition Language
- Permiten crear/modificar/borrar estructuras de datos

- Creación de tablas:  
```
CREATE TABLE <table_name> (  
    <column_name> <type> [<default value>] [<column constraints>],  
    : : :  
    <column_name> <type> [<default value>] [<column constraints>],  
    : : :
    <table constraint>
);
```