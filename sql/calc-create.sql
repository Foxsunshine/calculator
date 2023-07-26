CREATE DATABASE IF NOT EXISTS `aiful`;
USE `aiful`;

--
-- Table structure for table `personal_information`
--
DROP TABLE IF EXISTS `personal_information`;

CREATE TABLE `personal_information` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `equation_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`equation_id`) REFERENCES `equation_log` (`id`)
);

--
-- Table structure for table `equation_log`
--
DROP TABLE IF EXISTS `equation_log`;

CREATE TABLE `equation_log` (
  `id` int NOT NULL,
  `equation` varchar(255) DEFAULT NULL,
  `result` varchar(45) DEFAULT NULL,
  `summit_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
);