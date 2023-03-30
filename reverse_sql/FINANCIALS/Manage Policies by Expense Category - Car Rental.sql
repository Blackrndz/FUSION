/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_CARRENTAL_POLICIES

SELECT 'Car Rental' RES_EXPENSE_CATEGORY
,ExmCarPolicies.POLICY_NAME RES_POLICY_NAME
,ExmCarPolicies.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_CURRENCY_OPTION'
	AND LOOKUP_CODE = ExmCarPolicies.CURRENCY_OPTION_CODE
	) RES_RATE_CURRENCY
,(CASE
	WHEN ExmCarPolicies.CURRENCY_OPTION_CODE = 'MULTIPLE' THEN
		NULL
	ELSE
		ExmCarPolicies.CURRENCY_CODE||' - '||
		(SELECT NAME 
			FROM FND_CURRENCIES_TL
			WHERE CURRENCY_CODE = ExmCarPolicies.CURRENCY_CODE
			AND LANGUAGE = USERENV('LANG'))
	END) RES_CURRENCY
,DECODE(ExmCarPolicies.ENABLED_ROLE_FLAG,'Y','Yes','No') RES_ROLE
,(CASE
	WHEN ExmCarPolicies.ENABLED_ROLE_FLAG = 'Y' THEN
		(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'EXM_POLICY_ROLE'
		AND LOOKUP_CODE = ExmCarPolicies.POLICY_ROLE_CODE)
	END) RES_ROLE_TYPE
,DECODE(ExmCarPolicies.ENABLED_LOCATION_FLAG,'Y','Yes','No') RES_LOCATION
,(CASE
	WHEN ExmCarPolicies.ENABLED_LOCATION_FLAG = 'Y' THEN
		(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'EXM_LOCATION_TYPE'
		AND LOOKUP_CODE = ExmCarPolicies.LOCATION_TYPE_CODE)
	END) RES_LOCATION_TYPE
,(CASE
	WHEN ExmCarPolicies.ENABLED_LOCATION_FLAG = 'Y' AND ExmCarPolicies.LOCATION_TYPE_CODE = 'ZONE' THEN
		(SELECT MEANING 
			FROM FND_LOOKUP_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = ExmCarPolicies.ZONE_TYPE_CODE)
	END) RES_ZONE_TYPE
,(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'EXM_POLICY_ENFORCEMENT'
		AND LOOKUP_CODE = ExmCarPolicies.POLICY_ENFORCEMENT_CODE
		) RES_POLICY_ENFORCEMENT
,(CASE
	WHEN ExmCarPolicies.POLICY_ENFORCEMENT_CODE = 'VIOLATION' THEN
		DECODE(ExmCarPolicies.POLICY_VIOLATION_FLAG,'Y','Yes','No')
	END) RES_POLICY_VIOLATION_WARNING
,ExmCarPolicies.WARNING_TOLERANCE RES_WARNING_TOLERANCE_PERCENTA
,(CASE
	WHEN ExmCarPolicies.POLICY_ENFORCEMENT_CODE = 'VIOLATION' AND ExmCarPolicies.POLICY_VIOLATION_FLAG = 'Y' THEN
		DECODE(ExmCarPolicies.DISP_WARNING_TO_USER_FLAG,'Y','Yes','No')
	END) RES_DISPLAY_WARNING_TO_USER
,(CASE
	WHEN ExmCarPolicies.POLICY_ENFORCEMENT_CODE = 'VIOLATION' THEN
		DECODE(ExmCarPolicies.PREVENT_SUBMISSION_FLAG,'Y','Yes','No')
	END) RES_PREVENT_REPORT_SUBMISSION
,ExmCarPolicies.ERROR_TOLERANCE RES_ERROR_TOLERANCE_PERCENTAGE
,ExmCarPolicies.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmCarPolicies.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmCarPolicies.CREATED_BY RSC_CREATED_BY
,ExmCarPolicies.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_CARRENTAL_POLICIES ExmCarPolicies
ORDER BY ExmCarPolicies.POLICY_NAME