-- Procedimiento para validar documentos de usuario
CREATE OR REPLACE PROCEDURE validar_documento_usuario(
  idDocumentoUsuario INT,
  estado VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
  UPDATE UrlImgDocumentoUsuario
    SET nombreDocumento = CASE WHEN estado='aprobado' THEN nombreDocumento ELSE nombreDocumento END
  WHERE idDocumentoUsuario = idDocumentoUsuario;
END;
$$;

