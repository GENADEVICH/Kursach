## ⠀⠀⠀

![Скриншот 1](screenshots/erd.png)

## Типовые запросы

**1. Получить среднюю стоимость заказа по каждому клиенту:**
```Mysql
SELECT c.last_name AS фамилия, c.first_name AS имя, 
ROUND(AVG(od.total_price)) AS средняя_стоимость_заказа
FROM customers c
LEFT JOIN orders o ON c.id = o.customers_id
LEFT JOIN order_details od ON o.id = od.orders_id
GROUP BY c.id, c.last_name, c.first_name;

```
**2. Выяснить, в каких категориях продуктов есть товары с низкими остатками (менее 10):**
```Mysql
SELECT pc.name AS название_категории, p.name AS название_продукта, p.quantity AS количество
FROM products p
JOIN product_categories pc ON p.product_categories_id = pc.id
WHERE p.quantity < 10;
```

**3. Найти топ-5 клиентов, сделавших наибольшее количество заказов:**
```Mysql
SELECT c.first_name, c.last_name, COUNT(o.id) AS общее_количество_заказов
FROM customers c
JOIN orders o ON c.id = o.customers_id
GROUP BY c.id
ORDER BY общее_количество_заказов DESC
LIMIT 5;
```

**4. Узнать среднюю цену продуктов в каждой категории:**
```Mysql
SELECT pc.name AS название_категории, AVG(p.price) AS средняя_цена
FROM products p
JOIN product_categories pc ON p.product_categories_id = pc.id
GROUP BY pc.name;
```

**5. Получить общее количество продуктов в каждом складе:**
```Mysql
SELECT w.location_name AS склад, 
SUM(r.quantity) AS общее_количество_продуктов
FROM warehouses w
LEFT JOIN reserves r ON w.code = r.warehouse_code
GROUP BY w.location_name;
```
## Отдельные роли
**1. Роль: Администратор**
```Mysql
-- создание роли admin_role
CREATE ROLE IF NOT EXISTS admin_role; 

-- Предоставление полных прав администратору на схему housing
GRANT ALL PRIVILEGES ON shop.* TO admin_role;

-- создание пользователя и назначение ему роли admin_role
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'PaSsWoRd';
GRANT admin_role TO 'admin'@'localhost';

-- установка роли admin_role по умолчанию для пользователя admin
SET DEFAULT ROLE admin_role TO 'admin'@'localhost';

FLUSH PRIVILEGES;
```
**2. Роль: Менеджер**
```Mysql
-- создание роли manager_role
CREATE ROLE IF NOT EXISTS 'manager_role';

-- назначение привилегий роли manager_role
GRANT SELECT, INSERT, UPDATE, DELETE ON shop.products TO 'manager_role';
GRANT SELECT, INSERT, UPDATE, DELETE ON shop.customers TO 'manager_role';
GRANT SELECT, INSERT, UPDATE, DELETE ON shop.orders TO 'manager_role';
GRANT SELECT, INSERT, UPDATE, DELETE ON shop.order_details TO 'manager_role';
GRANT SELECT ON shop.manufacturers TO 'manager_role';
GRANT SELECT ON shop.product_categories TO 'manager_role';
GRANT SELECT ON shop.reserves TO 'manager_role';
GRANT SELECT ON shop.warehouses TO 'manager_role';

-- назначение привилегий на выполнение хранимых процедур
GRANT EXECUTE ON PROCEDURE shop.get_products_by_manufacturer TO 'manager_role';
GRANT EXECUTE ON PROCEDURE shop.get_products_by_category TO 'manager_role';
GRANT EXECUTE ON PROCEDURE shop.update_product_price TO 'manager_role';
GRANT EXECUTE ON PROCEDURE shop.calculate_order_total TO 'manager_role';
GRANT EXECUTE ON PROCEDURE shop.make_order TO 'manager_role';

-- создание пользователя manager и назначение ему роли manager_role
CREATE USER IF NOT EXISTS 'manager'@'localhost' IDENTIFIED BY 'PaSsWoRd';
GRANT 'manager_role' TO 'manager'@'localhost';

-- установка роли manager_role по умолчанию для пользователя manager
SET DEFAULT ROLE 'manager_role' FOR 'manager'@'localhost';

-- применение изменений
FLUSH PRIVILEGES;

```
**3. Роль: Клиент**
```Mysql
-- создание роли customer_role
CREATE ROLE IF NOT EXISTS 'customer_role';

-- назначение привилегий роли customer_role
GRANT SELECT ON shop.products TO 'customer_role';
GRANT SELECT ON shop.product_categories TO 'customer_role';
GRANT SELECT ON shop.manufacturers TO 'customer_role';

-- назначение привилегий на выполнение хранимых процедур
GRANT EXECUTE ON PROCEDURE shop.make_order TO customer_role;

-- создание пользователя customer и назначение ему роли customer_role
CREATE USER IF NOT EXISTS 'customer'@'localhost' IDENTIFIED BY 'SecurePassword';
GRANT 'customer_role' TO 'customer'@'localhost';

-- установка роли customer_role по умолчанию для пользователя customer
SET DEFAULT ROLE 'customer_role' FOR 'customer'@'localhost';

-- применение изменений
FLUSH PRIVILEGES;
```



