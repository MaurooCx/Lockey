-- -----------------------------------------------------
-- Schema lockey_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lockey_db` DEFAULT CHARACTER SET utf8 ;
USE `lockey_db` ;

-- -----------------------------------------------------
-- Table `lockey_db`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`User` (
  `id_usr` INT NOT NULL AUTO_INCREMENT,
  `nm_usr` VARCHAR(45) NOT NULL,
  `em_usr` VARCHAR(45) NOT NULL,
  `tel_usr` VARCHAR(10) NOT NULL,
  `pwd_usr` VARCHAR(64) NOT NULL,
  `type_usr` INT NOT NULL,
  `tk_usr` INT(6) NULL,
  PRIMARY KEY (`id_usr`))



-- -----------------------------------------------------
-- Table `lockey_db`.`Wallet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Wallet` (
  `id_wal` INT NOT NULL AUTO_INCREMENT,
  `id_usr` INT NOT NULL,
  `nknm_wal` VARCHAR(10) NOT NULL,
  `nm_wal` VARCHAR(45) NOT NULL,
  `num_wal` VARCHAR(16) NOT NULL,
  `date_wal` DATE NOT NULL,
  PRIMARY KEY (`id_wal`),
  INDEX `fk_wallet_user_idx` (`id_usr` ASC) VISIBLE,
  CONSTRAINT `fk_wallet_user`
    FOREIGN KEY (`id_usr`) REFERENCES `lockey_db`.`User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `lockey_db`.`ShippingType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`ShippingType` (
  `id_shpgtype` INT NOT NULL AUTO_INCREMENT,
  `nm_shpgtype` VARCHAR(16) NOT NULL,
  `time_shpgtype` TIME NOT NULL,
  PRIMARY KEY (`id_shpgtype`))


-- -----------------------------------------------------
-- Table `lockey_db`.`Shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Shipping` (
  `trk_shpg` INT NOT NULL,
  `id_usr` INT NOT NULL,
  `id_shpgtype` INT NOT NULL,
  `stat_shpg` INT NOT NULL,
  `dts_shpg` DATETIME NOT NULL DEFAULT NOW(),
  `dte_shpg` DATETIME NULL,
  `pr_shpg` DOUBLE NOT NULL,
  `hgt_shpg` DOUBLE NOT NULL,
  `wd_shpg` DOUBLE NOT NULL,
  `deep_shpg` DOUBLE NOT NULL,
  `wt_shpg` DOUBLE NULL,
  `id_wal` INT NOT NULL,
  PRIMARY KEY (`trk_shpg`),
  UNIQUE INDEX `trk_shpg_UNIQUE` (`trk_shpg` ASC) VISIBLE,
  INDEX `fk_shipping_user_idx` (`id_usr` ASC) VISIBLE,
  INDEX `fk_shipping_wallet_idx` (`id_wal` ASC) VISIBLE,
  INDEX `fk_shipping)shippingtype_idx` (`id_shpgtype` ASC) VISIBLE,
  CONSTRAINT `fk_shipping_user`
    FOREIGN KEY (`id_usr`) REFERENCES `lockey_db`.`User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping_wallet`
    FOREIGN KEY (`id_wal`) REFERENCES `lockey_db`.`Wallet` (`id_wal`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping)shippingtype`
    FOREIGN KEY (`id_shpgtype`) REFERENCES `lockey_db`.`ShippingType` (`id_shpgtype`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `lockey_db`.`Locker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Locker` (
  `id_lkr` INT NOT NULL AUTO_INCREMENT,
  `nm_lkr` VARCHAR(45) NOT NULL,
  `dir_lkr` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_lkr`))


-- -----------------------------------------------------
-- Table `lockey_db`.`DoorType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`DoorType` (
  `id_drtype` INT NOT NULL AUTO_INCREMENT,
  `nm_drtype` VARCHAR(16) NOT NULL,
  `hgt_drtype` DOUBLE NOT NULL,
  `wd_drtype` DOUBLE NOT NULL,
  `deep_drtype` DOUBLE NOT NULL,
  `wt_drtype` DOUBLE NULL,
  PRIMARY KEY (`id_drtype`))


-- -----------------------------------------------------
-- Table `lockey_db`.`Door`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Door` (
  `id_door` INT NOT NULL AUTO_INCREMENT,
  `id_lkr` INT NOT NULL,
  `id_drtype` INT NOT NULL,
  `nm_door` INT NOT NULL,
  `stat_door` INT NULL,
  PRIMARY KEY (`id_door`),
  INDEX `fk_locker_idx` (`id_lkr` ASC) VISIBLE,
  INDEX `fk_door_doortype_idx` (`id_drtype` ASC) VISIBLE,
  CONSTRAINT `fk_door_locker`
    FOREIGN KEY (`id_lkr`) REFERENCES `lockey_db`.`Locker` (`id_lkr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_door_doortype`
    FOREIGN KEY (`id_drtype`) REFERENCES `lockey_db`.`DoorType` (`id_drtype`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `lockey_db`.`Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Contact` (
  `id_cont` INT NOT NULL AUTO_INCREMENT,
  `id_usr` INT NOT NULL,
  `nm_cont` VARCHAR(45) NOT NULL,
  `em_cont` VARCHAR(45) NOT NULL,
  `tel_cont` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_cont`),
  INDEX `fk_Contact_User_idx` (`id_usr` ASC) VISIBLE,
  CONSTRAINT `fk_Contact_User`
    FOREIGN KEY (`id_usr`) REFERENCES `lockey_db`.`User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `lockey_db`.`Shipping-Door`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Shipping-Door` (
  `id_shpgdr` INT NOT NULL AUTO_INCREMENT,
  `id_door` INT NOT NULL,
  `trk_shpg` INT NOT NULL,
  `id_cont` INT NOT NULL,
  `edge_shpgdr` INT(1) NOT NULL,
  `busy_shpgdr` INT(1) NOT NULL DEFAULT 0,
  `qr_shpgdr` INT(6) NULL,
  PRIMARY KEY (`id_shpgdr`),
  INDEX `fk_shipping-door_shipping_idx` (`trk_shpg` ASC) VISIBLE,
  INDEX `fk_shipping-door_door_idx` (`id_door` ASC) VISIBLE,
  INDEX `fk_shipping-door_contact_idx` (`id_cont` ASC) VISIBLE,
  CONSTRAINT `fk_shipping-door_shipping`
    FOREIGN KEY (`trk_shpg`) REFERENCES `lockey_db`.`Shipping` (`trk_shpg`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping-door_door`
    FOREIGN KEY (`id_door`) REFERENCES `lockey_db`.`Door` (`id_door`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping-door_contact`
    FOREIGN KEY (`id_cont`) REFERENCES `lockey_db`.`Contact` (`id_cont`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `lockey_db`.`Report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Report` (
  `id_rpt` INT NOT NULL AUTO_INCREMENT,
  `id_usr` INT NOT NULL,
  `id_door` INT NOT NULL,
  `trk_shpg` INT NULL,
  `tit_rpt` VARCHAR(45) NOT NULL,
  `msg_rpt` VARCHAR(256) NULL,
  PRIMARY KEY (`id_rpt`),
  INDEX `fk_report_user_idx` (`id_usr` ASC) VISIBLE,
  INDEX `fk_report_door_idx` (`id_door` ASC) VISIBLE,
  INDEX `fk_report_shipping_idx` (`trk_shpg` ASC) VISIBLE,
  CONSTRAINT `fk_report_user`
    FOREIGN KEY (`id_usr`) REFERENCES `lockey_db`.`User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_door`
    FOREIGN KEY (`id_door`) REFERENCES `lockey_db`.`Door` (`id_door`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_shipping`
    FOREIGN KEY (`trk_shpg`) REFERENCES `lockey_db`.`Shipping` (`trk_shpg`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `lockey_db`.`Route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`Route` (
  `id_rte` INT NOT NULL AUTO_INCREMENT,
  `id_usr` INT NOT NULL,
  `date_rte` DATETIME NOT NULL,
  `stat_rte` INT NOT NULL,
  PRIMARY KEY (`id_rte`),
  INDEX `fk_route_user_idx` (`id_usr` ASC) VISIBLE,
  CONSTRAINT `fk_route_user`
    FOREIGN KEY (`id_usr`) REFERENCES `lockey_db`.`User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `lockey_db`.`RouteDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lockey_db`.`RouteDetail` (
  `id_rtedtl` INT NOT NULL AUTO_INCREMENT,
  `id_rte` INT NOT NULL,
  `id_lkr` INT NOT NULL,
  `ord_rtedtl` INT NOT NULL,
  PRIMARY KEY (`id_rtedtl`),
  INDEX `fk_routedetail_route_idx` (`id_rte` ASC) VISIBLE,
  INDEX `fk_routedetail_locker_idx` (`id_lkr` ASC) VISIBLE,
  CONSTRAINT `fk_routedetail_route`
    FOREIGN KEY (`id_rte`) REFERENCES `lockey_db`.`Route` (`id_rte`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_routedetail_locker`
    FOREIGN KEY (`id_lkr`)
    REFERENCES `lockey_db`.`lockey_db`.`Locker` (`id_lkr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE USER 'lockey_usr' IDENTIFIED BY 'lockey_pwd_issi_pz';

-- GRANT SELECT, INSERT, TRIGGER, UPDATE ON TABLE `lockey_db`.* TO 'lockey_usr';
-- GRANT EXECUTE ON ROUTINE `lockey_db`.* TO 'lockey_usr';

-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `lockey_db`;
INSERT INTO `lockey_db`.`User` (`id_usr`, `nm_usr`, `em_usr`, `tel_usr`, `pwd_usr`, `type_usr`, `tk_usr`) VALUES (DEFAULT, 'Gustavo Peduzzi', 'gustavopdzz0@gmail.com', '5610338516', 'e476acd96b5d450ccad79cc6bfa1f928784e47a713c4311c307a6db0f7ad8a41', 3, NULL);
INSERT INTO `lockey_db`.`User` (`id_usr`, `nm_usr`, `em_usr`, `tel_usr`, `pwd_usr`, `type_usr`, `tk_usr`) VALUES (DEFAULT, 'Luis Martinez', 'luis@lockeriit.com', '5566282790', '904d5a563bb1c36cd6bbcd35ffd2ffb15d167d75b56f5da68b927532cef1151f', 2, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`Wallet`
-- -----------------------------------------------------
START TRANSACTION;
USE `lockey_db`;
INSERT INTO `lockey_db`.`Wallet` (`id_wal`, `id_usr`, `nknm_wal`, `nm_wal`, `num_wal`, `date_wal`) VALUES (DEFAULT, 1, 'Gustavo', 'Gustavo Alain Peduzzi Acevedo', '5243123265475854', '2025-09-22');
INSERT INTO `lockey_db`.`Wallet` (`id_wal`, `id_usr`, `nknm_wal`, `nm_wal`, `num_wal`, `date_wal`) VALUES (DEFAULT, 2, 'Luis', 'Luis Sanchez Martinez', '5243127556349076', '2024-12-31');

COMMIT;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`ShippingType`
-- -----------------------------------------------------
START TRANSACTION;
USE `lockey_db`;
INSERT INTO `lockey_db`.`ShippingType` (`id_shpgtype`, `nm_shpgtype`, `time_shpgtype`) VALUES (DEFAULT, 'Normal', '24:00:00');
INSERT INTO `lockey_db`.`ShippingType` (`id_shpgtype`, `nm_shpgtype`, `time_shpgtype`) VALUES (DEFAULT, 'Express', '12:00:00');

COMMIT;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`Shipping`
-- -----------------------------------------------------
--START TRANSACTION;
--USE `lockey_db`;
--INSERT INTO `lockey_db`.`Shipping` (`trk_shpg`, `ownr_shpg`, `id_shpgtype`, `stat_shpg`, `dts_shpg`, `dte_shpg`, `pr_shpg`, `hgt_shpg`, `wd_shpg`, `deep_shpg`, `wt_shpg`, `id_wal`) VALUES (DEFAULT, 'Pequeño', 10.93, 40.64, 63.5, NULL);
--INSERT INTO `lockey_db`.`Shipping` (`trk_shpg`, `ownr_shpg`, `id_shpgtype`, `stat_shpg`, `dts_shpg`, `dte_shpg`, `pr_shpg`, `hgt_shpg`, `wd_shpg`, `deep_shpg`, `wt_shpg`, `id_wal`) VALUES (DEFAULT, 'Mediano', 23.13, 40.64, 63.5, NULL);
--INSERT INTO `lockey_db`.`Shipping` (`trk_shpg`, `ownr_shpg`, `id_shpgtype`, `stat_shpg`, `dts_shpg`, `dte_shpg`, `pr_shpg`, `hgt_shpg`, `wd_shpg`, `deep_shpg`, `wt_shpg`, `id_wal`) VALUES (DEFAULT, 'Grande', 50.8, 40.64, 63.5, NULL);

--COMMIT;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`Locker`
-- -----------------------------------------------------
START TRANSACTION;
USE `lockey_db`;
INSERT INTO `lockey_db`.`Locker` (`id_lkr`, `nm_lkr`, `dir_lkr`) VALUES (DEFAULT, 'Plaza torres', 'Av. Miguel Othón de Mendizábal Ote. 343, Nueva Industrial Vallejo, Gustavo A. Madero, 07700 Ciudad de México, CDMX');
INSERT INTO `lockey_db`.`Locker` (`id_lkr`, `nm_lkr`, `dir_lkr`) VALUES (DEFAULT, 'Santa Fe', 'Vasco de Quiroga 3800, Santa Fe, Contadero, Cuajimalpa de Morelos, 05348 Ciudad de México, CDMX');

COMMIT;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`DoorType`
-- -----------------------------------------------------
START TRANSACTION;
USE `lockey_db`;
INSERT INTO `lockey_db`.`DoorType` (`id_drtype`, `nm_drtype`, `hgt_drtype`, `wd_drtype`, `deep_drtype`, `wt_drtype`) VALUES (DEFAULT, 'Pequeño', 10.93, 40.64, 63.5, NULL);
INSERT INTO `lockey_db`.`DoorType` (`id_drtype`, `nm_drtype`, `hgt_drtype`, `wd_drtype`, `deep_drtype`, `wt_drtype`) VALUES (DEFAULT, 'Mediano', 23.13, 40.64, 63.5, NULL);
INSERT INTO `lockey_db`.`DoorType` (`id_drtype`, `nm_drtype`, `hgt_drtype`, `wd_drtype`, `deep_drtype`, `wt_drtype`) VALUES (DEFAULT, 'Grande', 50.8, 40.64, 63.5, NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`Door`
-- -----------------------------------------------------
START TRANSACTION;
USE `lockey_db`;
INSERT INTO `lockey_db`.`Door` (`id_door`, `id_lkr`, `id_drtype`, `nm_door`, `stat_door`) VALUES (DEFAULT, 1, 2, 01, 1);
INSERT INTO `lockey_db`.`Door` (`id_door`, `id_lkr`, `id_drtype`, `nm_door`, `stat_door`) VALUES (DEFAULT, 2, 3, 02, 2);
INSERT INTO `lockey_db`.`Door` (`id_door`, `id_lkr`, `id_drtype`, `nm_door`, `stat_door`) VALUES (DEFAULT, 2, 1, 03, 3);

COMMIT;

-- -----------------------------------------------------
-- Data for table `lockey_db`.`Contact`
-- -----------------------------------------------------
START TRANSACTION;
USE `lockey_db`;
INSERT INTO `lockey_db`.`Contact` (`id_cont`, `id_usr`, `nm_cont`, `em_cont`, `tel_cont`) VALUES (DEFAULT, 1, 2, 01, 1);
INSERT INTO `lockey_db`.`Contact` (`id_cont`, `id_usr`, `nm_cont`, `em_cont`, `tel_cont`) VALUES (DEFAULT, 1, 2, 01, 1);
INSERT INTO `lockey_db`.`Contact` (`id_cont`, `id_usr`, `nm_cont`, `em_cont`, `tel_cont`) VALUES (DEFAULT, 1, 2, 01, 1);

COMMIT;