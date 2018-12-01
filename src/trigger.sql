-- Trigger de José María Martín Luque
-- Comprueba que la canción añadida tiene como autor y
-- género uno de los existentes
delimiter //
CREATE TRIGGER crearCancion
  BEFORE INSERT ON cancion
  FOR EACH ROW
  
BEGIN
  IF NEW.autor NOT IN (
	  SELECT identificador FROM autor
	  WHERE identificador = NEW.autor
  ) OR NEW.genero NOT IN (
    SELECT nombre FROM genero
	  WHERE nombre = NEW.genero
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La canción añadida debe tener un autor y género de entre los existentes';
  END IF;
END;//
delimiter ;

-- Trigger de Luis Antonio Ortega Andrés
delimiter //
CREATE TRIGGER emailUsuario
  BEFORE INSERT ON usuario
  FOR EACH ROW
BEGIN
  IF NEW.correo_electronico NOT LIKE '_%@_%.__%' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de email no valido';
  END IF;
END;//
delimiter ;

-- Trigger de Sofía Almeida Bruno
-- Comprueba que un usuario ha escuchado una 
-- canción para permitir comentar sobre ella
delimiter //
create trigger ponerComentario
  before insert on comenta
  for each row
begin

declare
relacionados VARCHAR (12);

select alias into relacionados from escuchadas
  where alias = NEW.alias  AND identificador = NEW.identificador;

if relacionados IS NULL then
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pueden añadir comentarios si no se ha escuchado la canción';
end if;
end;//
delimiter ;

-- Trigger de Antonio Martín Ruiz
DELIMITER $
CREATE TRIGGER compruebafecha
BEFORE INSERT ON autor
FOR EACH ROW 
BEGIN
IF (DATEDIFF(NEW.comienzo_actividad,CURDATE()) >= 0 )
THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de comienzo debe estar en el pasado';
END IF;
END;$

DELIMITER ;
