# Магазин одежды

### Схема shop
#### shop.clients -
Таблица, в которой хранится информация о клиентах. 
Номер телефона каждого клиента уникальный.
#### shop.clientscards -
Таблица, в которой хранится информация о карте лояльности клиента. После покупки товара в магазине клиент регистрируется в программе лояльности и на его имя заводится "Бронзовая карта".
#### shop.sales -
Таблица, в которой хранится информация о продаже.
В sale_info хранится информация в jsonb - 1. size - размер; 2. color - цвет; 3. gender - пол(char(3) - МУЖ, ЖЕН, МАЛ, ДЕВ)
#### shop.staff - 
Таблица, в которой хранится информация о сотрудниках.
Номер телефона каждого сотрудника уникальный.
#### shop.storage - 
Таблица, в которой хранится информация о наличии товара по размерам.
Столбец size - char(3) - XS, S, M, L, XL

## Функции в схеме shop

#### shop.clients_getinfo - 
Функция для получения информации о клиентах по номеру телефона, включая айди карты клиента и ее тип.
Пример вызова:
```sql
select shop.clients_getinfo('89282374456');
```
```json
{
   "data":[
      {
         "name":"Андрей",
         "phone":"89282374456",
         "gender":"МУЖ",
         "card_id":36,
         "type_id":1,
         "client_id":33,
         "birth_date":"2002-10-29"
      }
   ]
}
```
#### shop.clients_upd - 
Функция изменения или добавления информации о клиенте.
Пример заполнения:
```sql
select shop.clients_upd('{
  "name": "Андрей",
  "birth_date": "2002-10-29",
  "gender": "МУЖ",
  "phone": "89282374456",
  "ch_staff_id": 24,
  "ch_dt": "now()"
}', 24)
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
         "error":"shop.clientsupd.phone.phone_exists",
         "detail":null,
         "message":"Такой телефон у другого человека"
      }
   ]
}
```
#### shop.clientscards_upd - 
Функция изменения или добавления карты для клиента
Пример заполнения:
```sql
select shop.clientscards_upd('{
  "type_id": 1,
  "client_id": 33,
  "is_deleted": false,
  "ch_dt": "now()"
}', 24)
```

#### shop.staff_getinfo - 
Функция для получения информации о сотруднике по айди должности и номеру телефона.
Пример поиска:
```sql
select shop.staff_getinfo(1::SMALLINT,
                          '89377881885'::VARCHAR(11));
```
```json
{
   "data":[
      {
         "name":"Пирогова Анна Ивановна",
         "phone":"89377881885",
         "staff_id":11,
         "is_active":true,
         "birth_date":"1997-03-25",
         "position_id":1
      }
   ]
}
```
#### shop.staff_upd - 
Функция изменения или добавления сотрудника
```json
select shop.staff_upd('{
  "position_id": 7,
  "name": "Смирнова Александра Никитична",
  "phone": 89876111104,
  "birth_date": "2000-12-20",
  "is_active": true
}', 24);
```
Пример ошибки:
```json
{
   "errors":[
      {
         "error":"shop.staffupd.phone.phone_exists",
         "detail":null,
         "message":"Такой телефон у другого человека"
      }
   ]
}
```
#### shop.storage_getbynm - 
Функция для отображении информации о общем количестве товара определенного размера
Пример поиска:
```sql
select shop.storage_getbynm(1)
```
Ответ:
```json
{
   "data":[
      {
         "size":"S  ",
         "ch_dt":"2023-10-18T11:43:16.248999+00:00",
         "nm_id":1,
         "quantity":15,
         "ch_staff_id":24
      },
      {
         "size":"XS ",
         "ch_dt":"2023-10-18T15:25:36.434826+00:00",
         "nm_id":1,
         "quantity":59,
         "ch_staff_id":24
      }
   ]
}
```
#### shop.storage_upd -
Функция для добавления или изменения количества товаров по размерам.
Пример заполнения:
```sql
select shop.storage_upd('[
  {
    "nm_id": 1,
    "size": "XS",
    "quantity": 10
  },
  {
    "nm_id": 1,
    "size": "XS",
    "quantity": 10
  }
]', 24);
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
#### shop.sales_create - 
Функция факта продажи. Стоимость каждого товара указана со скидкой. 

В таблице хранится факт продажи только тех клиентов, кто зарегистрирован в программе лояльности 
```sql
SELECT shop.sale_create('
                        [
                          {
                            "client_id": 37,
                            "nm_id": 1,
                            "size": "XS",
                            "quantity": 2
                          },
                          {
                            "client_id": 37,
                            "nm_id": 1,
                            "size": "S",
                            "quantity": 3
                          }
                        ]', 24);
```

#### shop.sales_getbyclient - 
Функция для отображения информации о покупке по айди клиента
Пример поиска:
```sql
select shop.sales_getbyclient(37)
```
Ответ:
```json
{
   "data":[
      {
         "dt":"2023-10-19T19:21:50.741843+03:00",
         "ch_dt":"2023-10-19T19:21:50.741843+03:00",
         "client_id":37,
         "sale_info":{
            "size":"S  ",
            "nm_id":1,
            "amount":5097.45,
            "quantity":3
         },
         "ch_staff_id":24
      },
      {
         "dt":"2023-10-19T19:21:50.741843+03:00",
         "ch_dt":"2023-10-19T19:21:50.741843+03:00",
         "client_id":37,
         "sale_info":{
            "size":"XS ",
            "nm_id":1,
            "amount":3398.30,
            "quantity":2
         },
         "ch_staff_id":24
      }
   ]
}
```

