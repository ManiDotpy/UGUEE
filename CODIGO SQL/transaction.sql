CREATE OR REPLACE FUNCTION aceptar_viaje(
  rutaId INT,
  conductorId INT,
  viajeId INT
) RETURNS VOID AS $$
DECLARE
  asientos INT;
BEGIN
  -- Verificar cuántos asientos disponibles hay en el viaje
  SELECT asientosDisponibles INTO asientos
  FROM viaje
  WHERE idViaje = viajeId
  FOR UPDATE;

  -- Validar si hay espacio
  IF asientos <= 0 THEN
    RAISE EXCEPTION 'No hay asientos disponibles en la ruta %', viajeId;
  END IF;

  -- Asignar conductor y ruta al viaje
  INSERT INTO rutaConductorViaje (idRuta, idConductor, idViaje)
  VALUES (rutaId, conductorId, viajeId);

  -- Cambiar estado del viaje a aceptado
  UPDATE viaje
  SET estadoDelViaje = 'aceptado'
  WHERE idViaje = viajeId;
END;
$$ LANGUAGE plpgsql;

