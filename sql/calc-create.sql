CREATE DATABASE IF NOT EXISTS `aiful`;
USE `aiful`;

--
-- Table structure for table `equation_log`
--
DROP TABLE IF EXISTS `equation_log`;

CREATE TABLE `equation_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `equation` VARCHAR(255) DEFAULT NULL,
  `result` VARCHAR(45) DEFAULT NULL,
  `summit_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(3) DEFAULT '00',
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `personal_information`
--
DROP TABLE IF EXISTS `personal_information`;

CREATE TABLE `personal_information` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) DEFAULT NULL,
  `email` VARCHAR(45) DEFAULT NULL,
  `phone_number` VARCHAR(45) DEFAULT NULL,
  `equation_id` INT DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_equation_id` (`equation_id`), -- Add an index for the foreign key column
  FOREIGN KEY (`equation_id`) REFERENCES `equation_log` (`id`) -- Reference the `id` column in `equation_log`
);
