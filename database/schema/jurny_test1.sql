CREATE USER 'jurny_test'@'localhost' IDENTIFIED BY 'jurny_test';

DROP SCHEMA IF EXISTS `jurny_test1` ;
CREATE SCHEMA IF NOT EXISTS `jurny_test1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `jurny_test1` ;

GRANT ALL PRIVILEGES ON `jurny_test1`.* TO 'jurny_test'@'localhost'
WITH GRANT OPTION;