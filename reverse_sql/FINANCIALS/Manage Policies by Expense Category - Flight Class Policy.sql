/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_AIRFARE_POLICIES

SELECT 'Airfare' RES_EXPENSE_CATEGORY
,ExmAirfarePolicies.POLICY_NAME RES_POLICY_NAME
,ExmAirfarePolicies.DESCRIPTION RES_DESCRIPTION
,DECODE(ExmAirfarePolicies.ENABLED_FLIGHT_TYPE_FLAG,'Y','Yes','No') RES_FLIGHT_TYPE
,DECODE(ExmAirfarePolicies.ENABLED_FLIGHT_DURATION_FLAG,'Y','Yes','No') RES_FLIGHT_DURATIONS
,DECODE(ExmAirfarePolicies.ENABLED_ROLE_FLAG,'Y','Yes','No') RES_ROLE
,(CASE
	WHEN ExmAirfarePolicies.ENABLED_ROLE_FLAG = 'Y' THEN
		(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'EXM_POLICY_ROLE'
		AND LOOKUP_CODE = ExmAirfarePolicies.POLICY_ROLE_CODE)
	END) RES_ROLE_TYPE
,(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'EXM_PREFERRED_ENFORCEMENT'
		AND LOOKUP_CODE = ExmAirfarePolicies.POLICY_ENFORCEMENT_CODE
		) RES_POLICY_ENFORCEMENT
,(CASE
	WHEN ExmAirfarePolicies.POLICY_ENFORCEMENT_CODE = 'VIOLATION' THEN
		DECODE(ExmAirfarePolicies.DISP_WARNING_TO_USER_FLAG,'Y','Yes','No')
	END) RES_DISPLAY_WARNING_TO_USER
,ExmAirfarePolicies.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmAirfarePolicies.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmAirfarePolicies.CREATED_BY RSC_CREATED_BY
,ExmAirfarePolicies.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_AIRFARE_POLICIES ExmAirfarePolicies
ORDER BY ExmAirfarePolicies.POLICY_NAME