
-- ----------------------------------------------------
-- Table `jurny_dev1`.`travellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`travellers` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`travellers` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(100) NOT NULL ,
  `lastname` VARCHAR(100) NOT NULL ,
  `birthdate` DATE NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`trips`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`trips` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`trips` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `summary` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`destinations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`destinations` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`destinations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `summary` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`journeys`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`journeys` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`journeys` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `startdestination` INT NOT NULL ,
  `enddestination` INT NOT NULL ,
  `summary` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_journey_start` (`startdestination` ASC) ,
  INDEX `fk_journey_end` (`enddestination` ASC) ,
  CONSTRAINT `fk_journey_start`
    FOREIGN KEY (`startdestination` )
    REFERENCES `jurny_dev1`.`destinations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_journey_end`
    FOREIGN KEY (`enddestination` )
    REFERENCES `jurny_dev1`.`destinations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`trip_destinations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`trip_destinations` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`trip_destinations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `trip` INT NOT NULL ,
  `destination` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_trip_destinations_trip` (`trip` ASC) ,
  INDEX `fk_trip_destinations_destination` (`destination` ASC) ,
  CONSTRAINT `fk_trip_destinations_trip`
    FOREIGN KEY (`trip` )
    REFERENCES `jurny_dev1`.`trips` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_destinations_destination`
    FOREIGN KEY (`destination` )
    REFERENCES `jurny_dev1`.`destinations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plans` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plans` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `trip` INT NOT NULL ,
  `summary` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_trip` (`trip` ASC) ,
  CONSTRAINT `fk_plan_trip`
    FOREIGN KEY (`trip` )
    REFERENCES `jurny_dev1`.`trips` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`transport_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`transport_types` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`transport_types` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`journey_transport_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`journey_transport_types` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`journey_transport_types` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `journey` INT NOT NULL ,
  `transporttype` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_journey_transport_types_journey` (`journey` ASC) ,
  INDEX `fk_journey_transport_types_transport_type` (`transporttype` ASC) ,
  CONSTRAINT `fk_journey_transport_types_journey`
    FOREIGN KEY (`journey` )
    REFERENCES `jurny_dev1`.`journeys` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_journey_transport_types_transport_type`
    FOREIGN KEY (`transporttype` )
    REFERENCES `jurny_dev1`.`transport_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_journeys`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_journeys` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_journeys` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `plan` INT NOT NULL ,
  `journeytransporttype` INT NOT NULL ,
  `order` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_journeys_plan` (`plan` ASC) ,
  INDEX `fk_plan_journeys_journey_transport_type` (`journeytransporttype` ASC) ,
  CONSTRAINT `fk_plan_journeys_plan`
    FOREIGN KEY (`plan` )
    REFERENCES `jurny_dev1`.`plans` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_journeys_journey_transport_type`
    FOREIGN KEY (`journeytransporttype` )
    REFERENCES `jurny_dev1`.`journey_transport_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`destination_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`destination_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`destination_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `destination` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_destination_notes_destination` (`destination` ASC) ,
  INDEX `fk_destination_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_destination_notes_destination`
    FOREIGN KEY (`destination` )
    REFERENCES `jurny_dev1`.`destinations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destination_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`journey_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`journey_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`journey_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `journey` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` INT NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_journey_notes_journey` (`journey` ASC) ,
  INDEX `fk_journey_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_journey_notes_journey`
    FOREIGN KEY (`journey` )
    REFERENCES `jurny_dev1`.`journeys` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_journey_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`accomodations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`accomodations` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`accomodations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `destination` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `summary` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_accomodations_destination` (`destination` ASC) ,
  CONSTRAINT `fk_accomodations_destination`
    FOREIGN KEY (`destination` )
    REFERENCES `jurny_dev1`.`destinations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`accomodation_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`accomodation_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`accomodation_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `accomodation` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `notes` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_accomodation_notes_accomodation` (`accomodation` ASC) ,
  INDEX `fk_accomodation_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_accomodation_notes_accomodation`
    FOREIGN KEY (`accomodation` )
    REFERENCES `jurny_dev1`.`accomodations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accomodation_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`trip_travellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`trip_travellers` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`trip_travellers` (
  `trip` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  PRIMARY KEY (`trip`, `traveller`) ,
  INDEX `fk_trips_has_travellers_travellers1` (`traveller` ASC) ,
  INDEX `fk_trips_has_travellers_trips1` (`trip` ASC) ,
  CONSTRAINT `fk_trips_has_travellers_trips1`
    FOREIGN KEY (`trip` )
    REFERENCES `jurny_dev1`.`trips` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trips_has_travellers_travellers1`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`trip_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`trip_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`trip_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `trip` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_trip_notes_trip` (`trip` ASC) ,
  INDEX `fk_trip_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_trip_notes_trip`
    FOREIGN KEY (`trip` )
    REFERENCES `jurny_dev1`.`trips` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`sites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`sites` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`sites` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `destination` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `fk_site_destination` (`destination` ASC) ,
  CONSTRAINT `fk_site_destination`
    FOREIGN KEY (`destination` )
    REFERENCES `jurny_dev1`.`destinations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`restaurants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`restaurants` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`restaurants` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `destination` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_restaurants_destination` (`destination` ASC) ,
  CONSTRAINT `fk_restaurants_destination`
    FOREIGN KEY (`destination` )
    REFERENCES `jurny_dev1`.`destinations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_stays`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_stays` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_stays` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `planjourney` INT NOT NULL ,
  `accomodation` INT NOT NULL ,
  `staydate` DATE NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_stays_plan_journey` (`planjourney` ASC) ,
  INDEX `fk_plan_stays_accomodation` (`accomodation` ASC) ,
  CONSTRAINT `fk_plan_stays_plan_journey`
    FOREIGN KEY (`planjourney` )
    REFERENCES `jurny_dev1`.`plan_journeys` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_stays_accomodation`
    FOREIGN KEY (`accomodation` )
    REFERENCES `jurny_dev1`.`accomodations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_meals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_meals` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_meals` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `planjourney` INT NOT NULL ,
  `restaurant` INT NOT NULL ,
  `mealtype` ENUM('B','L','D') NULL ,
  `mealdate` DATE NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_meals_restaurant` (`restaurant` ASC) ,
  INDEX `fk_plan_meals_plan_journey` (`planjourney` ASC) ,
  CONSTRAINT `fk_plan_meals_restaurant`
    FOREIGN KEY (`restaurant` )
    REFERENCES `jurny_dev1`.`restaurants` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_meals_plan_journey`
    FOREIGN KEY (`planjourney` )
    REFERENCES `jurny_dev1`.`plan_journeys` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_visits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_visits` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_visits` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `planjourney` INT NOT NULL ,
  `site` INT NOT NULL ,
  `visitdate` DATE NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_visits_plan_journey` (`planjourney` ASC) ,
  INDEX `fk_plan_visits_site` (`site` ASC) ,
  CONSTRAINT `fk_plan_visits_plan_journey`
    FOREIGN KEY (`planjourney` )
    REFERENCES `jurny_dev1`.`plan_journeys` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_visits_site`
    FOREIGN KEY (`site` )
    REFERENCES `jurny_dev1`.`sites` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`journey_transport_type_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`journey_transport_type_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`journey_transport_type_notes` (
  `id` INT NOT NULL ,
  `journeytransporttype` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_journey_transport_type_notes_journey_transport_type` (`journeytransporttype` ASC) ,
  INDEX `fk_journey_transport_type_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_journey_transport_type_notes_journey_transport_type`
    FOREIGN KEY (`journeytransporttype` )
    REFERENCES `jurny_dev1`.`journey_transport_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_journey_transport_type_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_journey_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_journey_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_journey_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `planjourney` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_journey_notes_plan_journey` (`planjourney` ASC) ,
  INDEX `fk_plan_journey_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_plan_journey_notes_plan_journey`
    FOREIGN KEY (`planjourney` )
    REFERENCES `jurny_dev1`.`plan_journeys` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_journey_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_meal_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_meal_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_meal_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `planmeal` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_meal_notes_plan_meal` (`planmeal` ASC) ,
  INDEX `fk_plan_meal_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_plan_meal_notes_plan_meal`
    FOREIGN KEY (`planmeal` )
    REFERENCES `jurny_dev1`.`plan_meals` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_meal_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `plan` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_notes_plan` (`plan` ASC) ,
  INDEX `fk_plan_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_plan_notes_plan`
    FOREIGN KEY (`plan` )
    REFERENCES `jurny_dev1`.`plans` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_stay_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_stay_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_stay_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `planstay` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_plan_stay_notes_plan_stay` (`planstay` ASC) ,
  INDEX `fk_plan_stay_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_plan_stay_notes_plan_stay`
    FOREIGN KEY (`planstay` )
    REFERENCES `jurny_dev1`.`plan_stays` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_stay_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`plan_visit_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`plan_visit_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`plan_visit_notes` (
  `plan_visit_notes` INT NOT NULL AUTO_INCREMENT ,
  `planvisit` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`plan_visit_notes`) ,
  INDEX `fk_plan_visit_notes_plan_visit` (`planvisit` ASC) ,
  INDEX `fk_plan_visit_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_plan_visit_notes_plan_visit`
    FOREIGN KEY (`planvisit` )
    REFERENCES `jurny_dev1`.`plan_visits` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plan_visit_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`restaurant_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`restaurant_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`restaurant_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `restaurant` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_restaurant_notes_restaurant` (`restaurant` ASC) ,
  INDEX `fk_restaurant_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_restaurant_notes_restaurant`
    FOREIGN KEY (`restaurant` )
    REFERENCES `jurny_dev1`.`restaurants` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurny_dev1`.`site_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jurny_dev1`.`site_notes` ;

CREATE  TABLE IF NOT EXISTS `jurny_dev1`.`site_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `site` INT NOT NULL ,
  `traveller` INT NOT NULL ,
  `notedate` DATETIME NOT NULL ,
  `note` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_site_notes_site` (`site` ASC) ,
  INDEX `fk_site_notes_traveller` (`traveller` ASC) ,
  CONSTRAINT `fk_site_notes_site`
    FOREIGN KEY (`site` )
    REFERENCES `jurny_dev1`.`sites` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_site_notes_traveller`
    FOREIGN KEY (`traveller` )
    REFERENCES `jurny_dev1`.`travellers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
