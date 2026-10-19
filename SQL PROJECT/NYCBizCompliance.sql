  --Phase 0 - Date Quality and Validation
----Checking for Duplicates

--SELECT LicenseNumber, BusinessName, BusinessUniqueID, BusinessCategory, LicenseType, LicenseStatus, InitialIssuanceDate, ExpirationDate, City, State, ZipCode, Borough, COUNT(*)
--FROM Issued_Licenses
--GROUP BY  LicenseNumber, BusinessName, BusinessUniqueID, BusinessCategory, LicenseType, LicenseStatus, InitialIssuanceDate, ExpirationDate, City, State, ZipCode, Borough
--HAVING COUNT(*) > 1;
----There was a discrepency of 2 records being duplicates, so i removed one of the rows
--WITH DUPE_DEL as(
--	SELECT *,
--		ROW_NUMBER() OVER (
--			PARTITION BY LicenseNumber
--			Order By LicenseNumber ASC
--		) AS Row_num
--	From Issued_Licenses
--)
--DELETE FROM DUPE_DEL
--Where Row_num > 1

--SELECT CertificateofInspection,	InspectionNumber,	DateofOccurrence,	BusinessUniqueID,	BusinessName,	BusinessCategory,	
--DCWPLicenseNumber,	InspectionType,	InspectionStatus,	NOHNumber,	City,	State,	Postcode,	Borough,
-- COUNT(*)
--FROM DCWP_Inspections
--GROUP BY CertificateofInspection,	InspectionNumber,	DateofOccurrence,	BusinessUniqueID,	BusinessName,	BusinessCategory,	
--DCWPLicenseNumber,	InspectionType,	InspectionStatus,	NOHNumber,	City,	State,	Postcode,	Borough
--HAVING COUNT(*) > 1;

--Select RecordID,	RelatedRecordType,	BusinessUniqueID,	BusinessName,	BusinessCategory,	InspectionNumber,	
--	NOHNumber,	ViolationDate,	Charge,	Charge_Count,	CureEligible,	Cured,	Outcome,	Guilty,	NotGuilty,	Dismissed, COUNT(*)
--From DCWP_Charges
--GROUP BY RecordID,	RelatedRecordType,	BusinessUniqueID,	BusinessName,	BusinessCategory,	InspectionNumber,	NOHNumber,	
--ViolationDate,	Charge,	Charge_Count,	CureEligible,	Cured,	Outcome,	Guilty,	NotGuilty,	Dismissed
--Having Count(*) > 1

--Deleting Duplicates in DCWP_Charges
--WITH CTE_Duplicates AS (
--    SELECT 
--        RecordID, RelatedRecordType, BusinessUniqueID, BusinessName, BusinessCategory, 
--        InspectionNumber, NOHNumber, ViolationDate, Charge, Charge_Count, 
--        CureEligible, Cured, Outcome, Guilty, NotGuilty, Dismissed,
--        ROW_NUMBER() OVER (
--            PARTITION BY 
--                RecordID, RelatedRecordType, BusinessUniqueID, BusinessName, BusinessCategory, 
--                InspectionNumber, NOHNumber, ViolationDate, Charge, Charge_Count, 
--                CureEligible, Cured, Outcome, Guilty, NotGuilty, Dismissed
--            ORDER BY 
--                (SELECT NULL) 
--        ) AS RowNum
--    FROM DCWP_Charges
--)
--DELETE FROM CTE_Duplicates
--WHERE RowNum > 1;


--Updating the DCWP_Charges Table according to the Field Limitations stated in the table dictionary
--ALTER TABLE DCWP_Charges
--ALTER COLUMN CureEligible Varchar(3) NOT NULL
--UPDATE DCWP_Charges
--SET CureEligible = 'No'
--Where CureEligible IS NULL

--UPDATE DCWP_Charges
--SET CureEligible = 'Yes'
--Where CureEligible = '1'
--UPDATE DCWP_Charges
--Set CureEligible = 'No'
--Where CureEligible = '0'

