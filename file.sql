



CREATE TABLE empresas (
    id_empresa INT NOT NULL,
    nombre_empresa VARCHAR(100) NOT NULL,
    ciudad_empresa VARCHAR(100) NOT NULL,
    CONSTRAINT pk_empresas PRIMARY KEY (id_empresa),
    CONSTRAINT uk_empresas UNIQUE (nombre_empresa)
);
GO

INSERT INTO empresas VALUES (1, 'huellitas', 'arequipa'),
                            (2, 'mibanco', 'puno'),
                            (3, 'agrotour', 'lima'),
                            (4, 'kingmotors', 'juliaca');
GO

CREATE TABLE empleados (
    id_empleado INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    ciudad_empleado VARCHAR(100) NOT NULL,
    sueldo_empleado FLOAT NOT NULL,
    CONSTRAINT pk_empleados PRIMARY KEY (id_empleado),
    CONSTRAINT ck_empleados CHECK (sueldo_empleado > 0)
);
GO

INSERT INTO empleados VALUES (1, 'leon', 'av. torres', 'lima', 920.50),
                             (2, 'wilber', 'jr. lima', 'arequipa', 1050.60),
                             (3, 'hebert', 'av. torres', 'puno', 920.50),
                             (4, 'mario', 'jr. inca', 'juliaca', 1050.60),
                             (5, 'mary', 'av. floral', 'tacna', 950.20);
GO

CREATE TABLE jefes (
    id_jefe INT NOT NULL,
    nombre_jefe VARCHAR(100) NOT NULL,
    sueldo_jefe FLOAT NOT NULL,
    CONSTRAINT pk_jefes PRIMARY KEY (id_jefe),
    CONSTRAINT ck_jefes CHECK (sueldo_jefe > 0)
);
GO

INSERT INTO jefes VALUES (1, 'oscar', 1800.20),
                         (2, 'jose', 950.80);
GO

-- creamos una tabla que nos ayudara a la relacion de:
-- un jefe puede tener varios empleados
-- un empleado solo puede tener un jefe
-- el sueldo del empleado no puede ser superior al del jefe

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
GO

INSERT INTO jf VALUES (1, 1, 1, 1800.20, 920.50),
                      (2, 2, 3, 950.80, 920.50),
                      (3, 2, 5, 950.80, 950.20),
                      (4, 1, 2, 1800.20, 1050.60),
                      (5, 1, 4, 1800.20, 1050.60);
GO

-- tabla que nos ayudara a la relacion de:
-- un empleado trabaja en una sola empresa
-- una empresa pueden tener varios empleados
-- cada empleado trabaje para una empresa ubicada en su ciudad de residencia

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

INSERT INTO trabajos VALUES (1, 1, 'agrotour', 'lima', 'lima'),
                            (2, 2, 'huellitas', 'arequipa', 'arequipa'),
                            (3, 3, 'mibanco', 'puno', 'puno'),
                            (4, 4, 'kingmotors', 'juliaca', 'juliaca');
GO

-- NOTA: si intentamos agregar datos donde no se cumplan las restricciones 'check'
-- nos devolvera un error, actualmente estoy probando el codigo en un servicio
-- llamado: http://sqlfiddle.com/ donde puedo ejecutar codigo de sql - server
-- las capturas se realizaron de esta pagina - tuve problemas al instalar
-- sql server en windows

-- EJERCICIO ADICIONAL:
-- en su tabla estudiante del trabajo anterior, agregar el campo para imagen del
-- estudiante. Luego insertar una imagen

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
GO

INSERT INTO estudiantes VALUES 
    (1, 'leon', 'chipana', 174547, 12457885, 'leon@gmail.com', 'M', 'https://static.thenounproject.com/png/446003-200.png'),
    (2, 'heber', 'charca', 154544, 78855412, 'hebert@gmail.com', 'M', 'https://static.thenounproject.com/png/446003-200.png');
GO

-- se escogio el formato text para la columna de imagen por que generalmente
-- se almacena la imagen en un servicio externo y solamente se guarda la url
-- en la base de datos