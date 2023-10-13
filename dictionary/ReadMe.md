# Магазин одежды

### Справочник 
#### dictionary.cardstype
Таблица, в которой хранятся айди типов карт клиентов, названия этих карт и их скидки.

##### dictionary.cardstype_upd(_src JSONB) 
Функция изменения или добавления типа карт
Пример заполнения:
```sql 
select dictionary.cardstype_upd('{
"type_id": 1,
"name": "Бриллиантовая",
"discount": 15
}')
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
#### dictionary.cardstype_getall() 
Отображение информации в таблице

Ответ:
```json
{
   "data":[
      {
         "name":"Бриллиантовая",
         "type_id":1,
         "discount":15
      },
      {
         "name":"Золотая",
         "type_id":2,
         "discount":10
      },
      {
         "name":"Серебряная",
         "type_id":3,
         "discount":7
      },
      {
         "name":"Бронзовая",
         "type_id":4,
         "discount":5
      }
   ]
}
```

#### dictionary.productscategory - 
Таблица, в которой хранятся айди категории одежды и название категории (Например, штаны, футболка, пальто и т.д.)

#### dictionary.productscategory_upd(_src JSONB)
Функция изменения или добавления категории товара

Пример заполнения:
```sql
select dictionary.productscategory_upd('{
  "name": "Шарф"
}');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
#### dictionary.productscategory_getall()
Отображение информации в таблице

Ответ:
```json
{
   "data":[
      {
         "name":"Пальто",
         "category_id":1
      },
      {
         "name":"Куртка",
         "category_id":2
      },
      {
         "name":"Пуховик",
         "category_id":3
      },
      {
         "name":"Джинсы",
         "category_id":4
      },
      {
         "name":"Брюки",
         "category_id":5
      },
      {
         "name":"Шорты",
         "category_id":6
      },
      {
         "name":"Свитер",
         "category_id":7
      },
      {
         "name":"Кардиган",
         "category_id":8
      },
      {
         "name":"Худи",
         "category_id":9
      },
      {
         "name":"Футболка",
         "category_id":10
      },
      {
         "name":"Майка",
         "category_id":11
      },
      {
         "name":"Топ",
         "category_id":12
      },
      {
         "name":"Платье",
         "category_id":13
      },
      {
         "name":"Лонгслив",
         "category_id":14
      },
      {
         "name":"Юбка",
         "category_id":15
      },
      {
         "name":"Спортивный костюм",
         "category_id":16
      },
      {
         "name":"Шапка",
         "category_id":17
      },
      {
         "name":"Перчатки",
         "category_id":18
      },
      {
         "name":"Варежки",
         "category_id":19
      },
      {
         "name":"Шарф",
         "category_id":20
      },
      {
         "name":"Кроссовки",
         "category_id":21
      },
      {
         "name":"Туфли",
         "category_id":22
      }
   ]
}
```
#### dictionary.productstype - 
Таблица, в которой хранятся айди типов одежды и название типа (Например, обувь, верхняя одежда и т.д)

#### dictionary.productstype_upd(_src JSONB) - 
Функция изменения или добавления типов товара

Пример заполнения:
```sql
select dictionary.productstype_upd('{
  "name": "Верхняя одежда"
}');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
#### dictionary.productstype_getall() - 
Отображение информации в таблице

Ответ:
```json
{
   "data":[
      {
         "name":"Верхняя одежда",
         "type_id":1
      },
      {
         "name":"Обувь",
         "type_id":2
      },
      {
         "name":"Трикотаж",
         "type_id":3
      },
      {
         "name":"Аксессуары",
         "type_id":4
      },
      {
         "name":"Спорт. одежда",
         "type_id":5
      },
      {
         "name":"Ниж. белье",
         "type_id":6
      },
      {
         "name":"Платья",
         "type_id":7
      },
      {
         "name":"Штаны",
         "type_id":8
      },
      {
         "name":"Юбки",
         "type_id":9
      }
   ]
}
```
#### dictionary.places - 
Таблица, в которой хранится информации о местах хранения магазина
#### dictionary.places_upd(_src JSONB) - 
Функция на добавление или изменение названия мест для хранения вещей в магазине

Пример заполнения:
```sql
select dictionary.places_upd('{
  "name": "Стеллаж 3"
}')
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

#### dictionary.places_getall - 
Функция на отображение всей информации в таблице

