CREATE USER 'jurny_prod'@'localhost' IDENTIFIED BY 'jurny_prod';

DROP SCHEMA IF EXISTS `jurny_prod1` ;
CREATE SCHEMA IF NOT EXISTS `jurny_prod1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `jurny_prod1` ;

GRANT ALL PRIVILEGES ON `jurny_prod1`.* TO 'jurny_prod'@'localhost'
WITH GRANT OPTION;