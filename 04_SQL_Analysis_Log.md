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
