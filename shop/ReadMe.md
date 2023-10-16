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

## Функции в схеме shop

#### shop.clients_getinfo - 
Функция для получения информации о сотрудниках по номеру телефона, включая айди карты клиента и ее тип.
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