create table usuario (
  alias VARCHAR (12) PRIMARY KEY,
  contrasenia VARCHAR (128),
  correo_electronico VARCHAR (128),
  foto BLOB,
  biografia VARCHAR (500),
  fecha_de_nacimiento DATE
);

create table autor(
  identificador VARCHAR(16) PRIMARY KEY,
  nombre VARCHAR(30),
  procedencia VARCHAR(40),
  comienzo_actividad DATE,
  fin_actividad DATE,
  biografía VARCHAR(2000)
);

create table genero(
  nombre VARCHAR (20),
  descripcion VARCHAR (500),
  PRIMARY KEY (nombre)
);

create table cancion(
  identificador VARCHAR (16) PRIMARY KEY,
  fecha DATE,
  autor VARCHAR (30),
  genero VARCHAR (20),
  album VARCHAR (20),
  portada BLOB
);

create table sigue(
  alias1 VARCHAR (12) REFERENCES usuario (alias),
  alias2 VARCHAR (12) REFERENCES usuario (alias),
  PRIMARY KEY (alias1, alias2)
);

create table favoritas(
  alias VARCHAR (12) REFERENCES usuario (alias),
  identificador VARCHAR (16) REFERENCES cancion (identificador),
  PRIMARY KEY (alias, identificador)
);

create table comenta(
  alias VARCHAR (12) REFERENCES usuario (alias),
  identificador VARCHAR (16) REFERENCES cancion (identificador),
  texto VARCHAR (500),
  PRIMARY KEY (alias, identificador)
);

create table valora(
  alias VARCHAR (12) REFERENCES usuario (alias),
  identificador VARCHAR (16) REFERENCES cancion (identificador),
  valor INT,
  PRIMARY KEY (alias, identificador)
);

create table pertenencia(
  id_cancion VARCHAR (16) REFERENCES cancion (identificador),
  nombre VARCHAR (20) REFERENCES genero (nombre)
);

create table autoria(
  id_cancion VARCHAR (16) REFERENCES cancion(identificador),
  id_autor VARCHAR (16) REFERENCES autor(identificador),
  PRIMARY KEY (id_cancion, id_autor)
);

create table aniade_genero(
  nombre VARCHAR(20) REFERENCES genero(nombre),
  alias VARCHAR(16) REFERENCES usuario_privilegiado(alias),
  PRIMARY_KEY (nombre, alias)
);

create table moderador(
  alias VARCHAR(16) REFERENCES usuario_privilegiado(alias),
  PRIMARY_KEY (alias)
);

create table administrador(
  alias VARCHAR(16) REFERENCES usuario_privilegiado(alias),
  PRIMARY_KEY (alias)
);

create table usuario_privilegiado(
  alias VARCHAR(16),
  PRIMARY_KEY (alias)
);





--- a parte ---

create table aniade_cancion(
  identificador VARCHAR(16) REFERENCES cancion(identificador),
  alias VARCHAR(16) REFERENCES usuario_privilegiado(alias),
  PRIMARY_KEY (identificador, alias)
);

create table modifica_cancion(
  identificador VARCHAR(16) REFERENCES cancion(identificador),
  alias VARCHAR(16) REFERENCES usuario_privilegiado(alias),
  dato ???
  PRIMARY_KEY (identificador, alias)
);

create table aniade_cancion(
  identificador VARCHAR(16) REFERENCES cancion(identificador),
  alias VARCHAR(16) REFERENCES usuario_privilegiado(alias),
  PRIMARY_KEY (identificador, alias)
);

create table modifica_cancion(
  identificador VARCHAR(16) REFERENCES cancion(identificador),
  alias VARCHAR(16) REFERENCES usuario_privilegiado(alias),
  dato ???
  PRIMARY_KEY (identificador, alias)
);