create database serenazgo;
use serenazgo;
-------------------------- Tipo de usuario --------------------------
create table tipo_usu(
	id_tipo_us int auto_increment primary key,
    nombre_tipo VARCHAR(50) NOT NULL
);

SELECT * FROM tipo_usu;


-------------------------- Usuario --------------------------
create table usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(8) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    nacimiento DATE NOT NULL,
    contrasena VARCHAR(200) NOT NULL,
    correo VARCHAR(50),
    direccion VARCHAR(100),  
    telefono VARCHAR(20),
    sexo VARCHAR(20) NOT NULL,
    adicional VARCHAR(50),
    foto VARCHAR(50),
    fk_tipo_us INT,
    FOREIGN KEY (fk_tipo_us) REFERENCES tipo_usu(id_tipo_us)
);

select * from usuario;
alter table usuario alter column foto set default 'D:\Proyectos\front_sereno\src\assets\users';

-- Insertar datos en la tabla usuario
INSERT INTO usuario (dni, nombre, apellido, nacimiento, contrasena, correo, direccion, telefono, sexo, adicional, foto, fk_tipo_us)
VALUES 
('12345678', 'Juan', 'Pérez', '1990-05-15', 'clave123', 'juan@example.com', 'Calle Principal 123', '555-5555', 'Masculino', 'Información adicional', 'foto1.jpg', 1),
('87654321', 'María', 'Gómez', '1988-10-20', 'clave456', 'maria@example.com', 'Avenida Secundaria 456', '555-6666', 'Femenino', 'Otra información', 'foto2.jpg', 2),
('23456789', 'Pedro', 'López', '1995-03-25', 'clave789', 'pedro@example.com', 'Plaza Central 789', '555-7777', 'Masculino', 'Más información', 'foto3.jpg', 1);

UPDATE usuario
SET contrasena = '$2a$10$CBLcLL45QK16hf1tuh4W5uoIHMQXuhmtT7lqFtW0smFtvhFu8EmhK'
where id_usuario = 1;

-------------------------- Turno --------------------------
CREATE TABLE turno (
    id_turno INT NOT NULL,
    turno VARCHAR(200) NOT NULL,
    PRIMARY KEY (id_turno)
); 
select * from turno;
insert into turno (id_turno, turno) values (3, 'Madrugada');


-------------------------- Tipo de unidad --------------------------
CREATE TABLE tipo_unidad (
    id_tipo_unidad INT AUTO_INCREMENT PRIMARY KEY,
    tipo_unidad VARCHAR(200) NOT NULL
);

SELECT * FROM tipo_unidad;
INSERT INTO tipo_unidad (tipo_unidad) VALUES ('Camión');


-------------------------- Unidad -----------------------------
CREATE TABLE unidad (
    id_unidad INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(15) NOT NULL,
    descripcion VARCHAR(50),
    estado BOOLEAN NOT NULL DEFAULT 1,
    fk_tipo_unidad INT,
    imagen VARCHAR(250) DEFAULT 'unidad.jpg',
    UNIQUE (placa),
    FOREIGN KEY (fk_tipo_unidad) REFERENCES tipo_unidad (id_tipo_unidad)
);

SELECT * FROM unidad;

INSERT INTO unidad (placa, descripcion, fk_tipo_unidad)
VALUES ('xyz-123', 'sin descripción', 1);

SELECT unidad.id_unidad,
CONCAT(tipo_unidad.tipo_unidad, ' - ', unidad.placa) as unidad_list,
STRING_AGG(patrullaje.id_patrullaje, ', ') AS patrullajes_pertenecientes
FROM unidad LEFT JOIN patrullaje ON unidad.id_unidad = patrullaje.fk_unidad
INNER JOIN tipo_unidad ON unidad.fk_tipo_unidad = tipo_unidad.id_tipo_unidad
GROUP BY unidad.id_unidad, CONCAT(tipo_unidad.tipo_unidad, ' - ', unidad.placa)
ORDER BY CONCAT(tipo_unidad.tipo_unidad, ' - ', unidad.placa);

-------------------------- Patrullaje --------------------------
CREATE TABLE patrullaje (
    id_patrullaje INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(200),
    fk_turno INT NOT NULL,
    fk_unidad INT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado TINYINT NOT NULL DEFAULT 1
);
ALTER TABLE patrullaje ADD CONSTRAINT fk_turno FOREIGN KEY (fk_turno) REFERENCES turno (id_turno);
ALTER TABLE patrullaje ADD CONSTRAINT fk_unidad FOREIGN KEY (fk_unidad) REFERENCES unidad (id_unidad);

select * from patrullaje;
select * from turno;

INSERT INTO patrullaje (descripcion, fk_turno, fk_unidad) VALUES ('grupo', 1, 1);

-------------------------- Sereno --------------------------
CREATE TABLE sereno (
    id_sereno INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(8) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    genero TINYINT NOT NULL,
    celular VARCHAR(20),
    correo VARCHAR(30),
    direccion VARCHAR(30),
    nacimiento DATE NOT NULL,
    imagen VARCHAR(100),
    fk_patrullaje INT NULL,
    CONSTRAINT FK_Sereno_Patrullaje FOREIGN KEY(fk_patrullaje) REFERENCES patrullaje(id_patrullaje)
);

SELECT * FROM sereno;

SELECT id_sereno, dni, nombre, apellidos, genero, celular, correo, direccion, nacimiento, imagen, 
YEAR(CURDATE()) - YEAR(nacimiento) AS edad, 
fk_patrullaje from sereno;

INSERT INTO sereno (dni, nombre, apellidos, genero, celular, correo, direccion, nacimiento)
VALUES ('75115452', 'diego', 'cruz', 1, '945098055', 'diego@gmail.com', 'calle 123', '1996-12-30');