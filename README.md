# Blog API

1. Создаёт пост. Принимает заголовок и содержание поста (не могут быть пустыми), а также логин и айпи автора. Если автора с таким логином еще нет, создаёт его. Возвращает либо атрибуты поста со статусом 200, либо ошибки валидации со статусом 422.

```bash
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"header":"x-fa-fafds","body":"yoyoy42", "ip":"125.0.0.1", "user_login": "ttt538"}}'  http://localhost:3000/posts
```

2. Cтавит оценку посту. Принимает айди поста и значение, возвращает новый средний рейтинг поста. Корректно отрабатывает при любом количестве конкурентных запросов на оценку одного и того же поста.
```bash
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"num": 3, "post_id": 42}}'  http://localhost:3000/posts/create_mark
```

3. Получает топ N постов по среднему рейтингу. Просто массив объектов с заголовками и содержанием.
```bash
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X GET -d ' {"post": {"n": 5}}'  http://localhost:3000/posts/give_top_posts
```

4. Получает список айпи, с которых постило несколько разных авторов. Массив объектов с полями: айпи и массив логинов авторов.
```bash
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X GET http://localhost:3000/posts/give_ip_list
```

## Задание на знание SQL:

### Дана таблица users вида - id, group_id

```sql
CREATE TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3); 

id  | group_id
----+----------
  1 |        1
  2 |        1
  3 |        1
  4 |        2
  5 |        1
  6 |        3
```

В этой таблице, упорядоченой по ID необходимо: 

1. Выделить непрерывные группы по group_id с учетом указанного порядка записей (их 4) 

```sql
SELECT group_id FROM (
   SELECT
     CASE
       WHEN group_id = LAG(group_id) OVER (ORDER BY id)
         THEN NULL
         ELSE group_id
       END
       AS group_id FROM users
   ) AS result
 WHERE result IS NOT NULL;

 group_id
----------
        1
        2
        1
        3
(4 rows)
```

2. Подсчитать количество записей в каждой группе 
```sql
SELECT group_id, COUNT(group_id) AS group_total
FROM users
GROUP BY group_id;

group_id | group_total
---------+-------------
       1 |           4
       3 |           1
       2 |           1
(3 rows)
```

3. Вычислить минимальный ID записи в группе

```sql
SELECT group_id, MIN(id) AS min_id
FROM users
GROUP BY group_id;

group_id | min_id
---------+--------
       1 |      1
       3 |      6
       2 |      4
(3 rows)
```