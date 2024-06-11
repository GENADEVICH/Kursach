-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dd
-- ------------------------------------------------------
-- Server version	8.0.37

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Иван','Иванов','ул. Ленина, д. 10, г. Москва, Россия','ivan.ivanov@example.com','1234567890'),(2,'Мария','Петрова','пр. Победы, д. 15, г. Санкт-Петербург, Россия','maria.petrova@example.com','0987654321'),(3,'Анна','Сидорова','ул. Кирова, д. 5, г. Екатеринбург, Россия','anna.sidorova@example.com','555555555'),(4,'Павел','Кузнецов','пр. Ленина, д. 20, г. Новосибирск, Россия','pavel.kuznetsov@example.com','777777777'),(5,'Елена','Смирнова','ул. Гагарина, д. 25, г. Краснодар, Россия','elena.smirnova@example.com','9876543210'),(6,'Алексей','Волков','пр. Ленина, д. 30, г. Омск, Россия','alexey.volkov@example.com','555444333'),(7,'Ольга','Иванова','ул. Пушкина, д. 5, г. Владивосток, Россия','olga.ivanova@example.com','111222333');
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
  `name` varchar(255) NOT NULL,
  `country` char(2) NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'ASUS','TW','https://www.asus.com'),(2,'MSI','TW','https://www.msi.com'),(3,'Intel','US','https://www.intel.com'),(4,'AMD','US','https://www.amd.com'),(5,'Corsair','US','https://www.corsair.com'),(6,'NVIDIA','US','https://www.nvidia.com'),(7,'Samsung','KR','https://www.samsung.com');
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
  `total_price` decimal(10,2) NOT NULL,
  `from_reserves` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_details_products1_idx` (`products_id`),
  KEY `fk_order_details_orders1_idx` (`orders_id`),
  CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_order_details_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_from_reserves_trigger` AFTER INSERT ON `order_details` FOR EACH ROW BEGIN
    IF NEW.from_reserves = 1 THEN
        UPDATE `reserves`
        SET `quantity` = `quantity` - NEW.quantity
        WHERE `products_id` = NEW.products_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `order_details_view`
--

