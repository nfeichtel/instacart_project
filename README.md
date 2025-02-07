🚧 *Project under construction. Thank you for your patience!* 🚧

## Background

Instacart is a grocery deliver service founded in 2012 that curently provides service from more than 85,000 locations. Instacart delivers over 38,213 prodcuts that are categorized into 20 departments. Data on product orderings from Q2 and Q3 have been analyzed to identify product trends and assist in decision making.


Insights and recommendations are provided on the following key areas:

- Overall order trends by department
- Comparitive analysis of organic and non-organic product orders

The SQL queries used to inspect and clean the data for this analysis can be found [here](setup_queries).

Analysis SQL queries regarding various business questions can be found [here](analysis_queries).

An interactive Tableau dashboard used to report and explore customer service trends can be found [here](https://public.tableau.com/app/profile/nick.feichtel/viz/InstacartReorderAnalysis/ExecutiveSummary).

## Data

## Executive Summary

![Executive Summary Dash](assets/executive_summary.png)

From Q2 2024 to Q3 2024 Instacart's overall orders increased by 333,587. This 1.75% increase in orders can in part be attributed to large order increases in the "Produce" and "Frozen" departments. Not all departments saw increases during the quarter, with "Dairy Eggs" and "Babies" seeing significant decreases. Overall, organic products saw large decreases in orders while non-organic products saw overall increases. Further insights into these trends and actionable recommendations are provided below.

## Detailed Analysis

### Overall Order Trends

![Total Orders Dash](assets/total_orders.png)

- Orders increased from Q2 to Q3 by a modest 1.75%. In total, 13 departments saw order increases and 7 departments saw order decreases. The largest order iincreases were seen in the "Produce", "Frozen" and "Household" departments, while the most significant decreases were seen in the "Dairy Eggs", "Babies", and "Snacks" departments. 
- Orders from the "Dairy Eggs" department make up on average 18% of all of our orders.Therefore the large decrease of 184,472 orders during the quarter is concerning. Orders from the "Babies" department make up around onlt 1% of orders, but the department saw an order decrease of 22.30%, the largest percent decrease during the quarter, warranting further investigation. Decreases in these departments were significant for both organic and non-organic products, and will be explored further below.
- "Produce" orders make up roughly 32% of all orders and are up 3.5% from Q2 to Q3. Increased produce orders could be do to seasonality trends, with more produce being in-season and consumed during the Summer months. The "Frozen" department saw a 9% increase in orders. Seasonality is likely factoring in to the increases as well. Previous years data should be analyzed to see if these seasonality trends hold up or if there is a different force driving this order growth.

### Comparative Product Analysis: Organic vs. Non-Organic

![Non-Organic Orders Dash](assets/non_organic_orders.png)

![Organic Order Dash](assets/organic_orders.png)



## Recommendations

## Assumptions and Caveats

