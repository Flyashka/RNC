-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 22 2023 г., 12:11
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
-- Структура таблицы `convertasion`
--

CREATE TABLE `convertasion` (
  `id` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `conversion_rate` decimal(10,2) NOT NULL,
  `last_operation_datetime` datetime NOT NULL,
  `person_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `convertasion`
--

INSERT INTO `convertasion` (`id`, `type`, `conversion_rate`, `last_operation_datetime`, `person_name`) VALUES
(1, 'online', 0.01, '2023-05-22 12:56:01', 'Антон'),
(2, 'cash', 0.00, '2023-05-22 12:56:48', 'JАнтон');

-- --------------------------------------------------------

--
-- Структура таблицы `data`
--

CREATE TABLE `data` (
  `ls` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  `has` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `data`
--

INSERT INTO `data` (`ls`, `y`, `datetime`, `has`) VALUES
(123456, 500, '2023-05-15 14:46:06', '279d3c740ec52f44e24f634080e8ee42'),
(324874, 3000, '2023-05-22 11:58:54', 'f7f467dbd0d7340c3199b53cedb93d3f');

-- --------------------------------------------------------

--
-- Структура таблицы `transaction`
--

CREATE TABLE `transaction` (
  `ls` int(11) NOT NULL,
  `sum` decimal(10,2) NOT NULL,
  `type` varchar(50) NOT NULL,
  `datetime` datetime NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `has` tinyint(1) NOT NULL,
  `conversion_rate` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `convertasion`
--
ALTER TABLE `convertasion`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`ls`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `convertasion`
--
ALTER TABLE `convertasion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
