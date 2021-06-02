-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`AREA_CONHECIMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AREA_CONHECIMENTO` (
  `id_AREA_CONHECIMENTO` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_AREA_CONHECIMENTO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EDITORA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EDITORA` (
  `id_EDITORA` INT NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `cidade` VARCHAR(45) NULL,
  PRIMARY KEY (`id_EDITORA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LIVRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LIVRO` (
  `id_LIVRO` INT NOT NULL,
  `autor` VARCHAR(45) NOT NULL,
  `titulo` VARCHAR(60) NOT NULL,
  `n_edicao` VARCHAR(45) NOT NULL,
  `ano_publicacao` YEAR(4) NOT NULL,
  `isbn` INT NULL,
  `idioma` VARCHAR(45) NULL,
  `id_EDITORA` INT NOT NULL,
  `id_AREA_CONHECIMENTO` INT NOT NULL,
  PRIMARY KEY (`id_LIVRO`, `id_EDITORA`),
  CONSTRAINT `fk_LIVRO_EDITORA`
    FOREIGN KEY (`id_EDITORA`)
    REFERENCES `mydb`.`EDITORA` (`id_EDITORA`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_LIVRO_AREA_CONHECIMENTO1`
    FOREIGN KEY (`id_AREA_CONHECIMENTO`)
    REFERENCES `mydb`.`AREA_CONHECIMENTO` (`id_AREA_CONHECIMENTO`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_LIVRO_EDITORA1_idx` ON `mydb`.`LIVRO` (`id_EDITORA` ASC) VISIBLE;

CREATE INDEX `fk_LIVRO_AREA_CONHECIMENTO1_idx` ON `mydb`.`LIVRO` (`id_AREA_CONHECIMENTO` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`AUTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AUTOR` (
  `id_AUTOR` INT NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `nacionalidade` VARCHAR(45) NULL,
  `bibliografia` VARCHAR(100) NULL,
  PRIMARY KEY (`id_AUTOR`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EXEMPLAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EXEMPLAR` (
  `id_EXEMPLAR` INT NOT NULL,
  `situacao` VARCHAR(45) NOT NULL,
  `ibsn` VARCHAR(45) NULL,
  `id_LIVRO` INT NOT NULL,
  PRIMARY KEY (`id_EXEMPLAR`),
  CONSTRAINT `fk_EXEMPLAR_LIVRO1`
    FOREIGN KEY (`id_LIVRO`)
    REFERENCES `mydb`.`LIVRO` (`id_LIVRO`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_EXEMPLAR_LIVRO1_idx` ON `mydb`.`EXEMPLAR` (`id_LIVRO` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARIO` (
  `id_USUARIO` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` INT NOT NULL,
  `rg` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `estado_civil` VARCHAR(45) NULL,
  `status_usuario` VARCHAR(45) NOT NULL,
  `escolaridade` VARCHAR(45) NOT NULL,
  `nascimento` DATE NOT NULL,
  `telefone_fixo` INT NOT NULL,
  `celular` INT NOT NULL,
  `cep` INT NOT NULL,
  `uf` CHAR(2) NOT NULL,
  `logradouro` VARCHAR(90) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_USUARIO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EMPRESTIMO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMPRESTIMO` (
  `data_devolucao` DATE NULL,
  `hora` DATETIME NOT NULL,
  `data_devolvido` DATE NOT NULL,
  `data_emprestado` DATE NOT NULL,
  `id_EXEMPLAR` INT NOT NULL,
  `id_EMPRESTIMO` INT NOT NULL,
  `id_USUARIO` INT NOT NULL,
  PRIMARY KEY (`id_EMPRESTIMO`, `id_USUARIO`),
  CONSTRAINT `fk_EMPRESTIMO_EXEMPLAR1`
    FOREIGN KEY (`id_EXEMPLAR`)
    REFERENCES `mydb`.`EXEMPLAR` (`id_EXEMPLAR`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_EMPRESTIMO_USUARIO1`
    FOREIGN KEY (`id_USUARIO`)
    REFERENCES `mydb`.`USUARIO` (`id_USUARIO`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_EMPRESTIMO_EXEMPLAR1_idx` ON `mydb`.`EMPRESTIMO` (`id_EXEMPLAR` ASC) VISIBLE;

CREATE INDEX `fk_EMPRESTIMO_USUARIO1_idx` ON `mydb`.`EMPRESTIMO` (`id_USUARIO` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`AUTOR_LIVRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AUTOR_LIVRO` (
  `id_AUTOR` INT NOT NULL,
  `id_LIVRO` INT NOT NULL,
  PRIMARY KEY (`id_AUTOR`, `id_LIVRO`),
  CONSTRAINT `fk_AUTOR_LIVRO_AUTOR1`
    FOREIGN KEY (`id_AUTOR`)
    REFERENCES `mydb`.`AUTOR` (`id_AUTOR`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_AUTOR_LIVRO_LIVRO1`
    FOREIGN KEY (`id_LIVRO`)
    REFERENCES `mydb`.`LIVRO` (`id_LIVRO`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_AUTOR_LIVRO_LIVRO1_idx` ON `mydb`.`AUTOR_LIVRO` (`id_LIVRO` ASC) VISIBLE;

CREATE INDEX `fk_AUTOR_LIVRO_AUTOR1_idx` ON `mydb`.`AUTOR_LIVRO` (`id_AUTOR` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
