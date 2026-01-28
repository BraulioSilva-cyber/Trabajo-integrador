-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-01-2026 a las 05:15:31
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_grafo_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE `ciudades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `latitud` float NOT NULL,
  `longitud` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`id`, `nombre`, `latitud`, `longitud`) VALUES
(1, 'Ambato', -1.36657, -78.585),
(2, 'Quito', -0.211212, -78.5027),
(3, 'Guayaquil', -2.15721, -79.8829),
(4, 'Pimampiro', 0.392484, -77.9386),
(5, 'Casa', -1.25806, -78.626),
(6, 'PUCESA', -1.27406, -78.6393),
(7, 'Latacunga', -0.92583, -78.6201),
(8, 'Baeza', -0.46746, -77.8854),
(9, 'Loja', -4.05003, -79.8002),
(10, 'Esmeraldas', 0.7064, -79.3223),
(11, 'Manabí', -0.80088, -80.043),
(12, 'Santa Elena', -2.08584, -80.4825),
(13, 'Machala', -3.27708, -79.9431),
(14, 'Milagro', -2.13058, -79.5992),
(15, 'Naranjal', -2.67091, -79.6107),
(16, 'Cuenca', -2.90025, -79.0018),
(17, 'Riobamba', -1.68012, -78.6714),
(18, 'Guamote', -1.94366, -78.7208),
(19, 'Chunchi', -2.29223, -78.9158),
(20, 'Giron', -3.17562, -79.1548),
(21, 'Saraguro', -3.63623, -79.229),
(22, 'Loja City', -4.00921, -79.2106),
(23, 'Portoviejo', -1.10845, -80.5429),
(24, 'Pajan', -1.58128, -80.421),
(25, 'Loreto', -0.70146, -77.3201),
(26, 'Baños', -1.39643, -78.4253),
(27, 'Pujilí', -0.956452, -78.6967),
(28, 'La Mana', -0.942835, -79.224);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE `historial` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `accion` varchar(100) DEFAULT NULL,
  `detalle` text DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial`
--

