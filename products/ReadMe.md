# Магазин одежды

### Схема products 

#### products.ordertosuppliers - 
Таблица, в которой хранится информация о заказе товаров у поставщика
#### products.prices - 
Таблица, в которой хранится информация о цене каждого товара
#### products.products - 
Таблица, в которой хранится информация о товарах.
Столбец description тип JSON - color и gender(МУЖ, ЖЕН, МАЛ, ДЕВ)
#### productsonplace - 
Таблица, в которой хранится информация о расположении каждого товара в магазине. 
Place_id тянется из справочника. Room_id - 1. STK - stock - cклад; 2. HL1 - hall1 - зал 1, 3. HL2 - hall2 - зал 2 (char3).
#### suppliersdelivery - 
Таблица, в которой хранится информация о доставки товара от поставщика. Столбец delivery_info тип JSONB - nm_id, color, gender

### Функции
#### products.prices_bynm - 
Функция для отображение цены по nm_id
Пример поиска:
```sql
select products.prices_bynm(3);
```
Ответ:
```json
{
   "data":[
      {
         "ch_dt":"2023-10-17T17:47:08.670962+00:00",
         "nm_id":3,
         "price":2599.00,
         "ch_staff_id":24
      }
   ]
}
```
#### products.prices_upd - 
Функция для изменения цены или добавление цены для товара.
```sql
select products.prices_upd('{
  "nm_id": 2,
  "price": 1400
}', 24);
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

#### products.products_getinfo - 
Функция для поиска товара по nm_id, type_id, category_id
```sql
select products.products_getinfo(1::BIGINT);
```
Ответ:
```json
{
   "data":[
      {
         "nm_id":1,
         "type_id":1,
         "category_id":1,
         "description":{
            "color":"PURPLE",
            "gender":"МУЖ"
         }
      }
   ]
}
```
#### products.products_upd - 
Таблица для добавления или изменения товара 
```sql
select products.products_upd('{
  "type_id": 2,
  "category_id": 21,
  "description": {
    "color": "RED",
    "gender": "ЖЕН"
  }
}', 24)
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
#### products.productsonplace_getinfo - 
Функция для отображения информации о расположении каждого товара 

```sql
select products.productsonplace_getinfo(1, 1, 1)
```
Ответ:
```json
{
   "data":[
      {
         "nm_id":1,
         "room_id":1,
         "place_id":1,
         "quantity":75
      }
   ]
}
```
#### products.productsonplace_upd
```sql
select products.productsonplace_upd('[
  {
    "place_id": 1,
    "room_id": 1,
    "nm_id": 2,
    "quantity": 1
  }
]');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
####