--ALTER TABLE DCWP_Charges
--ALTER COLUMN Cured varchar(50) 
--UPDATE DCWP_Charges
--SET Cured = 'Pending Resolution'
--Where Cured IS NULL or Cured = '0'

--UPDATE DCWP_Charges
--SET Cured = 'Yes'
--Where Cured = '1'

--ALTER TABLE DCWP_Charges
--ALTER COLUMN Outcome varchar(50) 
--UPDATE DCWP_Charges
--SET Outcome = 'Pending Resolution'
--Where Outcome IS NULL 

--ALTER TABLE DCWP_Charges
--ALTER COLUMN Guilty varchar(50) 
--UPDATE DCWP_Charges
--SET Guilty = 'Pending Resolution'
--Where Guilty IS NULL 

--ALTER TABLE DCWP_Charges
--ALTER COLUMN NotGuilty varchar(50) 
--UPDATE DCWP_Charges
--SET NotGuilty = 'Pending Resolution'
--Where NotGuilty IS NULL 

--ALTER TABLE DCWP_Charges
--ALTER COLUMN Dismissed varchar(50) 
--UPDATE DCWP_Charges
--SET Dismissed = 'Pending Resolution'
--Where Dismissed IS NULL 

--UPDATE Issued_Licenses
--Set Borough = 'Outside NYC'
--Where Borough IS NULL

--SELECT COUNT(DISTINCT i.BusinessUniqueID) AS MatchingBusinesses
--FROM DCWP_Inspections i
--INNER JOIN
--(
--    SELECT DISTINCT BusinessUniqueID
--    FROM DCWP_Charges
--) l
--ON i.BusinessUniqueID = l.BusinessUniqueID;  --22896

--SELECT COUNT(DISTINCT i.BusinessUniqueID) AS MatchingBusinesses
--FROM DCWP_Inspections i
--INNER JOIN
--(
--    SELECT DISTINCT BusinessUniqueID
--    FROM Issued_Licenses
--) l
--ON i.BusinessUniqueID = l.BusinessUniqueID; --18857

--SELECT COUNT(DISTINCT i.BusinessUniqueID) AS MatchingBusinesses
--FROM DCWP_Charges i
--INNER JOIN
--(
--    SELECT DISTINCT BusinessUniqueID
--    FROM Issued_Licenses
--) l
--ON i.BusinessUniqueID = l.BusinessUniqueID; -- 7521

--SELECT COUNT(DISTINCT BusinessUniqueID)
--FROM DCWP_Inspections; -- 80122
--SELECT COUNT(DISTINCT BusinessUniqueID)
--FROM DCWP_Charges; --24746
--Select COUNT(DISTINCT BusinessUniqueID)
--From Issued_Licenses --62932

--Question 1: How many records exist in each dataset?
--select * from Issued_Licenses -- 69,885 records
--select * from DCWP_Inspections -- 263,325 records
--select * from DCWP_Charges -- 129,619 records

----Question 2: What period does each dataset cover
--Select min(InitialIssuanceDate) as earliest_date, max(InitialIssuanceDate) as recent_date
--from Issued_Licenses -- earliest_date = 1900-12-31, recent_date = 2026-04-16
--select min(ExpirationDate) as earliest_date, max(ExpirationDate) as latest_date
--from Issued_Licenses -- earliest_date = 2019-09-30, latest_date = 2100-12-18

--select min(DateofOccurrence) as earliest_date, max(DateofOccurrence) as recent_date
--from DCWP_Inspections -- earliest_date = 2023-01-08, recent_date = 2026-12-05

--select min(ViolationDate) as earliest_date, max(ViolationDate) as recent_date
--from DCWP_Charges -- earliest_date = 2023-01-08, recent_date = 2026-12-03

----Question 3: Are the primary keys unique?
--select DISTINCT(LicenseNumber)
--from Issued_Licenses --> yes this can be used as a primary key

--select COUNT(DISTINCT InspectionNumber)
--from DCWP_Inspections --> yes this can be used as a primary key

--select COUNT(DISTINCT RecordID)
--from DCWP_Charges --> No, this cant be used as a primary key. need to make a new one.
--ALTER TABLE DCWP_Charges
--Add Charge_ID INT IDENTITY(1,1) NOT NULL --> this will act as the surrogate Primary key

