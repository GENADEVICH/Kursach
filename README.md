## Скриншоты

![Скриншот 1](screenshots/erd.png)

## Типовые запросы

```Mysql
Добавление нового продукта в каталог:
INSERT INTO products (name, description, price, specifications, quantity, manufacturers_id, product_categories_id) 
VALUES ('Название продукта', 'Описание продукта', 99.99, 'Спецификации продукта', 100, 1, 1);
```

