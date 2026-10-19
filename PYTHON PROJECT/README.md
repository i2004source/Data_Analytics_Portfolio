Python Project – real world dataset from <https://data.sba.gov/dataset/7a-504-foia>

**SBA 7(a) vs 504 Loans - Which loan program has the better performance for small business README**

**Project Overview:**

This project uses Python to explore an open dataset from the U.S. federal government's U.S. Small Business Administration (SBA), which primarily focuses on capital, counselling and contracts.

My objective is to demonstrate practical data analyst skills by profiling real-world data, validating relationships between datasets and to compare the 2 main loan programs, the 7(a)-loan and the 504-loan offered by the SBA to small businesses across the USA. This analysis uses Python to transform raw public data into structured findings…

**Project Background:**

Based in Washington D.C., the U.S. Small Business Administration (SBA), is an independent agency of the United States federal government created in 1953 to help, counsel and protect the interest of small business. Its core missions focus on the 3 Cs: providing **Capital** (loans and guarantees), **Counselling** (training and advisory services) and **Contracts** (federal procurement assistance), alongside disaster recovery support. They support over 34 million small businesses, which makes up almost 99% of all U.S. businesses.

From a data analyst perspective, this gave me an opportunity to decide which parts of the data is relevant to the analysis, examining the different structures and parties involved in either program, the characteristics of each program and the patterns in charge-off rates.

Insights and recommendations are provided on the following key areas:

- **Industry Risk:** Which industries have the highest and lowest observed charge-off rates in SBA 7(a) and 504 lending?
- **Loan and Project Characteristics:** How do financing amounts, repayment terms, and other loan or project characteristics vary across outcomes?
- **Geographic Risk:** How does observed credit risk vary across states and other geographic markets?
- **Hypothesis Testing:** Do charged-off and paid-in-full loans differ significantly in financing amounts and repayment characteristics?

**Data Sources and Structure:**

This project uses 3 tables available as well as a data dictionary about the 2 tables as part of the dataset from the U.S. government:

- **FOIA_504_FY2010_Present_asof_260603:** records all loans approved by the SBA for the 504-loan program between 2010 - 03.06.2026
- **FOIA_7a_FY2010_FY2019_asof_260603:** records all loans approved by the SBA for the 7(a)-loan program between 2010 – 2019
- **FOIA_7a_FY2020_Presnet \_asof_260603:** records all loans approved by the SBA for the 7(a)-loan program between 2020 – 03.06.2026
- **7a_504_foia_data_dictionary:** this is a dictionary of what each column means and further explains the meaning of certain values.

**Dataset Size:**

The final DataFrames used for this project is the full 2010 – present 504 table labelled as df504 and for the 7(a) table I concatenated the 2010 – 2019 table with the 2020 – present table to make a full 2010 – present table labelled as df7a.

| **Dataset** | **Records** |
| ----------- | ----------- |
| df7a        | 934,089     |
| df504       | 117,983     |

No duplicates were found in either table.

**Key Fields and Data Relationships:**

The 7(a) and 504 datasets are analysed separately because their financing structures and available variables differ. In particular, the 504 programme uses a financing structure involving a third-party lender and a CDC/SBA debenture, so its financing fields are not directly interchangeable with 7(a) fields.

- **Loan Status:** Indicates whether a loan was paid in full, charged off, cancelled, undisbursed, or has another reporting status.
- **Financing Amounts:** Includes gross approval amounts and programme-specific financing measures.
- **Dates and Terms:** Includes approval dates, fiscal years, first disbursement dates, and repayment terms.
- **Industry:** Includes NAICS codes and industry descriptions.
- **Geography:** Includes project state and county, SBA district office, and lender or CDC location fields.
- **Business Characteristics:** Includes business age, business type, franchise information, collateral indicators, and jobs supported.

No entity relationship diagram is required because this is a loan-level analytical project rather than a relational database analysis.

**Executive Summary:**

**Overview of Findings:**

The analysis found differences in observed charge-off rates between the two programmes and across industries. Among records with explicitly resolved outcomes, the overall observed charge-off rate was **8.14% for 7(a)** and **2.42% for 504**. Industry-level results also showed substantial variation, while financing amounts, repayment terms, business characteristics, and geographic markets provided additional ways to investigate differences between charged-off and paid-in-full records.

These results are descriptive rather than proof that one programme or industry is inherently riskier. The analysis includes only records with explicitly recorded paid-in-full or charged-off outcomes for charge-off rate calculations, and more recent loans may not have had as much time to reach an outcome.

**Insights Deep Dive:**

1\. **Industry Risk:**

- **Observed charge-off rates varied considerably by industry.** In the 7(a) dataset, Cosmetics, Beauty Supplies, and Perfume Retailers had the highest observed rate identified, at **40.00% (26 charge-offs out of 65 resolved records).**
- **Other 7(a) industries also recorded elevated rates.** All Other Miscellaneous Retailers had a rate of **32.69% (34 out of 104**), while Formal Wear and Costume Rental had a rate of **30.16% (19 out of 63).**
- **The highest observed rate in the 504 analysis was lower than the highest 7(a) rate.** Plastics Material and Resin Manufacturing recorded **12.00% (3 out of 25 resolved records),** followed by Cut Stone and Stone Product Manufacturing at **10.71% (6 out of 56).**
- **Several industries recorded no charge-offs in the analysed sample.** However, a zero observed rate does not establish that an industry has no credit risk, especially where the number of resolved records is limited.