--Setting Primary Keys 
--Alter table Issued_Licenses
--ADD PRIMARY KEY (LicenseNumber) 
--Alter table DCWP_Inspections
--ADD Primary key (InspectionNumber)
--Alter table DCWP_Charges
--ADD PRIMARY KEY (Charge_ID)


--Question 4: what proportion of records containt missing values? any below 5% will not be written
--SELECT
--	ROUND(CAST(SUM(CASE WHEN Borough IS NULL or Borough = '' THEN 1 Else 0 END) as float)
--	/ count(*) * 100, 2) as proportion_missing
--From Issued_Licenses

--SELECT
--	ROUND(CAST(SUM(CASE WHEN NOHNumber IS NULL or NOHNumber = '' THEN 1 Else 0 END) as float)
--	/ count(*) * 100, 2) as proportion_missing
--From DCWP_Inspections

--SELECT
--	ROUND(CAST(SUM(CASE WHEN DCWPLicenseNumber IS NULL or DCWPLicenseNumber = '' THEN 1 Else 0 END) as float)
--	/ count(*) * 100, 2) as proportion_missing
--From DCWP_Inspections

----Question 5: How many licensed businesses have been inspected?
--SELECT COUNT(*) AS TotalInspections
--FROM DCWP_Inspections I
--WHERE EXISTS
--(
--    SELECT BusinessUniqueID
--    FROM Issued_Licenses L
--    WHERE L.BusinessUniqueID = I.BusinessUniqueID
--);


--------Question 6: Can every charge be linked to a valid inspection?
----		--		Are there charges that cannot be linked? 
--Select COUNT(*) AS Charges_With_Inspection
--FROM DCWP_Charges AS c
--Where EXISTS
--(
--	SELECT 1
--	FROM DCWP_Inspections as L
--	Where c.BusinessUniqueID = L.BusinessUniqueID
--)

--Select COUNT(*) AS Charges_Without_Inspection
--FROM DCWP_Charges AS c
--Where NOT EXISTS
--(
--	SELECT 1
--	FROM DCWP_Inspections as L
--	Where c.BusinessUniqueID = L.BusinessUniqueID
--);
--select * from DCWP_Charges

------Question 7: How many unique licensed businesses have never been inspected?
--With LicensedBuss AS(
--Select 
--	DISTINCT BusinessUniqueID
--	From Issued_Licenses
--)

--Select COUNT(*) AS Number_of_Business
--From LicensedBuss as L
--Where NOT EXISTS
--(
--Select 1
--FROM DCWP_Inspections as I
--Where L.BusinessUniqueID = I.BusinessUniqueID
--)


----Question 8: Are there inspections for businesses that do not exist in the Issued Licenses dataset?
--WITH LicensedBusinesses AS
--(
--    SELECT DISTINCT BusinessUniqueID
--    FROM Issued_Licenses
--)

--SELECT COUNT(*) AS Inspections_Without_Matching_Business
--FROM DCWP_Inspections i
--WHERE NOT EXISTS
--(
--    SELECT 1
--    FROM LicensedBusinesses l
--    WHERE i.BusinessUniqueID = l.BusinessUniqueID
--);

--WITH LicensedBusinesses AS
--(
--    SELECT DISTINCT BusinessUniqueID
--    FROM Issued_Licenses
--)

--SELECT
--    i.InspectionNumber,
--    i.BusinessUniqueID,
--    i.BusinessName,
--    i.DateofOccurrence
--FROM DCWP_Inspections i
--WHERE NOT EXISTS
--(
--    SELECT 1
--    FROM LicensedBusinesses l
--    WHERE i.BusinessUniqueID = l.BusinessUniqueID
--);
--Select * from DCWP_Inspections


--SELECT COUNT(DISTINCT i.BusinessUniqueID) AS MatchingBusinesses
--FROM DCWP_Inspections i
--INNER JOIN
--(
--    SELECT DISTINCT BusinessUniqueID
--    FROM DCWP_Charges
--) l
--ON i.BusinessUniqueID = l.BusinessUniqueID;

