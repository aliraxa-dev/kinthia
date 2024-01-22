/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.0.31 : Database - aleadev_voyance_server
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `kinthiavoyance_adcriterias` */

DROP TABLE IF EXISTS `kinthiavoyance_adcriterias`;

CREATE TABLE `kinthiavoyance_adcriterias` (
  `adCriterionId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `htmlContent` text NOT NULL,
  PRIMARY KEY (`adCriterionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_ads` */

DROP TABLE IF EXISTS `kinthiavoyance_ads`;

CREATE TABLE `kinthiavoyance_ads` (
  `adId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `adCriterionId` mediumint unsigned NOT NULL,
  `page` varchar(64) NOT NULL,
  `place` varchar(64) NOT NULL,
  PRIMARY KEY (`adId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_bannedemails` */

DROP TABLE IF EXISTS `kinthiavoyance_bannedemails`;

CREATE TABLE `kinthiavoyance_bannedemails` (
  `banId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(64) NOT NULL,
  `dateBanned` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`banId`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_bannedips` */

DROP TABLE IF EXISTS `kinthiavoyance_bannedips`;

CREATE TABLE `kinthiavoyance_bannedips` (
  `banId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `remoteIp` varchar(15) NOT NULL,
  `banDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`banId`),
  KEY `remoteIp` (`remoteIp`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_captchacodes` */

DROP TABLE IF EXISTS `kinthiavoyance_captchacodes`;

CREATE TABLE `kinthiavoyance_captchacodes` (
  `publicCode` char(32) NOT NULL,
  `privateCode` char(4) NOT NULL,
  `generationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`publicCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_cartitems` */

DROP TABLE IF EXISTS `kinthiavoyance_cartitems`;

CREATE TABLE `kinthiavoyance_cartitems` (
  `cartItemId` int unsigned NOT NULL AUTO_INCREMENT,
  `cartId` char(32) NOT NULL,
  `itemId` mediumint unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `quantity` mediumint unsigned NOT NULL,
  `totalPrice` float(10,2) NOT NULL,
  `voyantId` mediumint unsigned NOT NULL,
  `type` varchar(29) DEFAULT NULL,
  `packageId` text,
  PRIMARY KEY (`cartItemId`),
  KEY `cartId` (`cartId`,`itemId`)
) ENGINE=MyISAM AUTO_INCREMENT=10925 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_carts` */

DROP TABLE IF EXISTS `kinthiavoyance_carts`;

CREATE TABLE `kinthiavoyance_carts` (
  `cartId` char(32) NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `itemsCount` mediumint unsigned DEFAULT '0',
  `userId` mediumint unsigned DEFAULT NULL,
  `status` enum('pending','ordered','deleted','init') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`cartId`),
  KEY `creationDate` (`creationDate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_consultations` */

DROP TABLE IF EXISTS `kinthiavoyance_consultations`;

CREATE TABLE `kinthiavoyance_consultations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_consultationtypes` */

DROP TABLE IF EXISTS `kinthiavoyance_consultationtypes`;

CREATE TABLE `kinthiavoyance_consultationtypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `consultaion_type` int DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_custommessages` */

DROP TABLE IF EXISTS `kinthiavoyance_custommessages`;

CREATE TABLE `kinthiavoyance_custommessages` (
  `messageId` varchar(20) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `userText` text NOT NULL,
  `userDefined` enum('0','1') NOT NULL DEFAULT '1',
  `type` enum('email','custom') NOT NULL DEFAULT 'email',
  PRIMARY KEY (`messageId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_languages` */

DROP TABLE IF EXISTS `kinthiavoyance_languages`;

CREATE TABLE `kinthiavoyance_languages` (
  `languageId` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `languageCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `languageFlag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`languageId`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_newsletteremails` */

DROP TABLE IF EXISTS `kinthiavoyance_newsletteremails`;

CREATE TABLE `kinthiavoyance_newsletteremails` (
  `emailId` mediumint NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `active` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`emailId`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orderitems` */

DROP TABLE IF EXISTS `kinthiavoyance_orderitems`;

CREATE TABLE `kinthiavoyance_orderitems` (
  `orderId` mediumint unsigned NOT NULL,
  `itemId` mediumint DEFAULT NULL,
  `packId` mediumint DEFAULT NULL,
  `quantity` mediumint unsigned NOT NULL,
  `totalPrice` float(10,2) unsigned NOT NULL,
  KEY `orderId` (`orderId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orderitems_(07)` */

DROP TABLE IF EXISTS `kinthiavoyance_orderitems_(07)`;

CREATE TABLE `kinthiavoyance_orderitems_(07)` (
  `orderId` mediumint unsigned NOT NULL,
  `itemId` mediumint DEFAULT NULL,
  `packId` mediumint DEFAULT NULL,
  `quantity` mediumint unsigned NOT NULL,
  `totalPrice` float(10,2) unsigned NOT NULL,
  KEY `orderId` (`orderId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orderitems_new` */

DROP TABLE IF EXISTS `kinthiavoyance_orderitems_new`;

CREATE TABLE `kinthiavoyance_orderitems_new` (
  `orderId` mediumint unsigned NOT NULL,
  `itemId` mediumint DEFAULT NULL,
  `packId` mediumint DEFAULT NULL,
  `quantity` mediumint unsigned NOT NULL,
  `totalPrice` float(10,2) unsigned NOT NULL,
  KEY `orderId` (`orderId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orders` */

DROP TABLE IF EXISTS `kinthiavoyance_orders`;

CREATE TABLE `kinthiavoyance_orders` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `amount` float(10,2) NOT NULL,
  `title` text NOT NULL,
  `ip` char(15) NOT NULL,
  `userId` mediumint unsigned DEFAULT NULL,
  `purchaseDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('unpaid','pending','paid','denied') NOT NULL DEFAULT 'unpaid',
  `type` varchar(20) DEFAULT NULL,
  `currency` char(3) NOT NULL,
  `itemId` varchar(255) DEFAULT NULL,
  `questionStatus` enum('pending','done') NOT NULL DEFAULT 'pending',
  `voyantId` mediumint unsigned NOT NULL,
  `invoiceId` mediumint unsigned DEFAULT NULL,
  `payPalId` varchar(128) DEFAULT NULL,
  `invoiceData` text,
  `paymentMethod` enum('payPal','check','stripe') NOT NULL,
  `stripeData` text,
  `cartId` char(32) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `purchaseDate` (`purchaseDate`),
  KEY `userId` (`userId`,`status`),
  KEY `voyantId` (`voyantId`),
  KEY `invoiceId` (`invoiceId`)
) ENGINE=MyISAM AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orders_(07)` */

DROP TABLE IF EXISTS `kinthiavoyance_orders_(07)`;

CREATE TABLE `kinthiavoyance_orders_(07)` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `amount` float(10,2) NOT NULL,
  `title` text NOT NULL,
  `ip` char(15) NOT NULL,
  `userId` mediumint unsigned DEFAULT NULL,
  `purchaseDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('unpaid','pending','paid','denied') NOT NULL DEFAULT 'unpaid',
  `currency` char(3) NOT NULL,
  `itemId` varchar(255) DEFAULT NULL,
  `questionStatus` enum('pending','done') NOT NULL DEFAULT 'pending',
  `voyantId` mediumint unsigned NOT NULL,
  `invoiceId` mediumint unsigned DEFAULT NULL,
  `payPalId` varchar(128) DEFAULT NULL,
  `invoiceData` text,
  `paymentMethod` enum('payPal','check','stripe') NOT NULL,
  `stripeData` text,
  `cartId` char(32) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `purchaseDate` (`purchaseDate`),
  KEY `userId` (`userId`,`status`),
  KEY `voyantId` (`voyantId`),
  KEY `invoiceId` (`invoiceId`)
) ENGINE=MyISAM AUTO_INCREMENT=4760 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orders_(07-10-2021))` */

DROP TABLE IF EXISTS `kinthiavoyance_orders_(07-10-2021))`;

CREATE TABLE `kinthiavoyance_orders_(07-10-2021))` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `amount` float(10,2) NOT NULL,
  `title` text NOT NULL,
  `ip` char(15) NOT NULL,
  `userId` mediumint unsigned DEFAULT NULL,
  `purchaseDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('unpaid','pending','paid','denied') NOT NULL DEFAULT 'unpaid',
  `currency` char(3) NOT NULL,
  `itemId` varchar(255) DEFAULT NULL,
  `questionStatus` enum('pending','done') NOT NULL DEFAULT 'pending',
  `voyantId` mediumint unsigned NOT NULL,
  `invoiceId` mediumint unsigned DEFAULT NULL,
  `payPalId` varchar(128) DEFAULT NULL,
  `invoiceData` text,
  `paymentMethod` enum('payPal','check','stripe') NOT NULL,
  `stripeData` text,
  `cartId` char(32) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `purchaseDate` (`purchaseDate`),
  KEY `userId` (`userId`,`status`),
  KEY `voyantId` (`voyantId`),
  KEY `invoiceId` (`invoiceId`)
) ENGINE=MyISAM AUTO_INCREMENT=4760 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orders_new` */

DROP TABLE IF EXISTS `kinthiavoyance_orders_new`;

CREATE TABLE `kinthiavoyance_orders_new` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `amount` float(10,2) NOT NULL,
  `title` text NOT NULL,
  `ip` char(15) NOT NULL,
  `userId` mediumint unsigned DEFAULT NULL,
  `purchaseDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('unpaid','pending','paid','denied') NOT NULL DEFAULT 'unpaid',
  `currency` char(3) NOT NULL,
  `itemId` varchar(255) DEFAULT NULL,
  `questionStatus` enum('pending','done') NOT NULL DEFAULT 'pending',
  `voyantId` mediumint unsigned NOT NULL,
  `invoiceId` mediumint unsigned DEFAULT NULL,
  `payPalId` varchar(128) DEFAULT NULL,
  `invoiceData` text,
  `paymentMethod` enum('payPal','check','stripe') NOT NULL,
  `stripeData` text,
  `cartId` char(32) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `purchaseDate` (`purchaseDate`),
  KEY `userId` (`userId`,`status`),
  KEY `voyantId` (`voyantId`),
  KEY `invoiceId` (`invoiceId`)
) ENGINE=MyISAM AUTO_INCREMENT=4712 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_orders_old` */

DROP TABLE IF EXISTS `kinthiavoyance_orders_old`;

CREATE TABLE `kinthiavoyance_orders_old` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `amount` float(10,2) NOT NULL,
  `title` text NOT NULL,
  `ip` char(15) NOT NULL,
  `userId` mediumint unsigned DEFAULT NULL,
  `purchaseDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('unpaid','pending','paid','denied') NOT NULL DEFAULT 'unpaid',
  `currency` char(3) NOT NULL,
  `itemId` varchar(255) DEFAULT NULL,
  `questionStatus` enum('pending','done') NOT NULL DEFAULT 'pending',
  `voyantId` mediumint unsigned NOT NULL,
  `invoiceId` mediumint unsigned DEFAULT NULL,
  `payPalId` varchar(128) DEFAULT NULL,
  `invoiceData` text,
  `paymentMethod` enum('payPal','check','stripe') NOT NULL,
  `stripeData` text,
  `cartId` char(32) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `purchaseDate` (`purchaseDate`),
  KEY `userId` (`userId`,`status`),
  KEY `voyantId` (`voyantId`),
  KEY `invoiceId` (`invoiceId`)
) ENGINE=MyISAM AUTO_INCREMENT=4760 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_packages` */

DROP TABLE IF EXISTS `kinthiavoyance_packages`;

CREATE TABLE `kinthiavoyance_packages` (
  `packageId` int NOT NULL AUTO_INCREMENT,
  `packageName` varchar(199) DEFAULT NULL,
  `packageDescription` text,
  `packageTime` varchar(55) DEFAULT NULL,
  `packagePrice` varchar(55) DEFAULT NULL,
  `packageBarredPrice` varchar(55) DEFAULT NULL,
  `packagePromo` tinyint NOT NULL DEFAULT '1',
  `packagePromoMsg` text,
  `packageDisplay` tinyint NOT NULL DEFAULT '1',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`packageId`)
) ENGINE=MyISAM AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;

/*Table structure for table `kinthiavoyance_paymentprocessors` */

DROP TABLE IF EXISTS `kinthiavoyance_paymentprocessors`;

CREATE TABLE `kinthiavoyance_paymentprocessors` (
  `processorId` varchar(32) NOT NULL,
  `displayName` varchar(64) NOT NULL,
  `enabled` enum('0','1') NOT NULL,
  `currency` char(3) NOT NULL,
  `testMode` enum('0','1') NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  `stripePublicKey` varchar(255) DEFAULT NULL,
  `stripePrivateKey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`processorId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_photos` */

