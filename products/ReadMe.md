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
Пример ошибки:
```json
{
   "errors":[
      {
         "error":"products.prices_upd.nm.nm_not_found",
         "detail":null,
         "message":"Такой номенклатуры не существует!"
      }
   ]
}
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
Функция для раскладки товара на места хранения. 

Для переноса товара с одного места на другое указать is_replace true для места хранения, с которого переносят.

Для заполнения места хранения указать false.

Переносим с места хранения 2 на место хранения 1:
```sql
select products.productsonplace_upd('[
  {
    "place_id": 1,
    "room_id": 1,
    "nm_id": 1,
    "quantity": 9,
    "is_replace": true
  },
  {
    "place_id": 2,
    "room_id": 1,
    "nm_id": 1,
    "quantity": 9,
    "is_replace": false
  }
]');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
#### products.suppliersdelivery_finished -
Процедура для закрытия поставки. Данные о поставке мы получаем из SuppliersDelivery_Import.
Пример вызова:
```sql
CALL products.suppliersdelivery_finished(1,24, now())
```
#### products.ordertosuppliers_upd - 
Функция для заполнения заказа поставщику. В order_info json - nm_id, size - XS, S, M, L, XL, quantity
Пример заполнения: 
```sql
select products.ordertosuppliers_upd('{
  "order_id": 59,
  "suppliers_id": 1,
  "order_info": {
    "nm_id": 1,
    "size": "XS",
    "quantity": 34
  },
  "is_finished": true,
  "dt": "now()"
}', 24);
```
#### products.ordertosuppliers_getinfo - 
Функция для получения информации о заказе поставщику.
Пример поиска:
```sql
select products.ordertosuppliers_getinfo(59, 1)
```
Ответ: 
```json
{
   "data":[
      {
         "dt":"2023-10-19T17:03:44.10629+03:00",
         "order_id":59,
         "order_info":{
            "size":"XS",
            "nm_id":1,
            "quantity":34
         },
         "is_finished":true,
         "suppliers_id":1
      }
   ]
}
```
#### products.suppliersdelivery_getinfo - 
Функция для получения информации о поставках
Пример вызова:
```sql
select products.suppliersdelivery_getinfo();
```
Ответ:
```json
{
   "data":[
      {
         "dt":"2023-10-19T12:18:57.483766+00:00",
         "ch_dt":null,
         "plan_dt":"2023-10-19",
         "ch_staff_id":null,
         "delivery_id":7,
         "is_finished":true,
         "suppliers_id":1,
         "delivery_info":{
            "size":"XS",
            "nm_id":1,
            "quantity":34
         }
      }
   ]
}
```