--SELECT COUNT(DISTINCT BusinessUniqueID)
--FROM DCWP_Inspections;
--SELECT COUNT(DISTINCT BusinessUniqueID)
--FROM DCWP_Charges;
--Select COUNT(DISTINCT BusinessUniqueID)
--From Issued_Licenses








------Phase 1 - Understanding the Licensing landscape in NYC?

----Question 1: Which Business categories have the largest and smallest number of business licenses?
--select BusinessCategory, COUNT(LicenseNumber) as No_of_licenses
--From Issued_Licenses
--GRoup by BusinessCategory
--Order by No_of_licenses Desc

--select BusinessCategory, COUNT(LicenseNumber) as No_of_licenses
--From Issued_Licenses
--GRoup by BusinessCategory
--Order by No_of_licenses ASC

----Question 2: How are licenses distributed across Boroughs?
--select Borough, COUNT(*) as No_of_Licenses
--From Issued_Licenses
--Group by Borough
--Order by No_of_Licenses DESC

--Question 3: What proportion of businesses have active, expired or inactive licences?
--SELECT
--    LicenseStatus,
--    COUNT(*) AS LicenseCount,
--    ROUND(
--        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
--        2
--    ) AS Percentage
--FROM Issued_Licenses
--GROUP BY LicenseStatus
--ORDER BY LicenseCount DESC;

--Question 4: How has the number of newly issued licences changed over time?
-- With YearlyCounts AS (
--	Select
--		YEAR(InitialIssuanceDate) as IssuanceYear,
--		COUNT(*) as NewLicenseCount
--	FROM Issued_Licenses
--	Where InitialIssuanceDate IS NOT NULL
--	GROUP BY YEAR(InitialIssuanceDate)
--)
--SELECT
--	IssuanceYear,
--	NewLicenseCount,
--	LAG(NewLicenseCount) OVER (ORDER BY IssuanceYear) AS PreviousYearCount,
--	NewLicenseCOUNT - LAG(NewLicenseCount) OVER (ORDER BY IssuanceYear) as YOYDIFF
--FROM YearlyCounts
--Order BY IssuanceYear DESC

--Question 5: Which industries have experienced the greatest growth in licensed businesses?
-- With YearlyCounts AS (
--	Select
--		YEAR(InitialIssuanceDate) as IssuanceYear,
--		BusinessCategory,
--		COUNT(*) as NewLicenseCount
--	FROM Issued_Licenses
--	Where InitialIssuanceDate IS NOT NULL
--	GROUP BY Year(InitialIssuanceDate), BusinessCategory
--)
--SELECT
--	IssuanceYear,
--	BusinessCategory,
--	NewLicenseCount,
--	LAG(NewLicenseCount) OVER (PARTITION BY BusinessCategory ORDER BY IssuanceYear) AS PreviousYearCount,
--	NewLicenseCOUNT - LAG(NewLicenseCount) OVER (PARTITION BY BusinessCategory ORDER BY IssuanceYear) as YOYDIFF,
--	ROUND(
--	(NewLicenseCount - LAG(NewLicenseCount) OVER (PARTITION BY BusinessCategory ORDER BY IssuanceYear)) * 100.0/
--	NULLIF(LAG(NewLicenseCount) OVER (PARTITION BY BusinessCategory ORDER BY IssuanceYear), 0),
--	2) AS YOYGrowthPercentage
--FROM YearlyCounts
--Order BY YOYGrowthPercentage DESC, IssuanceYear ASC

--Question 6: which license types are the most common?
--select MAX(LicenseType) as License_Type, COUNT(*) as no_of_licenses
--From Issued_Licenses
--GROUP BY(LicenseType)

--Question 7: How many licenses are approaching expiry quarterly FY2026 ?
--select count(*) AS LicenseExpiringSoon_Q1
--FROM Issued_Licenses
--Where ExpirationDate >= '2026-03-31'
--AND ExpirationDate <= CAST(DATEADD(month, 3, '2026-03-31') AS DATE)