INSERT INTO `historial` (`id`, `usuario_id`, `accion`, `detalle`, `fecha`) VALUES
(1, 1, 'Login', 'Ingreso al sistema', '2026-01-23 11:27:54'),
(2, 1, 'Crear Ruta', 'Conectó Pimampiro con PUCESA (201.02 km)', '2026-01-23 11:28:10'),
(3, 2, 'Login', 'Ingreso al sistema', '2026-01-23 11:31:32'),
(4, 1, 'Login', 'Ingreso al sistema', '2026-01-23 12:22:12'),
(5, 2, 'Login', 'Ingreso al sistema', '2026-01-23 12:25:21'),
(6, 1, 'Login', 'Ingreso al sistema', '2026-01-23 12:33:36'),
(7, 1, 'Cálculo Dijkstra', 'Ruta óptima: Casa -> PUCESA (2.31 km)', '2026-01-23 12:35:13'),
(8, 1, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Quito (128.8 km)', '2026-01-23 12:37:25'),
(9, 1, 'Cálculo Dijkstra', 'Ruta óptima: Pimampiro -> PUCESA (201.02 km)', '2026-01-23 12:39:57'),
(10, 1, 'Cálculo Dijkstra', 'Ruta óptima: Pimampiro -> Quito -> Ambato -> Guayaquil (389.6 km)', '2026-01-23 12:43:07'),
(11, 1, 'Cálculo Dijkstra', 'Ruta óptima: Pimampiro -> Quito -> Ambato -> Guayaquil (389.6 km)', '2026-01-23 12:43:54'),
(12, 1, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Guayaquil (168.93 km)', '2026-01-23 12:51:25'),
(13, 1, 'Login', 'Ingreso al sistema', '2026-01-23 12:53:58'),
(14, 1, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Quito -> Guayaquil (394.06 km)', '2026-01-23 12:55:19'),
(15, 2, 'Login', 'Ingreso al sistema', '2026-01-23 13:17:15'),
(16, 3, 'Login', 'Ingreso al sistema', '2026-01-23 13:17:47'),
(17, 3, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Latacunga -> Baeza (145.45 km)', '2026-01-23 13:19:22'),
(18, 2, 'Login', 'Ingreso al sistema', '2026-01-23 13:19:45'),
(19, 3, 'Login', 'Ingreso al sistema', '2026-01-23 13:22:11'),
(20, 3, 'Login', 'Ingreso al sistema', '2026-01-23 13:34:13'),
(21, 3, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Quito -> Guayaquil -> Baeza (684.93 km)', '2026-01-23 13:35:36'),
(22, 3, 'Cálculo Dijkstra', 'Ruta óptima: Pimampiro -> Baeza (95.8 km)', '2026-01-23 13:45:57'),
(23, 3, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Quito -> Esmeraldas -> Manabí -> Santa Elena -> Guayaquil -> Machala -> Loja (881.58 km)', '2026-01-23 14:07:27'),
(24, 3, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Loja (327.49 km)', '2026-01-23 14:07:48'),
(25, 3, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Riobamba -> Guamote -> Chunchi -> Cuenca -> Giron -> Saraguro -> Loja City (307.07 km)', '2026-01-23 14:18:14'),
(26, 3, 'Cálculo Dijkstra', 'Ruta óptima: Ambato -> Riobamba -> Guamote -> Chunchi -> Cuenca -> Giron -> Saraguro -> Loja City -> Loja -> Machala -> Naranjal -> Milagro -> Guayaquil (628.64 km)', '2026-01-23 14:18:43'),
(27, 2, 'Login', 'Ingreso al sistema', '2026-01-23 14:19:11'),
(28, 1, 'Login', 'Ingreso al sistema', '2026-01-23 14:20:35'),
(29, 1, 'Cálculo Dijkstra', 'Ruta óptima: Guayaquil -> Milagro -> Naranjal -> Machala -> Loja -> Loja City -> Saraguro -> Giron -> Cuenca -> Chunchi -> Guamote -> Riobamba -> Ambato -> Loreto (787.53 km)', '2026-01-23 14:26:15'),
(30, 1, 'Login', 'Ingreso al sistema', '2026-01-23 19:08:00'),
(31, 1, 'Cálculo Dijkstra', 'Ruta óptima: Guayaquil -> Ambato (168.93 km)', '2026-01-23 19:08:56'),
(32, 1, 'Login', 'Ingreso al sistema', '2026-01-27 22:24:07'),
(33, 2, 'Login', 'Ingreso al sistema', '2026-01-27 22:30:24'),
(34, 1, 'Login', 'Ingreso al sistema', '2026-01-27 22:31:37'),
(35, 2, 'Login', 'Ingreso al sistema', '2026-01-27 22:41:18'),
(36, 1, 'Login', 'Ingreso al sistema', '2026-01-27 23:00:57'),
(37, 1, 'Crear Ruta', 'Ambato-Baeza', '2026-01-27 23:15:16'),
(38, 1, 'Crear Ruta', 'Baños-Guayaquil', '2026-01-27 23:15:37'),
(39, 1, 'Crear Ruta', 'Guayaquil-Milagro', '2026-01-27 23:16:08'),
(40, 1, 'Dijkstra', 'Guayaquil -> Milagro', '2026-01-27 23:16:38'),
(41, 1, 'Dijkstra', 'Guayaquil -> Milagro', '2026-01-27 23:17:22'),
(42, 1, 'Dijkstra', 'Guayaquil -> Milagro', '2026-01-27 23:18:25'),
(43, 1, 'Crear Ciudad', 'Pujilí', '2026-01-27 23:24:57'),
(44, 1, 'Crear Ruta', 'Loja-Guayaquil', '2026-01-27 23:36:41'),
(45, 1, 'Dijkstra', 'Loja -> Guayaquil', '2026-01-27 23:36:59'),
(46, 1, 'Crear Ruta', 'Ambato-Saraguro', '2026-01-27 23:40:40'),
(47, 1, 'Dijkstra', 'Ambato -> Saraguro', '2026-01-27 23:40:54'),
(48, 1, 'Crear Ruta', 'Ambato-Saraguro', '2026-01-27 23:43:14'),
(49, 1, 'Crear Ruta', 'Saraguro-Loja', '2026-01-27 23:44:13'),
(50, 1, 'Crear Ruta', 'Loja-Loja City', '2026-01-27 23:44:44'),
(51, 1, 'Dijkstra', 'Loja City -> Loja', '2026-01-27 23:45:19'),
(52, 1, 'Crear Ruta', 'Loreto-Baños', '2026-01-27 23:47:17'),
(53, 1, 'Crear Ruta', 'Ambato-Baños', '2026-01-27 23:47:33'),
(54, 1, 'Crear Ruta', 'Pujilí-Latacunga', '2026-01-27 23:47:49'),
(55, 1, 'Crear Ruta', 'Baeza-Loreto', '2026-01-27 23:48:01'),
(56, 1, 'Crear Ruta', 'Milagro-Guamote', '2026-01-27 23:49:08'),
(57, 1, 'Crear Ruta', 'Ambato-Baeza', '2026-01-28 00:00:41'),
(58, 1, 'Dijkstra', 'Ambato -> Baeza', '2026-01-28 00:00:49'),
(59, 1, 'Dijkstra', 'Ambato -> Baeza', '2026-01-28 00:08:33'),
(60, 1, 'Dijkstra', 'Baeza -> Loja City', '2026-01-28 00:09:17'),
(61, 1, 'Dijkstra', 'Baeza -> Loja City', '2026-01-28 00:13:31'),
(62, 1, 'Crear Ruta', 'Esmeraldas-Loja City', '2026-01-28 00:14:24'),
(63, 1, 'Dijkstra', 'Esmeraldas -> Loja City', '2026-01-28 00:14:37'),
(64, 1, 'Crear Ruta', 'Ambato-PUCESA', '2026-01-28 00:41:36'),
(65, 1, 'Crear Ruta', 'Ambato-PUCESA', '2026-01-28 00:41:47'),
(66, 1, 'Dijkstra', 'Ambato -> PUCESA', '2026-01-28 00:41:59'),
(67, 1, 'Crear Ruta', 'Casa-PUCESA', '2026-01-28 00:43:37'),
(68, 1, 'Dijkstra', 'Casa -> PUCESA', '2026-01-28 00:43:51'),
(69, 1, 'Crear Ruta', 'Esmeraldas-Manabí', '2026-01-28 00:46:50'),
(70, 1, 'Crear Ruta', 'Manabí-Portoviejo', '2026-01-28 00:47:10'),
(71, 1, 'Crear Ruta', 'Portoviejo-Pajan', '2026-01-28 00:47:31'),
(72, 1, 'Crear Ruta', 'Pajan-Santa Elena', '2026-01-28 00:47:46'),
(73, 1, 'Crear Ruta', 'Santa Elena-Guayaquil', '2026-01-28 00:48:05'),
(74, 1, 'Crear Ruta', 'Milagro-Naranjal', '2026-01-28 00:48:31'),
(75, 1, 'Crear Ruta', 'Naranjal-Machala', '2026-01-28 00:48:45'),
(76, 1, 'Crear Ruta', 'Machala-Loja', '2026-01-28 00:49:05'),
(77, 1, 'Dijkstra', 'Esmeraldas -> Loja City', '2026-01-28 00:49:48'),
(78, 1, 'Crear Ruta', 'Esmeraldas-Manabí', '2026-01-28 00:52:52'),
(79, 1, 'Crear Ruta', 'Portoviejo-Pajan', '2026-01-28 00:53:17'),
(80, 1, 'Dijkstra', 'Esmeraldas -> Loja City', '2026-01-28 00:53:50'),
(81, 1, 'Dijkstra', 'Esmeraldas -> Loja City', '2026-01-28 00:55:27'),
(82, 1, 'Crear Ruta', 'Ambato-Loja City', '2026-01-28 01:02:28'),
(83, 1, 'Dijkstra', 'Baeza -> Casa', '2026-01-28 01:02:57'),
(84, 1, 'RESET TOTAL', 'Se eliminaron 29 conexiones.', '2026-01-28 01:05:54'),
(85, 1, 'Crear Ruta', 'Ambato-Casa', '2026-01-28 01:06:45'),
(86, 1, 'Crear Ruta', 'Baños-Casa', '2026-01-28 01:07:07'),
(87, 1, 'Crear Ciudad', 'La Mana', '2026-01-28 01:29:04'),
(88, 2, 'Login', 'Ingreso al sistema', '2026-01-28 01:51:42'),
(89, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:05:56'),
(90, 3, 'Login', 'Ingreso al sistema', '2026-01-28 02:06:09'),
(91, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:07:12'),
(92, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:07:46'),
(93, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:23:01'),
(94, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:33:28'),
(95, 4, 'Login', 'Ingreso al sistema', '2026-01-28 02:34:15'),
(96, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:34:36'),
(97, 1, 'Login', 'Ingreso al sistema', '2026-01-28 02:42:28'),
(98, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:43:13'),
(99, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:46:45'),
(100, 3, 'Login', 'Ingreso al sistema', '2026-01-28 02:47:51'),
(101, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:58:55'),
(102, 2, 'Login', 'Ingreso al sistema', '2026-01-28 02:59:57'),
(103, 2, 'Login', 'Ingreso al sistema', '2026-01-28 03:00:06'),
(104, 4, 'Login', 'Ingreso al sistema', '2026-01-28 03:00:21'),
(105, 2, 'Login', 'Ingreso al sistema', '2026-01-28 03:04:00'),
(106, 4, 'Login', 'Ingreso al sistema', '2026-01-28 03:07:54'),
(107, 4, 'DIJKSTRA', 'Ruta: Esmeraldas -> Loja', '2026-01-28 03:13:03'),
(108, 2, 'Login', 'Ingreso al sistema', '2026-01-28 03:13:22'),
(109, 1, 'Login', 'Ingreso al sistema', '2026-01-28 03:14:54'),
(110, 1, 'DIJKSTRA', 'Ruta: Baños -> Quito', '2026-01-28 03:15:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutas`
--

CREATE TABLE `rutas` (
  `id` int(11) NOT NULL,
  `origen_id` int(11) NOT NULL,
  `destino_id` int(11) NOT NULL,
  `distancia` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rutas`
--

INSERT INTO `rutas` (`id`, `origen_id`, `destino_id`, `distancia`) VALUES
(92, 1, 5, 12.88),
(93, 26, 5, 27.06);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(256) NOT NULL,
  `es_admin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password_hash`, `es_admin`) VALUES
(1, 'braulio94.bs@gmail.com', 'scrypt:32768:8:1$1Y9ejlRUn7J7A8vw$e5d7b4a234aa05e61a164d2221f34cd0da0e58d65801ccbdca1109543630a341c9786715252d4a6a75a7429d71a6624fc146a2bc7db1429da4cf58391410c495', 0),
(2, 'admin', 'scrypt:32768:8:1$xfuCjRZZRpLgk0uo$6dbd3cf316397c726fbb058aaacaf7fc77701ebbfbc096cf7ebe756f9e30a20abc1ca9a94a8419b53973f4abc753a1d77ee112d7b41c2c501b161dc2b7224820', 1),
(3, 'victor', 'scrypt:32768:8:1$nuydP63lvO1qVQvk$6076ea1c2fb7e90ac414a2c6ac31a50869a88c7ec99aa586384e28845fe976c9f69f8a208053a490adf24de545b11949a350d0048bd549a2db0369fc11a6e75d', 0),
(4, 'antonio', 'scrypt:32768:8:1$vfXOC4cvWi7F6jHN$65d70466798ffa42ee687ec6c41b38e90efc3f9c24eee0e257376b0965a6a14259b6cf6658c03137af17c73ed2a927fcd39b73988beb69a5ff8ad8b4799789ef', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `rutas`
--
ALTER TABLE `rutas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `origen_id` (`origen_id`),
  ADD KEY `destino_id` (`destino_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT de la tabla `rutas`
--
ALTER TABLE `rutas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `historial_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `rutas`
--
ALTER TABLE `rutas`
  ADD CONSTRAINT `rutas_ibfk_1` FOREIGN KEY (`origen_id`) REFERENCES `ciudades` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `rutas_ibfk_2` FOREIGN KEY (`destino_id`) REFERENCES `ciudades` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
