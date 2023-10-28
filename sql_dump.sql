-- Adminer 4.8.1 MySQL 8.0.29-21 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `user_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `auth_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `auth` (`user_id`, `password`) VALUES
('admin',	'$2b$10$ZnQJ6BiS.IOR./HY5bKQj.afRu4RWlWo2k0y2oDdthgs5cQlHC/hm'),
('@id_userVeangubOW973XBCsyw02O',	'$2b$10$aGCopmemD58Fm4cb0eFxo.BcUjiEbVb2dcTaIEobf7cStNRF0BKgK');

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `receipt_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `qty` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  KEY `receipt_id` (`receipt_id`),
  CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `receipt_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stars` int NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `receipts`;
CREATE TABLE `receipts` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `imgUrl` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `difficulty` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `portion` int NOT NULL,
  `minute_duration` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `receipts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `steps`;
CREATE TABLE `steps` (
  `receipt_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `step` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`receipt_id`,`step`),
  CONSTRAINT `steps_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP VIEW IF EXISTS `user_auth`;
CREATE TABLE `user_auth` (`id` varchar(255), `username` varchar(255), `name` varchar(255), `password` varchar(255), `email` varchar(255));


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`id`, `name`, `username`, `email`) VALUES
('@id_userVeangubOW973XBCsyw02O',	'anya',	'anya',	'anya@mail.com'),
('admin',	'admin',	'admin',	'admin@admin.com');

DROP TABLE IF EXISTS `user_auth`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `user_auth` AS select `users`.`id` AS `id`,`users`.`username` AS `username`,`users`.`name` AS `name`,`auth`.`password` AS `password`,`users`.`email` AS `email` from (`users` join `auth` on((`users`.`id` = `auth`.`user_id`)));

-- 2023-10-26 02:52:12