--select count(*) AS LicenseExpiringSoon_Q2
--FROM Issued_Licenses
--Where ExpirationDate >= '2026-06-30'
--AND ExpirationDate <= CAST(DATEADD(month, 3, '2026-06-30') AS DATE)

--select count(*) AS LicenseExpiringSoon_Q3
--FROM Issued_Licenses
--Where ExpirationDate >= '2026-09-30'
--AND ExpirationDate <= CAST(DATEADD(month, 3, '2026-09-30') AS DATE)

--select count(*) AS LicenseExpiringSoon_Q4
--FROM Issued_Licenses
--Where ExpirationDate >= '2026-12-31'
--AND ExpirationDate <= CAST(DATEADD(month, 3, '2026-12-31') AS DATE)





--Phase 2 - Inspection Activity and Operational Performance
--Question 1: How many inspections are conducted each year?
--SELECT 
--	YEAR(DateofOccurrence) as Inspection_year,
--	COUNT(*) as No_Of_Inspections
--	From DCWP_Inspections
--GROUP BY YEAR(DateofOccurrence)
--Order By Inspection_year 

--Question 2:Which business categories receive the highest number of inspections?
--Select BusinessCategory, COUNT(*) AS No_Of_Inspections 
--From DCWP_Inspections
--GROUP BY BusinessCategory
--ORDER BY No_Of_Inspections DESC


--Question 3: Which Boroughs experienced the greatest inspection activity?
--Select Borough, COUNT(InspectionStatus) as no_of_inspections
--From DCWP_Inspections
--where InspectionStatus NOT LIKE 'Closed' 
	--AND InspectionStatus NOT LIKE 'No Evidence of Activity'
	--AND InspectionStatus NOT LIKE 'No Violation Issued'
	--AND InspectionStatus NOT LIKE 'No Warning Issued'
	--AND InspectionStatus NOT LIKE 'Out of Business'
	--AND InspectionStatus NOT LIKE 'Pass'
--GROUP BY Borough
--Order By Count(InspectionStatus) DESC;

--Select Borough, COUNT(InspectionStatus) as no_of_inspections
--From DCWP_Inspections
--GROUP BY Borough
--Order By Count(InspectionStatus) DESC;

--Question 4: What inspection outcomes occurs most frequently?
--Select InspectionStatus, Count(*) as No_of_Outcomes
--FROM DCWP_Inspections
--Group By InspectionStatus
--Order By No_of_Outcomes DESC

--Question 5: Which Inspection Type is most commonly performed?
--Select InspectionType, COUNT(*) As Count_of_All_Types
--From DCWP_Inspections
--GROUP BY InspectionType
--Order by Count_of_All_Types desc

--Question 6: What Percentage of licensed businesses have been inspected
--WITH UniqueLicensed AS (
--    SELECT COUNT(DISTINCT BusinessUniqueID) AS TotalLicenses
--    FROM Issued_Licenses
--),
--UniqueInspected AS (
--    SELECT COUNT(DISTINCT l.BusinessUniqueID) AS InspectedLicenses
--    FROM Issued_Licenses l
--    INNER JOIN DCWP_Inspections i ON l.BusinessUniqueID = i.BusinessUniqueID
--)
--SELECT 
--    l.TotalLicenses,
--    i.InspectedLicenses,
--    ROUND((i.InspectedLicenses * 100.0) / l.TotalLicenses, 2) AS PercentageInspected
--FROM UniqueLicensed l, UniqueInspected i;

--Question 7: Which businesses are inspected repeatedly?
--Select BusinessUniqueID, BusinessName, Count(CertificateofInspection) as No_of_Inspections
--FROM DCWP_Inspections
--Group By BusinessUniqueID, BusinessName
--Order By No_of_Inspections DESC


--Question 8: Which industries experience the highest inspection frequency?
--Select BusinessCategory, Count(CertificateofInspection) AS No_of_Inspections
--FROM DCWP_Inspections
--GROUP BY BusinessCategory
--Order By No_of_Inspections DESC