Ответ:
```json
{
   "data":[
      {
         "name":"Касса",
         "place_id":1
      },
      {
         "name":"Вешалка 1",
         "place_id":2
      },
      {
         "name":"Вешалка 2",
         "place_id":3
      },
      {
         "name":"Вешалка 3",
         "place_id":4
      },
      {
         "name":"Вешалка 4",
         "place_id":5
      },
      {
         "name":"Вешалка 5",
         "place_id":6
      },
      {
         "name":"Вешалка 6",
         "place_id":7
      },
      {
         "name":"Полка 1",
         "place_id":8
      },
      {
         "name":"Полка 2",
         "place_id":9
      },
      {
         "name":"Полка 3",
         "place_id":10
      },
      {
         "name":"Полка 4",
         "place_id":11
      },
      {
         "name":"Полка 5",
         "place_id":12
      },
      {
         "name":"Полка 6",
         "place_id":13
      },
      {
         "name":"Полка 7",
         "place_id":14
      },
      {
         "name":"Полка 8",
         "place_id":15
      },
      {
         "name":"Полка 9",
         "place_id":16
      },
      {
         "name":"Стеллаж 1",
         "place_id":17
      },
      {
         "name":"Стеллаж 2",
         "place_id":18
      },
      {
         "name":"Стеллаж 3",
         "place_id":19
      }
   ]
}
```

#### dictionary.staffposition - 
Таблица, в которой хранится информация о должностях и зарплате
#### dictionary.staffposition_upd(_src JSONB) - 
Функция на добавление или изменение должности и зарплаты 

Пример добавления:
```sql
select dictionary.staffposition_upd('{
  "name": "Уборщица",
  "salary": 14893
}');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

#### dictionary.staffposition_getall() - 
Функция на отображение всей информации в таблице

Ответ:
```json
{
   "data":[
      {
         "name":"Директор",
         "salary":52338.00,
         "position_id":1
      },
      {
         "name":"Управляющий магазином",
         "salary":45560.00,
         "position_id":2
      },
      {
         "name":"Специалист по кадрам",
         "salary":44015.00,
         "position_id":3
      },
      {
         "name":"Главный бухгалтер",
         "salary":42580.00,
         "position_id":4
      },
      {
         "name":"Бухгалтер",
         "salary":35890.00,
         "position_id":5
      },
      {
         "name":"Менеджер",
         "salary":32867.00,
         "position_id":6
      },
      {
         "name":"Продавец-консультант",
         "salary":28439.00,
         "position_id":7
      },
      {
         "name":"Кассир",
         "salary":28439.00,
         "position_id":8
      },
      {
         "name":"Уборщица",
         "salary":14893.00,
         "position_id":9
      }
   ]
}
```
#### dictionary.suppliers - 
Таблица, в которой хранится информация о поставщиках.
В supp_info хранится ИНН.
#### dictionary.suppliers_upd - 
Функция на добавление или изменение информации о поставщиках

Пример добавления информации:
```sql
select dictionary.suppliers_upd('{
  "name": "StyleMakers",
  "supp_info": 571305204859,
  "phone": 89001081369,
  "is_active": true
}')
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

#### dictionary.suppliers_getall - 
Функция для получение всей информации в таблице

Ответ:
```json
{
   "data":[
      {
         "name":"StyleMakers",
         "phone":"89001081369",
         "is_active":true,
         "supp_info":"571305204859",
         "suppliers_id":1
      },
      {
         "name":"Fashionista",
         "phone":"89002124899",
         "is_active":true,
         "supp_info":"848648068120",
         "suppliers_id":2
      },
      {
         "name":"ModaChic",
         "phone":"89001947538",
         "is_active":false,
         "supp_info":"376968740576",
         "suppliers_id":3
      },
      {
         "name":"Couture Creations",
         "phone":"89008624668",
         "is_active":true,
         "supp_info":"604901035309",
         "suppliers_id":4
      },
      {
         "name":"Chic Boutique",
         "phone":"89001776405",
         "is_active":true,
         "supp_info":"120886576197",
         "suppliers_id":5
      },
      {
         "name":"Бифри",
         "phone":"89001810808",
         "is_active":true,
         "supp_info":"295336736407",
         "suppliers_id":6
      },
      {
         "name":"Мода из комода",
         "phone":"89000276560",
         "is_active":true,
         "supp_info":"609591102512",
         "suppliers_id":7
      }
   ]
}
```




