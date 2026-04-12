# Relational SQL 123s: DDL, DML, Filtering, and Turning Rows into Meaning

_A practical mental model for how databases are structured, how you put data in and change it, and how `WHERE`, aggregates, and `CASE WHEN` let you ask precise questions without getting lost in syntax._

---

This article is a **concept-first** tour of ideas that show up in almost every SQL course and job: **DDL** versus **DML**, the roles of **`CREATE`**, **`INSERT`**, **`UPDATE`**, and **`DELETE`**, how **`WHERE`** and common operators narrow results, and how **`CASE WHEN`** adds computed labels on top of raw values.

## DDL vs DML: structure versus contents

**DDL (Data Definition Language)** describes `structure`. It answers what objects exist, what they are named, which columns they have, their data types, and which integrity rules apply (primary keys, uniqueness, nullability, and so on). Typical DDL includes **`CREATE SCHEMA`** or **`CREATE DATABASE`**, **`CREATE TABLE`**, **`ALTER TABLE`**, and **`DROP`**. When you run DDL, you are defining the shape of storage and their dividers alongside the data that will live inside.

**DML (Data Manipulation Language)** describes `rows`. It answers what is stored **right now**. **`INSERT`** adds rows, **`UPDATE`** modifies existing rows, **`DELETE`** removes rows, and **`SELECT`** retrieves rows. **`SELECT`** is sometimes treated as its own category because it does not change persisted data by default, but it is universally grouped with “working with data” alongside inserts and updates.

Why distinguish them? In production, **DDL** often goes through migrations, reviews, and backups; getting a column wrong is expensive to unwind. **DML** is what applications and analysts run constantly. Mixing the two mentally helps you choose the right tool, “Am I changing the contract of the table, or only the rows inside it?”

---

## CREATE, ALTER, INSERT, UPDATE, and DELETE in practice

**`CREATE TABLE`** (and optionally **`CREATE SCHEMA`**) establishes tables and namespaces. You declare column names, types, and constraints such as **`PRIMARY KEY`**, **`NOT NULL`**, and **`UNIQUE`**. In systems like PostgreSQL, setting a **`search_path`** keeps multi-schema projects readable.

**`ALTER TABLE`** reflects evolving requirements - add a column you forgot at launch, rename a column when the business vocabulary changes, change a type when the data grows wider, or drop a column that is no longer collected. The important habit is to remember that **the table your `INSERT` targets is the table as it exists after all prior `ALTER`** column names in `INSERT` must match the new definition.

**`INSERT`** loads one or many rows. Values must respect constraints; duplicate keys or nulls in `NOT NULL` columns will fail fast, which is preferable to silent corruption.

**`UPDATE`** changes existing rows. A universal rule is **always constrain with `WHERE`** unless you truly intend to touch every row. A missing `WHERE` on `UPDATE` or **`DELETE`** is one of the fastest ways to turn a good day into an incident review.

**`DELETE`** removes rows, again almost always with a **`WHERE`** predicate so only the intended rows disappear. After DML, aggregates and reports reflect the new truth, counts and sums change because the underlying rows changed.

---

## Filtering with WHERE clause: precision over intuition

The **`WHERE`** clause limits which rows are considered for **`SELECT`**, and critically for **`UPDATE`** and **`DELETE`**. Common building blocks include:

- **Comparison:** `=`, `<>`, `<`, `>`, `<=`, `>=` (e.g. `status = 'active'`, `amount >= 100`).
- **Boolean logic:** **`AND`**, **`OR`**, **`NOT`**, with parentheses when intent is ambiguous.
- **`BETWEEN`:** **inclusive** ranges on numbers or dates (e.g. `order_date BETWEEN '2024-03-15' AND '2024-03-18'`).
- **`IN` / `NOT IN`:** membership in a fixed list (e.g. `region IN ('East', 'West', 'Central')`).
- **`LIKE`:** simple pattern matching; `%` matches any sequence, `_` matches a single character (e.g. `name LIKE 'A%'` for names starting with A, `description LIKE '%beta%'` for a substring).

Used together, these turn vague questions (“show me the interesting orders”) into **testable** predicates the engine can optimize. Text literals belong in **single quotes** in standard SQL; numbers do not.

---

## CASE WHEN: rules as readable columns

**`CASE WHEN`** adds **derived** values in the result of a query. You do not have to alter the table: you express business rules in SQL and expose them as named columns with **`AS`**. Conditions are usually evaluated **in order**; the first match wins, and **`ELSE`** catches the remainder.

Typical uses include **banding** numeric scores (grade tiers, discount brackets), **normalizing** messy codes into display labels, and **bucketing** categories (e.g. “high / medium / low” from thresholds).

```sql
CASE
    WHEN score >= 90 THEN 'Excellent'
    WHEN score >= 70 THEN 'Good'
    WHEN score >= 50 THEN 'Satisfactory'
    ELSE 'Needs attention'
END AS performance_band
```

The same pattern appears in reporting tools and spreadsheets; SQL makes it explicit and reusable in pipelines and APIs.

**`COUNT(*)`** and other aggregates (`SUM`, `AVG`, `MIN`, `MAX`) combine naturally with **`WHERE`**: you count or sum **only the rows that pass the filter**, which is how operational questions (“how many open tickets in this queue?”) map directly to queries.

---

The satisfying part with SQL is continuity: design the schema, load and correct data, then ask layered questions with filters, counts, and conditional labels. The database becomes a single place where \*\*rules and questions stay aligned.
