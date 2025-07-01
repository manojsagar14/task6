Here’s a clean and structured `README.md` file based on your executed queries and the output from the `library` table for **Task 6: Subqueries and Nested Queries**.

---

````markdown
# 📘 Task 6: Subqueries and Nested Queries

## 🎯 Objective
Demonstrate the use of subqueries in `SELECT`, `WHERE`, and `FROM` clauses using a sample `library` table.

---

## 🗃️ Table Used: `library`

| BookID | Title                    | Author          | Genre         | Year | Copies |
|--------|--------------------------|------------------|----------------|------|--------|
| 1      | The Alchemist            | Paulo Coelho     | Fiction        | 1988 | 5      |
| 2      | To Kill a Mockingbird    | Harper Lee       | Classic        | 1960 | 3      |
| 3      | The Theory of Everything | Stephen Hawking  | Science        | 2002 | 4      |
| 4      | Wings of Fire            | Naveen           | Autobiography  | 1999 | 2      |
| 5      | The Hobbit               | J.R.R. Tolkien   | Fantasy        | 1937 | 6      |

---

## 🔍 Subquery Examples

### 1. 📌 Subquery in `SELECT` (Scalar Subquery)
Shows each book along with total number of books in the table.

```sql
SELECT 
    Title, 
    Author, 
    (SELECT COUNT(*) FROM library) AS TotalBooks
FROM library;
````

✅ **Output:** Each row shows `TotalBooks = 5`.

---

### 2. 🕰️ Subquery in `WHERE` (Scalar)

Find books published in the **earliest year**.

```sql
SELECT * 
FROM library
WHERE Year = (SELECT MIN(Year) FROM library);
```

✅ **Output:**

* **The Hobbit** (1937)

---

### 3. 📚 Subquery using `IN`

Find books where the genre appears more than once.

```sql
SELECT *
FROM library
WHERE Genre IN (
    SELECT Genre
    FROM library
    GROUP BY Genre
    HAVING COUNT(*) > 1
);
```

❌ **Output:** Empty set (no genre repeats in current data)

---

### 4. 📈 Correlated Subquery

Find books that have more copies than the **average copies in their genre**.

```sql
SELECT *
FROM library l1
WHERE Copies > (
    SELECT AVG(Copies)
    FROM library l2
    WHERE l1.Genre = l2.Genre
);
```

❌ **Output:** Empty set (each book is alone in its genre)

---

### 5. 📊 Subquery in `FROM` (Derived Table)

Get genres with **total copies > 5**.

```sql
SELECT Genre, TotalCopies
FROM (
    SELECT Genre, SUM(Copies) AS TotalCopies
    FROM library
    GROUP BY Genre
) AS genre_summary
WHERE TotalCopies > 5;
```

✅ **Output:**

* **Fantasy** → 6 copies

---

### 6. 🔄 Subquery with `EXISTS`

Find books for which another book of the **same genre** exists.

```sql
SELECT *
FROM library l1
WHERE EXISTS (
    SELECT 1
    FROM library l2
    WHERE l1.Genre = l2.Genre AND l1.BookID <> l2.BookID
);
```

❌ **Output:** Empty set (no genre has more than 1 book)

---

```
