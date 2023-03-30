/* ****************************************************************************
* $Revision: 78730 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-13 12:40:55 +0700 (Mon, 13 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Year%20Periods%20and%20Billing%20Calendars%20-%20Billing%20Calendar%20Period.sql $:
* $Id: Manage Year Periods and Billing Calendars - Billing Calendar Period.sql 78730 2022-06-13 05:40:55Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=BEN_BILL_CYCLE
-- RSC_PREREQUISITE_OBJECTS=BEN_BILL_CALENDAR

/*<RSC_PRE_STEPS_LARGE_COLUMN_POSITION>8</RSC_PRE_STEPS_LARGE_COLUMN_POSITION>
	
-- The column position that using special data type.
 <RSC_PRE_STEPS_LARGE_COLUMN_TYPE>LONG</RSC_PRE_STEPS_LARGE_COLUMN_TYPE>

-- Specify what type of the data.
*/

WITH tmpEO AS (SELECT BEN_BILL_CALENDAR.* ,ROW_NUMBER() OVER (PARTITION BY BILL_CYCLE_ID ORDER BY BILL_YEAR) AS ROW_NUMBER
	FROM BEN_BILL_CALENDAR ORDER BY BILL_CYCLE_ID)
,maxE0 AS (SELECT BILL_CYCLE_ID,COUNT(BILL_YEAR) AS maxyear FROM BEN_BILL_CALENDAR GROUP BY BILL_CYCLE_ID)

SELECT benBILLCYCLEO.NAME RES_CALENDAR_NAME
,(SELECT BILL_YEAR FROM tmpEO WHERE ROW_NUMBER = 1 AND BILL_CYCLE_ID = benBILLCYCLEO.BILL_CYCLE_ID) RES_START_YEAR
,(SELECT BILL_YEAR FROM tmpEO WHERE ROW_NUMBER = (SELECT maxyear FROM maxE0 WHERE BILL_CYCLE_ID = benBILLCYCLEO.BILL_CYCLE_ID)
	AND BILL_CYCLE_ID = benBILLCYCLEO.BILL_CYCLE_ID) RES_END_YEAR
,benBILLCALENDAREO.PERIOD_NAME RES_BILLING_PERIOD
,benBILLCALENDAREO.BILL_YEAR RES_YEAR
,TO_CHAR(benBILLCALENDAREO.START_DATE,'DD-Mon-YYYY') RES_PERIOD_START_DATE
,TO_CHAR(benBILLCALENDAREO.END_DATE,'DD-Mon-YYYY') RES_PERIOD_END_DATE
,TO_CHAR(benBILLCALENDAREO.PYMNT_DUE_DT,'DD-Mon-YYYY') RES_PAYMENT_DUE_DATE
,TO_CHAR(benBILLCALENDAREO.PYMNT_OVERDUE_DT,'DD-Mon-YYYY') RES_PAYMENT_OVERDUE_DATE
,benBILLCALENDAREO.COMMENTS RES_COMMENTS


, benBILLCALENDAREO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
, benBILLCALENDAREO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
, benBILLCALENDAREO.CREATED_BY RSC_CREATED_BY
, benBILLCALENDAREO.CREATION_DATE RSC_CREATION_DATE
, NULL RSC_LEDGER_ID
, NULL RSC_CHART_OF_ACCOUNTS_ID
, NULL RSC_BUSINESS_UNIT_ID
, NULL RSC_LEGAL_ENTITY_ID
, NULL RSC_ORGANIZATION_ID
, NULL RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM BEN_BILL_CYCLE benBILLCYCLEO
,BEN_BILL_CALENDAR benBILLCALENDAREO
WHERE benBILLCYCLEO.BILL_CYCLE_ID = benBILLCALENDAREO.BILL_CYCLE_ID
ORDER BY RES_BILLING_PERIOD