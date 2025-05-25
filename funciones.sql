CREATE OR REPLACE FUNCTION registrar_pasajero(
  idInstitucion INT,
  tipoDocumento VARCHAR,
  contrasena VARCHAR,
  fechaNacimiento DATE,
  correo VARCHAR,
  nombreCompleto VARCHAR,
  edad INT,
  telefono INT,
  calle VARCHAR,
  numeroCasa VARCHAR,
  ciudad VARCHAR,
  codigoEstudiantil INT,
  estatuto VARCHAR
) RETURNS VOID AS $$
DECLARE
  idUsuario INT;
BEGIN
  INSERT INTO usuario (
    idInstitucion, tipoDocumento, contrasena,
    fechaNacimiento, correo, nombreCompleto, edad,
    telefono, calle, numeroCasa, ciudad, codigoEstudiantil
  ) VALUES (
    idInstitucion, tipoDocumento, contrasena,
    fechaNacimiento, correo, nombreCompleto, edad,
    telefono, calle, numeroCasa, ciudad, codigoEstudiantil
  ) RETURNING nIdentificacion INTO idUsuario;

  INSERT INTO pasajero (
    idUsuario, estatuto, cantidadViajesTomados, estadoPasajero
  ) VALUES (
    idUsuario, estatuto, 0, 'pendiente'
  );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION registrar_conductor(
  idInstitucion INT,
  tipoDocumento VARCHAR,
  contrasena VARCHAR,
  fechaNacimiento DATE,
  correo VARCHAR,
  nombreCompleto VARCHAR,
  edad INT,
  telefono INT,
  calle VARCHAR,
  numeroCasa VARCHAR,
  ciudad VARCHAR,
  numeroDeLicencia INT,
  idVehiculo INT
) RETURNS VOID AS $$
DECLARE
  idUsuario INT;
BEGIN
  INSERT INTO usuario (
    idInstitucion, tipoDocumento, contrasena,
    fechaNacimiento, correo, nombreCompleto, edad,
    telefono, calle, numeroCasa, ciudad
  ) VALUES (
    idInstitucion, tipoDocumento, contrasena,
    fechaNacimiento, correo, nombreCompleto, edad,
    telefono, calle, numeroCasa, ciudad,codigoEstudiantil
  ) RETURNING nIdentificacion INTO idUsuario;

  INSERT INTO conductor (
    idUsuario, idVehiculo, numeroDeLicencia, estadoConductor, cantidadViajesRealizados
  ) VALUES (
    idUsuario, idVehiculo, numeroDeLicencia, 'pendiente', 0
  );
END;
$$ LANGUAGE plpgsql;


