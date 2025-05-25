CREATE OR REPLACE VIEW resumen_viajes AS
SELECT
  v.idViaje,
  v.tiempoDeSalida,
  v.tiempoDeLlegada,
  v.duracionViajeHoras,
  rc.idConductor,
  COUNT(pv.idPasajero) AS cantidadPasajeros,
  AVG(c.puntuacionViaje)::NUMERIC(3,2) AS promedioCalificacion
FROM viaje v
JOIN rutaConductorViaje rc ON v.idViaje = rc.idViaje
LEFT JOIN pasajeroViaje pv ON pv.idViaje = v.idViaje
LEFT JOIN calificacion c ON c.idViaje = v.idViaje
GROUP BY v.idViaje, rc.idConductor;

