# Olist E-Commerce Analytics — Data Dictionary

## 1. Purpose

This document describes the Olist dataset, its tables, important columns,
table grain, keys, relationships, and analytical considerations.

Understanding the grain and relationships of the data is required before
performing SQL analysis.

---

# 2. Dataset Overview

The Olist Brazilian E-Commerce Public Dataset contains data from an
e-commerce marketplace.

The dataset contains information about:

- Customers
- Orders
- Order items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Product category translations

The original dataset contains 9 CSV files.

---

# 3. Tables

| Table | Purpose | Grain |
|---|---|---|
| customers | Customer/order-level customer information | One customer_id record |
| orders | Order lifecycle information | One order |
| order_items | Products included in orders | One item/line within an order |
| products | Product catalog information | One product |
| sellers | Seller information | One seller |
| order_payments | Payment transactions | One payment record |
| order_reviews | Customer review information | One review record |
| geolocation | ZIP-prefix geographic information | One geographic record |
| category_translation | Portuguese-English category mapping | One category mapping |

---

# 4. Customers

## Table

`raw_customers`

## Purpose

Contains customer information associated with orders.

## Columns

| Column | Description |
|---|---|
| customer_id | Identifier used to connect the customer record to an order |
| customer_unique_id | Identifier representing the actual customer across orders |
| customer_zip_code_prefix | First five digits of the customer's ZIP code |
| customer_city | Customer city |
| customer_state | Customer state |

## Important distinction

`customer_id` and `customer_unique_id` are NOT interchangeable.

Olist states that each order has a unique `customer_id`, while
`customer_unique_id` allows identification of customers who make
multiple purchases.

Therefore:

`customer_id`
→ order-associated customer record

`customer_unique_id`
→ stable customer identity for customer-level analysis

## Analytical importance

For:

- Repeat purchase analysis
- Retention
- Churn
- RFM
- CLV

we should generally use `customer_unique_id`.

---

# 5. Orders

## Table

`raw_orders`

## Purpose

Contains information about each order and its lifecycle.

## Grain

One row = one order.

## Important columns

| Column | Description |
|---|---|
| order_id | Unique identifier for an order |
| customer_id | Customer record associated with the order |
| order_status | Status of the order |
| order_purchase_timestamp | Time when the order was placed |
| order_approved_at | Time when the order was approved |
| order_delivered_carrier_date | Date the order was handed to the carrier |
| order_delivered_customer_date | Date the order was delivered to the customer |
| order_estimated_delivery_date | Estimated delivery date |

## Analytical uses

Used for:

- Order volume
- Sales trends
- Order status
- Delivery analysis
- Customer purchase timing
- Retention
- Cohort analysis

---

# 6. Order Items

## Table

`raw_order_items`

## Purpose

Contains the individual items/products included in orders.

## Grain

One row = one order item / line item.

An order can contain multiple order-item rows.

## Important columns

| Column | Description |
|---|---|
| order_id | Order containing the item |
| order_item_id | Sequential item identifier within the order |
| product_id | Product purchased |
| seller_id | Seller responsible for the item |
| shipping_limit_date | Seller's shipping deadline |
| price | Price of the item |
| freight_value | Freight/shipping value associated with the item |

## Important note about freight

If an order contains multiple items, freight value is allocated across
the individual order-item rows.

Therefore, summing `freight_value` across order items is appropriate for
calculating total freight represented in the dataset.

## Analytical uses

This is a central table for:

- Product sales
- Category sales
- Seller sales
- Item-level sales
- Merchandise value
- Freight value
- Order-level value

---

# 7. Products

## Table

`raw_products`

## Purpose

Contains product catalog information.

## Grain

One row = one product.

## Important columns

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| product_category_name | Product category |
| product_name_length | Length of product name |
| product_description_length | Length of product description |
| product_photos_qty | Number of product photos |
| product_weight_g | Product weight |
| product_length_cm | Product length |
| product_height_cm | Product height |
| product_width_cm | Product width |

## Analytical uses

Used for:

- Product performance
- Category performance
- Product characteristics
- Product-level analysis

---

# 8. Sellers

## Table

`raw_sellers`

## Purpose

Contains information about marketplace sellers.

## Grain

One row = one seller.

## Important columns

| Column | Description |
|---|---|
| seller_id | Unique seller identifier |
| seller_zip_code_prefix | Seller ZIP code prefix |
| seller_city | Seller city |
| seller_state | Seller state |

## Analytical uses

Used for:

- Seller sales
- Seller performance
- Seller delivery performance
- Seller concentration
- Geographic seller analysis

---

# 9. Order Payments

## Table

`raw_order_payments`

## Purpose

Contains payment records associated with orders.

## Grain

One row = one payment record.

## Important columns

| Column | Description |
|---|---|
| order_id | Order associated with the payment |
| payment_sequential | Sequence number of the payment within the order |
| payment_type | Payment method |
| payment_installments | Number of installments |
| payment_value | Monetary value of the payment record |

## Important warning

An order can have multiple payment records.

Therefore:

Do NOT assume:

`one order = one payment row`

When calculating total payment value at order level, payment records should
first be aggregated by `order_id`.

## Analytical uses

Used for:

- Payment method analysis
- Payment value
- Installment analysis
- Payment behavior

