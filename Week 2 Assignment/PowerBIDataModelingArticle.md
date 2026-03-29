# Data Modeling in Power BI Explained(Without the Headache): Joins, Relationships, and Schemas...


*What really happens when tables “talk” to each other in Power BI. Joins, relationships, star schemas, and the mistakes that quietly break your dashboards.*



![Data modelling illustration](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/7x9le9ysdpo6xebbfuv1.webp)
---
As I continue my Data Science & Engineering journey at **LuxDev HQ**, I’m noticing the same pattern everywhere: people rush to pretty charts, then spend hours wondering why the numbers don’t line up. Nine times out of ten, the issue isn’t the visual. It’s the model underneath.

This article is my attempt to explain data modeling in Power BI in plain language: what it is, how `joins` and `relationships` differ, how `fact` and `dimension` tables fit in, and how `star`, `snowflake`, and `flat` layouts show up in real work. I’ll also walk through **where** in Power BI you actually click to build these things.


### Why data modeling matters before you touch a chart
Power BI makes it easy to drag fields onto a canvas. That’s the fun part. The hard part is making sure that when you filter by “March” or “Customer A,” the engine is counting the **right rows** the **right number of times**.

When the model is wrong, you get symptoms like:
- Totals that don’t match your source system  
- Duplicates that appear out of nowhere  
- Slicers that seem to “half work”  
- Reports that were fine in Excel but fall apart in Power BI  

Almost always, that traces back to how tables are connected, either in **Power Query** (merges/joins) or in the **Model** (relationships). Fixing visuals won’t fix that but fixing the model might.


***Data modeling decides how your tables are structured and how they connect, so that measures and filters behave correctly.***

In Power BI, you’re usually doing two related things:
1. `Shaping data` — cleaning, renaming, sometimes **merging** tables into one wider table (Power Query).  
2. `Connecting tables` — leaving tables separate but linking them with relationships so DAX can aggregate across them (Model view).

Both matter. They’re not the same tool, and mixing them up is where most people often get stuck.

---

### Part 1 — Joins: combining tables in Power Query

A **join** answers: *“If I stack these two tables side by side on a key, which rows do I keep?”*

In Power BI Desktop, joins show up when you **merge** queries, You pick two tables, the matching column(s), and a **join kind**. That’s the same logic used in SQL joins.

Below is a simple mental picture: **Table A** (left) and **Table B** (right), matched on something like `CustomerID`.


![JOIN Illustration](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/jru6mz2d92y1ryv5cznz.png)



#### INNER JOIN — only the overlap
This keeps rows where the key exists in both tables. For example you have *Orders* and *Customers*. You only want orders where you actually have a customer record (no “orphan” orders).

*When it’s useful:* Clean reporting, official numbers, “show me only valid combinations.”


#### LEFT JOIN — everything on the left, plus matches from the right
This keeps all rows from the left table. If there’s no match on the right, you still keep the row; the extra columns from the right show as *null* (blank).

*When it’s useful:* Operational reality — you rarely throw away transactions just because someone forgot to create the customer card.


#### RIGHT JOIN — everything on the right, plus matches from the left
Maintains the same idea as LEFT JOIN, but the “keep everything” side is the right table.

In practice, many people *swap which table is left vs right* and use a *LEFT* join instead, because it’s easier to read. RIGHT isn’t wrong; it’s just less common.


#### FULL OUTER JOIN — everything from both sides
This keeps all rows from both tables. Where there’s no match, you get blanks on the missing side. For example during reconciliation in *System A payments* vs *System B payments**, you would want to see what’s in A only, what’s in B only, and what’s in both.

*When it’s useful:* During audits, matching two different sources, finding gaps.


#### LEFT ANTI JOIN — “only in the left, not in the right”
Returns rows from the left table that have *no* match in the right table. For example payments that appear in *M-Pesa* (or a bank file) but never landed in your internal system.

*When it’s useful:* Exception lists, “what are we missing?”, data quality checks.


#### RIGHT ANTI JOIN — “only in the right, not in the left”
*Same as LEFT ANTI, but flipped:* rows that exist only in the *right* table for example customer records that exist in a CRM but have *never* placed an order.

---

### Part 2 — Relationships: connecting tables in the Model

Relationships are built on the **Model view** (the diagram with boxes and lines). Drag from one column to another, or click on *Modeling → Manage Relationships* then add/edit/delete in a list. You will need to set:
- *Cardinality* (one-to-many, many-to-many, one-to-one)  
- *Cross-filter direction* (single or both)  
- *Active vs inactive* when you have more than one path between the same tables  


#### Cardinality in everyday terms

*`One-to-many (1:M)`* — this is the default star-schema pattern for example one customer having many orders. The *“many”* side is usually your *fact* table (transactions). The *“one”* side is the *dimension* (customer, product, date).

*`Many-to-many (M:M)`* — this duplicates on *both* sides of the relationship. Power BI can model this, but it’s easier to get wrong measures if you don’t understand what’s happening. Often the fix is a *bridge table* or reshaping the data.

*`One-to-one (1:1)`* mostly rare but sometimes used when one entity was split across two tables for maintenance or row size reasons.

#### Active vs inactive relationships

You can have *multiple relationships* between the same two tables, but *only one is active* at a time for a given path.


#### Joins vs relationships — side by side

| | Joins (Power Query merge) | Relationships (Model) |
|---|------------------------------|----------------------------|
| Where | Power Query Editor | Model view / Manage Relationships |
| Effect | Can combine into one table (wider result) | Tables stay separate; engine knows how they link |
| When it runs | During *refresh* (data load) | At *query time* for visuals and DAX |
| Flexibility | Fixed shape after refresh | Multiple measures can use different logic (e.g. `USERELATIONSHIP`) |


