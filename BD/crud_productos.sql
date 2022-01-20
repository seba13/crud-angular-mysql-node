-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-01-2022 a las 21:23:29
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `crud_productos`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_estado_producto` (IN `id_producto` INT, IN `estado` BOOLEAN)  BEGIN
UPDATE productos SET productos.estado=estado, productos.fecha_actualizacion=now() WHERE productos.id_producto= id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_fecha_creacion_producto` (IN `id_producto` INT, IN `fecha_creacion` DATE)  BEGIN
UPDATE productos SET productos.fecha_creacion=fecha_creacion, productos.fecha_actualizacion=now() WHERE productos.id_producto= id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_marca` (IN `id_marca` INT, IN `nombre_marca` VARCHAR(30), IN `estado_marca` BOOLEAN)  BEGIN
UPDATE marcas SET marcas.nombre_marca=nombre_marca, marcas.estado=estado_marca WHERE marcas.id_marca=id_marca;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_nombre_producto` (IN `id_producto` INT, IN `nombre_producto` VARCHAR(30))  BEGIN
UPDATE productos SET productos.nombre_producto=nombre_producto, productos.fecha_actualizacion=now() WHERE productos.id_producto= id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_producto` (IN `id_producto` INT, IN `nombre_producto` VARCHAR(30), IN `valor` NUMERIC(15,2), IN `estado` BOOLEAN, IN `id_marca` INT)  BEGIN
UPDATE productos SET productos.nombre_producto=nombre_producto, productos.valor= valor, productos.fecha_creacion = now(), productos.fecha_actualizacion = now(), productos.estado = estado, productos.id_marca = id_marca
WHERE productos.id_producto=id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_valor_producto` (IN `id_producto` INT, IN `valor_producto` NUMERIC(15,2))  BEGIN
UPDATE productos SET productos.valor=valor_producto, productos.fecha_actualizacion=now() WHERE productos.id_producto= id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_agregar_marca` (IN `nombre_marca` VARCHAR(30), IN `estado` BOOLEAN)  BEGIN
INSERT INTO marcas(id_marca,nombre_marca, fecha_creacion, fecha_actualizacion, estado) VALUES (null, nombre_marca, now(), now(), estado);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_agregar_producto` (IN `nombre_producto` VARCHAR(30), IN `valor` NUMERIC(15,2), IN `estado` BOOLEAN, IN `id_marca` INT)  BEGIN
	INSERT INTO productos(productos.id_producto, productos.nombre_producto, productos.valor, productos.fecha_creacion, productos.fecha_actualizacion, productos.estado, productos.id_marca) VALUES (null, nombre_producto, valor, now(), now(), estado, id_marca);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_marca` (IN `id` INT)  BEGIN
DELETE FROM marcas WHERE id_marca=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_eliminar_producto` (IN `id_producto` INT)  BEGIN
DELETE FROM productos
WHERE productos.id_producto=id_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_marcas_detalle` ()  BEGIN
SELECT marcas.id_marca, marcas.nombre_marca, marcas.fecha_creacion, marcas.fecha_actualizacion, marcas.estado, estado.descripcion
FROM marcas JOIN estado ON marcas.estado=estado.estado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_productos` ()  BEGIN
SELECT * from productos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_productos_detalle` ()  BEGIN 
SELECT productos.id_producto, productos.nombre_producto, productos.valor, productos.fecha_creacion, productos.fecha_actualizacion, estado.descripcion, marcas.nombre_marca
FROM productos JOIN estado ON productos.estado=estado.estado JOIN marcas ON productos.id_marca=marcas.id_marca;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `estado` tinyint(1) NOT NULL,
  `descripcion` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`estado`, `descripcion`) VALUES
(0, 'No Disponible'),
(1, 'Disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id_marca` int(11) NOT NULL,
  `nombre_marca` varchar(30) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`id_marca`, `nombre_marca`, `fecha_creacion`, `fecha_actualizacion`, `estado`) VALUES
