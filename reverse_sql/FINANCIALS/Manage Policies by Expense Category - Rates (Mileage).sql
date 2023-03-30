/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_MILEAGE_POLICIES

SELECT 'Mileage' RES_EXPENSE_CATEGORY
,ExmMileagePolicies.POLICY_NAME RES_NAME
,ExmMileagePolicyLines.RATE RES_MILEAGE_RATE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_CALCULATION_METHOD'
	AND LOOKUP_CODE = ExmMileagePolicyLinesE1.CALCULATION_METHOD_CODE
	) RES_PASSENGER_RATE_CALCULATION
,ExmMileagePolicyLinesE1.RATE RES_PASSENGER_RATE
,TO_CHAR(ExmMileagePolicyLines.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExmMileagePolicyLines.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ExmMileagePolicyLines.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmMileagePolicyLines.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmMileagePolicyLines.CREATED_BY RSC_CREATED_BY
,ExmMileagePolicyLines.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_MILEAGE_POLICIES ExmMileagePolicies
,EXM_MILEAGE_POL_LINES ExmMileagePolicyLines
,(SELECT * FROM EXM_MILEAGE_POL_LINES WHERE TYPE_OF_RATE_CODE = 'PASSENGER') ExmMileagePolicyLinesE1
WHERE ExmMileagePolicies.MILEAGE_POLICY_ID = ExmMileagePolicyLines.MILEAGE_POLICY_ID
AND ExmMileagePolicyLines.TYPE_OF_RATE_CODE = 'MILEAGE'
AND ExmMileagePolicyLines.MILEAGE_POLICY_ID = ExmMileagePolicyLinesE1.MILEAGE_POLICY_ID(+)
AND ExmMileagePolicyLines.START_DATE = ExmMileagePolicyLinesE1.START_DATE(+)
AND ExmMileagePolicyLines.END_DATE = ExmMileagePolicyLinesE1.END_DATE(+)
ORDER BY ExmMileagePolicies.POLICY_NAME