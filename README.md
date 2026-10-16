SQL Project – real world dataset from <https://www.nyc.gov/opendata>

**NYC DCWP Licensing and Enforcement README**

**Project Overview:**

This project uses SQL to explore an open dataset from New York City's regulating agency the Department of Consumer and Worker Protection (DCWP), which focuses on business licensing, regulatory inspections and enforcement charges.

My objective is to demonstrate practical data analyst skills by cleaning and profiling real-world data, validating relationships between datasets, investigation trends and answering questions about licensing and regulatory activity. This analysis uses SQL to transform raw public data into structured findings, with attention to data-quality, record-level accuracy and limitations of joining datasets with different scopes.

**Project Background:**

The DCWP formerly known as the Department of Consumer Affairs (DCA), established 2019, is the official municipal agency in New York City charged with delivering economic justice and protecting consumers and workers. The company publishes its data about its licensing issuance, inspections and charges on the NYC open data website.

From a data analyst perspective, this gave me an opportunity to decide which parts of the data is relevant to the analysis, examining distributions of licenses businesses, patterns in inspection activity and the relationship between inspections and enforcement records.

Insights and recommendations are provided on the following key areas:

- **Data Quality & Relationships:** Assessing data completeness, validating unique identifiers, profiling date ranges and examining relationships between datasets.
- **Business Licensing:** Exploring license status, license types, business categories, geographic distribution and issuance trends.
- **Inspection Activity:** Analysing inspection volumes, outcomes, inspection types, geographic patterns and businesses receiving repeated inspections
- **Regulatory Charges & Integrated Analysis:** Investigating charge patterns and examining how licensing, inspection and charges records overlap

**Data Sources & Structure:**

This project uses three publicly available datasets from NYC Open Data:

- **Issued Licenses:** Records of licenses issued by DCWP, including license numbers, business identifiers, business categories, license status, borough and license dates
- **DCWP Inspections:** Records of Inspections, including inspection identifiers, business and license references, inspection dates, inspection types and outcomes
- **DCWP Charges:** Records relating to regulatory charges, including case/application identifiers and charge-related information.

**Dataset Size** (after dropping duplicates)**:**

| **Dataset**      | **Records** |
| ---------------- | ----------- |
| Issued Licenses  | 69,885      |
| DCWP Inspections | 263,325     |
| DCWP Charges     | 129,607     |

The raw dataset contained 1 duplicate in the Issued Licenses table and 8 duplicates in the DCWP Charges table, which have all been removed during cleaning. The charge dataset was assigned a new Charge_ID to uniquely identify individual charge rows because the source RecordID was not unique.

**Data Relationships:**

This dataset shares 1 common column – BusinessUniqueID - in all 3 tables It is useful for business-level matching, but because it repeats across licenses and inspections, joining raw tables directly on it can multiply rows and inflate counts.

- **LicenseNumber:** found in the Issued Licenses table, is a unique column which identifies individual license records. Supports a more specific license-level comparison between issued licenses and inspections
- **InspectionNumber:** found in the DCWP_Inspections table, is a unique column which identifies individual inspection records. Links inspection records to related charge records where the identifiers match.
- **RecordID:** found in the DCWP_Charges table, is not a unique column which represents a source-level case/application identifier and can repeat. This means that each RecordID can have be linked to more than 1 date which have different outcomes, linking to further escalation of cases against a business.
- **Charge_ID (Surrogate Primary Key):** found in the DCWP_Charges table, is a column created by me to uniquely identify each record in the DCWP_Charges table.
- **BusinessUniqueID:** this is the common column across the dataset, which provides a business-level link, although the caveat is that a singular BusinessUniqueID can be linked to multiple licenses and inspection records.

The relationship between licensing with either the inspection or charges data is not complete. This is treated as an analytical finding and a limitation to investigate, rather than automatically assuming that unmatched records are data errors.

**Executive Summary:**

The analysis identified high inspection and charge volumes in tobacco retail, electronic cigarette retail and grocery retail categories. Inspection activity increased substantially between 2023 and 2024, while annual license issuance fluctuated. The available data identifies patterns for further investigation but does not establish the causes behind these trends.

