-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 06 2023 г., 13:35
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `rnc`
--

-- --------------------------------------------------------

--
-- Структура таблицы `conversion`
--

CREATE TABLE `conversion` (
  `id` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `conversion_rate` decimal(10,2) NOT NULL,
  `last_operation_datetime` datetime NOT NULL,
  `person_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `conversion`
--

INSERT INTO `conversion` (`id`, `type`, `conversion_rate`, `last_operation_datetime`, `person_name`) VALUES
(1, 'online', 0.01, '2023-06-05 09:25:05', 'Антон'),
(2, 'cash', 0.00, '2023-05-26 11:33:52', 'Антон');

-- --------------------------------------------------------

--
-- Структура таблицы `data`
--

CREATE TABLE `data` (
  `ls` int(11) NOT NULL,
  `y` decimal(10,2) NOT NULL,
  `datetime` datetime NOT NULL,
  `hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `data`
--

INSERT INTO `data` (`ls`, `y`, `datetime`, `hash`) VALUES
(128999, 10.00, '2023-05-23 15:11:51', 'f65b2f79e0ea8e55c41b2a9dcdc18de1'),
(555888, 15.00, '2023-05-23 15:12:21', 'd7984b9f2841e7a6949bf3467a218750'),
(666777, 80.04, '2023-06-05 09:25:05', 'a80ea7ad97fa700ce879942abea755962.00');

-- --------------------------------------------------------

--
-- Структура таблицы `transaction`
--

CREATE TABLE `transaction` (
  `ls` int(6) UNSIGNED NOT NULL,
  `sum` float(10,2) NOT NULL,
  `datetime` datetime NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `hash` varchar(32) NOT NULL,
  `conversion_rate` float(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `transaction`
--

INSERT INTO `transaction` (`ls`, `sum`, `datetime`, `valid`, `hash`, `conversion_rate`) VALUES
(128999, 10.00, '2023-05-23 15:11:51', 0, 'f65b2f79e0ea8e55c41b2a9dcdc18de1', 0.01),
(555888, 15.00, '2023-05-23 15:12:21', 0, 'd7984b9f2841e7a6949bf3467a218750', 0.01),
(666777, 10.00, '2023-05-26 14:07:50', 0, 'a5f3daf741811082f19f08baeb90aa41', 0.01),
(666777, 10.00, '2023-06-02 11:41:50', 0, '9b2b7a1c2bd1e97887d8829f0a0da017', 0.01),
(666777, 2.00, '2023-06-05 09:25:05', 0, 'a80ea7ad97fa700ce879942abea75596', 0.01);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` char(60) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `last_login`) VALUES
(1, 'Иван', '123', '2023-06-06 11:33:27');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `conversion`
--
ALTER TABLE `conversion`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`ls`);

--
-- Индексы таблицы `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`ls`,`datetime`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `conversion`
--
ALTER TABLE `conversion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
