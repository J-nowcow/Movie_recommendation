-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema project
-- -----------------------------------------------------
USE `Project` ;

-- -----------------------------------------------------
-- Table `Project`.`Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Director` (
  `Director_Code` INT UNSIGNED NOT NULL,
  `DName` VARCHAR(45) NULL,
  `DAge` INT NULL,
  `DSex` TINYINT(1) NULL,
  PRIMARY KEY (`Director_Code`),
  UNIQUE INDEX `Director_Code_UNIQUE` (`Director_Code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Movie` (
  `Movie_Code` INT UNSIGNED NOT NULL,
  `Title` VARCHAR(50) NOT NULL,
  `Director_Code` INT UNSIGNED NOT NULL,
  `Date` DATE NULL,
  `Time` INT NULL,
  PRIMARY KEY (`Movie_Code`, `Director_Code`),
  UNIQUE INDEX `Movie_Code_UNIQUE` (`Movie_Code` ASC) VISIBLE,
  INDEX `fk_Movie_Director1_idx` (`Director_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Movie_Director1`
    FOREIGN KEY (`Director_Code`)
    REFERENCES `Project`.`Director` (`Director_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Actor` (
  `Actor_Code` INT UNSIGNED NOT NULL,
  `AName` VARCHAR(20) NOT NULL,
  `AAge` INT NULL,
  `ASex` TINYINT(1) NULL,
  PRIMARY KEY (`Actor_Code`),
  UNIQUE INDEX `Actor_Code_UNIQUE` (`Actor_Code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Movie_has_Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Movie_has_Actor` (
  `Movie_Code` INT UNSIGNED NOT NULL,
  `Actor_Code` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Movie_Code`, `Actor_Code`),
  INDEX `fk_Movie_has_Actor_Actor1_idx` (`Actor_Code` ASC) VISIBLE,
  INDEX `fk_Movie_has_Actor_Movie_idx` (`Movie_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Movie_has_Actor_Movie`
    FOREIGN KEY (`Movie_Code`)
    REFERENCES `Project`.`Movie` (`Movie_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movie_has_Actor_Actor1`
    FOREIGN KEY (`Actor_Code`)
    REFERENCES `Project`.`Actor` (`Actor_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Rating` (
  `Movie_Code` INT UNSIGNED NOT NULL,
  `Rating_Naver` FLOAT NULL DEFAULT 0,
  `Num_Naver` INT NULL DEFAULT 0,
  `Rating_Daum` FLOAT NULL DEFAULT 0,
  `NUM_Daum` INT NULL DEFAULT 0,
  INDEX `fk_Rating_Movie1_idx` (`Movie_Code` ASC) VISIBLE,
  PRIMARY KEY (`Movie_Code`),
  CONSTRAINT `fk_Rating_Movie1`
    FOREIGN KEY (`Movie_Code`)
    REFERENCES `Project`.`Movie` (`Movie_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Rating_Comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Rating_Comment` (
  `Movie_Code` INT UNSIGNED NOT NULL,
  `IsNaver` TINYINT NULL COMMENT '1이면 네이버\n0이면 다음\n둘 중 하나로 들어와야 함',
  `Comment` VARCHAR(150) NOT NULL,
  INDEX `fk_Rating_Comment_Movie1_idx` (`Movie_Code` ASC) INVISIBLE,
  PRIMARY KEY (`Movie_Code`, `Comment`),
  UNIQUE INDEX `Movie_Code_UNIQUE` (`Movie_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Rating_Comment_Movie1`
    FOREIGN KEY (`Movie_Code`)
    REFERENCES `Project`.`Movie` (`Movie_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`User` (
  `User_ID` VARCHAR(20) NOT NULL,
  `UserName` VARCHAR(10) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Age` INT NULL,
  `Sex` TINYINT(1) NULL COMMENT '남자면 1\n여자면 0',
  PRIMARY KEY (`User_ID`),
  UNIQUE INDEX `User_Code_UNIQUE` (`User_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`User_has_Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`User_has_Movie` (
  `User_ID` VARCHAR(20) NOT NULL,
  `Movie_Code` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`User_ID`, `Movie_Code`),
  INDEX `fk_User_has_Movie_Movie1_idx` (`Movie_Code` ASC) VISIBLE,
  INDEX `fk_User_has_Movie_User1_idx` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Movie_User1`
    FOREIGN KEY (`User_ID`)
    REFERENCES `Project`.`User` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Movie_Movie1`
    FOREIGN KEY (`Movie_Code`)
    REFERENCES `Project`.`Movie` (`Movie_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Genre` (
  `Genre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Genre`),
  UNIQUE INDEX `Genre_UNIQUE` (`Genre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project`.`Genre_has_Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Project`.`Genre_has_Movie` (
  `Genre` VARCHAR(20) NOT NULL,
  `Movie_Code` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Genre`, `Movie_Code`),
  INDEX `fk_Genre_has_Movie_Movie1_idx` (`Movie_Code` ASC) VISIBLE,
  INDEX `fk_Genre_has_Movie_Genre1_idx` (`Genre` ASC) VISIBLE,
  CONSTRAINT `fk_Genre_has_Movie_Genre1`
    FOREIGN KEY (`Genre`)
    REFERENCES `Project`.`Genre` (`Genre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Genre_has_Movie_Movie1`
    FOREIGN KEY (`Movie_Code`)
    REFERENCES `Project`.`Movie` (`Movie_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
