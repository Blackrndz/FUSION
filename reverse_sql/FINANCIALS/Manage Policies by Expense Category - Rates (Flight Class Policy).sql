/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_ACCOM_POLICIES

SELECT 'Airfare' RES_EXPENSE_CATEGORY
,ExmAirfarePolicies.POLICY_NAME RES_POLICY_NAME
,NVL((SELECT NAME
	FROM PER_GRADES_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND GRADE_ID = ExmAirfarePolicyLines.ROLE_ID
	),'All Others') RES_ROLE
,ExmAirfarePolicyLines.FLIGHT_DURATION_THRESHOLD RES_FLIGHT_DURATIONS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_TICKET_CLASS'
	AND LOOKUP_CODE = ExmAirfarePolicyLines.FLIGHT_CLASS_CODE
	) RES_FLIGHT_CLASS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_TICKET_CLASS'
	AND LOOKUP_CODE = ExmAirfarePolicyLines.FLIGHT_CLASS_CODE_DOMESTIC
	) RES_FLIGHT_CLASS_DOMESTIC
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_TICKET_CLASS'
	AND LOOKUP_CODE = ExmAirfarePolicyLines.FLIGHT_CLASS_CODE_INTERNAT
	) RES_FLIGHT_CLASS_INTERNATIONAL
,TO_CHAR(ExmAirfarePolicyLines.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExmAirfarePolicyLines.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ExmAirfarePolicyLines.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmAirfarePolicyLines.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmAirfarePolicyLines.CREATED_BY RSC_CREATED_BY
,ExmAirfarePolicyLines.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_AIRFARE_POLICIES ExmAirfarePolicies
,EXM_AIRFARE_POL_LINES ExmAirfarePolicyLines
WHERE ExmAirfarePolicies.AIRFARE_POLICY_ID = ExmAirfarePolicyLines.AIRFARE_POLICY_ID
ORDER BY ExmAirfarePolicies.POLICY_NAME