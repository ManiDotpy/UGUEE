---Tabla institucion
CREATE TABLE institucion(
 	idInstitucion SERIAL PRIMARY KEY,
  	nombre VARCHAR(60) NOT NULL,
  	colorPrincipal VARCHAR(60) NOT NULL,
  	colorSecundario VARCHAR(60),
  	urllmgLogo TEXT NOT NULL,
  	sede VARCHAR(60) NOT NULL,
  	calle VARCHAR(60) NOT NULL,
  	numeroLugar VARCHAR(60) NOT NULL,
  	ciudad	VARCHAR(60) NOT NULL,
  	correo VARCHAR(60) UNIQUE NOT NULL,
	estado VARCHAR(60) NOT NULL DEFAULT 'pendiente'
);
-- Tabla url_documento_institucion
CREATE TABLE urlDocumentoInstitucion(
  idDocumentoInstitucion SERIAL PRIMARY KEY,
  idInstitucion INT,
  urlDocumento TEXT NOT NULL,
  nombreDocumento VARCHAR(60) NOT NULL,
  FOREIGN KEY (idInstitucion) REFERENCES institucion(idInstitucion)
  	ON DELETE CASCADE
);

-- tabla Admin (admin es palabra registrada asi que administrador)
CREATE TABLE administrador(
  idAdmin SERIAL PRIMARY KEY,
  idInstitucion INT,
  contrasena VARCHAR(60) NOT NULL,
  nombreCompleto VARCHAR(60) NOT NULL,
  correo VARCHAR(60) UNIQUE NOT NULL,
   FOREIGN KEY (idInstitucion) REFERENCES institucion(idInstitucion)
  	ON DELETE CASCADE
);

--tabla usuario
CREATE TABLE usuario(
	nIdentificacion SERIAL PRIMARY KEY,
  	idInstitucion INT,
  	tipoDocumento VARCHAR(60) NOT NULL,
  	contrasena VARCHAR(60) NOT NULL,
  	fechaNacimiento DATE NOT NULL,
  	correo VARCHAR(60) UNIQUE,
  	nombreCompleto VARCHAR(60) NOT NULL,
  	edad INT NOT NULL,
  	telefono INT UNIQUE NOT NULL,
  	calle VARCHAR(60) NOT NULL,
  	numeroCasa VARCHAR(60) NOT NULL,
  	ciudad VARCHAR(60) NOT NULL,
  	codigoEstudiantil INT,
  FOREIGN KEY (idInstitucion) REFERENCES institucion(idInstitucion)
  ON DELETE CASCADE
  
);

--tabla_admin_usuario
CREATE TABLE adminUsuario(
	idAdmin INT,
  	idUsuario INT,
  	estadoUsuario VARCHAR(60) NOT NULL DEFAULT 'pendiente',
  	descripcion TEXT,
  	fechaRevision TIMESTAMP NOT NULL,
  PRIMARY KEY(idAdmin, idUsuario),
  FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
  on delete set NULL,
  FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
  on delete CASCADE
);

-- tabla url_lmg_documento_usuario
CREATE TABLE urllmgDocumentoUsuario(
  idDocumentoUsuario SERIAL PRIMARY KEY,
  idUsuario INT,
  urllmgDocumento TEXT,
  nombreDocumento VARCHAR(60),
  FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
  on DELETE CASCADE
  ON UPDATE CASCADE
);

-- tabla PQRS
CREATE TABLE PQRS(
	idPQRS SERIAL PRIMARY KEY,
  	idUsuario INT,
  	tipoPQRS VARCHAR(60),
  	descripcion TEXT,
  	fecha VARCHAR(60),
  	latitud DECIMAL(9,6),
  	longitud DECIMAL(9,6),
  	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
  	ON UPDATE CASCADE
);

