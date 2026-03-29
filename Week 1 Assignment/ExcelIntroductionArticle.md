# From Spreadsheets to Insights: How Excel Powers Real-World Data Analysis

[#analytics](https://medium.com/t/analytics) [#datascience](https://medium.com/t/datascience) [#microsoft](https://medium.com/t/microsoft) [#productivity](https://medium.com/t/productivity)

_A technical look at what Excel really is, where it wins in production workflows, and the formulas analysts lean on when money and operations are on the line._

---

[![Excel Workbook image](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fcf8x0uae3r72m60s2ed3.webp)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fcf8x0uae3r72m60s2ed3.webp)

## Why excel still matters

In a world of warehouses, notebooks, and orchestration pipelines, **Microsoft Excel** remains the default “operating system” for ad‑hoc analysis, financial reconciliations, regulatory exports, and operational reporting. It is not nostalgia, it is **latency**: the time from question to answer when a stakeholder or manager needs a number _today_.

This article is gives a crisp mental model of Excel as an analytical tool, plus **concrete patterns** that show up in real financial and operational systems from my observations as I begin on my Data Science & Engineering Journey at **LuxDev HQ**.

---

## What Excel is (and is not)

Excel is a grid-based calculation environment: rows, columns, cells that can hold values, text, or formulas that reference other cells. Under the hood you get:

- _Recalculation_ when inputs change
- _Built-in functions_ (statistical, financial, text, logical, lookup)
- _PivotTables_ for aggregation without writing formulas for every slice
- _What-if tools_ (Goal Seek, Scenario Manager, Data Tables)
- _Lightweight automation_ via Office Scripts / VBA (platform-dependent)
- _Integration_ with external data (Power Query on desktop, connectors in Microsoft 365)

Excel is **not** a production database, a source of truth for concurrent writes at scale, or a substitute for versioned ELT. It **is** unbeatable for exploration, reconciliation, and human-in-the-loop workflows that bridge raw extracts and decisions.

### Some practical real-world use cases of excel

#### 1. Sales and revenue operations

Imagine downloading thousands of lines of sales data from CRM platforms and management asks for breakdowns by product or region or comparisons between months. This is where excel comes in, instead of going back to the IT team to help you add those factors in the reports or waiting for a dashboard update, you just open Excel and reshape the data yourself.

#### 2. Managing Stocks, Inventory and supply chain

Even in businesses with proper systems, people still fall back to Excel to answer questions like what should be reordered this week, what product is running out? Most stores do not have ERP systems to automate such so they rely on excel to keep simple sheets with Item names, Quantities, Minimum levels etc.

#### 3. Internal dashboards (the “manager view”)

Sometimes, people don’t want dashboards or tools, they just need a file they can open and understand immediately. Excel makes this easy through pivot-driven summaries + conditional formatting with a summary at the top, a few highlighted numbers, and maybe some color to show what’s good or bad

No logins, no loading screens, just open and see what’s going on.

---

### Making sense of data with lookups in excel

A very common situation in Excel is this; You have one list with basic data, and another list with extra details and you want to connect them. For example, one sheet has product codes and another sheet has the product names and prices. Excel can help you “fill in the gaps” automatically through its lookup functions

#### `VLOOKUP` — vertical join in one formula

**_Syntax:_**
`VLOOKUP(lookup_value, table_array, col_index_num, [range_lookup])`

- **`lookup_value`**: what you’re matching (e.g. customer ID in the transaction row).
- **`table_array`**: the lookup table; **the first column must contain the key**.
- **`col_index_num`**: which column to return (1 = key column).
- **`range_lookup`**: `FALSE` for exact match (almost always what you want in finance). `TRUE` means approximate match (sorted data—for tax brackets, depreciation bands, etc.).

Think of it like this - “Find this item in another table, and bring me the information next to it.”

**Example: “You have a product code, and you want Excel to return the price.”**

Assume `Transactions!A2` has PID `P-1001`. Tariffs are on sheet `Tariffs` with columns `PID | ListPrice | Cost | MarginPct`.

```
=VLOOKUP(A2, Tariffs!$A$2:$D$500, 4, FALSE)

```

Enter fullscreen mode Exit fullscreen mode

---

#### `HLOOKUP` — follows the same idea as VLOOKUP but with horizontal keys

**_Syntax:_**
`HLOOKUP(lookup_value, table_array, row_index_num, [range_lookup])`

---

#### `INDEX` + `MATCH`

`VLOOKUP` breaks when someone inserts a column to the left of the return field and that's why most people use the INDEX + MATCH. It decouples **where the key is** from **where the value is**.

```
=INDEX(Tariffs!$D$2:$D$500, MATCH(A2, Tariffs!$A$2:$A$500, 0))

```

Enter fullscreen mode Exit fullscreen mode

- `MATCH` finds the **row** of the exact PID.
- `INDEX` returns the margin from column D.

On modern Excels after 2021, **`XLOOKUP`** replaces most `VLOOKUP`/`HLOOKUP`/`INDEX/MATCH` patterns with one readable function which makes it easier.

Other functions like `SUMIFS` and `COUNTIFS` come in when doing multi-criteria analysis, or when dealing with conditions and/or adding filters to your numbers.

### What I learned: a personal reflection

When I started working with data to view and manage reports, I treated Excel as “the boring office app” and chased fancier tools first. That was backwards. Learning Excel forced me to ask better questions, understand joins between data (better than how SQL did) and those questions didn’t go away when I move to bigger tools, they just improved my understanding.