**2\. Loan and Project Characteristics**

- **Financing amounts were examined in relation to observed loan outcomes.** The analysis compared gross approval amounts and other available financing measures for charged-off and paid-in-full records.
- **Repayment terms were examined as a potential differentiating characteristic.** The 7(a) analysis included loan terms and initial interest rates where available; the 504-analysis focused on available financing measures and repayment terms.
- **Business and lending characteristics provided additional context.** Variables such as business age, business type, collateral indicators, processing method, and industry were assessed to identify differences in observed outcomes.
- **Results depend on the variables available in each programme's dataset.** The 504 analyses do not infer a directly comparable effective interest rate because the dataset does not provide a suitable equivalent to the 7(a) initial interest-rate field.

**3\. Geographic Risk**

- **Project location was used as the primary geographic dimension.** State-level comparisons help explore whether observed charge-off rates differ across the markets where financed businesses operate.
- **Geographic rates must be interpreted alongside record counts.** States with fewer resolved records can show volatile rates, so minimum sample-size thresholds are important when comparing markets.
- **Additional location fields provide different perspectives.** Lender state for 7(a), CDC state for 504, and SBA district office can help distinguish business location patterns from lending-channel patterns.
- **Geographic differences are descriptive, not necessarily causal.** Differences across states may reflect industry composition, borrower characteristics, loan mix, and other factors not isolated by this analysis.

**4\. Hypothesis Testing**

- **The analysis formally compared charged-off and paid-in-full records.** Mann–Whitney U tests were selected to compare the distributions of numeric variables without assuming that the data follow a normal distribution.
- **Financing measures were tested separately by programme.** The 7(a) tests included gross approval, SBA-guaranteed approval, loan term, and initial interest rate. The 504 tests included gross approval, third-party financing, and loan term.
- **Multiple comparisons were accounted for.** Bonferroni-adjusted p-values were used to reduce the risk of treating chance findings as statistically significant when multiple hypotheses were tested.
- **Statistical significance does not establish causation.** The tests identify differences in observed distributions, not whether a particular characteristic causes a loan to be charged off. Findings should also be considered alongside sample sizes, missing data, and loan maturity.

**Recommendations**

Based on the findings, lending risk and portfolio analysis teams could consider the following:

- **Industry monitoring:** Review industries with elevated observed charge-off rates more closely, while checking sample sizes and whether the results remain consistent over time.
- **Risk assessment:** Use financing amounts, repayment terms, business characteristics, and available borrower information as inputs for further risk analysis rather than relying on a single characteristic.
- **Geographic monitoring:** Compare state-level charge-off rates alongside lending volumes and resolved record counts to identify markets that may warrant further investigation.
- **Statistical validation:** Use the hypothesis-testing results to identify relationships worth investigating further and validate those relationships using additional data or suitable predictive modelling.
- **Outcome maturity:** Separate more recent loan cohorts from mature cohorts when assessing credit outcomes, because recent loans have had less time to experience and report charge-offs.

**Assumptions and Caveats**

- **Resolved-outcome definition:** Charge-off rates are calculated using only paid-in-full and charged-off records: P I F and CHGOFF for 7(a), and PIF and CHGOFF for 504. These rates describe observed outcomes among the included records, not the probability that every originated loan will eventually default.
- **Other statuses excluded:** Cancelled, undisbursed, and EXEMPT records are excluded from resolved-outcome charge-off rate calculations. EXEMPT means the record does not have a publicly disclosed paid-in-full or charged-off outcome under the dataset's reporting rules.
- **Unequal loan maturity:** Recent loan cohorts have had less time to reach an outcome. Comparisons across years should account for this difference.
- **Minimum sample sizes:** Industry and category comparisons use minimum record-count thresholds to reduce the influence of very small groups. Rankings can still be sensitive to sample size.
- **Different programme structures:** SBA 7(a) and 504 financing structures and available fields differ. Their observed rates can be compared descriptively, but differences do not by themselves establish that one programme is inherently riskier.
- **No direct comparable 504 interest rate:** The 504 dataset does not provide a directly comparable effective interest-rate measure, so the analysis does not invent or estimate one.
- **Missing data and data quality:** Missing values and inconsistent data types may affect individual analyses. Calculations should use available observations for each variable, and sample sizes should be checked where missingness is material.
- **Geographic interpretation:** Project location, lender state, CDC state, and SBA district office represent different geographic concepts and should not be treated as interchangeable.
- **Association versus causation:** Descriptive comparisons and hypothesis tests cannot establish that a loan characteristic caused a charge-off.
- **Public data limitations:** The analysis is limited to fields available in the public datasets. Results may not reflect all underwriting, borrower, economic, or servicing factors that influence loan outcomes.
