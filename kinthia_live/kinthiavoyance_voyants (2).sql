-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 21, 2023 at 07:49 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kinthia_dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `kinthiavoyance_voyants`
--

CREATE TABLE `kinthiavoyance_voyants` (
  `voyantId` mediumint(8) UNSIGNED NOT NULL,
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
  `timezone` text NOT NULL,
  `companyName` text NOT NULL,
  `companyFormat` text NOT NULL,
  `companyTaxNumber` text NOT NULL,
  `companyTvaNumber` text NOT NULL,
  `email` text NOT NULL,
  `phoneNumber` text NOT NULL,
  `mobileNumber` text NOT NULL,
  `voyantDescription` text NOT NULL,
  `voyantQuote` text NOT NULL,
  `hourlyDescription` text NOT NULL,
  `contactDescription` text NOT NULL,
  `supportDescription` text NOT NULL,
  `payPalEmail` text NOT NULL,
  `stripePublishableKey` text DEFAULT NULL,
  `stripeSecretKey` text DEFAULT NULL,
  `stripeEnable` int(11) NOT NULL DEFAULT 0,
  `stripeStatementDescriptor` text DEFAULT NULL,
  `stripeCaptureCharge` text DEFAULT NULL,
  `stripePaymentRequestButtons` text DEFAULT NULL,
  `stripeSavedCards` int(11) DEFAULT NULL,
  `priority` mediumint(8) UNSIGNED NOT NULL,
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
  `audioSrc` varchar(500) NOT NULL,
  `urlName` varchar(255) DEFAULT NULL,
  `ratingAverage` float(10,2) DEFAULT NULL,
  `available` enum('0','1') NOT NULL DEFAULT '1',
  `displayPhone` mediumint(9) DEFAULT NULL,
  `displayWebcam` mediumint(9) DEFAULT NULL,
  `displayEmail` mediumint(9) DEFAULT NULL,
  `consultationStatus` enum('OF','ON','B','P') NOT NULL DEFAULT 'OF' COMMENT 'OF:-offline,ON:-online,B:-busy,P:-processing',
  `consultationTime` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `kinthiavoyance_voyants`
--

INSERT INTO `kinthiavoyance_voyants` (`voyantId`, `name`, `gender`, `displayNameOnInvoice`, `firstName`, `displayFirstNameOnInvoice`, `lastName`, `displayLastNameOnInvoice`, `address`, `zipCode`, `city`, `country`, `timezone`, `companyName`, `companyFormat`, `companyTaxNumber`, `companyTvaNumber`, `email`, `phoneNumber`, `mobileNumber`, `voyantDescription`, `voyantQuote`, `hourlyDescription`, `contactDescription`, `supportDescription`, `payPalEmail`, `stripePublishableKey`, `stripeSecretKey`, `stripeEnable`, `stripeStatementDescriptor`, `stripeCaptureCharge`, `stripePaymentRequestButtons`, `stripeSavedCards`, `priority`, `title`, `metaDescription`, `headerDescription`, `navigationName`, `shortDescription`, `tva`, `displayTvaOnInvoice`, `bankIban`, `bankBic`, `paidBackQuestion`, `paidBackPhone`, `paidBackWebcam`, `paymentExpertPlatform`, `imageSrc`, `audioSrc`, `urlName`, `ratingAverage`, `available`, `displayPhone`, `displayWebcam`, `displayEmail`, `consultationStatus`, `consultationTime`) VALUES
(0, 'KINTHIA_COMPANY', NULL, '0', 'KINTHIA', '1', 'COMPANY', '1', '4 rue Gaston Bonnier', '92600', 'Asnières-sur-Seine', 'France', 'Europe/Paris', 'Test Company format', 'Test Company format', '51792279500029', '', 'kinthia.company@kinthia.com', '0160666556', '0160666556', '', '', '', '', '', 'kinthia.company@kinthia.com', 'pk_test_51Mvx1PGlnID89KQYps5IQwW8wVrci6pcriowN1E2KtWDTBrLXFc25Z2CS7Zhmvz3SaudrvljquXSjb4ScHo19rRT00PSeBAVms', 'sk_test_51Mvx1PGlnID89KQY8aQo268ltGHQtTAAZQ0FZIazR7bup6GSi94KothjiZhUHURlO6T8D2cStNmvsspAe1clrPts00Hs8CGoD2', 1, 'kinthia.com', '1', '1', 1, 0, 'Consultation de voyance en direct et tirages des tarots en ligne avec la voyante Kinthia', 'La voyante, médium professionnelle Kinthia répondra en direct à vos questions durant la consultation.', 'Kinthia : voyante / médium', 'Kinthia : consultation de voyance', '', '12', '0', '1146511156514', '154874154545445451', '50', '1', '1', '1', NULL, '9f5ef899.mp3', NULL, NULL, '1', NULL, NULL, NULL, 'ON', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kinthiavoyance_voyants`
--
ALTER TABLE `kinthiavoyance_voyants`
  ADD PRIMARY KEY (`voyantId`),
  ADD KEY `urlName` (`urlName`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