--Question 9: Are inspection volumes increasing or decreasing over time?
--With YearlyCounter AS(
--	Select
--		YEAR(DateofOccurrence) as InspectionYear,
--		COUNT(*) as InspectionCount
--		From DCWP_Inspections
--		Where DateofOccurrence IS NOT NULL
--		GROUP BY YEAR(DateofOccurrence)
--)
--Select
--	InspectionYear,
--	InspectionCount,
--	LAG(InspectionCount) OVER (ORDER BY InspectionYear) AS PreviousYearCount,
--	InspectionCount - LAG(InspectionCount) OVER (ORDER BY InspectionYear) AS YOYDIFF
--FROM YearlyCounter
--Order By InspectionYear







----Phase 3 - Compliance & Enforcement Analysis
--Question 1: Which business categories receive the highest number of charges?
--Select BusinessCategory, COUNT(Charge_Count) as No_of_Charges
--From DCWP_Charges
--Group By BusinessCategory
--Order By No_of_Charges DESC

--Question 2: Which boroughs recieves the highest number of charges?
--select IL.Borough, COUNT(DC.Charge_Count) AS No_of_Charges
--From DCWP_Charges AS DC
--JOIN Issued_Licenses as IL
--on DC.BusinessUniqueID = IL.BusinessUniqueID
--GROUP BY IL.Borough
--Order by No_of_Charges DESC

--Question 3: What are the most common charges issued?
--select Charge, COUNT(*) as Total
--From DCWP_Charges
--Group by Charge
--Order By Total DESC

--Question 4: Which businesses have the greatest number of enforcement cases?
--Select BusinessUniqueID, BusinessName, COUNT(DISTINCT RecordID) AS Total_Cases
--From DCWP_Charges
--GROUP BY BusinessUniqueID, BusinessName
--Order by Total_Cases DESC

--Question 5: Which inspection outcomes most frequently lead to charges?
--Select DI.InspectionType, COUNT(DC.Charge) as No_of_Charges
--From DCWP_Inspections as DI
--Join DCWP_Charges as DC
--on DI.InspectionNumber = DC.InspectionNumber
--GROUP BY DI.InspectionType
--Order By No_of_Charges DESC

--Question 6: Which Charges are most commonly cured?
--Select Charge, count(Cured) as Cure_Count
--From DCWP_Charges
--Where Cured = 'Yes'
--group by Charge
--ORDER BY Cure_Count DESC


--Question 7: Which business demonstrate repeated non-compliance?

--SELECT
--    BusinessUniqueID,
--    MAX(BusinessName) AS BusinessName,
--    MAX(BusinessCategory) AS BusinessCategory,
--    COUNT(Charge_ID) AS TotalChargeRecords,
--    COUNT(DISTINCT ViolationDate) AS DistinctChargeDates,
--    MIN(ViolationDate) AS FirstRecordedChargeDate,
--    MAX(ViolationDate) AS LastRecordedChargeDate,
--    DATEDIFF(
--        DAY,
--        MIN(ViolationDate),
--        MAX(ViolationDate)
--    ) AS DaysBetweenFirstAndLastCharge
--FROM DCWP_Charges
--WHERE ViolationDate IS NOT NULL
--GROUP BY BusinessUniqueID
--HAVING COUNT(DISTINCT ViolationDate) >= 2
--ORDER BY
--    DistinctChargeDates DESC,
--    TotalChargeRecords DESC;

--Question 8: which charges are likely to be cured versus unresolved
--SELECT
--    Cured,
--    Outcome,
--    CureEligible,
--    COUNT(*) AS ChargeRecords
--FROM DCWP_Charges
--GROUP BY
--    Cured,
--    Outcome,
--    CureEligible
--ORDER BY ChargeRecords DESC;

