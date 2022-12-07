
CREATE TABLE IF NOT EXISTS `User` (
  `id_usr` INT NOT NULL AUTO_INCREMENT,
  `nm_usr` VARCHAR(45) NOT NULL,
  `em_usr` VARCHAR(45) NOT NULL,
  `tel_usr` VARCHAR(10) NOT NULL,
  `pwd_usr` VARCHAR(64) NOT NULL,
  `type_usr` INT NOT NULL,
  `tk_usr` INT(6) NULL,
  PRIMARY KEY (`id_usr`))



-- -----------------------------------------------------
-- Table `Wallet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Wallet` (
  `id_wal` INT NOT NULL AUTO_INCREMENT,
  `id_usr` INT NOT NULL,
  `nknm_wal` VARCHAR(10) NOT NULL,
  `nm_wal` VARCHAR(45) NOT NULL,
  `num_wal` INT(16) NOT NULL,
  `date_wal` DATE NOT NULL,
  PRIMARY KEY (`id_wal`),
  INDEX `fk_wallet_user_idx` (`id_usr` ASC) VISIBLE,
  CONSTRAINT `fk_wallet_user`
    FOREIGN KEY (`id_usr`) REFERENCES `User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `ShippingType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ShippingType` (
  `id_shpgtype` INT NOT NULL AUTO_INCREMENT,
  `nm_shpgtype` VARCHAR(16) NOT NULL,
  `time_shpgtype` TIME NOT NULL,
  PRIMARY KEY (`id_shpgtype`))


-- -----------------------------------------------------
-- Table `Shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Shipping` (
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
    FOREIGN KEY (`id_usr`) REFERENCES `User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping_wallet`
    FOREIGN KEY (`id_wal`) REFERENCES `Wallet` (`id_wal`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping)shippingtype`
    FOREIGN KEY (`id_shpgtype`) REFERENCES `ShippingType` (`id_shpgtype`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `Locker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Locker` (
  `id_lkr` INT NOT NULL AUTO_INCREMENT,
  `nm_lkr` VARCHAR(45) NOT NULL,
  `dir_lkr` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_lkr`))


-- -----------------------------------------------------
-- Table `DoorType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DoorType` (
  `id_drtype` INT NOT NULL AUTO_INCREMENT,
  `nm_drtype` VARCHAR(16) NOT NULL,
  `hgt_drtype` DOUBLE NOT NULL,
  `wd_drtype` DOUBLE NOT NULL,
  `deep_drtype` DOUBLE NOT NULL,
  `wt_drtype` DOUBLE NULL,
  PRIMARY KEY (`id_drtype`))


-- -----------------------------------------------------
-- Table `Door`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Door` (
  `id_door` INT NOT NULL AUTO_INCREMENT,
  `id_lkr` INT NOT NULL,
  `id_drtype` INT NOT NULL,
  `nm_door` INT NOT NULL,
  `stat_door` INT NULL,
  PRIMARY KEY (`id_door`),
  INDEX `fk_locker_idx` (`id_lkr` ASC) VISIBLE,
  INDEX `fk_door_doortype_idx` (`id_drtype` ASC) VISIBLE,
  CONSTRAINT `fk_door_locker`
    FOREIGN KEY (`id_lkr`) REFERENCES `Locker` (`id_lkr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_door_doortype`
    FOREIGN KEY (`id_drtype`) REFERENCES `DoorType` (`id_drtype`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Contact` (
  `id_cont` INT NOT NULL AUTO_INCREMENT,
  `id_usr` INT NOT NULL,
  `nm_cont` VARCHAR(45) NOT NULL,
  `em_cont` VARCHAR(45) NOT NULL,
  `tel_cont` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_cont`),
  INDEX `fk_Contact_User_idx` (`id_usr` ASC) VISIBLE,
  CONSTRAINT `fk_Contact_User`
    FOREIGN KEY (`id_usr`) REFERENCES `User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `Shipping-Door`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Shipping-Door` (
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
    FOREIGN KEY (`trk_shpg`) REFERENCES `Shipping` (`trk_shpg`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping-door_door`
    FOREIGN KEY (`id_door`) REFERENCES `Door` (`id_door`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipping-door_contact`
    FOREIGN KEY (`id_cont`) REFERENCES `Contact` (`id_cont`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `Report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Report` (
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
    FOREIGN KEY (`id_usr`) REFERENCES `User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_door`
    FOREIGN KEY (`id_door`) REFERENCES `Door` (`id_door`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_shipping`
    FOREIGN KEY (`trk_shpg`) REFERENCES `Shipping` (`trk_shpg`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `Route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Route` (
  `id_rte` INT NOT NULL AUTO_INCREMENT,
  `id_usr` INT NOT NULL,
  `date_rte` DATETIME NOT NULL,
  `stat_rte` INT NOT NULL,
  PRIMARY KEY (`id_rte`),
  INDEX `fk_route_user_idx` (`id_usr` ASC) VISIBLE,
  CONSTRAINT `fk_route_user`
    FOREIGN KEY (`id_usr`) REFERENCES `User` (`id_usr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `RouteDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RouteDetail` (
  `id_rtedtl` INT NOT NULL AUTO_INCREMENT,
  `id_rte` INT NOT NULL,
  `id_lkr` INT NOT NULL,
  `ord_rtedtl` INT NOT NULL,
  PRIMARY KEY (`id_rtedtl`),
  INDEX `fk_routedetail_route_idx` (`id_rte` ASC) VISIBLE,
  INDEX `fk_routedetail_locker_idx` (`id_lkr` ASC) VISIBLE,
  CONSTRAINT `fk_routedetail_route`
    FOREIGN KEY (`id_rte`) REFERENCES `Route` (`id_rte`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_routedetail_locker`
    FOREIGN KEY (`id_lkr`) REFERENCES `Locker` (`id_lkr`)
    ON DELETE NO ACTION ON UPDATE NO ACTION)
