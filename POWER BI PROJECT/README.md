**Apple Retail Dataset:** a synthetic dataset taken from Kaggle, with some data enrichment applied.

**Apple Retail Performance Analytics README**

**Project Overview:**

A Power BI portfolio project exploring product performance, store consistency and warranty exposure using a synthetic Apple retail dataset enriched with reconstructed product metadata.

**Project Background:**

Apple operates across a broad portfolio of hardware, accessories and subscription services. Retail analysts need to understand which products drives sales value, how product performance change over time, whether store performance varies meaningfully, and where warranty indicators warrant further investigation.

This project approaches those questions from the perspective of a retail analyst supporting commercial and operations stakeholders. The objective is to transform a synthetic retail dataset into a structured analytical model and an interactive Power BI report.

Insights are explored across 4 key areas:

- **Executive Overview:** Overall modelled sales value, unit volume, growth, product mix and warranty exposure
- **Product & Category Performance:** Category contribution, product-family performance, product-level volume versus sales value, and growth
- **Store Performance & Benchmarking:** Store-level distribution, network benchmarks, monthly volatility and geographic footprint
- **Product Quality & Warranty Analysis:** Claim rates, claim timing, repeat claims and repair outcomes.

**Project resources:**

**Data Structure & Initial Checks:**

The Power BI model uses dimension tables and fact tables to support product, store, time, sales and warranty analysis.

The model consists of 6 tables:

- **DimDate:** Calendar attributes used for time-based analysis
- **Category:** Product category lookup table
- **Product:** Product metadata, including product family, type, condition, status, launch date and reference price
- **Sales** \[fact table\]: Retail sales transactions, including product, store, date and quantity
- **Store:** Store identifiers and geographic attributes
- **Warranty:** Warranty claim events associated with sales transactions

**Data Model:**

\___\__

\[insert entity relationship diagram here\]

**Data preparation and validation:**

The original dataset was reviewed and enriched before report development. Key preparation steps included:

- Correcting table headers and reviewing the source data structure.
- Reconstructing product metadata, product families, launch dates, and reference prices using publicly available Apple product information.
- Adding attributes to distinguish hardware, accessories, subscriptions, product age, new and certified-refurbished products, and current versus previous-generation products.
- Reviewing date chronology and validating that sales did not precede the associated product launch date.
- Reviewing duplicate store names while preserving unique store IDs and adding regions for accurate store-level analysis.
- Excluding software-subscription claim records from warranty analysis because they are more appropriately treated as technical-support issues than hardware warranty claims.

Modelled sales value is calculated using units sold multiplied by reconstructed product reference price. It is not actual realised transaction value or reported Apple revenue.

**Executive Summary:**

**Overview of Findings:**

This project brings together commercial performance, store benchmarking, and product-quality analysis in a single Power BI report. It distinguishes sales value from unit volume, evaluates store performance relative to network benchmarks, and uses warranty rates and repeat-claim behaviour to identify products that may warrant further investigation.

The dataset's synthetic nature is important when interpreting the results. The report demonstrates an analytical workflow and Power BI capabilities rather than establishing real-world Apple performance or product defect rates.

**Key metrics:**

- **Modelled sales value:** \$2.927Bn
- **Units sold:** 4.165M
- **Year-over-year sales-value growth:** +57.87%
- **Year-over-year unit growth: +33.83%**
- **Warranty claims per 1,000 units:** 7.05
- **Repeat claim rate:** 23.29%
- **Number of stores represented:** 75

**Insights Deep Dive:**

**Category 1: Executive Overview – What is happening?**

The executive overview consolidates the scale and direction of sales value, unit volume, product mix, geographic contribution and warranty exposure

Key questions:

- How are sales value and unit volume changing over time?
- Which categories contribute most to modelled sales value?
- How is the product portfolio distributed?
- What is the overall level of warranty exposure?

The objective is to provide stakeholders with a concise view of overall performance before they investigate individual products, store, or warranty indicators