--WITH ChargeOutcomeSummary AS (
--    SELECT
--        Charge,
--        COUNT(*) AS TotalChargeRecords,

--        SUM(CASE
--            WHEN CureEligible = 'Yes' THEN 1
--            ELSE 0
--        END) AS CureEligibleRecords,

--        SUM(CASE
--            WHEN CureEligible = 'Yes'
--             AND Cured = 'Yes' THEN 1
--            ELSE 0
--        END) AS CuredRecords,

--        SUM(CASE
--            WHEN CureEligible = 'Yes'
--             AND Cured = 'No' THEN 1
--            ELSE 0
--        END) AS NotCuredRecords,

--        SUM(CASE
--            WHEN CureEligible = 'Yes'
--             AND Cured = 'Pending Resolution' THEN 1
--            ELSE 0
--        END) AS PendingCureStatusRecords,

--        SUM(CASE
--            WHEN Outcome = 'Pending Resolution' THEN 1
--            ELSE 0
--        END) AS PendingOutcomeRecords

--    FROM DCWP_Charges
--    WHERE Charge IS NOT NULL
--    GROUP BY Charge
--),
--ChargeRates AS (
--    SELECT
--        *,
--        CuredRecords + NotCuredRecords
--            AS ResolvedEligibleRecords,

--        ROUND(
--            100.0 * CuredRecords
--            / NULLIF(CuredRecords + NotCuredRecords, 0),
--            2
--        ) AS CureRatePct,

--        ROUND(
--            100.0 * PendingOutcomeRecords
--            / NULLIF(TotalChargeRecords, 0),
--            2
--        ) AS PendingOutcomeRatePct

--    FROM ChargeOutcomeSummary
--)
--SELECT
--    Charge,
--    TotalChargeRecords,
--    CureEligibleRecords,
--    ResolvedEligibleRecords,
--    CuredRecords,
--    NotCuredRecords,
--    PendingCureStatusRecords,
--    PendingOutcomeRecords,
--    CureRatePct,
--    PendingOutcomeRatePct
--FROM ChargeRates
--WHERE TotalChargeRecords >= 100
--  AND ResolvedEligibleRecords >= 30
--ORDER BY
--    CureRatePct DESC,
--    TotalChargeRecords DESC;


---- PHASE 4: 
-- Question 1: Inspection to charge ratio

--WITH CategoryInspectionSummary AS (
--    SELECT
--        I.BusinessCategory,
--        COUNT(DISTINCT I.InspectionNumber) AS TotalInspections,
--        COUNT(DISTINCT C.InspectionNumber) AS InspectionsWithCharges,
--        COUNT(C.Charge_ID) AS TotalChargeRecords
--    FROM DCWP_Inspections AS I
--    LEFT JOIN DCWP_Charges AS C
--        ON I.InspectionNumber = C.InspectionNumber
--    GROUP BY
--        I.BusinessCategory
--)
--SELECT
--    BusinessCategory,
--    TotalInspections,
--    InspectionsWithCharges,
--    TotalChargeRecords,
--    ROUND(
--        100.0 * InspectionsWithCharges
--        / NULLIF(TotalInspections, 0),
--        2
--    ) AS PctInspectionsWithCharges,
--    ROUND(
--        1.0 * TotalChargeRecords
--        / NULLIF(TotalInspections, 0),
--        2
--    ) AS ChargeRecordsPerInspection
--FROM CategoryInspectionSummary
--WHERE TotalInspections >= 100
--ORDER BY
--    ChargeRecordsPerInspection DESC,
--    PctInspectionsWithCharges DESC;


