-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 23 2023 г., 14:08
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
(1, 'online', 0.01, '2023-05-23 14:58:29', 'Антон'),
(2, 'cash', 0.00, '2023-05-23 14:58:29', 'Антон');

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
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `conversion`
--
ALTER TABLE `conversion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
