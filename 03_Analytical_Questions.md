# Olist E-Commerce Analytics — Analytical Questions

## Purpose

This document defines the core business questions that will be answered
through the Olist analytics project.

The objective is not to solve a large number of unrelated SQL exercises.

Each question should lead to:

Business Question
→ Metric Definition
→ Data Investigation
→ SQL Analysis
→ Validation
→ Finding
→ Business Insight

---

# 1. Revenue & Sales

## Objective

Understand the scale, trend, drivers, and concentration of marketplace
sales.

### Core Questions

1. How much business is being generated?
2. How are sales and order volumes changing over time?
3. What is the Average Order Value (AOV), and how does it change?
4. Which products and categories drive sales?
5. Which sellers and geographic regions contribute most to sales?
6. What is driving significant changes in sales?

### Deeper Investigation

If useful, investigate:

- Sales concentration among products
- Sales concentration among sellers
- Product/category mix
- Orders vs AOV contribution to sales changes
- Seasonal patterns

---

# 2. Customer Behaviour

## Objective

Understand how customers purchase, spend, and interact with the marketplace.

### Core Questions

1. How many unique customers have purchased?
2. What proportion of customers are one-time vs repeat customers?
3. How frequently do customers purchase?
4. How much do customers spend?
5. Which customers and customer segments are economically valuable?
6. What products/categories do different customer groups prefer?

### Deeper Investigation

If useful, investigate:

- Recency
- Purchase frequency
- Monetary value
- Customer segments
- High-value customers
- Customer Lifetime Value (CLV)

---

# 3. Operational Performance

## Objective

Understand how efficiently orders are processed, shipped, and delivered.

### Core Questions

1. How long does it take to process and deliver orders?
2. How often are orders delivered late?
3. How does delivery performance vary by seller?
4. How does delivery performance vary by geography?
5. What patterns exist in cancellations and unavailable orders?
6. Where are the major operational problems concentrated?

### Deeper Investigation

If useful, investigate:

- Expected vs actual delivery
- Seller fulfillment performance
- Category-level delivery performance
- Geographic operational differences
- Relationship between operational performance and sales

---

# 4. Customer Experience

## Objective

Understand customer satisfaction and identify factors associated with
poor customer experiences.

### Core Questions

1. What does the overall review distribution look like?
2. Which products/categories receive the highest and lowest ratings?
3. Which sellers receive the highest and lowest ratings?
4. Does delivery performance relate to customer review scores?
5. How does customer experience vary geographically?
6. What are the major patterns associated with poor customer experience?

### Deeper Investigation

If useful, investigate:

- Late delivery vs review score
- Review trends over time
- Review score by order value
- Category-level experience
- Seller-level experience

### Analytical Principle

Correlation does not automatically imply causation.

Any relationship discovered will be described carefully.

---

# 5. Retention & Churn

## Objective

Understand whether customers return to the marketplace and identify
valuable customers who become inactive.

### Core Questions

1. What percentage of customers make repeat purchases?
2. How long does it take customers to make another purchase?
3. How does retention differ between customer cohorts?
4. Which customer groups have stronger or weaker retention?
5. Which valuable customers have become inactive?
6. What customer characteristics are associated with retention or churn?

### Deeper Investigation

If useful, investigate:

- RFM segmentation
- Customer Lifetime Value (CLV)
- Cohort retention
- High-value inactive customers
- Churn indicators

---

# 6. Cross-Domain Business Questions

After completing the five core domains, we will combine the findings.

Examples:

### Sales + Operations

Are high-sales sellers also operationally efficient?

### Operations + Customer Experience

Are delivery delays associated with lower review scores?

### Customer Behaviour + Retention

Which purchasing behaviors are associated with repeat purchases?

### Sales + Customer Behaviour

Is sales growth driven by acquiring more customers or by existing
customers spending more?

### Customer Experience + Retention

Are customers with poor experiences less likely to return?

### Sales + Retention

How much business comes from repeat customers?

---

# 7. Advanced Analysis

Advanced techniques will only be introduced when they answer a meaningful
business question.

Potential techniques include:

- Window functions
- Cohort analysis
- RFM segmentation
- Customer Lifetime Value
- Churn analysis
- Pareto/concentration analysis
- Period-over-period analysis

These techniques are not objectives by themselves.

The business problem comes first.

---

# 8. Scope Rule

We will prioritize:

1. Business relevance
2. Analytical reasoning
3. Data quality
4. SQL understanding
5. Business interpretation

We will NOT add analysis simply because a SQL technique exists.

Example:

We will not use a window function just to demonstrate that we know
window functions.

We will use it when the business question requires it.

---

# 9. Completion Standard

A business question is considered complete only when we have:

- Defined the business question
- Defined the metric
- Identified the appropriate data
- Considered table grain
- Written the SQL
- Validated the result
- Interpreted the result
- Identified the business implication
