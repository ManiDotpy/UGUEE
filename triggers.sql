CREATE OR REPLACE FUNCTION disminuir_asientos() RETURNS TRIGGER AS $$
BEGIN
  UPDATE viaje
  SET asientosDisponibles = asientosDisponibles - 1
  WHERE idRuta = (SELECT idRuta FROM rutaConductorViaje WHERE idViaje = NEW.idViaje LIMIT 1);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_disminuir_asientos
AFTER INSERT ON pasajeroViaje
FOR EACH ROW
EXECUTE FUNCTION disminuir_asientos();