**Category 2: Product and Category Performance – What is driving it?**

This analysis examines category contribution, product-family performance, product-level volume and sales value, and growth measures.

Key questions:

- Which categories and product families contribute most to modelled sales value?
- Do high-sales-value products also sell more units, or is their contribution associated with higher reference prices?
- Which products show differences between sales-value growth and unit growth?
- How has performance changed over time?

The distinction between value and column is central to the analysis. A product generating more sales value does not necessarily sell more units, and reconstructed reference prices should not be mistaken for actual transaction prices.

**Category 3: Store Performance & Benchmarking – How consistent is the network?**

This analysis examines the distribution of store sales value, performance relative to network benchmarks, monthly volatility and geographic footprint.

Key questions:

- How tightly are store sales values clustered?
- Which stores are above or below the network median?
- Do stores with higher average sales value also show greater monthly volatility?
- How does country-level sales value relate to store count and sales value per store?

Country totals are interpreted alongside store counts because a country with more stores may generate more total sales value without having higher productivity per store.

**Category 4: Product Quality & Warranty Analysis — Where should we investigate?**

This analysis evaluates warranty claim rates, claim timing, repeat claims, and repair outcomes to identify potential product-quality investigation priorities.

Key questions:

- Which products have elevated warranty claim rates relative to units sold?
- When after purchase do claims occur?
- How often do affected sales generate multiple claim events?
- Which products combine meaningful sales volume with elevated warranty indicators?

The refreshed dataset uses **7.05 warranty claims per 1,000 units** as the overall benchmark. Product-level rates can be compared with this benchmark, while considering volume and repeat-claim behaviour together.

Claim-event counts are not the same as affected-sale counts: a single sale can be associated with multiple claim events. Repair-status counts are treated descriptively and are not used alone to infer operational bottlenecks.

**Recommendations**

Based on the analytical framework and the patterns identified in the report, the following actions would be appropriate for further investigation using real operational data:

- **Separate sales-value growth from unit growth.** Investigate products where sales value grows materially faster than unit volume, considering reference prices and product mix before drawing conclusions about demand.
- **Prioritise warranty investigation using rates and volume together.** Focus on products with claim rates above the overall benchmark of 7.05 claims per 1,000 units and sufficient sales volume to make the comparison meaningful.
- **Investigate repeat claims.** Review products with elevated repeat-claim rates alongside claim reasons, repair history, and affected-sale counts.
- **Benchmark stores against the network.** Investigate sustained or material deviations from the store median and review monthly volatility before treating a ranking as evidence of superior performance.
- **Separate geographic scale from productivity.** Compare country-level sales value with store count and sales value per store.
- **Analyse subscriptions separately from hardware.** Their pricing and quantity definitions differ, and subscription-support issues should not be interpreted as hardware warranty claims.
- **Validate findings with real business data.** Use actual transaction prices, costs, product returns, warranty reasons, and repair details before making commercial or operational decisions.

**Assumptions and Caveats:**

The analysis uses a synthetic dataset and reconstructed information. The following limitations apply:

- **Synthetic sales and store data:** Transaction and store data do not represent actual Apple retail performance
- **Reconstructed product metadata:** Product launch dates and reference prices were reconstructed from publicly available information. Certified-refurbished reference prices may be used where original new-product pricing is no longer available
- **Modelled sales value:** Calculated as units sold multiplied by reconstructed product reference price. It does not account for actual transaction prices, discounts, tax, currency conversion or country-specific pricing
- **Launch-date assumption:** US retail launch dates are applied across the represented store network, although actual local launch timing may differ
- **Store assortment:** Each store is represented as selling the full product list. Real stores may differ in assortment, inventory and demand
- **Quantity generation:** Hardware sale quantities range from 1 – 10 in the synthetic dataset. Subscription quantities can represent multiple months and range from 6 – 24, so unit comparisons between subscriptions and physical products are not necessarily like-for-like
- **No cost data:** Product costs are not available, so profit and gross margin cannot be calculated
