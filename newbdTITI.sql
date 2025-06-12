CREATE DATABASE newdb_titishop;
USE newdb_titishop;

-- Crear tabla de Roles
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion_rol TEXT
);

-- Crear tabla de Vistas
CREATE TABLE vistas (
    id_vista INT AUTO_INCREMENT PRIMARY KEY,
    nombre_vista VARCHAR(100) NOT NULL,
    descripcion_vista TEXT,
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- Crear tabla de Usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    contrasena VARCHAR(255),
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);
INSERT INTO usuarios (nombre_usuario, correo, contrasena, id_rol) VALUES
('Felix Tintaya ', 'admin@titishop.com', '1234', 1);
UPDATE usuarios
SET contrasena = '$2y$10$VqcGarpUmOoFWKQvU/nU4ejkMMcW98.fTD2PES3uqa1fx7SLWPEdS'
WHERE correo = 'admin@titishop.com';
-- Crear tabla de Categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);
INSERT IGNORE INTO categorias (nombre_categoria) VALUES
('Drones'),
('Audífonos'),
('Smartwatch'),
('Proyectores'),
('Parlantes'),    
('Videojuegos');

-- Crear tabla de Productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2),
    stock INT,
    imagen_url VARCHAR(255),
    id_categoria INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Crear tabla de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    correo VARCHAR(100),
    direccion TEXT,  -- Dirección ahora está directamente en la tabla Clientes
    contrasena VARCHAR(255),  -- Guardar el hash de la contraseña
    es_registrado BOOLEAN DEFAULT TRUE  -- Si es un cliente registrado o no
);

-- Crear tabla de Ventas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT DEFAULT NULL,  -- Cliente registrado (puede ser NULL si no está registrado)
    id_cliente_no_registrado VARCHAR(100),  -- Nombre del cliente no registrado
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2),
    estado VARCHAR(50) DEFAULT 'pendiente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Crear tabla de Detalle de Venta
CREATE TABLE detalle_venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_producto INT,
    cantidad INT,
    subtotal DECIMAL(10, 2),
    precio_venta DECIMAL(10, 2),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Crear tabla de Carrito de Compras
