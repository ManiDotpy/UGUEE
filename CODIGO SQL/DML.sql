
--EJEMPLOS DE SCRIPTS PARA PROBAR LOS DATOS DE LAS TABLAS

INSERT INTO institucion (nombre, colorPrincipal, colorSecundario, urllmgLogo, sede, calle, numeroLugar, ciudad, correo, estado)
VALUES (
    'Universidad Tecnológica Nacional', 
    '#0056b3', 
    '#ffcc00', 
    'https://www.utn.edu.ar/images/logo-utn.png', 
    'Sede Central', 
    'Av. Medrano', 
    '951', 
    'Buenos Aires', 
    'contacto@utn.edu.ar', 
    'activo'
);

INSERT INTO institucion (nombre, colorPrincipal, colorSecundario, urllmgLogo, sede, calle, numeroLugar, ciudad, correo, estado)
VALUES (
    'Instituto Superior de Formación Docente', 
    '#8b0000', 
    '#ffffff', 
    'https://www.isfd.edu.ar/logo.png', 
    'Sede Norte', 
    'Calle Principal', 
    '123', 
    'Córdoba', 
    'admin@isfd.edu.ar', 
    'activo'
);

INSERT INTO monitor (idInstitucion, contrasena, nombreCompleto, correo)
VALUES (
    1, 
    'hashed_password_123', 
    'Juan Pérez', 
    'juan.perez@utn.edu.ar'
);

INSERT INTO monitor (idInstitucion, contrasena, nombreCompleto, correo)
VALUES (
    1, 
    'hashed_password_456', 
    'María González', 
    'maria.gonzalez@utn.edu.ar'
);

INSERT INTO monitor (idInstitucion, contrasena, nombreCompleto, correo)
VALUES (
    2, 
    'hashed_password_789', 
    'Carlos Rodríguez', 
    'carlos.rodriguez@isfd.edu.ar'
);

INSERT INTO monitor (idInstitucion, contrasena, nombreCompleto, correo)
VALUES (
    2, 
    'hashed_password_012', 
    'Ana Martínez', 
    'ana.martinez@isfd.edu.ar'
);

INSERT INTO urlDocumentoInstitucion (idInstitucion, urlDocumento, nombreDocumento)
VALUES (
    1, 
    'https://www.utn.edu.ar/docs/acreditacion.pdf', 
    'Certificado de Acreditación'
);

INSERT INTO urlDocumentoInstitucion (idInstitucion, urlDocumento, nombreDocumento)
VALUES (
    1, 
    'https://www.utn.edu.ar/docs/reglamento.pdf', 
    'Reglamento Institucional'
);

INSERT INTO urlDocumentoInstitucion (idInstitucion, urlDocumento, nombreDocumento)
VALUES (
    2, 
    'https://www.isfd.edu.ar/docs/acreditacion.pdf', 
    'Certificado de Acreditación'
);

INSERT INTO urlDocumentoInstitucion (idInstitucion, urlDocumento, nombreDocumento)
VALUES (
    2, 
    'https://www.isfd.edu.ar/docs/convenio.pdf', 
    'Convenio Marco'
);

-- Usuario 1 (Pendiente)
INSERT INTO usuario (idInstitucion, tipoDocumento, contrasena, fechaNacimiento, correo, nombreCompleto, edad, telefono, calle, numeroCasa, ciudad)
VALUES (
    1, 
    'DNI', 
    'hashed_pass_001', 
    '2000-05-15', 
    'estudiante1@utn.edu.ar', 
    'Laura Sánchez', 
    23, 
    1122334455, 
    'Calle Falsa', 
    '123', 
    'Buenos Aires'
);

-- Usuario 2 (Pendiente)
INSERT INTO usuario (idInstitucion, tipoDocumento, contrasena, fechaNacimiento, correo, nombreCompleto, edad, telefono, calle, numeroCasa, ciudad)
VALUES (
    1, 
    'DNI', 
    'hashed_pass_002', 
    '1999-08-22', 
    'estudiante2@utn.edu.ar', 
    'Pedro Gómez', 
    24, 
    1122334466, 
    'Avenida Siempreviva', 
    '742', 
    'Buenos Aires'
);

-- Usuario 3 (Aceptado)
INSERT INTO usuario (idInstitucion, tipoDocumento, contrasena, fechaNacimiento, correo, nombreCompleto, edad, telefono, calle, numeroCasa, ciudad, codigoEstudiantil)
VALUES (
    1, 
    'DNI', 
    'hashed_pass_003', 
    '2001-03-10', 
    'estudiante3@utn.edu.ar', 
    'Marta Rodríguez', 
    22, 
    1122334477, 
    'Calle Verdadera', 
    '456', 
    'Buenos Aires',
    10001
);

-- Usuario 4 (Aceptado)
INSERT INTO usuario (idInstitucion, tipoDocumento, contrasena, fechaNacimiento, correo, nombreCompleto, edad, telefono, calle, numeroCasa, ciudad, codigoEstudiantil)
VALUES (
    1, 
    'Pasaporte', 
    'hashed_pass_004', 
    '1998-11-30', 
    'estudiante4@utn.edu.ar', 
    'Carlos Fernández', 
    25, 
    1122334488, 
    'Boulevard Los Álamos', 
    '789', 
    'Buenos Aires',
    10002
);

-- Pasajero 1 (Pendiente)
INSERT INTO pasajero (idUsuario, estatuto, cantidadViajesTomados, estadoPasajero)
VALUES (
    (SELECT nIdentificacion FROM usuario WHERE correo = 'estudiante1@utn.edu.ar'),
    'Estudiante',
    0,
    'pendiente'
);

-- Pasajero 2 (Pendiente)
INSERT INTO pasajero (idUsuario, estatuto, cantidadViajesTomados, estadoPasajero)
VALUES (
    (SELECT nIdentificacion FROM usuario WHERE correo = 'estudiante2@utn.edu.ar'),
    'Estudiante',
    0,
    'pendiente'
);

-- Pasajero 3 (Aceptado)
INSERT INTO pasajero (idUsuario, estatuto, cantidadViajesTomados, estadoPasajero)
VALUES (
    (SELECT nIdentificacion FROM usuario WHERE correo = 'estudiante3@utn.edu.ar'),
    'Estudiante',
    5,
    'activo'
);

-- Pasajero 4 (Aceptado)
INSERT INTO pasajero (idUsuario, estatuto, cantidadViajesTomados, estadoPasajero)
VALUES (
    (SELECT nIdentificacion FROM usuario WHERE correo = 'estudiante4@utn.edu.ar'),
    'Docente',
    12,
    'activo'
);

-- Marta Rodríguez fue aceptada por Juan Pérez
INSERT INTO monitorusuario (idAdmin, idUsuario, estadoUsuario, descripcion, fechaRevision)
VALUES (
    (SELECT idAdmin FROM administrador WHERE correo = 'juan.perez@utn.edu.ar'),
    (SELECT nIdentificacion FROM usuario WHERE correo = 'estudiante3@utn.edu.ar'),
    'aceptado',
    'Estudiante regular con documentos en orden',
    '2023-10-15 14:30:00'
);

-- Carlos Fernández fue aceptado por María González
INSERT INTO monitorusuario (idAdmin, idUsuario, estadoUsuario, descripcion, fechaRevision)
VALUES (
    (SELECT idAdmin FROM administrador WHERE correo = 'maria.gonzalez@utn.edu.ar'),
    (SELECT nIdentificacion FROM usuario WHERE correo = 'estudiante4@utn.edu.ar'),
    'aceptado',
    'Docente de la facultad de ingeniería',
    '2023-09-20 11:15:00'
);
