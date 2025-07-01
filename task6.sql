
mysql> use library;
Database changed
mysql> select * from library;
+--------+--------------------------+-----------------+---------------+------+--------+
| BookID | Title                    | Author          | Genre         | Year | Copies |
+--------+--------------------------+-----------------+---------------+------+--------+
|      1 | The Alchemist            | Paulo Coelho    | Fiction       | 1988 |      5 |
|      2 | To Kill a Mockingbird    | Harper Lee      | Classic       | 1960 |      3 |
|      3 | The Theory of Everything | Stephen Hawking | Science       | 2002 |      4 |
|      4 | Wings of Fire            | Naveen          | Autobiography | 1999 |      2 |
|      5 | The Hobbit               | J.R.R. Tolkien  | Fantasy       | 1937 |      6 |
+--------+--------------------------+-----------------+---------------+------+--------+
5 rows in set (0.02 sec)

mysql> SELECT
    ->     Title,
    ->     Author,
    ->     (SELECT COUNT(*) FROM library) AS TotalBooks
    -> FROM library;
+--------------------------+-----------------+------------+
| Title                    | Author          | TotalBooks |
+--------------------------+-----------------+------------+
| The Alchemist            | Paulo Coelho    |          5 |
| To Kill a Mockingbird    | Harper Lee      |          5 |
| The Theory of Everything | Stephen Hawking |          5 |
| Wings of Fire            | Naveen          |          5 |
| The Hobbit               | J.R.R. Tolkien  |          5 |
+--------------------------+-----------------+------------+
5 rows in set (0.01 sec)

mysql> SELECT *
    -> FROM library
    -> WHERE Year = (SELECT MIN(Year) FROM library);
+--------+------------+----------------+---------+------+--------+
| BookID | Title      | Author         | Genre   | Year | Copies |
+--------+------------+----------------+---------+------+--------+
|      5 | The Hobbit | J.R.R. Tolkien | Fantasy | 1937 |      6 |
+--------+------------+----------------+---------+------+--------+
1 row in set (0.00 sec)

mysql> SELECT *
    -> FROM library
    -> WHERE Genre IN (
    ->     SELECT Genre
    ->     FROM library
    ->     GROUP BY Genre
    ->     HAVING COUNT(*) > 1
    -> );
Empty set (0.01 sec)

mysql> SELECT *
    -> FROM library l1
    -> WHERE Copies > (
    ->     SELECT AVG(Copies)
    ->     FROM library l2
    ->     WHERE l1.Genre = l2.Genre
    -> );
Empty set (0.00 sec)

mysql> SELECT Genre, TotalCopies
    -> FROM (
    ->     SELECT Genre, SUM(Copies) AS TotalCopies
    ->     FROM library
    ->     GROUP BY Genre
    -> ) AS genre_summary
    -> WHERE TotalCopies > 5;
+---------+-------------+
| Genre   | TotalCopies |
+---------+-------------+
| Fantasy |           6 |
+---------+-------------+
1 row in set (0.00 sec)

mysql> SELECT *
    -> FROM library l1
    -> WHERE EXISTS (
    ->     SELECT 1
    ->     FROM library l2
    ->     WHERE l1.Genre = l2.Genre AND l1.BookID <> l2.BookID
    -> );
Empty set (0.01 sec)