---Tabla institucion
CREATE TABLE institucion(
	idInstitucion INT PRIMARY KEY,
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
CREATE TABLE monitor(
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
	nIdentificacion INT PRIMARY KEY,
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
	urlAvatar TEXT,
	FOREIGN KEY (idInstitucion) REFERENCES institucion(idInstitucion)
		ON DELETE CASCADE
);

--tabla_monitor_usuario
CREATE TABLE monitorusuario(
	idAdmin INT,
	idUsuario INT,
	estadoUsuario VARCHAR(60) NOT NULL DEFAULT 'pendiente',
	descripcion TEXT,
	fechaRevision TIMESTAMP NOT NULL,
	PRIMARY KEY(idAdmin, idUsuario),
	FOREIGN KEY (idAdmin) REFERENCES administrador(idAdmin)
		ON DELETE SET NULL,
	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
		ON DELETE CASCADE
);

-- tabla url_lmg_documento_usuario
CREATE TABLE urllmgDocumentoUsuario(
	idDocumentoUsuario SERIAL PRIMARY KEY,
	idUsuario INT,
	urllmgDocumento TEXT NOT NULL,
	nombreDocumento VARCHAR(60) NOT NULL,
	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
		ON DELETE CASCADE
);

-- tabla PQRS
CREATE TABLE PQRS(
	idPQRS SERIAL PRIMARY KEY,
	idUsuario INT,
	tipoPQRS VARCHAR(60),
	descripcion TEXT,
	fecha TIMESTAMP NOT NULL,
	latitud DECIMAL(9,6),
	longitud DECIMAL(9,6),
	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
		ON DELETE SET NULL
);

--tabla viaje
CREATE TABLE viaje(
	idViaje SERIAL PRIMARY KEY,
	tiempoDeSalida TIMESTAMP NOT NULL,
	tiempoDeLlegada TIMESTAMP,
	duracionViajeHoras NUMERIC(5,2),
	estadoDelViaje VARCHAR(60) NOT NULL DEFAULT 'en curso',
	asientosDisponibles INT NOT NULL,
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
	CHECK(puntuacionViaje BETWEEN 0 AND 5),
	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
		ON DELETE SET NULL,
	FOREIGN KEY (idViaje) REFERENCES viaje(idViaje)
		ON DELETE CASCADE
);

-- tabla pasajero
Create TABLE pasajero(
	idUsuario INT PRIMARY KEY,
	estatuto VARCHAR(60) NOT NULL,
	cantidadViajesTomados INT NOT NULL,
	estadoPasajero VARCHAR(60) DEFAULT 'pendiente',
	FOREIGN KEY (idUsuario) REFERENCES usuario(nIdentificacion)
		ON DELETE CASCADE
);

-- tabla vehiculo
CREATE TABLE vehiculo(
	idVehiculo SERIAL PRIMARY KEY,
	color VARCHAR(60) NOT NULL,
	numeroAsientos INT NOT NULL,
	modelo VARCHAR(60) NOT NULL,
	marca VARCHAR(60) NOT NULL
);

--tabla url_lmg_documento_vehiculo
CREATE TABLE urllmgDocumentoVehiculo(
	idDocumentoVehiculo SERIAL PRIMARY KEY,
	idVehiculo INT,
	urllmgDocumento TEXT NOT NULL,
	nombreDocumento VARCHAR(60) NOT NULL,
	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
		ON DELETE CASCADE
);

-- tabla conductor
CREATE TABLE conductor(
	idUsuario INT PRIMARY KEY,
	idVehiculo INT,
	numeroDeLicencia INT NOT NULL,
	estadoConductor VARCHAR(60) NOT NULL DEFAULT 'pendiente',
	cantidadViajesRealizados INT NOT NULL,
	estatuto VARCHAR(60) NOT NULL,
	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
		ON DELETE SET NULL
);

--tabla pasajero_viaje
CREATE TABLE pasajeroViaje(
	idPasajero INT PRIMARY KEY,
	idViaje INT,
	checkviaje BOOLEAN NOT NULL DEFAULT FALSE,
	FOREIGN KEY (idPasajero) REFERENCES pasajero(idUsuario)
		ON DELETE SET NULL,
	FOREIGN KEY (idViaje) REFERENCES viaje(idViaje)
		ON DELETE CASCADE
);

--tabla ruta
CREATE TABLE ruta(
	idRuta SERIAL PRIMARY KEY,
	idVehiculo INT,
	salidaLatitud DECIMAL(9,6) NOT NULL,
	salidaLongitud DECIMAL(9,6) NOT NULL,
	paradaLatitud DECIMAL(9,6) NOT NULL,
	paradaLongitud DECIMAL(9,6) NOT NULL,
	distancia NUMERIC(6,2) NOT NULL,
	horaDeSalida TIME NOT NULL,
	fecha DATE NOT NULL,
	tipoDeRuta VARCHAR(60) NOT NULL,
	estado VARCHAR(60) NOT NULL DEFAULT 'disponible',
	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
		ON DELETE SET NULL
);

--tabla ruta_conductor_viaje
CREATE TABLE rutaConductorViaje(
	idRuta INT,
	idConductor INT,
	idViaje INT,
	PRIMARY KEY(idRuta, idConductor,idviaje),
	FOREIGN KEY (idRuta) REFERENCES ruta(idRuta)
		ON DELETE CASCADE,
	FOREIGN KEY (idConductor) REFERENCES conductor(idUsuario)
		ON DELETE CASCADE,
	FOREIGN KEY (idViaje) REFERENCES viaje(idViaje)
		ON DELETE SET NULL
);

--tabla vehiculo_ligero
CREATE TABLE vehiculoLigero(
	idVehiculo INT PRIMARY KEY,
	nSerie TEXT NOT NULL UNIQUE,
	tipo VARCHAR(60) NOT NULL,
	FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
		ON DELETE CASCADE
);

--tabla vehiculo_pesado
CREATE TABLE vehiculoPesado(
    idVehiculo INT PRIMARY KEY,
    placa CHAR(6) NOT NULL UNIQUE, 
    categoriaViaje VARCHAR(60) NOT NULL,
    tipoVehiculo VARCHAR(60) NOT NULL,
    categoria VARCHAR(60) NOT NULL,
    fechaVenTecno DATE NOT NULL,
    fechaVenSOAT DATE NOT NULL,
    FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
        ON DELETE CASCADE
);

-- Función y trigger para garantizar exclusividad
CREATE OR REPLACE FUNCTION verificar_exclusividad_vehiculo()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM vehiculoLigero WHERE idVehiculo = NEW.idVehiculo) AND
       EXISTS (SELECT 1 FROM vehiculoPesado WHERE idVehiculo = NEW.idVehiculo) THEN
        RAISE EXCEPTION 'Un vehículo no puede ser ligero y pesado al mismo tiempo';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers 
CREATE TRIGGER trigger_exclusividad_ligero
BEFORE INSERT OR UPDATE ON vehiculoLigero
FOR EACH ROW EXECUTE FUNCTION verificar_exclusividad_vehiculo();

CREATE TRIGGER trigger_exclusividad_pesado
BEFORE INSERT OR UPDATE ON vehiculoPesado
FOR EACH ROW EXECUTE FUNCTION verificar_exclusividad_vehiculo();






