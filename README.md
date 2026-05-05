# Data Center ESG & Profit Leakage Analytics

## Project Overview

This project helps identify where a data center business is losing revenue through energy waste, cooling inefficiency, underused server capacity, and carbon-heavy operations.

The analysis combines Python, PostgreSQL, Tableau, and Machine Learning to help business leaders understand which data center sites should be fixed first to reduce cost, improve energy efficiency, lower Scope 2 emissions, and protect margins.

The project is designed for Data Analyst, Business Analyst, Research Analyst, Sustainability Analyst, ML Analyst, and Data Scientist portfolio use.

---

## Business Problem

Data centers consume large amounts of electricity due to IT equipment, cooling systems, backup power, lighting, and facility operations.

As electricity demand increases, businesses face three major problems:

1. Rising energy cost
2. Revenue leakage due to inefficient energy usage and SLA penalties
3. Higher ESG risk from Scope 2 emissions

The business needs a data-driven way to answer:

- Which data center is losing the most money?
- Which site has the weakest energy efficiency?
- Which facility creates the highest Scope 2 emissions?
- Which cooling technology performs best?
- Which site should management fix first?
- Can machine learning predict future energy waste and risk?

---

## How This Project Helps the Business

This project helps the business move from manual ESG reporting to decision-driven analytics.

It identifies:

- Sites with the highest revenue leakage
- Data centers with poor PUE performance
- Facilities with high Scope 2 emissions
- Cooling types causing energy inefficiency
- Monthly cost spikes linked to cooling demand
- High-risk operating days
- Key drivers of energy waste and operational risk

The analysis shows that **Delhi Enterprise DC** should be fixed first because it has the highest revenue leakage, weakest PUE, high emissions, and lower margin performance.

**Mumbai Core DC** is the second priority because it has the highest Scope 2 emissions and frequent high-risk operating days.

---

## Tools Used

- Python
- Pandas
- NumPy
- Scikit-learn
- PostgreSQL
- SQL
- Tableau Public
- Jupyter Notebook
- GitHub

---

## Dataset

The dataset contains daily operating records for multiple data center sites.

Main areas covered:

- Site information
- Energy consumption
- Cooling system performance
- Server utilization
- Revenue and margin
- SLA penalties
- Renewable and fossil energy share
- Scope 2 emissions
- PUE and efficiency metrics
- Risk level labels

Main dataset used:

```text
clean_data_center_esg_ml_dataset.csv
