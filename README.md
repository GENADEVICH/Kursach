## Скриншоты

![Скриншот 1](screenshots/erd.png)

## Типовые запросы

1. Добавление нового продукта в каталог:
```Mysql
INSERT INTO products 
(name, description, price,
 specifications, quantity,
 manufacturers_id, product_categories_id) 
VALUES ('Xiaomi Redmi Note 10', 'Мощный смартфон по привлекательной цене',
 299.99, '6.43" AMOLED дисплей, 6 ГБ RAM, 128 ГБ встроенной памяти', 80, 5, 1);
```
2. Поиск продукта по ключевому слову:
```Mysql
SELECT * FROM products WHERE name LIKE '%MacBook Pro%';
```

3. Создание заказа покупателем:
```Mysql
INSERT INTO orders (customers_id, order_datetime, order_status)
VALUES (1, NOW(), 'processed');

INSERT INTO order_details (orders_id, products_id, quantity, from_reserves)
VALUES (7, 1, 12, 'no');
```

4. Получение списка заказов для конкретного покупателя:
```Mysql
SELECT * FROM orders WHERE customers_id = 1;
```

5. Получение общего количества продуктов на складе:
```Mysql
SELECT SUM(quantity) AS total_quantity FROM reserves;
```