CREATE TABLE carrito_compras (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT,
    estado ENUM('activo', 'comprado') DEFAULT 'activo',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Crear tabla de Historial de Compras
CREATE TABLE historial_compras (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_venta INT,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);
CREATE TABLE contactos (
    id_contacto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    asunto VARCHAR(255) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP
);

select * from clientes;
select * from contactos;
select * from carrito_compras;
select * from productos;
select * from usuarios;
select * from roles;
INSERT IGNORE INTO roles (id_rol, nombre_rol, descripcion_rol) VALUES
(1, 'admin', 'Administrador del sistema con acceso total y permisos de gestión.'),
(2, 'vendedor', 'Usuario con permisos para gestionar ventas y productos, pero sin acceso administrativo total.'),
(3, 'cliente', 'Usuario registrado para realizar compras en la tienda online.');
select * from vistas;

INSERT INTO productos (nombre, descripcion, precio, imagen_url)
VALUES
('DRONE M6', 'Xiaomi Mijia M6 Drone 8K cámara profesional HD Drones 5G WIFI', 450.00, 'img/DRONE M6 -produc.jpg'),
('DRONE E99 PRO', 'DRONE E99 PRO Plegable con 2 Cámaras HD 4kControl Remoto y manual', 105.00, 'img/DRONE E99 PRO --produc.jpg'),
('DRONE K12 MAX', 'DRONE K12 MAX 4K HD con cámara de 1080P y control remoto', 380.00, 'img/DRONE K12 MAX --produc.jpg'),
('DRONE K13 MAX', 'DRONE K13 MAX 4K HD con cámara de 1080P y control remoto', 115.00, 'img/DRONE K13 MAX -produc.jpg'),
('DRONE M3 ULTRA', 'Drone M3 ULTRA con Wifi y Cámara nativa 1080 ultra HD/4K', 350.00, 'img/DRONE M3ULTRA -produc.jpg'),
('DRONE FP 2736', 'Dron Fineplay FP-2736 Brushless con Cámara 4K y GPS', 280.00, 'img/DRON FP 2736 -produc.jpg'),
('DRONE K11 PRO MAX', 'DRONE K11 PRO MAX 4K HD con cámara de 1080P y control remoto', 220.00, 'img/K11 PRO MAX -produc.jpg'),
('DRONE S159', 'Dron profesional S159 GPS con Control de pantalla 5G 8K', 600.00, 'img/DRONE S159 -produc.jpg'),
('GS5 RETRO GAME CONSOLE', 'GS5 Retro Game Console 4K con 5000 juegos', 320.00, 'img/gs5.jpg'),
('TV BOX', 'XIAOMI MI TV BOX S 2DA GEN ANDROID TV CHROMECAST VERSION GLOBAL', 200.00, 'img/tv box.jpg'),
('MINI PROYECTOR 4K 1080P', 'MINI PROYECTOR 4K 1080P CON WIFI Y BLUETOOTH', 300.00, 'img/proyector.jpg'),
('PROYECTOR CINE', 'PROYECTOR CINE 4K CON WIFI MODO CINE', 800.00, 'img/proyector2.jpeg'),
('SUP VIDEOJUEGO RETRO', 'CONSOLA VIDEOJUEGO SUP CON MANDO ADICIONAL BLANCO', 58.90, 'img/sup.jpg'),
('SMARTWATCH T900 PRO MAX L NEGRO', 'SMARTWACH T900 PRO MAX GL CON PANTALLA TACTIL Y BLUETOOTH', 75.00, 'img/SMART T900.jpg'),
('AUDIFONOS BLUD 3', 'AUDÍFONO BLUETOOTH GENÉRICO GALAXY BUDS 3 PRO BLANCO', 120.00, 'img/AUDIFONOS AIR ON.jpg'),
('AUDÍFONOS INALÁMBRICO ENC', 'AUDÍFONOS INALÁMBRICO ENC BLUETOOTH SMART | PLATEADO', 99.00, 'img/AUDIFONOS INALAMBRICOS.jpg'),
('AUDÍFONOS INALÁMBRICOS AVENGERS', 'AUDÍFONOS BLUETOOTH AVENGERS Y TRANSFORMERS', 99.00, 'img/AUDIFONO AVENGERS.jpg'),
('SMARTWATCH BLUETOOTH', 'I10 PRO MAX PLOMO RELOJ BLUETOOTH CON CAPACIDAD DE 8HORAS DE DURACION', 110.00, 'img/RELOJ I10.jpg'),
('SMARTWATCH HELLO 3 PLUS ULTRA AMOLED NEGRO', 'El Hello Watch 3 CON RESOLUCION DE 425*518 PIXELES', 154.00, 'img/SMART HELLO 3.jpg'),
('PROYECTOR DE LUZ TEKHOME', 'PROYECTOR DE LUZ TEKHOME IMPORTACIONES 8K (7680 X 4320) ASTRONAUTA AJUSTABLE 360°', 150.00, 'img/PROYECTOR ASTRONAUTA.jpg'),
('PROYECTOR SASARU', 'PROYECTOR SASARU PERÚ WIFI 5G 4K 1080P FULL HD BLUETOOTH 5.0', 599.00, 'img/PROYECTOR SASURA.jpg'),
('MINI PROYECTOR', 'MINI PROYECTOR COMPRA FACIL WIFI Y BLUETOOTH 1080P SOPORTE PROYECTOR COMPATIBLE IOS/ANDROID/PORTÁTIL/TV STICK/HDMI/PS5', 465.00, 'img/MINI PROYECTOR PS5.jpg'),
('PROYECTOR CIRCULAR', 'PROYECTOR CIRCULAR NEGRO LUCES GALAXIA LAMPARA BLUETOOTH PARLANTE', 99.90, 'img/PROYECTOR GALAXIA.jpg'),
('PROYECTOR LUCES', 'PROYECTOR LUCES PROFESIONAL CON CABEZAL GIRATORIO PARA FIESTAS EVENTO', 369.00, 'img/ultimateproyec (1).jpg'),
('AUDÍFONOS IMPORTADO ON-EAR', 'AUDÍFONOS IMPORTADO ON-EAR AIRPRO BLUETOOTH AIR INPODS PRO NEGRO', 70.00, 'img/AUDÍFONOS AIR ON.jpg'),
('AUDÍFONOS ZIOP', 'AUDÍFONOS INALÁMBRICO IMPORTA ZIOP PRO BLANCO BLUETOOTH PRO TWS', 89.90, 'img/AUDIFNOS ZIOP.jpg'),
('AUDÍFONOS IMPORTADO OVER-EAR', 'AUDÍFONOS IMPORTADO OVER-EAR BLUETOOTH GATO CON LUZ LED ROSADO', 90.00, 'img/AUDI OVEREAR.jpg'),
('AUDÍFONOS GAMER', 'AUDÍFONOS GAMER IMPORTA ZIOP TRUE WIRELESS G11 BLUETOOTH NEGRO', 60.00, 'img/AUDI GAMER.jpg'),
('AUDÍFONOS GAMER IN-EAR M43', 'AUDÍFONOS GAMER IMPORTADO IN-EAR M43 BLUETOOTH CONTROL TÁCTIL CON CANCELACIÓN DE RUIDO', 54.90, 'img/AUDI CAJA.jpg'),
('AUDÍFONOS BLUETOOTH 5.3', 'AUDÍFONOS BLUETOOTH 5.3 RANURA TF Y ALMOHADILLAS IMANTADAS EJ-MAX A+ N', 84.00, 'img/AUDÍFONOS BLUETOOTH 5.3.jpg'),
('DRONE 998-PRO MINI', 'DRONE CON CÁMARA 4K 998-PRO MINI', 128.00, 'img/drone 998pro.jpg'),
('DRONE E88', 'MINI DRON IMPORTACIONES QIA KPUIA E88 PROFESIONAL PORTATIL CAMARA HD', 89.00, 'img/drone kpuia.jpg'),
('DRONE AVION X189', 'AVIÓN DE CONTROL REMOTO 2.4G JUGUETE AL AIRE LIBRE', 450.00, 'img/drone avion.jpg'),
('PARLANTE VINTAGE', 'PARLANTE VINTAGE PANEL SOLAR LINTERNA', 99.00, 'img/PARLANTE VINTAGE.jpg'),
('PARLANTE AUDIFONO 2 EN 1', 'COMBO PARLANTE SET AUDIO 4 S BRAX STERN BXS-1669C', 169.90, 'img/PARLANTE-AUDI.jpg'),
('PARLANTE DISCOTEK', 'LUCES PARLANTE MUSICAL BLUETOOTH / MAGIC BALL LED USB', 45.00, 'img/PARLANTE-LUCES.jpg'),
('PARLANTE BARRA', 'PARLANTE BARRA BLUETOOTH ALTAVOZ CON LUZ LED RGB DE SONIDO', 99.00, 'img/PARLANTE-BARRA.jpg'),
('PARLANTE HIELERA', 'PARLANTE HIELERA BLUETOOTH RECARGABLE CON LUZ RGB', 90.00, 'img/PARLANT-HIELERA.jpg'),
('LD-S639 40W', 'MINI PARLANTE LDIMI LD-S639 40W', 189.00, 'img/LIDIMI-PARLAN1.jpg'),
('PARLANTE PORTATIL', 'PARLANTE BLUETOOTH YXA172 PORTATIL 80 W 5.0 RADIO FM ANTENA', 89.90, 'img/PARLANTE PORT.jpg'),
('PARLANTE FANTASTIC', 'PARLANTE BLUETOOH FANTASTIC QUALITY GTS-1550 PARA FIESTAS', 249.00, 'img/PARLANTE FANTASTYC.jpg'),
('PARLANTE TRONSMART', 'PARLANTE TRONSMART MIRTUNE C2 PORTATIL BLUETOOTH 24W', 179.00, 'img/PARLANTE TRONSMART.jpeg'),
('JBL BOOMBOX 3', 'PARLANTE BLUETOOTH JBL BOOMBOX 3 80W PORTÁTIL NEGRO', 899.00, 'img/JBL 1.jpg'),
('JBL CLIP 5 5.3', 'PARLANTE BLUETOOTH JBL CLIP 5 5.3', 259.00, 'img/JBL2.jpg'),
('JBL GO 4 NEGRO', 'PARLANTE BLUETOOTH JBL GO 4 NEGRO', 168.00, 'img/JBL3.jpg');

UPDATE productos SET stock = 20 WHERE id_producto = 1;
UPDATE productos SET stock = 20 WHERE id_producto = 2;
UPDATE productos SET stock = 20 WHERE id_producto = 3;
UPDATE productos SET stock = 20 WHERE id_producto = 4;
UPDATE productos SET stock = 20 WHERE id_producto = 5;
UPDATE productos SET stock = 20 WHERE id_producto = 6;
UPDATE productos SET stock = 20 WHERE id_producto = 7;
UPDATE productos SET stock = 20 WHERE id_producto = 8;
UPDATE productos SET stock = 20 WHERE id_producto = 9;
UPDATE productos SET stock = 20 WHERE id_producto = 10;
UPDATE productos SET stock = 20 WHERE id_producto = 11;
UPDATE productos SET stock = 20 WHERE id_producto = 12;
UPDATE productos SET stock = 20 WHERE id_producto = 13;
UPDATE productos SET stock = 20 WHERE id_producto = 14;
UPDATE productos SET stock = 20 WHERE id_producto = 15;
UPDATE productos SET stock = 20 WHERE id_producto = 16;
UPDATE productos SET stock = 20 WHERE id_producto = 17;
UPDATE productos SET stock = 20 WHERE id_producto = 18;
UPDATE productos SET stock = 20 WHERE id_producto = 19;
UPDATE productos SET stock = 20 WHERE id_producto = 20;
UPDATE productos SET stock = 20 WHERE id_producto = 21;
UPDATE productos SET stock = 20 WHERE id_producto = 22;
UPDATE productos SET stock = 20 WHERE id_producto = 23;
UPDATE productos SET stock = 20 WHERE id_producto = 24;
UPDATE productos SET stock = 20 WHERE id_producto = 25;
UPDATE productos SET stock = 20 WHERE id_producto = 26;
UPDATE productos SET stock = 20 WHERE id_producto = 27;
UPDATE productos SET stock = 20 WHERE id_producto = 28;
UPDATE productos SET stock = 20 WHERE id_producto = 29;
UPDATE productos SET stock = 20 WHERE id_producto = 30;
UPDATE productos SET stock = 20 WHERE id_producto = 31;
UPDATE productos SET stock = 20 WHERE id_producto = 32;
UPDATE productos SET stock = 20 WHERE id_producto = 33;
UPDATE productos SET stock = 20 WHERE id_producto = 34;
UPDATE productos SET stock = 20 WHERE id_producto = 35;
UPDATE productos SET stock = 20 WHERE id_producto = 36;
UPDATE productos SET stock = 20 WHERE id_producto = 37;
UPDATE productos SET stock = 20 WHERE id_producto = 38;
UPDATE productos SET stock = 20 WHERE id_producto = 39;
UPDATE productos SET stock = 20 WHERE id_producto = 40;
UPDATE productos SET stock = 20 WHERE id_producto = 41;
UPDATE productos SET stock = 20 WHERE id_producto = 42;
UPDATE productos SET stock = 20 WHERE id_producto = 43;
UPDATE productos SET stock = 20 WHERE id_producto = 44;
UPDATE productos SET stock = 20 WHERE id_producto = 45;


ALTER TABLE ventas MODIFY estado ENUM('pendiente', 'completado', 'cancelado', 'procesando', 'enviado') DEFAULT 'pendiente';


UPDATE productos SET id_categoria = 1 WHERE id_producto = 1; -- Reemplaza ID_DRONE_M6
UPDATE productos SET id_categoria = 1 WHERE id_producto = 2;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 3;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 4;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 5;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 6;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 7;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 8;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 9;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 10;
UPDATE productos SET id_categoria = 1 WHERE id_producto = 11;


-- Videojuegos (id_categoria = 6)
UPDATE productos SET id_categoria = 6 WHERE id_producto = 12;
UPDATE productos SET id_categoria = 6 WHERE id_producto = 13;

-- Proyectores (id_categoria = 4)
UPDATE productos SET id_categoria = 4 WHERE id_producto = 14;
UPDATE productos SET id_categoria = 4 WHERE id_producto = 15;
UPDATE productos SET id_categoria = 4 WHERE id_producto = 16;
UPDATE productos SET id_categoria = 4 WHERE id_producto = 17;
UPDATE productos SET id_categoria = 4 WHERE id_producto = 18;
UPDATE productos SET id_categoria = 4 WHERE id_producto = 19;
UPDATE productos SET id_categoria = 4 WHERE id_producto = 20;

-- Smartwatch (id_categoria = 3)
UPDATE productos SET id_categoria = 3 WHERE id_producto = 21;
UPDATE productos SET id_categoria = 3 WHERE id_producto = 22;
UPDATE productos SET id_categoria = 3 WHERE id_producto = 23;

-- Audífonos (id_categoria = 2)
UPDATE productos SET id_categoria = 2 WHERE id_producto = 24;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 25;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 26;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 27;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 28;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 29;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 30;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 31;
UPDATE productos SET id_categoria = 2 WHERE id_producto = 32;

-- Parlantes (id_categoria = 5)
UPDATE productos SET id_categoria = 5 WHERE id_producto = 33;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 34;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 35;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 36;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 37;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 38;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 39;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 40;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 41;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 42;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 43;
UPDATE productos SET id_categoria = 5 WHERE id_producto = 44;