DROP TABLE IF EXISTS `order_details_view`;
/*!50001 DROP VIEW IF EXISTS `order_details_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `order_details_view` AS SELECT 
 1 AS `order_id`,
 1 AS `order_datetime`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `product_name`,
 1 AS `quantity`,
 1 AS `from_reserves`,
 1 AS `price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customers_id` int DEFAULT NULL,
  `order_datetime` datetime NOT NULL,
  `order_status` enum('processed','created','completed','canceled') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orders_customers1_idx` (`customers_id`),
  CONSTRAINT `fk_orders_customers1` FOREIGN KEY (`customers_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
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
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` VALUES (1,'Процессоры','Компоненты, отвечающие за обработку данных в компьютере'),(2,'Материнские платы','Основная плата, на которой располагаются другие компоненты компьютера'),(3,'Жесткие диски','Устройства для хранения и чтения информации на компьютере'),(4,'Видеокарты','Устройства, обеспечивающие обработку графики на компьютере');
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
  `price` decimal(10,2) NOT NULL,
  `specifications` text,
  `quantity` int NOT NULL,
  `manufacturers_id` int NOT NULL,
  `product_categories_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_products_manufacturers1_idx` (`manufacturers_id`),
  KEY `fk_products_product_categories1_idx` (`product_categories_id`),
  CONSTRAINT `fk_products_manufacturers1` FOREIGN KEY (`manufacturers_id`) REFERENCES `manufacturers` (`id`),
  CONSTRAINT `fk_products_product_categories1` FOREIGN KEY (`product_categories_id`) REFERENCES `product_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i9-12900K','Процессор Intel Core i9-12900K с архитектурой Alder Lake',500.00,'16 ядер, 24 потока, 3.2 GHz',20,3,1),(2,'AMD Ryzen 9 5950X','Процессор AMD Ryzen 9 5950X с архитектурой Zen 3',650.00,'16 ядер, 32 потока, 3.4 GHz',15,4,1),(3,'MSI GeForce RTX 3090','Видеокарта MSI GeForce RTX 3090',1500.00,'24GB GDDR6X, 384-bit, 1695 MHz',10,2,4),(4,'ASUS ROG Strix Z690-E','Материнская плата ASUS ROG Strix Z690-E',400.00,'Socket LGA1700, DDR5, PCIe 5.0',8,1,2),(5,'ASUS ROG Strix B560-F Gaming','Материнская плата ASUS ROG Strix B560-F Gaming',200.00,'Socket LGA1200, DDR4, PCIe 4.0',30,1,2),(6,'Corsair DOMINATOR Platinum RGB','Оперативная память Corsair DOMINATOR Platinum RGB 16GB',100.00,'DDR4, 3200 MHz',25,5,3),(7,'NVIDIA GeForce RTX 3080','Видеокарта NVIDIA GeForce RTX 3080',1200.00,'10GB GDDR6X, 320-bit, 1710 MHz',18,6,4),(8,'Samsung 970 EVO Plus','SSD накопитель Samsung 970 EVO Plus',150.00,'NVMe M.2, 1TB, Read/Write: 3500/3300 MB/s',22,7,3);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserves`
--

DROP TABLE IF EXISTS `reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserves` (
  `id` int NOT NULL AUTO_INCREMENT,
  `products_id` int NOT NULL,
  `warehouse_code` char(4) NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_warehouse_products1_idx` (`products_id`),
  KEY `warehouse_code_idx` (`warehouse_code`),
  CONSTRAINT `fk_warehouse_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`),
  CONSTRAINT `warehouse_code` FOREIGN KEY (`warehouse_code`) REFERENCES `warehouses` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserves`
--

LOCK TABLES `reserves` WRITE;
/*!40000 ALTER TABLE `reserves` DISABLE KEYS */;
INSERT INTO `reserves` VALUES (1,1,'WH01',53),(2,2,'WH02',25),(3,3,'WH03',42),(4,4,'WH01',37),(5,5,'WH03',76),(6,6,'WH01',43);
/*!40000 ALTER TABLE `reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouses` (
  `code` char(4) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES ('WH01','Склад 1, Москва'),('WH02','Склад 2, Санкт-Петербург'),('WH03','Склад 3, Тверь');
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dd'
--

--
-- Dumping routines for database 'dd'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_order_total` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_order_total`(product_id INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE product_quantity INT;
    DECLARE reserve_quantity INT;
    DECLARE product_price DECIMAL(10,2);
    DECLARE total_price DECIMAL(10,2);

    -- Получаем количество и цену продукта из таблицы products
    SELECT quantity, price INTO product_quantity, product_price FROM products WHERE id = product_id;

    -- Получаем количество товара из таблицы reserves
    SELECT SUM(quantity) INTO reserve_quantity FROM reserves WHERE product_id = product_id;

    -- Если товар не найден в таблице reserves, устанавливаем его количество 0
    IF reserve_quantity IS NULL THEN
        SET reserve_quantity = 0;
    END IF;

    -- Вычисляем общее количество товаров и общую стоимость
    SET total_price = (product_quantity + reserve_quantity) * product_price;

    RETURN total_price;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_products_by_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_products_by_category`(category_name VARCHAR(255))
BEGIN
    -- Проверяем, существует ли категория с указанным именем
    IF NOT EXISTS (SELECT name FROM product_categories WHERE name = category_name) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Категория не найдена';
    END IF;

    -- Если категория существует, выбираем продукты из неё
    SELECT p.id, p.name, p.description, p.price, p.quantity, c.name AS category_name
    FROM products p
    JOIN product_categories c ON p.product_categories_id = c.id
    WHERE c.name = category_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_products_by_manufacturer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_products_by_manufacturer`(manufacturer_name VARCHAR(255))
BEGIN
    IF NOT EXISTS (SELECT name FROM manufacturers WHERE name = manufacturer_name) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Производитель не найден';
    END IF;

    SELECT p.id, p.name, p.description, p.price, p.quantity, m.name AS manufacturer_name
    FROM products p
    JOIN manufacturers m ON p.manufacturers_id = m.id
    WHERE m.name = manufacturer_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `make_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_order`(
    IN customer_id INT,
    IN product_id INT,
    IN order_quantity INT,
    IN from_reserves BIT(1)
)
BEGIN
    DECLARE order_id INT;
    DECLARE product_price DECIMAL(10,2);

    -- Объявляем обработчик исключений
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Откатываем транзакцию в случае возникновения исключения
        ROLLBACK;
        -- Выдаем сообщение об ошибке
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Произошла ошибка при обработке заказа';
    END;

    -- Начать транзакцию
    START TRANSACTION;

    -- Получаем цену продукта
    SELECT price INTO product_price FROM products WHERE id = product_id;

    -- Если заказ из резерва
    IF from_reserves = 1 THEN
        -- Создаем новый заказ
        INSERT INTO `orders` (customers_id, order_datetime, order_status)
        VALUES (customer_id, NOW(), 'processed');

        -- Получаем ID только что созданного заказа
        SET order_id = LAST_INSERT_ID();

        -- Добавляем детали заказа с total_price
        INSERT INTO `order_details` (orders_id, products_id, quantity, from_reserves, total_price)
        VALUES (order_id, product_id, order_quantity, 1, order_quantity * product_price);
    ELSE
        -- Уменьшаем количество продуктов в таблице products
        UPDATE `products`
        SET `quantity` = `quantity` - order_quantity
        WHERE id = product_id;

        -- Создаем новый заказ
        INSERT INTO `orders` (customers_id, order_datetime, order_status)
        VALUES (customer_id, NOW(), 'processed');

        -- Получаем ID только что созданного заказа
        SET order_id = LAST_INSERT_ID();

        -- Добавляем детали заказа с total_price
        INSERT INTO `order_details` (orders_id, products_id, quantity, from_reserves, total_price)
        VALUES (order_id, product_id, order_quantity, 0, order_quantity * product_price);
    END IF;

    -- Завершаем транзакцию
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_product_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_product_price`(
    IN product_id INT,
    IN new_price DECIMAL(10, 2)
)
BEGIN
    DECLARE current_price DECIMAL(10, 2);
    DECLARE price_difference DECIMAL(10, 2);
    DECLARE updated_rows INT;

    -- Получить текущую цену продукта
    SELECT price INTO current_price FROM products WHERE id = product_id;

    -- Вычислить разницу между новой и текущей ценой
    SET price_difference = new_price - current_price;

    -- Обновить цену продукта
    UPDATE products SET price = new_price WHERE id = product_id;

    -- Получить количество обновленных строк
    SELECT ROW_COUNT() INTO updated_rows;

    -- Вывести сообщение о выполнении операции
    IF updated_rows > 0 THEN
        SELECT CONCAT('Цена продукта ', product_id, ' успешно обновлена.') AS message;
    ELSE
        SELECT CONCAT('Ошибка при обновлении цены продукта ', product_id) AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `order_details_view`
--

/*!50001 DROP VIEW IF EXISTS `order_details_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `order_details_view` AS select `o`.`id` AS `order_id`,`o`.`order_datetime` AS `order_datetime`,`c`.`first_name` AS `first_name`,`c`.`last_name` AS `last_name`,`p`.`name` AS `product_name`,`od`.`quantity` AS `quantity`,`od`.`from_reserves` AS `from_reserves`,`p`.`price` AS `price` from (((`orders` `o` join `customers` `c` on((`o`.`customers_id` = `c`.`id`))) join `order_details` `od` on((`o`.`id` = `od`.`orders_id`))) join `products` `p` on((`od`.`products_id` = `p`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-11 21:48:51
