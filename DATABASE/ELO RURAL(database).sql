drop schema elorural;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema elorural
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema elorural
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `elorural` DEFAULT CHARACTER SET utf8mb3 ;
USE `elorural` ;

-- -----------------------------------------------------
-- Table `elorural`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`administrador` (
  `idAdministrador` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `armazem_responsavel` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idAdministrador`),
  UNIQUE INDEX `idAdministrador_UNIQUE` (`idAdministrador` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3
COMMENT = '		';


-- -----------------------------------------------------
-- Table `elorural`.`produtor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`produtor` (
  `idAgricultor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `cep` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `propriedade` VARCHAR(100) NOT NULL,
  `registro_rural` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idAgricultor`),
  UNIQUE INDEX `idProdutor_UNIQUE` (`idAgricultor` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  UNIQUE INDEX `registro_rural_UNIQUE` (`registro_rural` ASC) VISIBLE,
  UNIQUE INDEX `localizacao_UNIQUE` (`cep` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `elorural`.`armazem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`armazem` (
  `idArmazem` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cep` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `capacidade` DECIMAL(10,2) NOT NULL,
  `produtorFK` INT NOT NULL,
  `administradorFK` INT NOT NULL,
  PRIMARY KEY (`idArmazem`),
  UNIQUE INDEX `idArmazem_UNIQUE` (`idArmazem` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_armazem_produtor1_idx` (`produtorFK` ASC) VISIBLE,
  INDEX `fk_armazem_administrador1_idx` (`administradorFK` ASC) VISIBLE,
  CONSTRAINT `fk_armazem_produtor1`
    FOREIGN KEY (`produtorFK`)
    REFERENCES `elorural`.`produtor` (`idAgricultor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_armazem_administrador1`
    FOREIGN KEY (`administradorFK`)
    REFERENCES `elorural`.`administrador` (`idAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `elorural`.`lote_semente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`lote_semente` (
  `idLote_Semente` INT NOT NULL AUTO_INCREMENT,
  `cod_QR` INT NOT NULL,
  `semente` VARCHAR(100) NOT NULL,
  `valor_lote` DECIMAL(10,2) NOT NULL,
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
  CONSTRAINT `fk_Lote_Semente_Agricultor1`
    FOREIGN KEY (`agricultorFK`)
    REFERENCES `elorural`.`produtor` (`idAgricultor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Lote_Semente_Armazem1`
    FOREIGN KEY (`armazemFK`)
    REFERENCES `elorural`.`armazem` (`idArmazem`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `elorural`.`alerta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`alerta` (
  `idAlerta` INT NOT NULL AUTO_INCREMENT,
  `tipo_alerta` ENUM('temperatura', 'umidade', 'validade') NOT NULL,
  `mensagem` VARCHAR(100) NOT NULL,
  `data_emissao` DATETIME NOT NULL,
  `status` ENUM('ativo', 'resolvido') NOT NULL,
  `loteFK` INT NOT NULL,
  PRIMARY KEY (`idAlerta`),
  INDEX `fk_Alerta_Lote_Semente1_idx` (`loteFK` ASC) VISIBLE,
  CONSTRAINT `fk_Alerta_Lote_Semente1`
    FOREIGN KEY (`loteFK`)
    REFERENCES `elorural`.`lote_semente` (`idLote_Semente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `elorural`.`auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`auditor` (
  `idAuditor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `orgao_vinculado` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idAuditor`),
  UNIQUE INDEX `idComprador_UNIQUE` (`idAuditor` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `elorural`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NULL,
  `registro_rural` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `idCliente_UNIQUE` (`idCliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elorural`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(100) NOT NULL,
  `numero` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cep` VARCHAR(100) NOT NULL,
  `complemento` VARCHAR(100) NULL,
  `clienteFK` INT NOT NULL,
  `lote_sementeFK` INT NOT NULL,
  PRIMARY KEY (`idEntrega`),
  UNIQUE INDEX `identrega_UNIQUE` (`idEntrega` ASC) VISIBLE,
  INDEX `fk_entrega_cliente1_idx` (`clienteFK` ASC) VISIBLE,
  INDEX `fk_entrega_lote_semente1_idx` (`lote_sementeFK` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_cliente1`
    FOREIGN KEY (`clienteFK`)
    REFERENCES `elorural`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_entrega_lote_semente1`
    FOREIGN KEY (`lote_sementeFK`)
    REFERENCES `elorural`.`lote_semente` (`idLote_Semente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elorural`.`rastreamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`rastreamento` (
  `idDistribuicao` INT NOT NULL AUTO_INCREMENT,
  `data_envio` DATE NOT NULL,
  `data_recebimento` DATETIME NULL DEFAULT NULL,
  `status_entrega` VARCHAR(45) NOT NULL,
  `entregaFK` INT NOT NULL,
  PRIMARY KEY (`idDistribuicao`),
  INDEX `fk_rastreamento_entrega1_idx` (`entregaFK` ASC) VISIBLE,
  CONSTRAINT `fk_rastreamento_entrega1`
    FOREIGN KEY (`entregaFK`)
    REFERENCES `elorural`.`entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `elorural`.`relatorio_auditor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `elorural`.`relatorio_auditor` (
  `idRelatorio_Auditor` INT NOT NULL AUTO_INCREMENT,
  `auditor` VARCHAR(45) NOT NULL,
  `data_emissao` DATE NOT NULL,
  `lote` INT NOT NULL,
  `parecer` VARCHAR(45) NOT NULL,
  `conformidade` ENUM('Conforme', 'Não Conforme', 'Em Análise') NOT NULL,
  `auditor_idAuditor` INT NOT NULL,
  `administradorFK` INT NOT NULL,
  `data_recebimento_admin` DATE NULL DEFAULT NULL,
  `lote_semente_idLote_Semente` INT NOT NULL,
  PRIMARY KEY (`idRelatorio_Auditor`),
  UNIQUE INDEX `idRelatorio_Auditor_UNIQUE` (`idRelatorio_Auditor` ASC) VISIBLE,
  INDEX `fk_relatorio_auditor_auditor1_idx` (`auditor_idAuditor` ASC) VISIBLE,
  INDEX `fk_relatorio_auditor_administrador1_idx` (`administradorFK` ASC) VISIBLE,
  INDEX `fk_relatorio_auditor_lote_semente1_idx` (`lote_semente_idLote_Semente` ASC) VISIBLE,
  CONSTRAINT `fk_relatorio_auditor_auditor1`
    FOREIGN KEY (`auditor_idAuditor`)
    REFERENCES `elorural`.`auditor` (`idAuditor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relatorio_auditor_administrador1`
    FOREIGN KEY (`administradorFK`)
    REFERENCES `elorural`.`administrador` (`idAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relatorio_auditor_lote_semente1`
    FOREIGN KEY (`lote_semente_idLote_Semente`)
    REFERENCES `elorural`.`lote_semente` (`idLote_Semente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
