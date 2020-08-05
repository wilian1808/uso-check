# TAREA SOBRE EL USO DEL CHECK

considerando la siguiente base de datos relacional.

> Tabla `Empleados`.

| EmpleadoID | Nombres | Calle | CiudadEmpleado | SueldoEmpleado |
| ---------- | ------- | ----- | ------ | ------ |

> Tabla `Trabajos`.

| TrabajoID | EmpleadoID | Nombre | CiudadEmpresa | CiudadEmpleado |
| --------- | ---------- | ------ | ------------- | -------------- |

> Tabla `Empresas`.

| EmpresaID | Nombre | CiudadEmpresa |
| --------- | ------ | ------------- |

> Tabla `Jefes`.

| JefeID | Nombre | SueldoJefe |
| ------ | ------ | ---------- |


### 2. Ejercicio adicional.

En su tabla `Estudiantes` del trabajo anterior, agregar el campo para la imagen del estudiante, insertar su imagen.

Podemos encontrar la tabla en el siguiente enlace:

- [Tabla estudiantes](https://github.com/wilian1808/restricciones-integridad#1-primero)

> Para poder insertar una imagen en la base de dato se agrego una nueva columna llamada *Imagen* de formato texto, se escogio este formato ya que las imagenes se guardan en servicios externos y lo unico que se inserta en las bases de datos son las urls de donde se encuentra almacenada nuestra imagen. Como estamos alterando una tabla ya existente para que los estudiantes no esten con una imagen en blanco definimos un valor por defecto.

```sql
ALTER TABLE Estudiantes 
    ADD COLUMN Imagen TEXT NOT NULL 
    DEFAULT 'https://www.rastreator.com/wp-content/uploads/106-300x300.jpg'
```

> Ahora procedemos a actualizar los valores de la imagen para cada estudiante segundo correspondan su id.

```sql
UPDATE Estudiantes 
    SET Imagen = 'https://i.pinimg.com/474x/b0/33/6d/b0336de8b6ca431d44e0ad5ed76b1dd8.jpg'
    WHERE EstudianteID = 1;

UPDATE Estudiantes 
    SET Imagen = 'https://i.pinimg.com/474x/b0/33/6d/b0336de8b6ca431d44e0ad5ed76b1dd8.jpg'
    WHERE EstudianteID = 2;
```