(2, 'Samsung', '1969-01-13', '2022-01-17', 1),
(3, 'LG', '1947-01-05', '2022-01-18', 1),
(5, 'HP', '2022-01-19', '2022-01-19', 1),
(12, 'Huawei', '2022-01-19', '2022-01-19', 1),
(15, 'MSI', '2022-01-19', '2022-01-19', 1),
(19, 'Gigabyte', '2022-01-20', '2022-01-20', 1),
(20, 'Sony', '2022-01-20', '2022-01-20', 1),
(21, 'ASUS', '2022-01-20', '2022-01-20', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(30) DEFAULT NULL,
  `valor` decimal(15,2) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `id_marca` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `valor`, `fecha_creacion`, `fecha_actualizacion`, `estado`, `id_marca`) VALUES
(20, 'samsung galaxy tab s8', '890000.00', '2022-01-20', '2022-01-20', 0, 2),
(22, 'NanoCell 50 4K', '389990.00', '2022-01-18', '2022-01-18', 1, 3),
(27, 'samsung galaxy tab s7', '50000.00', '2022-01-19', '2022-01-19', 1, 2),
(36, 'RTX 3090 MSI ', '1.00', '2022-01-20', '2022-01-20', 1, 15),
(37, 'Huawei P40 PRO', '500000.00', '2022-01-20', '2022-01-20', 1, 12);

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `actualizar_producto_bu` BEFORE UPDATE ON `productos` FOR EACH ROW INSERT INTO
productos_actualizados(id_producto, nombre_producto_old, nombre_producto_new, valor_old, valor_new, fecha_creacion_old, fecha_creacion_new, fecha_actualizacion_old, fecha_actualizacion_new, estado_old, estado_new, id_marca_old, id_marca_new, usuario, fecha_registro) VALUES (old.id_producto, old.nombre_producto, new.nombre_producto, old.valor, new.valor, old.fecha_creacion, new.fecha_creacion, old.fecha_actualizacion, new.fecha_actualizacion, old.estado, new.estado, old.id_marca, new.id_marca, CURRENT_USER, now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `agregar_producto_ai` AFTER INSERT ON `productos` FOR EACH ROW INSERT INTO productos_agregados(id_producto, nombre_producto, valor, fecha_creacion, fecha_actualizacion, estado, id_marca, usuario, fecha_registro) VALUES (new.id_producto, new.nombre_producto, new.valor, new.fecha_creacion, new.fecha_actualizacion, new.estado, new.id_marca, CURRENT_USER, now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `eliminar_producto_ad` AFTER DELETE ON `productos` FOR EACH ROW INSERT INTO productos_eliminados(id_producto, nombre_producto, valor, fecha_creacion, fecha_actualizacion, estado, id_marca, usuario, fecha_eliminacion) VALUES (old.id_producto, old.nombre_producto, old.valor, old.fecha_creacion, old.fecha_actualizacion, old.estado, old.id_marca, CURRENT_USER, now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_actualizados`
--

CREATE TABLE `productos_actualizados` (
  `id_producto` int(11) DEFAULT NULL,
  `nombre_producto_old` varchar(30) DEFAULT NULL,
  `nombre_producto_new` varchar(30) DEFAULT NULL,
  `valor_old` decimal(15,1) DEFAULT NULL,
  `valor_new` decimal(15,2) DEFAULT NULL,
  `fecha_creacion_old` date DEFAULT NULL,
  `fecha_creacion_new` date DEFAULT NULL,
  `fecha_actualizacion_old` date DEFAULT NULL,
  `fecha_actualizacion_new` date DEFAULT NULL,
  `estado_old` tinyint(1) DEFAULT NULL,
  `estado_new` tinyint(1) DEFAULT NULL,
  `id_marca_old` int(11) DEFAULT NULL,
  `id_marca_new` int(11) DEFAULT NULL,
  `usuario` varchar(30) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos_actualizados`
--

INSERT INTO `productos_actualizados` (`id_producto`, `nombre_producto_old`, `nombre_producto_new`, `valor_old`, `valor_new`, `fecha_creacion_old`, `fecha_creacion_new`, `fecha_actualizacion_old`, `fecha_actualizacion_new`, `estado_old`, `estado_new`, `id_marca_old`, `id_marca_new`, `usuario`, `fecha_registro`) VALUES
(11, 'samsung galaxy tab s7', 'samsung galazy tab s7', '829900.0', '799990.00', '2020-08-01', '2020-08-01', '2022-01-17', '2022-01-17', 1, 0, 2, 2, 'root@localhost', '2022-01-17'),
(11, 'samsung galazy tab s7', 'samsung galaxy tab s7', '799990.0', '800000.00', '2020-08-01', '2020-08-01', '2022-01-17', '2022-01-17', 0, 1, 2, 2, 'root@localhost', '2022-01-17'),
(11, 'samsung galaxy tab s7', 'samsung galaxy tab s7', '800000.0', '800000.00', '2020-08-01', '2020-08-01', '2022-01-17', '2022-01-18', 1, 1, 2, 2, 'root@localhost', '2022-01-18'),
(11, 'samsung galaxy tab s7', 'samsung galaxy tab s7', '800000.0', '850000.00', '2020-08-01', '2020-08-01', '2022-01-18', '2022-01-18', 1, 1, 2, 2, 'root@localhost', '2022-01-18'),
(11, 'samsung galaxy tab s7', 'samsung galaxy tab s8', '850000.0', '850000.00', '2020-08-01', '2020-08-01', '2022-01-18', '2022-01-18', 1, 1, 2, 2, 'root@localhost', '2022-01-18'),
(11, 'samsung galaxy tab s8', 'samsung galaxy tab s7', '850000.0', '850000.00', '2020-08-01', '2020-08-01', '2022-01-18', '2022-01-18', 1, 1, 2, 2, 'root@localhost', '2022-01-18'),
(11, 'samsung galaxy tab s7', 'samsung galaxy tab s7+', '850000.0', '850000.00', '2020-08-01', '2020-08-01', '2022-01-18', '2022-01-18', 1, 1, 2, 2, 'root@localhost', '2022-01-18'),
(11, 'samsung galaxy tab s7+', 'samsung galaxy tab s7+', '850000.0', '850000.00', '2020-08-01', '2020-08-01', '2022-01-18', '2022-01-19', 1, 1, 2, 2, 'root@localhost', '2022-01-19'),
(27, 'samsung galaxy tab s7', 'samsung galaxy tab s7', '50000.0', '50000.00', '2022-01-19', '2022-01-19', '2022-01-19', '2022-01-19', 1, 0, 2, 2, 'root@localhost', '2022-01-19'),
(27, 'samsung galaxy tab s7', 'samsung galaxy tab s7', '50000.0', '50000.00', '2022-01-19', '2022-01-19', '2022-01-19', '2022-01-19', 0, 1, 2, 2, 'root@localhost', '2022-01-19'),
(17, 'OLED 55\' OLED55C1', 'OLED 55\'d OLED55C1', '949990.0', '949990.00', '2021-01-06', '2022-01-19', '2022-01-18', '2022-01-19', 1, 0, 3, 1, 'root@localhost', '2022-01-19'),
(17, 'OLED 55\'d OLED55C1', 'OLED 55\'d OLED55C1', '949990.0', '949990.00', '2022-01-19', '2022-01-19', '2022-01-19', '2022-01-19', 0, 1, 1, 1, 'root@localhost', '2022-01-19'),
(32, 'televisor lg smart tv oled', 'televisor lg smart tv oled', '890000.0', '890000.00', '2022-01-19', '2022-01-19', '2022-01-19', '2022-01-19', 1, 0, 3, 3, 'root@localhost', '2022-01-19'),
(21, 'samsung galaxy s20+', 'samsung galaxy s20+', '900000.0', '900000.00', '2021-03-03', '2022-01-19', '2022-01-18', '2022-01-19', 1, 0, 2, 2, 'root@localhost', '2022-01-19'),
(11, 'samsung galaxy tab s7+', 'samsung galaxy tab s7+', '850000.0', '900000.00', '2020-08-01', '2022-01-19', '2022-01-19', '2022-01-19', 1, 1, 2, 2, 'root@localhost', '2022-01-19'),
(35, 'RTX 3090 MSI ', 'RTX 3090 MSI ', '2150000.0', '1.00', '2022-01-19', '2022-01-19', '2022-01-19', '2022-01-19', 1, 1, 14, 14, 'root@localhost', '2022-01-19'),
(37, 'Huawei P40 PRO', 'Huawei P40 PRO', '23232.0', '500000.00', '2022-01-20', '2022-01-20', '2022-01-20', '2022-01-20', 1, 1, 12, 12, 'root@localhost', '2022-01-20'),
(36, 'RTX 3090 MSI ', 'RTX 3090 MSI ', '2150000.0', '1.00', '2022-01-19', '2022-01-20', '2022-01-19', '2022-01-20', 1, 1, 15, 15, 'root@localhost', '2022-01-20'),
(20, 'samsung galaxy tab s8', 'samsung galaxy tab s8', '890000.0', '890000.00', '2021-12-08', '2022-01-20', '2022-01-18', '2022-01-20', 0, 0, 2, 3, 'root@localhost', '2022-01-20'),
(20, 'samsung galaxy tab s8', 'samsung galaxy tab s8', '890000.0', '890000.00', '2022-01-20', '2022-01-20', '2022-01-20', '2022-01-20', 0, 0, 3, 2, 'root@localhost', '2022-01-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_agregados`
--

CREATE TABLE `productos_agregados` (
  `id_producto` int(11) DEFAULT NULL,
  `nombre_producto` varchar(30) DEFAULT NULL,
  `valor` decimal(15,2) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `id_marca` int(11) DEFAULT NULL,
  `usuario` varchar(30) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos_agregados`
--

INSERT INTO `productos_agregados` (`id_producto`, `nombre_producto`, `valor`, `fecha_creacion`, `fecha_actualizacion`, `estado`, `id_marca`, `usuario`, `fecha_registro`) VALUES
(1, 'Led 55\" UN55TU7090', '359990.00', '2019-01-01', '2022-01-17', 1, 2, 'root@localhost', '2022-01-17'),
(2, 'samsung galaxy z flip', '599760.00', '2020-02-11', '2022-01-17', 0, 2, 'root@localhost', '2022-01-17'),
(5, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 0, 2, 'root@localhost', '2022-01-17'),
(6, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 0, 2, 'root@localhost', '2022-01-17'),
(7, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 1, 2, 'root@localhost', '2022-01-17'),
(8, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 0, 2, 'root@localhost', '2022-01-17'),
(10, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 1, 2, 'root@localhost', '2022-01-17'),
(11, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 1, 2, 'root@localhost', '2022-01-17'),
(12, 'prueba', '23323.00', '0000-00-00', '2022-01-18', 0, 2, 'root@localhost', '2022-01-18'),
(17, 'OLED 55\' OLED55C1', '949990.00', '2021-01-06', '2022-01-18', 1, 3, 'root@localhost', '2022-01-18'),
(20, 'samsung galaxy tab s8', '890000.00', '2021-12-08', '2022-01-18', 0, 2, 'root@localhost', '2022-01-18'),
(21, 'samsung galaxy s20+', '900000.00', '2021-03-03', '2022-01-18', 1, 2, 'root@localhost', '2022-01-18'),
(22, 'NanoCell 50 4K', '389990.00', '2022-01-18', '2022-01-18', 1, 3, 'root@localhost', '2022-01-18'),
(23, 'samsung galaxy fold z 3', '1404000.00', '2022-01-18', '2022-01-18', 1, 2, 'root@localhost', '2022-01-18'),
(24, 'd', '2.00', '0000-00-00', '2022-01-18', 1, 3, 'root@localhost', '2022-01-18'),
(26, 'prueba', '200.00', '0000-00-00', '2022-01-19', 1, 2, 'root@localhost', '2022-01-19'),
(27, 'samsung galaxy tab s7', '50000.00', '2022-01-19', '2022-01-19', 1, 2, 'root@localhost', '2022-01-19'),
(28, 'Huawei P40 PRO', '500000.00', '2022-01-19', '2022-01-19', 1, 4, 'root@localhost', '2022-01-19'),
(29, 'Huawei P40 PRO', '500000.00', '2022-01-19', '2022-01-19', 1, 7, 'root@localhost', '2022-01-19'),
(30, 'Huawei P40 PRO', '50000.00', '2022-01-19', '2022-01-19', 1, 7, 'root@localhost', '2022-01-19'),
(31, 'Huawei P40 PRO', '500000.00', '2022-01-19', '2022-01-19', 1, 8, 'root@localhost', '2022-01-19'),
(32, 'televisor lg smart tv oled', '890000.00', '2022-01-19', '2022-01-19', 1, 3, 'root@localhost', '2022-01-19'),
(33, 'Tarjeta de video 1660 ti Msi', '350000.00', '2022-01-19', '2022-01-19', 1, 9, 'root@localhost', '2022-01-19'),
(35, 'RTX 3090 MSI ', '2150000.00', '2022-01-19', '2022-01-19', 1, 14, 'root@localhost', '2022-01-19'),
(36, 'RTX 3090 MSI ', '2150000.00', '2022-01-19', '2022-01-19', 1, 15, 'root@localhost', '2022-01-19'),
(37, 'Huawei P40 PRO', '23232.00', '2022-01-20', '2022-01-20', 1, 12, 'root@localhost', '2022-01-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_eliminados`
--

CREATE TABLE `productos_eliminados` (
  `id_producto` int(11) DEFAULT NULL,
  `nombre_producto` varchar(30) DEFAULT NULL,
  `valor` decimal(15,2) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `id_marca` int(11) DEFAULT NULL,
  `usuario` varchar(30) DEFAULT NULL,
  `fecha_eliminacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos_eliminados`
--

INSERT INTO `productos_eliminados` (`id_producto`, `nombre_producto`, `valor`, `fecha_creacion`, `fecha_actualizacion`, `estado`, `id_marca`, `usuario`, `fecha_eliminacion`) VALUES
(5, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 0, 2, 'root@localhost', '2022-01-17'),
(6, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 0, 2, 'root@localhost', '2022-01-17'),
(7, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 1, 2, 'root@localhost', '2022-01-17'),
(8, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 0, 2, 'root@localhost', '2022-01-17'),
(10, 'samsung galaxy tab s7', '829900.00', '2020-08-01', '2022-01-17', 1, 2, 'root@localhost', '2022-01-17'),
(12, 'prueba', '23323.00', '0000-00-00', '2022-01-18', 0, 2, 'root@localhost', '2022-01-18'),
(1, 'Led 55\" UN55TU7090', '359990.00', '2019-01-01', '2022-01-17', 1, 2, 'root@localhost', '2022-01-18'),
(2, 'samsung galaxy z flip', '599760.00', '2020-02-11', '2022-01-17', 0, 2, 'root@localhost', '2022-01-18'),
(24, 'd', '2.00', '0000-00-00', '2022-01-18', 1, 3, 'root@localhost', '2022-01-18'),
(26, 'prueba', '200.00', '0000-00-00', '2022-01-19', 1, 2, 'root@localhost', '2022-01-19'),
(23, 'samsung galaxy fold z 3', '1404000.00', '2022-01-18', '2022-01-18', 1, 2, 'root@localhost', '2022-01-19'),
(29, 'Huawei P40 PRO', '500000.00', '2022-01-19', '2022-01-19', 1, 7, 'root@localhost', '2022-01-19'),
(17, 'OLED 55\'d OLED55C1', '949990.00', '2022-01-19', '2022-01-19', 1, 1, 'root@localhost', '2022-01-19'),
(31, 'Huawei P40 PRO', '500000.00', '2022-01-19', '2022-01-19', 1, 8, 'root@localhost', '2022-01-19'),
(35, 'RTX 3090 MSI ', '1.00', '2022-01-19', '2022-01-19', 1, 14, 'root@localhost', '2022-01-19'),
(21, 'samsung galaxy s20+', '900000.00', '2022-01-19', '2022-01-19', 0, 2, 'root@localhost', '2022-01-20'),
(32, 'televisor lg smart tv oled', '890000.00', '2022-01-19', '2022-01-19', 0, 3, 'root@localhost', '2022-01-20'),
(11, 'samsung galaxy tab s7+', '900000.00', '2022-01-19', '2022-01-19', 1, 2, 'root@localhost', '2022-01-20');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`estado`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id_marca`),
  ADD UNIQUE KEY `nombre_marca` (`nombre_marca`),
  ADD KEY `fk_estado_marca` (`estado`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD UNIQUE KEY `nombre_producto` (`nombre_producto`),
  ADD KEY `fk_estado_producto` (`estado`),
  ADD KEY `fk_id_marca` (`id_marca`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id_marca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD CONSTRAINT `fk_estado_marca` FOREIGN KEY (`estado`) REFERENCES `estado` (`estado`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_estado_producto` FOREIGN KEY (`estado`) REFERENCES `estado` (`estado`),
  ADD CONSTRAINT `fk_id_marca` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id_marca`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
