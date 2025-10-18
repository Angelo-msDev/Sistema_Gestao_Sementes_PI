-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema EloRural
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema EloRural
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `EloRural` DEFAULT CHARACTER SET utf8 ;
USE `EloRural` ;

-- -----------------------------------------------------
-- Table `EloRural`.`Administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Administrador` (
  `idAdministrador` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(15) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `armazem_responsavel` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idAdministrador`),
  UNIQUE INDEX `idAdministrador_UNIQUE` (`idAdministrador` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  UNIQUE INDEX `senha_UNIQUE` (`senha` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `EloRural`.`Armazem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Armazem` (
  `idArmazem` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `localizacao` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `capacidade` VARCHAR(45) NOT NULL,
  `administradorFK` INT NOT NULL,
  PRIMARY KEY (`idArmazem`),
  UNIQUE INDEX `idArmazem_UNIQUE` (`idArmazem` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_Armazem_Administrador_idx` (`administradorFK` ASC) VISIBLE,
  CONSTRAINT `fk_Armazem_Administrador`
    FOREIGN KEY (`administradorFK`)
    REFERENCES `mydb`.`Administrador` (`idAdministrador`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EloRural`.`Produtor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Produtor` (
  `idAgricultor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NULL,
  `localizacao` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `propirdade` VARCHAR(100) NOT NULL,
  `registro_rural` VARCHAR(100) NOT NULL,
  `administradorFK` INT NULL,
  PRIMARY KEY (`idAgricultor`),
  UNIQUE INDEX `idProdutor_UNIQUE` (`idAgricultor` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  UNIQUE INDEX `registro_rural_UNIQUE` (`registro_rural` ASC) VISIBLE,
  UNIQUE INDEX `localizacao_UNIQUE` (`localizacao` ASC) VISIBLE,
  INDEX `fk_Agricultor_Administrador1_idx` (`administradorFK` ASC) VISIBLE,
  CONSTRAINT `fk_Agricultor_Administrador1`
    FOREIGN KEY (`administradorFK`)
    REFERENCES `mydb`.`Administrador` (`idAdministrador`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EloRural`.`Lote_Semente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Lote_Semente` (
  `idLote_Semente` INT NOT NULL AUTO_INCREMENT,
  `cod_QR` INT NOT NULL,
  `semente` VARCHAR(100) NOT NULL,
  `data_colheita` DATE NOT NULL,
  `validade` DATE NOT NULL,
  `origem` VARCHAR(100) NOT NULL,
  `qualidade` DECIMAL(5,2) NOT NULL,
  `status` ENUM('Em estoque', 'Distribuído', 'Comprometido', 'Finalizado') NOT NULL,
  `armazemFK` INT NOT NULL,
  `agricultorFK` INT NOT NULL,
  PRIMARY KEY (`idLote_Semente`),
  UNIQUE INDEX `idLotes_Sementes_UNIQUE` (`idLote_Semente` ASC) VISIBLE,
  UNIQUE INDEX `cod_QR_UNIQUE` (`cod_QR` ASC) VISIBLE,
  INDEX `fk_Lote_Semente_Armazem1_idx` (`armazemFK` ASC) VISIBLE,
  INDEX `fk_Lote_Semente_Agricultor1_idx` (`agricultorFK` ASC) VISIBLE,
  CONSTRAINT `fk_Lote_Semente_Armazem1`
    FOREIGN KEY (`armazemFK`)
    REFERENCES `mydb`.`Armazem` (`idArmazem`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Lote_Semente_Agricultor1`
    FOREIGN KEY (`agricultorFK`)
    REFERENCES `mydb`.`Produtor` (`idAgricultor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EloRural`.`Auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Auditor` (
  `idAuditor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `orgao_vinculado` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`idAuditor`),
  UNIQUE INDEX `idComprador_UNIQUE` (`idAuditor` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EloRural`.`Relatorio_Auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Relatorio_Auditor` (
  `idRelatorio_Auditor` INT NOT NULL AUTO_INCREMENT,
  `auditor` VARCHAR(45) NOT NULL,
  `data_emissao` DATE NOT NULL,
  `lote` INT NOT NULL,
  `parecer` VARCHAR(45) NOT NULL,
  `conformidade` ENUM('Conforme', 'Não Conforme', 'Em Análise') NOT NULL,
  `auditorFK` INT NULL,
  `administradorFK` INT NULL,
  `data_recebimento_admin` DATE NULL,
  PRIMARY KEY (`idRelatorio_Auditor`),
  UNIQUE INDEX `idRelatorio_Auditor_UNIQUE` (`idRelatorio_Auditor` ASC) VISIBLE,
  INDEX `fk_Relatorio_Auditor_Auditor1_idx` (`auditorFK` ASC) VISIBLE,
  INDEX `fk_Relatorio_Auditor_Administrador1_idx` (`administradorFK` ASC) VISIBLE,
  CONSTRAINT `fk_Relatorio_Auditor_Auditor1`
    FOREIGN KEY (`auditorFK`)
    REFERENCES `mydb`.`Auditor` (`idAuditor`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Relatorio_Auditor_Administrador1`
    FOREIGN KEY (`administradorFK`)
    REFERENCES `mydb`.`Administrador` (`idAdministrador`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EloRural`.`Alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Alerta` (
  `idAlerta` INT NOT NULL AUTO_INCREMENT,
  `tipo_alerta` ENUM("temperatura", "umidade", "validade") NOT NULL,
  `mesagem` VARCHAR(45) NOT NULL,
  `data_emissao` DATETIME NOT NULL,
  `status` ENUM("ativo", "resolvido") NOT NULL,
  `loteFK` INT NOT NULL,
  PRIMARY KEY (`idAlerta`),
  INDEX `fk_Alerta_Lote_Semente1_idx` (`loteFK` ASC) VISIBLE,
  CONSTRAINT `fk_Alerta_Lote_Semente1`
    FOREIGN KEY (`loteFK`)
    REFERENCES `mydb`.`Lote_Semente` (`idLote_Semente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EloRural`.`Distribuicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EloRural`.`Distribuicao` (
  `idDistribuicao` INT NOT NULL,
  `data_envio` DATE NOT NULL,
  `data_recebimento` DATE NOT NULL,
  `status_entrega` VARCHAR(45) NOT NULL,
  `loteFK` INT NOT NULL,
  `agricultorFK` INT NOT NULL,
  PRIMARY KEY (`idDistribuicao`),
  INDEX `fk_Distribuicao_Lote_Semente1_idx` (`loteFK` ASC) VISIBLE,
  INDEX `fk_Distribuicao_Produtor1_idx` (`agricultorFK` ASC) VISIBLE,
  CONSTRAINT `fk_Distribuicao_Lote_Semente1`
    FOREIGN KEY (`loteFK`)
    REFERENCES `mydb`.`Lote_Semente` (`idLote_Semente`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Distribuicao_Produtor1`
    FOREIGN KEY (`agricultorFK`)
    REFERENCES `mydb`.`Produtor` (`idAgricultor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
