Ecommerce Analysis Dashboard

Project Overview

This project analyzes the Brazilian ecommerce marketplace using the Olist ecommerce dataset from Kaggle.
The analysis focuses on revenue trends, customer retention, product category performance, and delivery operations across Brazilian states.

The project combines SQL analysis in Google BigQuery with an interactive Tableau dashboard built from exported CSV datasets.

⸻

Dataset

Dataset source:
Brazilian Ecommerce Public Dataset by Olist￼

CSV files used as Tableau data sources were generated from BigQuery SQL queries.
Raw dataset is available on Kaggle.

The dataset contains information about:

* orders
* customers
* sellers
* products
* payments
* deliveries
* geolocation data

Analysis period:

* September 2016 → August 2018

⸻

Tech Stack

* Google BigQuery￼
* Tableau Public/Desktop￼
* CSV exports as Tableau data sources
* Kaggle dataset

⸻

Project Structure

ecommerce-analysis/
│
├── dashboard/
│   ├── ecommerce_dashboard_final.twbx
│   └── previous dashboard iterations
│
├── sql/
│   ├── 01_metrics_by_month.sql
│   ├── 02_customer_binning.sql
│   ├── 03_metrics_by_category.sql
│   ├── 04_retention_analysis.sql
│   ├── 05_customer_state_analysis.sql
│   ├── 06_seller_analysis.sql
│   └── 07_delivery_KPI's.sql
│
├── images/
│   └── dashboard screenshots
│
└── README.md

⸻

SQL Analysis

The project uses multiple SQL scripts to create aggregated analytical datasets for Tableau.

Monthly Metrics

* total revenue
* total orders
* unique customers
* average order value (AOV)

Customer Segmentation

Customers were grouped into behavioral segments based on purchase frequency:

* New customers
* Returning customers
* Loyal customers
* VIP customers

Product Category Analysis

Analysis of:

* revenue by category
* order volume
* customer count
* AOV by category

Retention Analysis

A cohort retention table was created using:

* customer first purchase month
* month difference between purchases
* retained customer counts

Delivery Performance

State-level delivery metrics:

* on-time delivery %
* delayed delivery %
* average delay days
* total delivered orders

⸻

Dashboard Features

The Tableau dashboard includes:

* KPI overview cards
* monthly revenue trend analysis
* cohort retention heatmap
* dynamic category analysis using parameters
* state-level revenue map
* delivery performance comparison by state
* click-to-filter interactivity

⸻

Key Insights

Customer Retention

The business is highly dependent on new customers.
The retention heatmap shows a sharp drop in returning customer activity after the first purchase month.

Revenue Concentration

Revenue growth accelerated significantly during late 2017 and remained relatively stable through 2018.

Category Performance

Certain categories generated high customer volume and revenue simultaneously, while others showed higher AOV but lower order frequency.

Delivery Performance

Delivery quality varied considerably across Brazilian states.
Some states experienced significantly higher delivery delays compared to the overall average.

⸻

Dashboard Design Decisions

Several exploratory visualizations were created during analysis but excluded from the final dashboard to improve readability and focus.

Examples:

* Revenue share by customer segment
* Top sellers by revenue and AOV

The seller analysis was excluded because sellers in the dataset are represented only by IDs, which reduced the business interpretability of the visualization.

The retention heatmap already provided stronger insight into customer dependency on new users, making the segment revenue chart redundant in the final dashboard.

⸻

## Dashboard Overview

![Overview](images/dashboard_overview.png)

## Retention Analysis

![Retention](images/retention_heatmap.png)

## Delivery Performance

![Delivery](images/delivery_analysis.png)

⸻

Skills Demonstrated

* SQL aggregations and joins
* cohort retention analysis
* KPI calculation
* parameter-driven Tableau visualizations
* dashboard design and layout
* business-oriented analytical thinking
* multi-source Tableau dashboard architecture