DROP TABLE IF EXISTS `kinthiavoyance_photos`;

CREATE TABLE `kinthiavoyance_photos` (
  `photoId` int unsigned NOT NULL AUTO_INCREMENT,
  `itemId` mediumint unsigned NOT NULL,
  `src` varchar(32) NOT NULL,
  `addDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tempId` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`photoId`),
  KEY `tempId` (`tempId`),
  KEY `itemId` (`itemId`)
) ENGINE=MyISAM AUTO_INCREMENT=580 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_platforminvoices` */

DROP TABLE IF EXISTS `kinthiavoyance_platforminvoices`;

CREATE TABLE `kinthiavoyance_platforminvoices` (
  `platformId` int NOT NULL AUTO_INCREMENT,
  `voyantId` int NOT NULL,
  `invoicePlatformNumber` int NOT NULL,
  `invoice_date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`platformId`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=latin1;

/*Table structure for table `kinthiavoyance_settings` */

DROP TABLE IF EXISTS `kinthiavoyance_settings`;

CREATE TABLE `kinthiavoyance_settings` (
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_skills` */

DROP TABLE IF EXISTS `kinthiavoyance_skills`;

CREATE TABLE `kinthiavoyance_skills` (
  `skillId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `metaDescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `metaRobots` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `longDescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `longDescription2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `h1_tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `breadcrumb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createPage` tinyint NOT NULL DEFAULT '1',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`skillId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_tasks` */

DROP TABLE IF EXISTS `kinthiavoyance_tasks`;

CREATE TABLE `kinthiavoyance_tasks` (
  `taskId` varchar(32) NOT NULL,
  `status` enum('init','active','pause','stop','finish','next') NOT NULL DEFAULT 'active',
  `livePingTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `parsedItems` mediumint NOT NULL DEFAULT '0',
  `totalItems` mediumint NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  PRIMARY KEY (`taskId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_userconsultationrequests` */

DROP TABLE IF EXISTS `kinthiavoyance_userconsultationrequests`;

CREATE TABLE `kinthiavoyance_userconsultationrequests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `voyantId` int DEFAULT NULL,
  `consultationType` varchar(20) DEFAULT NULL,
  `consultationTime` varchar(222) DEFAULT NULL,
  `consultationDate` date DEFAULT NULL,
  `userRequestStatus` enum('P','A','C') NOT NULL DEFAULT 'P',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

/*Table structure for table `kinthiavoyance_userconsultations` */

DROP TABLE IF EXISTS `kinthiavoyance_userconsultations`;

CREATE TABLE `kinthiavoyance_userconsultations` (
  `userconsultationId` int NOT NULL AUTO_INCREMENT,
  `userId` mediumint NOT NULL,
  `voyantId` mediumint NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('A','C','E','P','VA') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'P' COMMENT 'P:-Pending, A:-Accept,C:-Cancel, E:- End, VA:- Voyant Accept',
  `duration` time DEFAULT NULL,
  `date` date NOT NULL,
  `ended_by` enum('U','V','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` enum('unpaid','pending','paid','denied') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userconsultationId`)
) ENGINE=InnoDB AUTO_INCREMENT=740 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_userfavs` */

DROP TABLE IF EXISTS `kinthiavoyance_userfavs`;

CREATE TABLE `kinthiavoyance_userfavs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voyantId` int NOT NULL,
  `userId` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `kinthiavoyance_userpackages` */

DROP TABLE IF EXISTS `kinthiavoyance_userpackages`;

CREATE TABLE `kinthiavoyance_userpackages` (
  `packId` mediumint NOT NULL AUTO_INCREMENT,
  `userId` mediumint NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','answered') NOT NULL DEFAULT 'pending',
  `packageId` mediumint NOT NULL,
  `summary` text,
  `orderId` mediumint NOT NULL,
  PRIMARY KEY (`packId`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `kinthiavoyance_userpackages_new` */

DROP TABLE IF EXISTS `kinthiavoyance_userpackages_new`;

CREATE TABLE `kinthiavoyance_userpackages_new` (
  `packId` mediumint NOT NULL AUTO_INCREMENT,
  `userId` mediumint NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','answered') NOT NULL DEFAULT 'pending',
  `packageId` mediumint NOT NULL,
  `summary` text,
  `orderId` mediumint NOT NULL,
  PRIMARY KEY (`packId`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `kinthiavoyance_userquestions` */

DROP TABLE IF EXISTS `kinthiavoyance_userquestions`;

CREATE TABLE `kinthiavoyance_userquestions` (
  `questionId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `userId` mediumint unsigned NOT NULL,
  `voyantId` mediumint unsigned NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','answered') NOT NULL DEFAULT 'pending',
  `voyantQuestionId` mediumint unsigned NOT NULL,
  `summary` text,
  `orderId` mediumint unsigned NOT NULL,
  PRIMARY KEY (`questionId`),
  KEY `userId` (`userId`),
  KEY `voyantId` (`voyantId`,`status`),
  KEY `orderId` (`orderId`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_userquestions_new` */

DROP TABLE IF EXISTS `kinthiavoyance_userquestions_new`;

CREATE TABLE `kinthiavoyance_userquestions_new` (
  `questionId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `userId` mediumint unsigned NOT NULL,
  `voyantId` mediumint unsigned NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','answered') NOT NULL DEFAULT 'pending',
  `voyantQuestionId` mediumint unsigned NOT NULL,
  `summary` text,
  `orderId` mediumint unsigned NOT NULL,
  PRIMARY KEY (`questionId`),
  KEY `userId` (`userId`),
  KEY `voyantId` (`voyantId`,`status`),
  KEY `orderId` (`orderId`)
) ENGINE=MyISAM AUTO_INCREMENT=3634 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_users` */

DROP TABLE IF EXISTS `kinthiavoyance_users`;

CREATE TABLE `kinthiavoyance_users` (
  `userId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `role` enum('administrator','voyant','user') NOT NULL,
  `active` enum('0','1') NOT NULL DEFAULT '1',
  `name` varchar(128) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `firstName` varchar(64) DEFAULT NULL,
  `lastName` varchar(64) DEFAULT NULL,
  `birthdayDate` date DEFAULT NULL,
  `mobilePhone` varchar(32) DEFAULT NULL,
  `newsletterEnabled` enum('0','1') NOT NULL DEFAULT '0',
  `namePrefix` varchar(10) DEFAULT NULL,
  `firstGalleryImageSrc` varchar(64) DEFAULT NULL,
  `photosCount` smallint unsigned NOT NULL DEFAULT '0',
  `ordersCount` mediumint unsigned NOT NULL DEFAULT '0',
  `address` text,
  `zipCode` text,
  `city` text,
  `country` text,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`),
  KEY `role` (`role`),
  KEY `login` (`login`)
) ENGINE=MyISAM AUTO_INCREMENT=2670 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_usertimeslots` */

DROP TABLE IF EXISTS `kinthiavoyance_usertimeslots`;

CREATE TABLE `kinthiavoyance_usertimeslots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voyantdatescheduleId` int NOT NULL,
  `voyanttimeslotId` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_verifications` */

DROP TABLE IF EXISTS `kinthiavoyance_verifications`;

CREATE TABLE `kinthiavoyance_verifications` (
  `code` varchar(32) NOT NULL,
  `itemId` varchar(32) NOT NULL,
  `type` enum('newsletterEmailAdd','newsletterEmailDel','userEmail','siteEmail') NOT NULL,
  `data` text NOT NULL,
  `creationDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`code`),
  KEY `itemId` (`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_voyantchats` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantchats`;

CREATE TABLE `kinthiavoyance_voyantchats` (
  `chatId` int NOT NULL AUTO_INCREMENT,
  `userconsultationId` int NOT NULL,
  `voyantId` int NOT NULL,
  `userId` int NOT NULL,
  `voyantname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sendby` enum('U','V') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`chatId`)
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_voyantcomments` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantcomments`;

CREATE TABLE `kinthiavoyance_voyantcomments` (
  `commentId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `remoteIp` varchar(15) NOT NULL,
  `orderId` mediumint DEFAULT NULL,
  `itemId` mediumint DEFAULT NULL,
  `userconsultationId` mediumint DEFAULT NULL,
  `voyantId` mediumint unsigned NOT NULL,
  `text` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `validated` enum('0','1') NOT NULL DEFAULT '0',
  `type` enum('Q','P','W','E') NOT NULL COMMENT 'Q:-Question,P:-Phone,W:-Webcam,E:Email',
  `rating` tinyint unsigned DEFAULT NULL,
  `userId` mediumint unsigned NOT NULL,
  `replyText` text,
  PRIMARY KEY (`commentId`),
  KEY `userId` (`userId`),
  KEY `voyantId` (`voyantId`),
  KEY `siteId` (`orderId`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_voyantconsultations` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantconsultations`;

CREATE TABLE `kinthiavoyance_voyantconsultations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `consultationId` int NOT NULL,
  `voyantId` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=412 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_voyantdateschedules` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantdateschedules`;

CREATE TABLE `kinthiavoyance_voyantdateschedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voyantId` int DEFAULT NULL,
  `consultationtypeId` int NOT NULL,
  `schedule_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_voyantlanguages` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantlanguages`;

CREATE TABLE `kinthiavoyance_voyantlanguages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `languageId` int NOT NULL,
  `voyantId` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_voyantmessages` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantmessages`;

CREATE TABLE `kinthiavoyance_voyantmessages` (
  `messageId` int NOT NULL AUTO_INCREMENT,
  `voyantId` int NOT NULL,
  `userId` int NOT NULL,
  `text` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `view` enum('1','0') NOT NULL DEFAULT '0',
  `sendby` enum('U','V') NOT NULL,
  PRIMARY KEY (`messageId`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=latin1;

/*Table structure for table `kinthiavoyance_voyantquestionprices` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantquestionprices`;

CREATE TABLE `kinthiavoyance_voyantquestionprices` (
  `priceId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `questionId` mediumint unsigned NOT NULL,
  `quantity` smallint unsigned NOT NULL,
  `price` float(10,2) NOT NULL,
  PRIMARY KEY (`priceId`),
  KEY `questionId` (`questionId`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_voyantquestions` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantquestions`;

CREATE TABLE `kinthiavoyance_voyantquestions` (
  `questionId` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `voyantId` mediumint unsigned NOT NULL,
  `title` text NOT NULL,
  `shortDescription` text NOT NULL,
  `longDescription` text NOT NULL,
  `price` float(10,2) NOT NULL,
  `metaTitle` text NOT NULL,
  `metaDescription` text NOT NULL,
  `headerDescription` text NOT NULL,
  `navigationName` text NOT NULL,
  `position` mediumint unsigned NOT NULL DEFAULT '0',
  `urlName` varchar(128) DEFAULT NULL,
  `imageSrc` varchar(32) DEFAULT NULL,
  `displayOnline` tinyint(1) NOT NULL DEFAULT '0',
  `adminValidation` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`questionId`),
  KEY `voyantId` (`voyantId`,`position`),
  KEY `urlName` (`urlName`)
) ENGINE=MyISAM AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_voyantreports` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantreports`;

CREATE TABLE `kinthiavoyance_voyantreports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voyantId` int NOT NULL,
  `userId` int NOT NULL,
  `consultantName` text NOT NULL,
  `explainProblem` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Table structure for table `kinthiavoyance_voyants` */

DROP TABLE IF EXISTS `kinthiavoyance_voyants`;

CREATE TABLE `kinthiavoyance_voyants` (
  `voyantId` mediumint unsigned NOT NULL,
  `name` text NOT NULL,
  `gender` enum('M','F') DEFAULT NULL,
  `displayNameOnInvoice` enum('0','1') NOT NULL,
  `firstName` text NOT NULL,
  `displayFirstNameOnInvoice` enum('0','1') NOT NULL,
  `lastName` text NOT NULL,
  `displayLastNameOnInvoice` enum('0','1') NOT NULL,
  `address` text NOT NULL,
  `zipCode` text NOT NULL,
  `city` text NOT NULL,
  `country` text NOT NULL,
  `timezone` text,
  `companyName` text NOT NULL,
  `companyFormat` text NOT NULL,
  `companyTaxNumber` text NOT NULL,
  `companyTvaNumber` text NOT NULL,
  `email` text NOT NULL,
  `phoneNumber` text NOT NULL,
  `mobileNumber` text NOT NULL,
  `voyantDescription` text NOT NULL,
  `voyantQuote` text,
  `hourlyDescription` text NOT NULL,
  `contactDescription` text NOT NULL,
  `supportDescription` text NOT NULL,
  `payPalEmail` text NOT NULL,
  `stripePublishableKey` text,
  `stripeSecretKey` text,
  `stripeEnable` int NOT NULL DEFAULT '0',
  `stripeStatementDescriptor` text,
  `stripeCaptureCharge` text,
  `stripePaymentRequestButtons` text,
  `stripeSavedCards` int DEFAULT NULL,
  `priority` mediumint unsigned NOT NULL,
  `title` text NOT NULL,
  `metaDescription` text NOT NULL,
  `headerDescription` text NOT NULL,
  `navigationName` text NOT NULL,
  `shortDescription` text NOT NULL,
  `tva` text NOT NULL,
  `displayTvaOnInvoice` enum('0','1') NOT NULL,
  `bankIban` text NOT NULL,
  `bankBic` text NOT NULL,
  `paidBackQuestion` text NOT NULL,
  `paidBackPhone` text NOT NULL,
  `paidBackWebcam` text NOT NULL,
  `paymentExpertPlatform` enum('0','1') NOT NULL DEFAULT '0',
  `imageSrc` varchar(32) DEFAULT NULL,
  `audioSrc` varchar(500) DEFAULT NULL,
  `urlName` varchar(255) DEFAULT NULL,
  `ratingAverage` float(10,2) DEFAULT NULL,
  `available` enum('0','1') NOT NULL DEFAULT '1',
  `displayPhone` mediumint DEFAULT NULL,
  `displayWebcam` mediumint DEFAULT NULL,
  `displayEmail` mediumint DEFAULT NULL,
  `consultationStatus` enum('OF','ON','B','P') NOT NULL DEFAULT 'OF' COMMENT 'OF:-offline,ON:-online,B:-busy,P:-processing',
  `consultationTime` datetime DEFAULT NULL,
  PRIMARY KEY (`voyantId`),
  KEY `urlName` (`urlName`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

/*Table structure for table `kinthiavoyance_voyantskills` */

DROP TABLE IF EXISTS `kinthiavoyance_voyantskills`;

CREATE TABLE `kinthiavoyance_voyantskills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `skillId` int NOT NULL,
  `voyantId` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=428 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kinthiavoyance_voyanttimeslots` */

DROP TABLE IF EXISTS `kinthiavoyance_voyanttimeslots`;

CREATE TABLE `kinthiavoyance_voyanttimeslots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voyantdatescheduleId` int NOT NULL,
  `timeslots` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1750 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
