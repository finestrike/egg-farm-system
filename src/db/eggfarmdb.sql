/*
SQLyog Ultimate v10.42 
MySQL - 5.6.10-log : Database - eggfarmdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`eggfarmdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `Id` char(32) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Role` tinyint(4) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `additionalcost` */

DROP TABLE IF EXISTS `additionalcost`;

CREATE TABLE `additionalcost` (
  `Id` char(36) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Value` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `consumable` */

DROP TABLE IF EXISTS `consumable`;

CREATE TABLE `consumable` (
  `Id` char(36) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Type` tinyint(4) DEFAULT NULL,
  `Unit` varchar(50) DEFAULT NULL,
  `UnitPrice` bigint(20) DEFAULT NULL,
  `Active` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `consumableusage` */

DROP TABLE IF EXISTS `consumableusage`;

CREATE TABLE `consumableusage` (
  `Id` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Total` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `consumableusagedetail` */

DROP TABLE IF EXISTS `consumableusagedetail`;

CREATE TABLE `consumableusagedetail` (
  `UsageId` char(36) NOT NULL,
  `HouseId` char(36) NOT NULL,
  `ConsumableId` char(36) NOT NULL,
  `Count` int(11) DEFAULT NULL,
  `UnitPrice` bigint(20) DEFAULT NULL,
  `SubTotal` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`UsageId`,`HouseId`,`ConsumableId`),
  KEY `HouseId` (`HouseId`),
  KEY `ConsumableId` (`ConsumableId`),
  CONSTRAINT `consumableusagedetail_ibfk_1` FOREIGN KEY (`UsageId`) REFERENCES `consumableusage` (`Id`),
  CONSTRAINT `consumableusagedetail_ibfk_2` FOREIGN KEY (`HouseId`) REFERENCES `henhouse` (`Id`),
  CONSTRAINT `consumableusagedetail_ibfk_3` FOREIGN KEY (`ConsumableId`) REFERENCES `consumable` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `eggproduction` */

DROP TABLE IF EXISTS `eggproduction`;

CREATE TABLE `eggproduction` (
  `Id` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `eggproductiondetail` */

DROP TABLE IF EXISTS `eggproductiondetail`;

CREATE TABLE `eggproductiondetail` (
  `ProductionId` char(36) NOT NULL,
  `HouseId` char(36) NOT NULL,
  `GoodEggCount` int(11) DEFAULT NULL,
  `RetailQuantity` decimal(10,3) DEFAULT NULL,
  `Fcr` decimal(10,3) DEFAULT NULL,
  `CrackedEggCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`ProductionId`,`HouseId`),
  KEY `HouseId` (`HouseId`),
  CONSTRAINT `eggproductiondetail_ibfk_1` FOREIGN KEY (`ProductionId`) REFERENCES `eggproduction` (`Id`),
  CONSTRAINT `eggproductiondetail_ibfk_2` FOREIGN KEY (`HouseId`) REFERENCES `henhouse` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `Id` char(36) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Salary` bigint(20) DEFAULT NULL,
  `Active` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `employeecost` */

DROP TABLE IF EXISTS `employeecost`;

CREATE TABLE `employeecost` (
  `Id` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `Total` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `employeecostdetail` */

DROP TABLE IF EXISTS `employeecostdetail`;

CREATE TABLE `employeecostdetail` (
  `CostId` char(36) NOT NULL,
  `EmployeeId` char(36) NOT NULL,
  `Present` bit(1) DEFAULT NULL,
  `Salary` bigint(20) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CostId`,`EmployeeId`),
  KEY `EmployeeId` (`EmployeeId`),
  CONSTRAINT `employeecostdetail_ibfk_1` FOREIGN KEY (`CostId`) REFERENCES `employeecost` (`Id`),
  CONSTRAINT `employeecostdetail_ibfk_2` FOREIGN KEY (`EmployeeId`) REFERENCES `employee` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `hen` */

DROP TABLE IF EXISTS `hen`;

CREATE TABLE `hen` (
  `Id` char(36) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Count` int(11) DEFAULT NULL,
  `Active` bit(1) DEFAULT NULL,
  `Cost` bigint(20) DEFAULT NULL,
  `HouseId` char(36) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `hendepreciation` */

DROP TABLE IF EXISTS `hendepreciation`;

CREATE TABLE `hendepreciation` (
  `Id` char(36) NOT NULL,
  `Date` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `hendepreciationdetail` */

DROP TABLE IF EXISTS `hendepreciationdetail`;

CREATE TABLE `hendepreciationdetail` (
  `DepreciationId` char(36) NOT NULL,
  `HouseId` char(36) NOT NULL,
  `InitialPrice` decimal(10,3) DEFAULT NULL,
  `SellingPrice` decimal(10,3) DEFAULT NULL,
  `Profit` decimal(10,3) DEFAULT NULL,
  `Depreciation` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`DepreciationId`,`HouseId`),
  KEY `HouseId` (`HouseId`),
  CONSTRAINT `hendepreciationdetail_ibfk_1` FOREIGN KEY (`DepreciationId`) REFERENCES `hendepreciation` (`Id`),
  CONSTRAINT `hendepreciationdetail_ibfk_2` FOREIGN KEY (`HouseId`) REFERENCES `henhouse` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `henhouse` */

DROP TABLE IF EXISTS `henhouse`;

CREATE TABLE `henhouse` (
  `Id` char(36) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `PurchaseCost` bigint(20) DEFAULT NULL,
  `YearUsage` int(11) DEFAULT NULL,
  `Depreciation` bigint(20) DEFAULT NULL,
  `ProductiveAge` int(11) DEFAULT NULL,
  `Active` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
