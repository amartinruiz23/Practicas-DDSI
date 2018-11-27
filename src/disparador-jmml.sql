CREATE TRIGGER crear_cancion
BEFORE INSERT ON cancion
WHEN NEW.autor NOT IN (
	SELECT identificador FROM autor
	WHERE identificador = NEW.autor) OR NEW.genero NOT IN (
    SELECT nombre FROM genero
	  WHERE nombre = NEW.genero
  )
BEGIN
SELECT RAISE(ABORT, 
	'La canción añadida debe tener un autor y género de entre los existentes');
END;