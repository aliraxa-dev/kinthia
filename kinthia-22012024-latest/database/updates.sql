
-- KIN-16
ALTER TABLE `kinthiavoyance_users` ADD `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
UPDATE kinthiavoyance_users SET createdAt = NULL;

-- KIN-21/22
ALTER TABLE `kinthiavoyance_userconsultations` ADD COLUMN `expertEarning` DECIMAL(10, 2) DEFAULT 0;


ALTER TABLE `kinthiavoyance_userquestions` ADD COLUMN `expertQEarning` DECIMAL(10, 2) DEFAULT 0;


ALTER TABLE `kinthiavoyance_orders` CHANGE `status` `status` ENUM('unpaid','pending','paid','denied','refund') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'unpaid';

ALTER TABLE `kinthiavoyance_userquestions` ADD `whoispaid` varchar(20) NULL;

UPDATE `kinthiavoyance_userquestions` SET `whoIsPaid` = (SELECT `type` FROM `kinthiavoyance_orders` WHERE `kinthiavoyance_userquestions`.`orderId` = `kinthiavoyance_orders`.`orderId` );

-- KIN-6
INSERT INTO `kinthiavoyance_consultations` (`name`, `created_at`, `updated_at`) VALUES ('chat', now(), now());
ALTER TABLE `kinthiavoyance_voyants` ADD `displayChat` MEDIUMINT(1) NULL DEFAULT '1' AFTER `displayEmail`;
-- ALTER TABLE `kinthiavoyance_voyants` ADD `displayChat` BOOLEAN NOT NULL DEFAULT FALSE AFTER `displayEmail`;

-- KIN-41
INSERT INTO `kinthiavoyance_settings` (`key`, `value`) VALUES ('expertListRefreshRate', '15');

-- KIN-44
ALTER TABLE `kinthiavoyance_voyants` ADD `payPalEnableDisable` VARCHAR(1) NULL DEFAULT '1' AFTER `supportDescription`;

-- KIN-4
INSERT INTO `kinthiavoyance_consultationtypes`(`consultaion_type`, `status`) VALUES ('4','1');
ALTER TABLE `kinthiavoyance_voyantcomments` CHANGE `type` `type` ENUM('Q','P','W','E','C') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Q:-Question,P:-Phone,W:-Webcam,E:Email,C:Chat';
INSERT INTO `kinthiavoyance_settings`(`key`, `value`) VALUES ('expertListLastRefreshedAt', NOW());