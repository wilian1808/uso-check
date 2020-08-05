CREATE TABLE empresas (
    id_empresa INT NOT NULL,
    nombre_empresa VARCHAR(100) NOT NULL,
    ciudad_empresa VARCHAR(100) NOT NULL,
    CONSTRAINT pk_empresas PRIMARY KEY (id_empresa),
    CONSTRAINT uk_empresas UNIQUE (nombre_empresa)
);

CREATE TABLE empleados (
    id_empleado INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    ciudad_empleado VARCHAR(100) NOT NULL,
    sueldo_empleado FLOAT NOT NULL,
    CONSTRAINT pk_empleados PRIMARY KEY (id_empleado),
    CONSTRAINT ck_empleados CHECK (sueldo_empleado > 0)
);

CREATE TABLE jefes (
    id_jefe INT NOT NULL,
    nombre_jefe VARCHAR(100) NOT NULL,
    sueldo_jefe FLOAT NOT NULL,
    CONSTRAINT pk_jefes PRIMARY KEY (id_jefe),
    CONSTRAINT ck_jefes CHECK (sueldo_jefe > 0)
);

CREATE TABLE jf (
    id_je INT NOT NULL,
    id_jefe INT,
    id_empleado INT,
    sueldo_jefe FLOAT NOT NULL,
    sueldo_empleado FLOAT NOT NULL,
    CONSTRAINT pk_je PRIMARY KEY (id_je),
    CONSTRAINT fk_je_jefes_id FOREIGN KEY (id_jefe) REFERENCES jefes (id_jefe)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_je_empleados_id FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
        ON DELETE CASCADE ON UPDATE CASCADE,
    -- comprueba que el sueldo del jefe es mayor al empleado
    CONSTRAINT ck_jf CHECK (sueldo_jefe > sueldo_empleado)
);

CREATE TABLE trabajos (
    id_trabajo INT NOT NULL,
    id_empleado INT,
    nombre_empresa VARCHAR(100),
    ciudad_empresa VARCHAR(100) NOT NULL,
    ciudad_empleado VARCHAR(100) NOT NULL
    CONSTRAINT pk_trabajos PRIMARY KEY (id_trabajo),
    CONSTRAINT fk_empleados_trabajos FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_empresas_trabajos FOREIGN KEY (nombre_empresa) REFERENCES empresas (nombre_empresa)
        ON DELETE CASCADE ON UPDATE CASCADE,
    -- se asegura que la ciudad del empleado sea igual a la ciudad de la empresa
    CONSTRAINT ck_trabajos CHECK (ciudad_empleado = ciudad_empresa)
);


-- EJERCICIO ADICIONAL:
-- en su tabla estudiante del trabajo anterior, agregar el campo para imagen del
-- estudiante. Lu insertar una imagen

CREATE TABLE estudiantes (
    id_estudiante INT NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    numero_matricula INT NOT NULL, -- restriccion de formato - unico
    dni INT NOT NULL, -- restriccion de formato - unico
    correo VARCHAR(100) NOT NULL, -- restriccion de formato - unico
    sexo VARCHAR(10) NOT NULL,
    img TEXT NOT NULL,
    CONSTRAINT pk_estudiantes PRIMARY KEY (id_estudiante),
    CONSTRAINT uk_nmatricula_estudiantes UNIQUE (numero_matricula),
    CONSTRAINT ck_nmatricula_estudiantes CHECK (numero_matricula > 0),
    CONSTRAINT uk_dni_estudiantes UNIQUE (dni),
    CONSTRAINT ck_dni_estudiantes CHECK (dni > 0),
    CONSTRAINT uk_correo_estudiantes UNIQUE (correo)
);

INSERT INTO estudiantes VALUES 
    (1, 'leon', 'chipana', 174547, 12457885, 'leon@gmail.com', 'M', 'https://static.thenounproject.com/png/446003-200.png'),
    (2, 'heber', 'charca', 154544, 78855412, 'hebert@gmail.com', 'M', 'https://static.thenounproject.com/png/446003-200.png');
