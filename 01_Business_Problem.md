# Olist E-Commerce Analytics

## 1. Business Context

Olist is an e-commerce marketplace that connects customers and sellers.

The company generates a large amount of transactional data from customers, orders, products, sellers, payments, deliveries, and customer reviews.

The objective of this project is to analyze this data and identify insights that can help improve sales, customer retention, operational performance, and customer experience.

---

## 2. Main Business Problem

How can Olist use its customer, order, product, seller, payment, delivery, and review data to improve:

- Revenue and sales performance
- Customer understanding and purchasing behavior
- Operational performance
- Customer experience
- Customer retention and churn

---

## 3. Analytical Objectives

### 3.1 Revenue & Sales

Understand how the marketplace generates sales and identify the major drivers of sales performance.

We will investigate:

- Overall sales performance
- Sales trends over time
- Average Order Value (AOV)
- Product and category performance
- Seller performance
- Geographic sales performance
- Sales concentration
- Reasons behind significant changes in sales

---

### 3.2 Customer Behaviour

Understand how customers purchase and spend on the platform.

We will investigate:

- Customer purchase frequency
- One-time vs repeat customers
- Customer spending
- Recency of purchases
- Customer segments
- High-value customers
- Purchasing patterns
- Category preferences
- Customer Lifetime Value (CLV)

---

### 3.3 Operational Performance

Understand how efficiently orders are processed and delivered.

We will investigate:

- Order processing time
- Delivery time
- Expected vs actual delivery
- Late deliveries
- Seller fulfillment performance
- Geographic delivery performance
- Cancellation patterns
- Concentration of operational problems

---

### 3.4 Customer Experience

Understand customer satisfaction and identify factors associated with poor experiences.

We will investigate:

- Review score distribution
- Seller ratings
- Category ratings
- Delivery performance vs review scores
- Geographic differences in customer satisfaction
- Trends in customer experience

We will distinguish between correlation and causation when interpreting results.

---

### 3.5 Retention & Churn

Understand whether customers return to the platform and identify valuable customers who may become inactive.

We will investigate:

- First and repeat purchases
- Repeat purchase rate
- Time between purchases
- Customer cohorts
- Retention rates
- Inactive customers
- High-value inactive customers
- RFM analysis
- Customer Lifetime Value
- Churn indicators

---

## 4. Analytical Approach

This project will follow a business-first analytical process:

Business Problem
        ↓
Business Question
        ↓
Metric Definition
        ↓
Data Investigation
        ↓
SQL Analysis
        ↓
Validation
        ↓
Finding
        ↓
Business Insight
        ↓
Recommendation

---

## 5. SQL Learning Objectives

This project will also be used to develop practical SQL skills.

Topics will be learned through real business problems rather than isolated exercises:

- SELECT and filtering
- Aggregations
- GROUP BY and HAVING
- CASE statements
- JOINs
- Subqueries
- CTEs
- Date and time functions
- Conditional aggregation
- Window functions
- Ranking
- Running totals
- Period-over-period analysis
- Customer-level analysis
- Cohort analysis

---

## 6. Analytical Principles

Throughout the project, we will follow these principles:

### Understand the data before querying

We must understand table grain, relationships, identifiers, and business meaning before calculating metrics.

### Define metrics clearly

Terms such as sales, revenue, GMV, order value, and profit should not be treated as interchangeable.

### Avoid double counting

Joins between tables with different grains can multiply rows and produce incorrect results.

### Validate important results

Important metrics should be checked for unexpected values, duplicate multiplication, NULLs, and incorrect joins.

### Separate correlation from causation

A relationship between two variables does not automatically mean that one caused the other.

### Focus on business decisions

The objective is not simply to produce SQL results.

Every important analysis should answer:

> What does this mean for the business?

---

## 7. Project Scope

The project focuses on five major areas:

1. Revenue & Sales
2. Customer Behaviour
3. Operational Performance
4. Customer Experience
5. Retention & Churn

The project will prioritize meaningful business investigations over solving a large number of unrelated SQL questions.

---

## 8. Expected Outcome

By the end of the project, we aim to produce:

- A structured MySQL database
- A documented data model
- Business-focused SQL analysis
- Validated analytical metrics
- Customer and sales insights
- CLV, RFM, retention and churn analysis
- Operational and customer experience analysis
- Business recommendations
- A Power BI dashboard
- A documented portfolio case study

---

## 9. Important Limitation

The Olist dataset contains transactional marketplace data, but it does not provide every financial component required to calculate Olist's actual accounting revenue or profit.

Therefore, financial metrics will be defined carefully based on the fields available in the dataset and will not automatically be interpreted as company revenue or profit.