---

# 10. Order Reviews

## Table

`raw_order_reviews`

## Purpose

Contains customer review information associated with orders.

## Grain

One row = one review record.

## Important columns

| Column | Description |
|---|---|
| review_id | Review identifier |
| order_id | Order associated with the review |
| review_score | Customer rating from 1 to 5 |
| review_comment_title | Review title |
| review_comment_message | Review text |
| review_creation_date | Review creation date |
| review_answer_timestamp | Review response timestamp |

## Analytical uses

Used for:

- Customer satisfaction
- Review analysis
- Seller performance
- Category experience
- Delivery performance vs customer ratings

## Important warning

Do not automatically assume that every order has exactly one review
without validating the actual data.

---

# 11. Geolocation

## Table

`raw_geolocation`

## Purpose

Contains geographic information associated with ZIP code prefixes.

## Important columns

| Column | Description |
|---|---|
| geolocation_zip_code_prefix | ZIP code prefix |
| geolocation_lat | Latitude |
| geolocation_lng | Longitude |
| geolocation_city | City |
| geolocation_state | State |

## Important warning

A ZIP code prefix can have multiple geographic records.

Therefore, joins to geolocation can multiply rows if the data is not
deduplicated or aggregated first.

---

# 12. Product Category Translation

## Table

`raw_category_translation`

## Purpose

Maps Portuguese product category names to English category names.

## Columns

| Column | Description |
|---|---|
| product_category_name | Original Portuguese category |
| product_category_name_english | English category |

---

# 13. Key Relationships

The major relationships are:

customers → orders

`customers.customer_id = orders.customer_id`

orders → order_items

`orders.order_id = order_items.order_id`

order_items → products

`order_items.product_id = products.product_id`

order_items → sellers

`order_items.seller_id = sellers.seller_id`

orders → payments

`orders.order_id = order_payments.order_id`

orders → reviews

`orders.order_id = order_reviews.order_id`

products → category translation

`products.product_category_name =
category_translation.product_category_name`

---

# 14. Simplified Data Model

customers
    |
    | customer_id
    ↓
orders
    |
    | order_id
    ↓
order_items
    |              |
    |              |
product_id       seller_id
    ↓              ↓
products         sellers

orders
    |
    ├── order_payments
    |
    └── order_reviews

products
    |
    ↓
category_translation

customers / sellers
    |
    ↓
geolocation
(using ZIP code prefix)

---

# 15. Table Grain — Critical Concept

Before joining any tables, identify their grain.

### Customers

One row = one customer_id record.

### Orders

One row = one order.

### Order Items

One row = one item/line within an order.

### Products

One row = one product.

### Sellers

One row = one seller.

### Payments

One row = one payment record.

### Reviews

One row = one review record.

### Geolocation

One row = one geographic record.

---

# 16. Common Analytical Risks

## Risk 1 — Double counting from joins

Different tables have different grains.

Example:

One order has:

3 order items

and

2 payment records.

A direct join can produce:

3 × 2 = 6 rows.

If payment values or item prices are summed after this join,
the result may be overstated.

Therefore, aggregation must happen at the appropriate grain before
joining when necessary.

---

## Risk 2 — Customer ID confusion

Do not use `customer_id` as the definition of a unique real-world
customer.

Use `customer_unique_id` when the analytical question is about the
customer across multiple orders.

---

## Risk 3 — Payment value vs item price

`price` in `order_items` represents the item price.

`freight_value` represents freight associated with the item.

`payment_value` represents the value of a payment record.

These are different measures and should not automatically be treated
as the same metric.

---

## Risk 4 — Revenue terminology

The dataset does NOT provide a direct accounting-revenue or profit field
for Olist.

Therefore, this project will not automatically label:

`SUM(price)`

or

`SUM(price + freight_value)`

as Olist accounting revenue.

Instead, we will explicitly define metrics such as:

### Merchandise Value

SUM(order_items.price)

### Freight Value

SUM(order_items.freight_value)

### Order/Transaction Value

Depending on the analytical definition:

Merchandise Value + Freight Value

These are analytical measures based on the available dataset and should
not automatically be interpreted as Olist's accounting revenue or profit.

---

# 17. Data Validation Principle

Before using a table in analysis, validate:

- Row count
- Duplicate keys
- NULL values
- Unique identifiers
- Relationship integrity
- Table grain
- Unexpected values

Before trusting a metric, validate:

- Correct filters
- Correct joins
- Correct aggregation level
- Possible row multiplication
- Appropriate denominator

---

# 18. Analytical Rule

For every business question:

1. Understand the business question.
2. Define the metric.
3. Identify the required table(s).
4. Identify the grain of each table.
5. Identify the join keys.
6. Check whether the join can multiply rows.
7. Write the SQL.
8. Validate the result.
9. Interpret the result.
10. Convert the finding into a business insight.

---

# 19. Source of Truth

The original Olist dataset documentation is the primary reference for
the dataset schema and column definitions.

The actual CSV data will be treated as the source of truth for:

- Row counts
- NULL counts
- Duplicate checks
- Cardinality
- Actual relationships
- Data quality
- Analytical results

Secondary documentation may be used for cross-checking but will not
override the original dataset or the actual data.
