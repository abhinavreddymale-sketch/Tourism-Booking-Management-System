-- MySQL dump 10.13  Distrib 9.7.1, for macos15 (arm64)
--
-- Host: localhost    Database: tourism_booking_db
-- ------------------------------------------------------
-- Server version	9.7.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '1f34e05c-80f6-11f1-882f-7a4a07423956:1-103';

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `package_id` int NOT NULL,
  `booking_date` date NOT NULL,
  `travel_date` date NOT NULL,
  `number_of_travelers` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `booking_status` enum('Pending','Confirmed','Cancelled','Completed') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`booking_id`),
  KEY `customer_id` (`customer_id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `booking_chk_1` CHECK ((`number_of_travelers` > 0)),
  CONSTRAINT `booking_chk_2` CHECK ((`total_amount` > 0)),
  CONSTRAINT `booking_chk_3` CHECK ((`travel_date` >= `booking_date`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,1,1,'2026-10-06','2026-12-15',4,63996.00,'Confirmed'),(2,2,2,'2026-10-06','2026-12-20',2,37998.00,'Confirmed'),(3,3,3,'2026-10-06','2027-01-10',3,68997.00,'Confirmed'),(4,4,4,'2026-10-06','2027-01-15',2,39998.00,'Pending'),(5,5,5,'2026-10-06','2027-02-05',3,80997.00,'Confirmed');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `booking_summary`
--

DROP TABLE IF EXISTS `booking_summary`;
/*!50001 DROP VIEW IF EXISTS `booking_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `booking_summary` AS SELECT 
 1 AS `booking_id`,
 1 AS `customer_name`,
 1 AS `email`,
 1 AS `package_name`,
 1 AS `booking_date`,
 1 AS `travel_date`,
 1 AS `number_of_travelers`,
 1 AS `total_amount`,
 1 AS `booking_status`,
 1 AS `payment_method`,
 1 AS `payment_status`,
 1 AS `transaction_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Abhinav Reddy','abhinav@example.com','9876543210','Male','2007-02-08'),(2,'Rahul Sharma','rahul.sharma@example.com','9876543211','Male','2006-05-14'),(3,'Sneha Reddy','sneha.reddy@example.com','9876543212','Female','2007-08-22'),(4,'Arjun Kumar','arjun.kumar@example.com','9876543213','Male','2006-11-03'),(5,'Priya Nair','priya.nair@example.com','9876543214','Female','2007-01-19');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_booking_history`
--

DROP TABLE IF EXISTS `customer_booking_history`;
/*!50001 DROP VIEW IF EXISTS `customer_booking_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_booking_history` AS SELECT 
 1 AS `customer_id`,
 1 AS `full_name`,
 1 AS `email`,
 1 AS `booking_id`,
 1 AS `package_name`,
 1 AS `booking_date`,
 1 AS `travel_date`,
 1 AS `number_of_travelers`,
 1 AS `total_amount`,
 1 AS `booking_status`,
 1 AS `payment_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `destination`
--

DROP TABLE IF EXISTS `destination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destination` (
  `destination_id` int NOT NULL AUTO_INCREMENT,
  `destination_name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'India',
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`destination_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination`
--

LOCK TABLES `destination` WRITE;
/*!40000 ALTER TABLE `destination` DISABLE KEYS */;
INSERT INTO `destination` VALUES (1,'Goa Beach Escape','Goa','Goa','India','Beaches, nightlife, water sports and coastal scenery.'),(2,'Manali Adventure','Manali','Himachal Pradesh','India','Mountains, trekking, adventure activities and scenic valleys.'),(3,'Royal Rajasthan','Jaipur','Rajasthan','India','Forts, palaces, heritage sites and traditional culture.'),(4,'Kerala Backwaters','Alappuzha','Kerala','India','Backwaters, houseboats, beaches and lush landscapes.'),(5,'Kashmir Paradise','Srinagar','Jammu and Kashmir','India','Lakes, mountains, gardens and Himalayan scenery.');
/*!40000 ALTER TABLE `destination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `hotel_id` int NOT NULL AUTO_INCREMENT,
  `hotel_name` varchar(150) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'India',
  `star_rating` int DEFAULT NULL,
  `room_price` decimal(10,2) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `available_rooms` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`hotel_id`),
  CONSTRAINT `hotel_chk_1` CHECK ((`star_rating` between 1 and 5)),
  CONSTRAINT `hotel_chk_2` CHECK ((`room_price` > 0)),
  CONSTRAINT `hotel_chk_3` CHECK ((`available_rooms` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'Taj Exotica Resort','Goa','Goa','India',5,12000.00,'9876500001',20),(2,'Sea View Resort','Manali','Himachal Pradesh','India',4,7500.00,'9876500002',15),(3,'Royal Palace Hotel','Jaipur','Rajasthan','India',5,9000.00,'9876500003',12),(4,'Backwater Paradise Resort','Alappuzha','Kerala','India',4,6500.00,'9876500004',18),(5,'Kashmir Valley Resort','Srinagar','Jammu and Kashmir','India',4,8000.00,'9876500005',10);
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package` (
  `package_id` int NOT NULL AUTO_INCREMENT,
  `package_name` varchar(150) NOT NULL,
  `duration_days` int NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `max_travelers` int NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`package_id`),
  UNIQUE KEY `package_name` (`package_name`),
  CONSTRAINT `package_chk_1` CHECK ((`duration_days` > 0)),
  CONSTRAINT `package_chk_2` CHECK ((`base_price` > 0)),
  CONSTRAINT `package_chk_3` CHECK ((`max_travelers` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES (1,'Goa Beach Escape',4,15999.00,20,'A relaxing Goa holiday covering beaches, sightseeing, nightlife and water activities.'),(2,'Manali Adventure',5,18999.00,18,'An adventurous Himalayan trip featuring trekking, sightseeing and mountain experiences.'),(3,'Royal Rajasthan',6,22999.00,20,'Explore the royal heritage of Rajasthan through forts, palaces and cultural attractions.'),(4,'Kerala Backwaters',5,19999.00,16,'A peaceful Kerala experience featuring backwaters, houseboats and scenic landscapes.'),(5,'Kashmir Paradise',6,26999.00,15,'A scenic Kashmir tour covering lakes, gardens, mountains and famous valley attractions.');
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_destination`
--

DROP TABLE IF EXISTS `package_destination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_destination` (
  `package_id` int NOT NULL,
  `destination_id` int NOT NULL,
  `visit_order` int NOT NULL,
  PRIMARY KEY (`package_id`,`destination_id`),
  KEY `destination_id` (`destination_id`),
  CONSTRAINT `package_destination_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `package_destination_ibfk_2` FOREIGN KEY (`destination_id`) REFERENCES `destination` (`destination_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_destination`
--

LOCK TABLES `package_destination` WRITE;
/*!40000 ALTER TABLE `package_destination` DISABLE KEYS */;
INSERT INTO `package_destination` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1);
/*!40000 ALTER TABLE `package_destination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `package_details`
--

DROP TABLE IF EXISTS `package_details`;
/*!50001 DROP VIEW IF EXISTS `package_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `package_details` AS SELECT 
 1 AS `package_id`,
 1 AS `package_name`,
 1 AS `base_price`,
 1 AS `duration_days`,
 1 AS `destination_name`,
 1 AS `city`,
 1 AS `hotel_name`,
 1 AS `star_rating`,
 1 AS `transport_type`,
 1 AS `provider_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `package_hotel`
--

DROP TABLE IF EXISTS `package_hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_hotel` (
  `package_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `nights` int NOT NULL,
  PRIMARY KEY (`package_id`,`hotel_id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `package_hotel_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `package_hotel_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `package_hotel_chk_1` CHECK ((`nights` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_hotel`
--

LOCK TABLES `package_hotel` WRITE;
/*!40000 ALTER TABLE `package_hotel` DISABLE KEYS */;
INSERT INTO `package_hotel` VALUES (1,1,3),(2,2,4),(3,3,3),(4,4,3),(5,5,5);
/*!40000 ALTER TABLE `package_hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_transport`
--

DROP TABLE IF EXISTS `package_transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_transport` (
  `package_id` int NOT NULL,
  `transport_id` int NOT NULL,
  `transport_role` enum('Arrival','Departure','Local') NOT NULL DEFAULT 'Local',
  PRIMARY KEY (`package_id`,`transport_id`),
  KEY `transport_id` (`transport_id`),
  CONSTRAINT `package_transport_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `package_transport_ibfk_2` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`transport_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_transport`
--

LOCK TABLES `package_transport` WRITE;
/*!40000 ALTER TABLE `package_transport` DISABLE KEYS */;
INSERT INTO `package_transport` VALUES (1,1,'Arrival'),(2,2,'Arrival'),(3,3,'Arrival'),(4,4,'Local'),(5,5,'Arrival');
/*!40000 ALTER TABLE `package_transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `transaction_id` varchar(100) NOT NULL,
  `payment_date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('UPI','Credit Card','Debit Card','Net Banking','Cash') NOT NULL,
  `payment_status` enum('Pending','Successful','Failed','Refunded') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `booking_id` (`booking_id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `payment_chk_1` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,'TXN202610060001','2026-10-06',63996.00,'UPI','Successful'),(2,2,'TXN202610060002','2026-10-06',37998.00,'Credit Card','Successful'),(3,3,'TXN202610060003','2026-10-06',68997.00,'UPI','Successful'),(4,4,'TXN202610060004','2026-10-06',39998.00,'Debit Card','Pending'),(5,5,'TXN202610060005','2026-10-06',80997.00,'Net Banking','Successful');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_payment_success` AFTER INSERT ON `payment` FOR EACH ROW BEGIN
    IF NEW.payment_status = 'Successful' THEN
        UPDATE booking
        SET booking_status = 'Confirmed'
        WHERE booking_id = NEW.booking_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transport`
--

DROP TABLE IF EXISTS `transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transport` (
  `transport_id` int NOT NULL AUTO_INCREMENT,
  `transport_type` enum('Flight','Train','Bus','Cab') NOT NULL,
  `provider_name` varchar(150) NOT NULL,
  `vehicle_number` varchar(50) DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `available_seats` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`transport_id`),
  CONSTRAINT `transport_chk_1` CHECK ((`price` > 0)),
  CONSTRAINT `transport_chk_2` CHECK ((`available_seats` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport`
--

LOCK TABLES `transport` WRITE;
/*!40000 ALTER TABLE `transport` DISABLE KEYS */;
INSERT INTO `transport` VALUES (1,'Flight','IndiGo Airlines','6E-4521','Delhi','Goa','08:00:00','10:30:00',6500.00,35),(2,'Bus','RedBus Travels','RB-101','Delhi','Manali','20:00:00','08:00:00',1800.00,25),(3,'Train','Indian Railways','12956','Delhi','Jaipur','06:00:00','10:30:00',1200.00,80),(4,'Bus','Kerala Travels','KT-205','Kochi','Alappuzha','09:00:00','11:00:00',600.00,30),(5,'Flight','Air India','AI-824','Delhi','Srinagar','07:30:00','09:00:00',5500.00,40);
/*!40000 ALTER TABLE `transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `booking_summary`
--

/*!50001 DROP VIEW IF EXISTS `booking_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `booking_summary` AS select `b`.`booking_id` AS `booking_id`,`c`.`full_name` AS `customer_name`,`c`.`email` AS `email`,`p`.`package_name` AS `package_name`,`b`.`booking_date` AS `booking_date`,`b`.`travel_date` AS `travel_date`,`b`.`number_of_travelers` AS `number_of_travelers`,`b`.`total_amount` AS `total_amount`,`b`.`booking_status` AS `booking_status`,`py`.`payment_method` AS `payment_method`,`py`.`payment_status` AS `payment_status`,`py`.`transaction_id` AS `transaction_id` from (((`booking` `b` join `customer` `c` on((`b`.`customer_id` = `c`.`customer_id`))) join `package` `p` on((`b`.`package_id` = `p`.`package_id`))) left join `payment` `py` on((`b`.`booking_id` = `py`.`booking_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customer_booking_history`
--

/*!50001 DROP VIEW IF EXISTS `customer_booking_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_booking_history` AS select `c`.`customer_id` AS `customer_id`,`c`.`full_name` AS `full_name`,`c`.`email` AS `email`,`b`.`booking_id` AS `booking_id`,`p`.`package_name` AS `package_name`,`b`.`booking_date` AS `booking_date`,`b`.`travel_date` AS `travel_date`,`b`.`number_of_travelers` AS `number_of_travelers`,`b`.`total_amount` AS `total_amount`,`b`.`booking_status` AS `booking_status`,`py`.`payment_status` AS `payment_status` from (((`customer` `c` join `booking` `b` on((`c`.`customer_id` = `b`.`customer_id`))) join `package` `p` on((`b`.`package_id` = `p`.`package_id`))) left join `payment` `py` on((`b`.`booking_id` = `py`.`booking_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `package_details`
--

/*!50001 DROP VIEW IF EXISTS `package_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `package_details` AS select `p`.`package_id` AS `package_id`,`p`.`package_name` AS `package_name`,`p`.`base_price` AS `base_price`,`p`.`duration_days` AS `duration_days`,`d`.`destination_name` AS `destination_name`,`d`.`city` AS `city`,`h`.`hotel_name` AS `hotel_name`,`h`.`star_rating` AS `star_rating`,`t`.`transport_type` AS `transport_type`,`t`.`provider_name` AS `provider_name` from ((((((`package` `p` left join `package_destination` `pd` on((`p`.`package_id` = `pd`.`package_id`))) left join `destination` `d` on((`pd`.`destination_id` = `d`.`destination_id`))) left join `package_hotel` `ph` on((`p`.`package_id` = `ph`.`package_id`))) left join `hotel` `h` on((`ph`.`hotel_id` = `h`.`hotel_id`))) left join `package_transport` `pt` on((`p`.`package_id` = `pt`.`package_id`))) left join `transport` `t` on((`pt`.`transport_id` = `t`.`transport_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-06 23:33:09
