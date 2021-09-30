-- Thu Sep 30 15:12:23 2021
-- Model Version: 1.0

-- -----------------------------------------------------
-- Schema db_ganadero
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_ganadero` DEFAULT CHARACTER SET utf8 ;
USE `db_ganadero` ;

-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(20) NOT NULL,
  `creation_date` DATE NULL,
  PRIMARY KEY (`id_rol`));

-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(50) NULL,
  `document_type` ENUM('C.C', 'C.E', 'Pasport', 'Registro Civil') NULL,
  `document` VARCHAR(10) NOT NULL,
  `gender` ENUM('Femenino', 'Masculino') NULL,
  `email` VARCHAR(100) NOT NULL,
  `user_password` VARCHAR(15) NOT NULL,
  `phone_number` VARCHAR(10) NULL,
  `creation_date` DATE NULL,
  `rol_id` INT NOT NULL,
  PRIMARY KEY (`id_user`, `rol_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_tbl_user_tbl_rol_idx` (`rol_id` ASC) VISIBLE,
  UNIQUE INDEX `document_UNIQUE` (`document` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_user_tbl_rol`
    FOREIGN KEY (`rol_id`)
    REFERENCES `db_ganadero`.`tbl_rol` (`id_rol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_farm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_farm` (
  `id_farm` INT NOT NULL AUTO_INCREMENT,
  `farm_name` VARCHAR(30) NOT NULL,
  `nit` VARCHAR(11) NULL,
  `address` VARCHAR(70) NOT NULL,
  `owner_farm` VARCHAR(80) NOT NULL,
  `creation_date` DATE NULL,
  `id_user` INT NOT NULL,
  `rol_id` INT NOT NULL,
  PRIMARY KEY (`id_farm`, `id_user`, `rol_id`),
  INDEX `fk_tbl_farm_tbl_user1_idx` (`id_user` ASC, `rol_id` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_farm_tbl_user1`
    FOREIGN KEY (`id_user` , `rol_id`)
    REFERENCES `db_ganadero`.`tbl_user` (`id_user` , `rol_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_type_won`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_type_won` (
  `id_type_won` INT NOT NULL AUTO_INCREMENT,
  `class_won` VARCHAR(10) NOT NULL,
  `creation_date` DATE NULL,
  PRIMARY KEY (`id_type_won`));

-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_purpose`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_purpose` (
  `id_purpose` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(15) NOT NULL,
  `creation_date` DATE NULL,
  PRIMARY KEY (`id_purpose`));

-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_incidents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_incidents` (
  `id_incident` INT NOT NULL AUTO_INCREMENT,
  `incident` VARCHAR(20) NULL,
  `incident_status` VARCHAR(200) NOT NULL,
  `creation_date` DATE NULL,
  PRIMARY KEY (`id_incident`));

-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_iron_mark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_iron_mark` (
  `id_mark` INT NOT NULL AUTO_INCREMENT,
  `name_own_iron` VARCHAR(20) NOT NULL,
  `document_own_iron` VARCHAR(10) NOT NULL,
  `iron_image` VARCHAR(20) NOT NULL,
  `creation_date` DATE NULL,
  PRIMARY KEY (`id_mark`));


-- -----------------------------------------------------
-- Table `db_ganadero`.`tbl_won`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_ganadero`.`tbl_won` (
  `id_cow` INT NOT NULL AUTO_INCREMENT,
  `sex` ENUM('macho', 'hembra') NOT NULL,
  `bred` VARCHAR(20) NOT NULL,
  `age` INT NOT NULL,
  `weight` FLOAT NOT NULL,
  `photo` VARCHAR(30) NOT NULL,
  `creation_date` DATE NOT NULL,
  `farm_id` INT NOT NULL,
  `id_type_won` INT NOT NULL,
  `id_purpose` INT NOT NULL,
  `id_incident` INT NOT NULL,
  `Iid_mark` INT NOT NULL,
  PRIMARY KEY (`id_cow`, `farm_id`, `id_type_won`, `id_purpose`, `id_incident`, `Iid_mark`),
  INDEX `fk_tbl_cow_tbl_farm1_idx` (`farm_id` ASC) VISIBLE,
  INDEX `fk_tbl_cow_tbl_type_won1_idx` (`id_type_won` ASC) VISIBLE,
  INDEX `fk_tbl_won_tbl_purpose1_idx` (`id_purpose` ASC) VISIBLE,
  INDEX `fk_tbl_won_tbl_incidents1_idx` (`id_incident` ASC) VISIBLE,
  INDEX `fk_tbl_won_tbl_iron_mark1_idx` (`Iid_mark` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_cow_tbl_farm1`
    FOREIGN KEY (`farm_id`)
    REFERENCES `db_ganadero`.`tbl_farm` (`id_farm`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tbl_cow_tbl_type_won1`
    FOREIGN KEY (`id_type_won`)
    REFERENCES `db_ganadero`.`tbl_type_won` (`id_type_won`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tbl_won_tbl_purpose1`
    FOREIGN KEY (`id_purpose`)
    REFERENCES `db_ganadero`.`tbl_purpose` (`id_purpose`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tbl_won_tbl_incidents1`
    FOREIGN KEY (`id_incident`)
    REFERENCES `db_ganadero`.`tbl_incidents` (`id_incident`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tbl_won_tbl_iron_mark1`
    FOREIGN KEY (`Iid_mark`)
    REFERENCES `db_ganadero`.`tbl_iron_mark` (`id_mark`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);