**Insights Deep Dive:**

Category 1 - Understanding NYC's Licensed Business Landscape

- **License Status:** Only 62.36% of licenses in NYC are active. The remaining 37.64% is mostly expired at 26.68%, surrendered at 3.88% and failed to renew at 2.74%. As of 1<sup>st</sup> of June 2026, 653 licenses are approaching expiry. It should be stated that businesses can hold multiple licenses, each having their own expiry date.
- **Business Category License Count:** Home Improvement Contractors is the largest category by license count – 18,437 licenses, followed by Tobacco Retail Dealers with 6,586 and Second-hand Dealer – General with 5,415. These numbers represent licenses rather than distinct businesses, who can hold multiple licenses.
- **Geography:** The largest concentration of licenses holders appears to be outside of NYC holding 24,560 licenses. With in New York, Queens has the highest count at 13,129 and Brooklyn following second at 13,067. Manhattan holds 9,986, the Bronx at 6,144 and Staten Island holding 2,998. This should be considered a misrepresentation of which licenses operate in New York city.
- **Licenses Renewal Date and Issuances:** FY2026 Q1-Q3 shows that a moderate range of 1,599 – 3,936 licenses would approach expiry and need renewal. Q4 shows a large jump to 23,608, showing that the DCWP tends to keep license renewals closer to the year ends. Yearly Issuance fell in 2024 from 5,866 to 5,506 before rising to 6,661 in 2025. As off April 2026 the DCWP issued 1,656 FY 2026 so far.

Category 2 - Inspection Activity & Operational Performance

- **Inspection Activity:** the DCWP increased activity between 2023 and 2024, from 34,333 inspections to 100,803, declining in 2025 to 92,479. As of 5<sup>th</sup> Dec 2026, total inspections stand at 35,710. The increase in activity between 2023 – 2024 could reflect changes in enforcement activity, reporting or data coverage, available results do not establish the cause.
- **Business Category Inspections:** Inspection activity was undertaken in several business categories; however, a common field of categories faced the greatest number of inspections. Tobacco Retail Dealer recorded 59,009 inspections, followed by Electronic Cigarette Dealer recorded 52,306 and Grocery-Retail with 35,680. In total these are 146,996 out of 263,326 inspections.
- **Geographic Inspection:** Brooklyn holds the highest inspection count at 72,891 of which 19,924 resulted as bad inspections followed by Queens with 70,145 of which 17,363 resulted as bad inspections and Manhattan with 69,445 of which 18,344 resulted as bad inspections.
- **Inspection Type and Status:** most frequent status includes No Violation Issued at 60,730, Violation Issued at 50,625, Out of Business at 42,748 and No Evidence of Activity at 40,954. Due to the both violation-related and non-violation related outcomes, it indicated inspections serve different purposes, including identifying violations, establishing whether businesses are operating. Patrol was the most common inspection type with 91,197 records followed by Tobacco – Sale to Minor with 44,683.

Category 3 - Compliance & Enforcement Analysis: Findings

- **Enforcement Activity:** Concentrated around tobacco-related and E-cig business categories. Tobacco Retail Dealer accounted for 47,731 charge records, followed by Electronic Cigarette Dealer with 32,093 and Grocery-Retail with 19,221. This is consistent with the high inspection volumes for these categories found in phase 2, suggesting tobacco dealing, E-cig dealing and retail are important for continued compliance monitoring.
- **Cure rates Vs Pending-Outcome rates:** each use different denominators and measure different things: cure rate is calculated from eligible records with a known Yes or No cure status, while pending-outcome rate is calculated from all records in a charge category. They should not be compared as if they were alternative measures of the same outcome. Overall, the results identify recurring enforcement themes, repeat-charge activity and charge types that may benefit from either targeted education or follow-up.
- **Cure Analysis:** Refund-policy posting violations accounted for 1,714 cured charges, while failure to display total selling prices had 1,029. Cure rates varied by charge type, among the eligible records with a known Yes or No cure status, smaller categories had cure rates above 90% such as the out-of-order machine sign charge, 181 out 188 resolved. Refund policy posting had a cure rate of 85.36% whilst total-selling-price display had a cure rate of 82.92%.
- **Pending Adjudication:** pending adjudication outcomes were particularly common in several tax-preparer disclosure charge categories. The charge relating to disclosure of whether the preparer would represent the taxpayer during an audit has a pending-outcome rate of 65.38%. These figures can help identify charge types for which many records remain unresolved in the dataset.

