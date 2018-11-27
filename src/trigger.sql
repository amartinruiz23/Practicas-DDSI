CREATE TRIGGER email.usuario
  BEFORE INSERT ON usuario
  FOR EACH ROW
BEGIN
  IF NEW.correo_electronico NOT LIKE '_%@_%.__%' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Formato de email no valido';
  END IF;
END; 