--tabla viaje
CREATE TABLE viaje(
	idViaje SERIAL PRIMARY KEY,
  	tiempoDeSalida TIMESTAMP,
  	tiempoDeLlegada TIMESTAMP,
  	duracionViajeHoras NUMERIC(5,2),
  	estadoDelViaje VARCHAR(60),
  	ubicacionActualLatitud DECIMAL(9,6),
  	ubicacionActualLongitud DECIMAL(9,6)
);

--tabla calificación
CREATE TABLE calificacion(
	idCalificacion SERIAL PRIMARY KEY,
  	idUsuario INT,
  	idViaje INT,
  	comentario TEXT,
  	puntuacionViaje INT,
  	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion),
  	FOREIGN KEY (idViaje) REFERENCES viaje(idViaje)

);

-- tabla pasajero
Create TABLE pasajero(
	idUsuario INT PRIMARY KEY,
  	estatuto VARCHAR(60),
  	cantidadViajesTomados INT,
  	estadoPasajero VARCHAR(60) DEFAULT 'pendiente',
  	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
  	ON DELETE CASCADE
);

-- tabla vehiculo
CREATE TABLE vehiculo(
	idVehiculo SERIAL PRIMARY KEY,
  	color VARCHAR(60),
  	numeroAsientos INT,
  	modelo VARCHAR(60),
  	marca VARCHAR(60)
  
);

--tabla url_lmg_documento_vehiculo
CREATE TABLE urllmgDocumentoVehiculo(
	idDocumentoVehiculo SERIAL PRIMARY KEY,
  	idVehiculo INT,
  	urllmgDocumento TEXT,
  	nombreDocumento VARCHAR(60),
  	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
  	
);

-- tabla conductor
CREATE TABLE conductor(
	idUsuario INT PRIMARY KEY,
  	idVehiculo INT,
  	numeroDeLicencia INT,
  	estadoConductor VARCHAR(60) DEFAULT 'pendiente',
  	cantidadViajesRealizados INT,
  	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
);

--tabla pasajero_viaje
CREATE TABLE pasajeroViaje(
	idPasajero INT PRIMARY KEY,
  	idViaje INT,
  	FOREIGN KEY (idPasajero) REFERENCES pasajero(idUsuario),
  	FOREIGN KEY (idViaje) REFERENCES viaje(idViaje)
);

--tabla ruta
CREATE TABLE ruta(
	idRuta SERIAL PRIMARY KEY,
  	idVehiculo INT,
  	salidaLatitud DECIMAL(9,6),
  	salidaLongitud DECIMAL(9,6),
  	paradaLatidud DECIMAL(9,6),
  	paradaLongitud DECIMAL(9,6),
  	distancia NUMERIC(6,2),
  	horaDeSalida TIME,
  	fecha DATE,
  	tipoDeRuta VARCHAR(60),
  	estado VARCHAR(60) DEFAULT '',
  	asientosDisponibles INT
);

--tabla ruta_conductor_viaje
CREATE TABLE rutaConductorViaje(
	idRuta INT,
  	idConductor INT,
  	idViaje INT,
  	PRIMARY KEY(idRuta, idConductor),
  	FOREIGN KEY (idRuta) REFERENCES ruta(idRuta),
  	FOREIGN KEY (idConductor) REFERENCES conductor(idUsuario),
  	FOREIGN KEY (idViaje) REFERENCES viaje(idViaje)
);

--tabla vehiculo_ligero
CREATE TABLE vehiculoLigero(
	idVehiculo INT PRIMARY KEY,
  	nSerie TEXT,
  	tipo VARCHAR(60),
  	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
);

--tabla vehiculo_pesado
Create TABLE vehiculoPesado(
	idVehiculo INT PRIMARY KEY,
  	placa CHAR(6),
  	categoriaViaje VARCHAR(60),
  	tipoVehiculo VARCHAR(60),
  	categoria VARCHAR(60),
  	fechaVenTecno DATE,
  	fechaVenSOAT DATE,
  	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
);








