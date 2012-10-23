CREATE USER 'jurny_dev'@'localhost' IDENTIFIED BY 'jurny_dev';

DROP SCHEMA IF EXISTS `jurny_dev1` ;
CREATE SCHEMA IF NOT EXISTS `jurny_dev1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `jurny_dev1` ;

GRANT ALL PRIVILEGES ON `jurny_dev1`.* TO 'jurny_dev'@'localhost'
WITH GRANT OPTION;