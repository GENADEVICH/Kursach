-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Иван','Иванов','ул. Ленина, д. 10, г. Москва','ivan@example.com','+7 (123) 456-7890'),(2,'Мария','Петрова','пр. Победы, д. 20, г. Санкт-Петербург','maria@example.com','+7 (987) 654-3210'),(3,'Алексей','Смирнов','ул. Гагарина, д. 5, г. Екатеринбург','alex@example.com','+7 (901) 234-5678'),(4,'Елена','Сидорова','пр. Ленина, д. 15, г. Новосибирск','elena@example.com','+7 (902) 345-6789'),(5,'Андрей','Козлов','ул. Советская, д. 30, г. Казань','andrey@example.com','+7 (903) 456-7890'),(6,'Ольга','Павлова','пр. Мира, д. 25, г. Владивосток','olga@example.com','+7 (904) 567-8901'),(7,'Дмитрий','Николаев','ул. Лермонтова, д. 40, г. Самара','dmitry@example.com','+7 (905) 678-9012'),(8,'Татьяна','Иванова','пр. Кирова, д. 35, г. Челябинск','tatiana@example.com','+7 (906) 789-0123'),(9,'Сергей','Петров','ул. Калинина, д. 50, г. Уфа','sergey@example.com','+7 (907) 890-1234'),(10,'Анастасия','Смирнова','пр. Ленина, д. 55, г. Тюмень','anastasia@example.com','+7 (908) 901-2345');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'Samsung','South Korea','www.samsung.com'),(2,'Apple','USA','www.apple.com'),(3,'Sony','Japan','www.sony.com'),(4,'LG','South Korea','www.lg.com'),(5,'Huawei','China','www.huawei.com'),(6,'Dell','USA','www.dell.com'),(7,'HP','USA','www.hp.com'),(8,'Lenovo','China','www.lenovo.com'),(9,'Asus','Taiwan','www.asus.com'),(10,'Microsoft','USA','www.microsoft.com');
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orders_id` int NOT NULL,
  `products_id` int NOT NULL,
  `quantity` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_details_products1_idx` (`products_id`),
  KEY `fk_order_details_orders1_idx` (`orders_id`),
  CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_order_details_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (1,1,1,2),(2,1,2,1),(3,2,3,3),(4,3,4,1),(5,3,5,2),(6,4,6,1),(7,4,7,2),(8,5,8,1),(9,5,9,2),(10,6,10,1),(11,6,11,1),(12,7,12,1),(13,7,13,2),(14,8,14,1),(15,8,15,2),(16,9,16,1),(17,9,17,2),(18,10,18,1),(19,10,19,1),(20,1,20,1),(21,2,1,1),(22,2,2,1),(23,3,3,1),(24,3,4,2),(25,4,5,1),(26,4,6,1),(27,5,7,1),(28,5,8,2),(29,6,9,1),(30,6,10,1),(31,7,11,1),(32,7,12,2),(33,8,13,1),(34,8,14,1),(35,9,15,1),(36,9,16,2),(37,10,17,1),(38,10,18,1);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customers_id` int DEFAULT NULL,
  `order_datetime` datetime DEFAULT NULL,
  `order_status` enum('обрабатывается','создан','завершен') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orders_customers1_idx` (`customers_id`),
  CONSTRAINT `fk_orders_customers1` FOREIGN KEY (`customers_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2024-03-29 10:00:00','создан'),(2,2,'2024-03-30 11:00:00','обрабатывается'),(3,3,'2024-03-30 12:00:00','создан'),(4,4,'2024-03-31 13:00:00','создан'),(5,5,'2024-03-31 14:00:00','обрабатывается'),(6,6,'2024-03-31 15:00:00','обрабатывается'),(7,7,'2024-04-01 16:00:00','создан'),(8,8,'2024-04-01 17:00:00','обрабатывается'),(9,9,'2024-04-02 18:00:00','создан'),(10,10,'2024-04-02 19:00:00','обрабатывается'),(11,1,'2024-04-02 20:00:00','обрабатывается'),(12,2,'2024-04-03 21:00:00','создан'),(13,3,'2024-04-03 22:00:00','обрабатывается'),(14,4,'2024-04-03 23:00:00','обрабатывается'),(15,5,'2024-04-04 10:00:00','создан'),(16,6,'2024-04-04 11:00:00','обрабатывается'),(17,7,'2024-04-04 12:00:00','обрабатывается'),(18,8,'2024-04-05 13:00:00','создан'),(19,9,'2024-04-05 14:00:00','обрабатывается'),(20,10,'2024-04-05 15:00:00','обрабатывается');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES (1,'Смартфоны','Мобильные устройства'),(2,'Ноутбуки','Портативные компьютеры'),(3,'Телевизоры','Электроника для дома'),(4,'Планшеты','Портативные компьютеры'),(5,'Ноутбук аксессуары','Аксессуары для ноутбуков'),(6,'Мониторы','Компьютерные мониторы'),(7,'Наушники','Звуковые устройства'),(8,'Фотоаппараты','Оптические устройства для фотографии'),(9,'Принтеры','Офисная техника'),(10,'Игровые консоли','Компьютерные игровые устройства');
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `specifications` text,
  `quantity` int NOT NULL,
  `manufacturers_id` int NOT NULL,
  `product_categories_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_products_manufacturers1_idx` (`manufacturers_id`),
  KEY `fk_products_product_categories1_idx` (`product_categories_id`),
  CONSTRAINT `fk_products_manufacturers1` FOREIGN KEY (`manufacturers_id`) REFERENCES `manufacturers` (`id`),
  CONSTRAINT `fk_products_product_categories1` FOREIGN KEY (`product_categories_id`) REFERENCES `product_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Samsung Galaxy S21','Флагманский смартфон',799.99,'6.2\" экран, 8 ГБ RAM, 128 ГБ хранилище',100,1,1),(2,'MacBook Pro','Профессиональный ноутбук',1999.99,'13\" экран, Intel Core i5, 16 ГБ RAM, 512 ГБ SSD',50,2,2),(3,'Sony Bravia X90J','4K HDR LED Телевизор',1499.99,'55\" экран, Dolby Vision, Android TV',30,3,3),(4,'iPad Air','Планшет',599.99,'10.9\" экран, Apple A14 Bionic, 64 ГБ хранилище',40,2,4),(5,'Apple Pencil','Аксессуар для iPad',99.99,'Беспроводное зарядка, Ускоренная сенсорная реакция',100,2,5),(6,'LG UltraGear','Игровой монитор',699.99,'27\" экран, WQHD, 144 Гц, AMD FreeSync',20,4,6),(7,'Sony WH-1000XM4','Беспроводные наушники',349.99,'Активное шумоподавление, 30 часов работы от одной зарядки',80,3,7),(8,'Canon EOS R6','Зеркальная камера',2499.99,'20.1 Мп сенсор, 4K видео, Встроенный Wi-Fi',15,3,8),(9,'HP LaserJet Pro M404dn','Черно-белый лазерный принтер',199.99,'Двусторонняя печать, Скорость 40 стр/мин',30,7,9),(10,'Xbox Series X','Игровая консоль',499.99,'4K геймплей, Совместимость с играми предыдущего поколения',25,5,10),(11,'Samsung Galaxy Z Fold3','Смартфон-трансформер',1799.99,'Гибкий 7.6\" экран, S Pen в комплекте, 12 ГБ RAM, 256 ГБ хранилище',10,1,1),(12,'Dell XPS 13','Ультрабук',1299.99,'13.3\" экран, Intel Core i7, 16 ГБ RAM, 512 ГБ SSD',35,6,2),(13,'Asus ROG Swift','Игровой монитор',899.99,'32\" экран, 4K UHD, 144 Гц, NVIDIA G-SYNC',18,9,6),(14,'AirPods Pro','Беспроводные наушники',249.99,'Активное шумоподавление, Водоустойчивость',70,2,7),(15,'Sony Alpha A7 III','Зеркальная камера',1999.99,'24.2 Мп сенсор, 4K HDR видео, Встроенный Wi-Fi',12,3,8),(16,'Lenovo Legion 5','Игровой ноутбук',999.99,'15.6\" экран, AMD Ryzen 7, NVIDIA GeForce GTX 1660 Ti, 16 ГБ RAM, 512 ГБ SSD',22,8,2),(17,'HP OfficeJet Pro 8025','Цветной струйный принтер',169.99,'Двусторонняя печать, Скорость 20 стр/мин',40,7,9),(18,'PlayStation 5','Игровая консоль',499.99,'8K геймплей, Виртуальная реальность, Беспроводной контроллер DualSense',30,5,10),(19,'Huawei MateBook X Pro','Ультрабук',1499.99,'13.9\" экран, Intel Core i7, 16 ГБ RAM, 1 ТБ SSD',15,5,2),(20,'Samsung Odyssey G7','Игровой монитор',699.99,'27\" экран, QHD, 240 Гц, AMD FreeSync Premium Pro',25,1,6);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `warehouse_code` char(4) NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_warehouse_products1_idx` (`products_id`),
  KEY `warehouse_code_idx` (`warehouse_code`),
  CONSTRAINT `fk_warehouse_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`),
  CONSTRAINT `warehouse_code` FOREIGN KEY (`warehouse_code`) REFERENCES `warehouse_locations` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (1,1,'WH01',20),(2,2,'WH02',15),(3,3,'WH01',10),(4,4,'WH02',8),(5,5,'WH03',5),(6,6,'WH01',12),(7,7,'WH02',18),(8,8,'WH01',25),(9,9,'WH03',30),(10,10,'WH01',20),(11,11,'WH02',12),(12,12,'WH01',17),(13,13,'WH03',22),(14,14,'WH01',28),(15,15,'WH02',35),(16,16,'WH03',40),(17,17,'WH04',45),(18,18,'WH03',18),(19,19,'WH04',20),(20,20,'WH01',10);
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse_locations`
--

DROP TABLE IF EXISTS `warehouse_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_locations` (
  `code` char(4) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse_locations`
--

LOCK TABLES `warehouse_locations` WRITE;
/*!40000 ALTER TABLE `warehouse_locations` DISABLE KEYS */;
INSERT INTO `warehouse_locations` VALUES ('WH01','Склад 1'),('WH02','Склад 2'),('WH03','Склад 3'),('WH04','Склад 4');
/*!40000 ALTER TABLE `warehouse_locations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-29  1:32:05