--Question 2: How long after licence issuance does the first inspection typically occur?
--WITH FirstInspection AS (
--    SELECT
--        L.LicenseNumber,
--        L.BusinessUniqueID,
--        L.BusinessCategory,
--        L.InitialIssuanceDate,
--        MIN(I.DateofOccurrence) AS FirstInspectionDate
--    FROM Issued_Licenses AS L
--    INNER JOIN DCWP_Inspections AS I
--        ON L.LicenseNumber = I.DCWPLicenseNumber
--    WHERE
--        L.InitialIssuanceDate IS NOT NULL
--        AND I.DateofOccurrence IS NOT NULL
--        AND I.DateofOccurrence >= L.InitialIssuanceDate
--    GROUP BY
--        L.LicenseNumber,
--        L.BusinessUniqueID,
--        L.BusinessCategory,
--        L.InitialIssuanceDate
--),
--InspectionIntervals AS (
--    SELECT
--        LicenseNumber,
--        DATEDIFF(
--            DAY,
--            InitialIssuanceDate,
--            FirstInspectionDate
--        ) AS DaysToFirstInspection
--    FROM FirstInspection
--),
--BinnedIntervals AS (
--    SELECT
--        CASE
--            WHEN DaysToFirstInspection <= 30
--                THEN '030 days'
--            WHEN DaysToFirstInspection <= 90
--                THEN '3190 days'
--            WHEN DaysToFirstInspection <= 180
--                THEN '91180 days'
--            WHEN DaysToFirstInspection <= 365
--                THEN '181365 days'
--            WHEN DaysToFirstInspection <= 730
--                THEN '12 years'
--            WHEN DaysToFirstInspection <= 1095
--                THEN '23 years'
--            WHEN DaysToFirstInspection <= 1825
--                THEN '35 years'
--            WHEN DaysToFirstInspection <= 3650
--                THEN '510 years'
--            WHEN DaysToFirstInspection <= 7300
--                THEN '10-20 years'
--            ELSE '20+ years'
--        END AS InspectionInterval,
--        CASE
--            WHEN DaysToFirstInspection <= 30 THEN 1
--            WHEN DaysToFirstInspection <= 90 THEN 2
--            WHEN DaysToFirstInspection <= 180 THEN 3
--            WHEN DaysToFirstInspection <= 365 THEN 4
--            WHEN DaysToFirstInspection <= 730 THEN 5
--            WHEN DaysToFirstInspection <= 1095 THEN 6
--            WHEN DaysToFirstInspection <= 1825 THEN 7
--            WHEN DaysToFirstInspection <= 3650 THEN 8
--            WHEN DaysToFirstInspection <= 7300 THEN 9
--            ELSE 10
--        END AS BinOrder
--    FROM InspectionIntervals
--)
--SELECT
--    InspectionInterval,
--    COUNT(*) AS LicenseCount,
--    ROUND(
--        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
--        2
--    ) AS PercentageOfMatchedLicenses
--FROM BinnedIntervals
--GROUP BY
--    InspectionInterval,
--    BinOrder
--ORDER BY
--    BinOrder;


--Question 3: Repeated charge activity

--WITH BusinessChargeHistory AS (
--    SELECT
--        BusinessUniqueID,
--        BusinessCategory,
--        MAX(BusinessName) AS BusinessName,
--        COUNT(Charge_ID) AS TotalChargeRecords,
--        COUNT(DISTINCT ViolationDate) AS DistinctChargeDates,
--        MIN(ViolationDate) AS FirstRecordedChargeDate,
--        MAX(ViolationDate) AS LastRecordedChargeDate
--    FROM DCWP_Charges
--    WHERE ViolationDate IS NOT NULL
--    GROUP BY
--        BusinessUniqueID,
--        BusinessCategory
--),
--CategoryRepeatSummary AS (
--    SELECT
--        BusinessCategory,
--        COUNT(*) AS BusinessesWithCharges,
--        SUM(
--            CASE
--                WHEN DistinctChargeDates >= 2 THEN 1
--                ELSE 0
--            END
--        ) AS BusinessesWithChargesOnMultipleDates,
--        SUM(TotalChargeRecords) AS TotalChargeRecords
--    FROM BusinessChargeHistory
--    GROUP BY BusinessCategory
--    HAVING COUNT(*) >= 100
--),
--CategoryRepeatRates AS (
--    SELECT
--        BusinessCategory,
--        BusinessesWithCharges,
--        BusinessesWithChargesOnMultipleDates,
--        TotalChargeRecords,
--        ROUND(
--            100.0 * BusinessesWithChargesOnMultipleDates
--            / NULLIF(BusinessesWithCharges, 0),
--            2
--        ) AS RepeatChargeRatePct
--    FROM CategoryRepeatSummary
--)
--SELECT
--    BusinessCategory,
--    BusinessesWithCharges,
--    BusinessesWithChargesOnMultipleDates,
--    TotalChargeRecords,
--    RepeatChargeRatePct
--FROM CategoryRepeatRates
--ORDER BY
--    RepeatChargeRatePct DESC,
--    BusinessesWithCharges DESC;
