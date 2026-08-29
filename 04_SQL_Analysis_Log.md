# Olist E-Commerce Analytics — SQL Analysis Log

## Purpose

This document records the reasoning, SQL, validation, findings, and
business implications for each analytical problem.

The goal is not only to produce correct SQL but to develop the ability
to independently solve business problems using data.

---

# Analysis Workflow

Every analysis follows this process:

Business Question
        ↓
Understand the Business Context
        ↓
Define the Metric
        ↓
Form a Hypothesis
        ↓
Identify Required Data
        ↓
Understand Table Grain
        ↓
Plan the SQL
        ↓
Write SQL
        ↓
Validate the Result
        ↓
Interpret the Finding
        ↓
Business Implication
        ↓
Next Question

---

# Analysis Template

## Analysis #

### Business Domain

Revenue & Sales / Customer Behaviour / Operations /
Customer Experience / Retention & Churn

---

### Business Question

What business question are we trying to answer?

---

### Why Does This Matter?

Why would a stakeholder care about this question?

---

### Metric Definition

What exactly are we measuring?

Example:

AOV = Total Order Value / Number of Orders

---

### My Initial Hypothesis

Before looking at the result, what do I expect?

---

### Required Tables

List the tables required and explain why each is needed.

Example:

- raw_orders → order status and purchase date
- raw_order_items → item price and freight

---

### Table Grain

What does one row represent in each table?

---

### Join Logic

Which tables need to be connected?

Which keys are being used?

Are there any risks of row multiplication?

---

### My SQL Approach

Explain the approach before writing the final query.

---

### SQL

```sql
1. REVENUE&SALES
#analysis 1 :

Business Question
How much business did the marketplace generate from completed/delivered orders?

Metric
Delivered Product Sales Value = SUM(order_items.price) for delivered orders.

Result
13,221,498.11

Validation
The orders → order_items join did not create duplicate order-item records, and order_id is unique in the orders table.

#analysis 2:
Finding

Delivered product sales increased substantially as order volume increased. AOV remained relatively stable across the main period, suggesting that growth was driven primarily by an increase in the number of orders rather than a major increase in order value.

Limitation

The earliest months contain very few delivered orders, so their AOV and sales values should not be treated as representative.

+#analysis 3:


Finding

The overall delivered-order AOV was approximately 137.04 in product value. Monthly AOV remained relatively stable compared with the much larger changes in order volume.

Business interpretation

Olist's sales growth appears to have been driven more by increasing order volume than by customers substantially increasing their spend per order.