Category 4 – Compliance Risk Assessment: Findings

- **High enforcement intensity:** Tax Preparers had the highest charges-per-inspection ratio (0.86), followed by Tobacco Retail Dealers (0.77) and Supermarkets (0.74), highlighting categories for further compliance review. These ratios should be treated as indicators of enforcement intensity rather than the probability that an inspection will result in a charge.
- **Compliance can change over time:** Several businesses moved from favourable inspection outcomes, such as Pass or No Violation Issued, to a later Violation Issued outcome, showing the value of tracking inspection histories rather than relying on single results.
- **Repeat offending is concentrated in certain categories:** Supermarkets had a reported repeat-offender rate of 56.26%, while Tobacco Retail Dealers and Electronic Cigarette Dealers recorded 44.28% and 44.13%, respectively. Smaller sample sizes should be considered when interpreting these rates.
- **Historical patterns can support risk-based inspections:** The analysis classified 7,429 businesses as high risk (9.27% of the inspected-business population reported). This offers a starting point for targeted follow-ups, but the risk model should be validated before operational use.

**Recommendations:**

Based on the insights and findings above, I would recommend the DCWP to consider the following:

1. **Prioritise targeted reviews of high-activity categories.** Use tobacco retail, electronic-cigarette retail and other categories with high charge volumes as starting points for reviewing inspection coverage, recurring violations and the effectiveness of existing interventions.
2. **Combine volume with rates.** Compare charge counts with the number of businesses and inspections in each category and borough. This would help distinguish areas with high activity because they contain many businesses from areas with comparatively high enforcement activity relative to their size.
3. **Use repeat activity to inform follow-up.** Flag businesses with charge records across multiple dates or repeated adverse inspection outcomes for case-level review. Confirm case outcomes and current compliance status before treating a business as a priority for enforcement.
4. **Expand targeted compliance education.** Consider guidance or outreach on recurring requirements, including refund-policy signs, total selling-price displays, tobacco retail licensing and electronic-cigarette retail regulations. Future analysis could assess whether these interventions correspond with changes in subsequent violation or cure rates.
5. **Review unresolved cases separately from cure outcomes.** Track pending adjudication outcomes independently from whether a charge was recorded as cured. This would provide a clearer picture of case resolution and avoid conflating correction of a violation with the legal outcome of a charge.
6. **Develop and validate a risk-based inspection framework.** Use historical inspection outcomes, repeated charge dates, charge frequency and relevant licensing information as potential inputs. Test the framework against later records to assess whether it identifies businesses that subsequently receive adverse inspection outcomes or further charges.
7. **Monitor performance over time.** Useful indicators include inspection coverage among matched businesses, inspections per business, charges per inspection, repeat-charge rate, cure rate among eligible records with known outcomes, share of cases pending resolution and time between recorded enforcement events. Report the denominator and observation period for each KPI.

Assumptions and Caveats:

- Different units of analysis: License, business, inspection, and charge counts are not interchangeable.
- Incomplete coverage: The datasets cover different periods, and 2026 is partial; unmatched records do not prove an event never occurred.
- Join limitations: One-to-many relationships can inflate counts if records are not aggregated at the correct grain.
- Interpretation limits: Charges per inspection, cure rates, and repeat-offender rates describe specific recorded patterns, not definitive measures of compliance or causation.
- Validation and uncertainty: Charge totals need reconciliation, pending statuses must be handled carefully, and risk classifications require validation before operational use.
