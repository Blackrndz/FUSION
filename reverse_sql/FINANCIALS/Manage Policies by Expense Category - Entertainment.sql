/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_ENTERTAINMENT_POLICIES

SELECT 'Entertainment' RES_EXPENSE_CATEGORY
,ExmEntertainmentPolicies.POLICY_NAME RES_POLICY_NAME
,ExmEntertainmentPolicies.DESCRIPTION RES_DESCRIPTION
,DECODE(ExmEntertainmentPolicies.EMPLOYEE_ATTENDEE_INFO_FLAG,'Y','Yes','No') RES_DISPLAY_EMPLOYEE_ATTENDEE_
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_FIELD_BEHAVIOUR'
	AND LOOKUP_CODE = ExmEntertainmentPolicies.EMP_ATTENDEE_AMT_CODE
	) RES_DISPLAY_EMPLOYEE_ATTENDE_0
,DECODE(ExmEntertainmentPolicies.EMPL_REQ_AS_ATTENDEE_FLAG,'Y','Yes','No') RES_REQUIRE_AT_LEAST_ONE_EMPLO
,DECODE(ExmEntertainmentPolicies.NON_EMPL_ATTENDEE_INFO_FLAG,'Y','Yes','No') RES_DISPLAY_NONEMPLOYEE_ATTEND
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_FIELD_BEHAVIOUR'
	AND LOOKUP_CODE = ExmEntertainmentPolicies.NONEMP_ATTENDEE_TYPE_CODE
	) RES_ATTENDEE_TYPE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_FIELD_BEHAVIOUR'
	AND LOOKUP_CODE = ExmEntertainmentPolicies.NONEMP_ATTENDEE_AMT_CODE
	) RES_DISPLAY_NONEMPLOYEE_ATTE_1
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_FIELD_BEHAVIOUR'
	AND LOOKUP_CODE = ExmEntertainmentPolicies.NONEMP_JOB_TITLE_CODE
	) RES_JOB_TITLE
,DECODE(ExmEntertainmentPolicies.NONEMP_CREATION_FLAG,'Y','Yes','No') RES_ENABLE_NONEMPLOYEE_CREATIO
,DECODE(ExmEntertainmentPolicies.NONEMP_REQUIRED_ATTENDEE_FLAG,'Y','Yes','No') RES_REQUIRE_AT_LEAST_ONE_NONEM
,DECODE(ExmEntertainmentPolicies.ENABLED_RATE_LIMIT_FLAG,'Y','Yes','No') RES_ENABLE_RATE_LIMIT
,DECODE(ExmEntertainmentPolicies.SINGLE_INSTANCE_LIMIT_FLAG,'Y','Yes','No') RES_SINGLE_INSTANCE_LIMIT
,DECODE(ExmEntertainmentPolicies.YEARLY_LIMIT_FLAG,'Y','Yes','No') RES_YEARLY_LIMIT
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'MONTH'
	AND LOOKUP_CODE = ExmEntertainmentPolicies.PERIOD_MONTH
	) RES_PERIOD_START_MONTH
,ExmEntertainmentPolicies.PERIOD_DAY RES_PERIOD_START_DAY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_CURRENCY_OPTION'
	AND LOOKUP_CODE = ExmEntertainmentPolicies.CURRENCY_OPTION_CODE
	) RES_RATE_CURRENCY
,(CASE
	WHEN ExmEntertainmentPolicies.CURRENCY_OPTION_CODE = 'MULTIPLE' THEN
		NULL
	ELSE
		ExmEntertainmentPolicies.CURRENCY_CODE||' - '||
		(SELECT NAME 
			FROM FND_CURRENCIES_TL
			WHERE CURRENCY_CODE = ExmEntertainmentPolicies.CURRENCY_CODE
			AND LANGUAGE = USERENV('LANG'))
	END) RES_CURRENCY
,DECODE(ExmEntertainmentPolicies.EMP_RATE_DETERMINANT_FLAG,'Y','Yes','No') RES_EMPLOYEE
,DECODE(ExmEntertainmentPolicies.NONEMP_RATE_DETERMINANT_FLAG,'Y','Yes','No') RES_NONEMPLOYEE_ATTENDEE_TYPES
,(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE LOOKUP_TYPE = 'EXM_POLICY_ENFORCEMENT'
		AND LOOKUP_CODE = ExmEntertainmentPolicies.POLICY_ENFORCEMENT_CODE
		) RES_POLICY_ENFORCEMENT
,(CASE
	WHEN ExmEntertainmentPolicies.POLICY_ENFORCEMENT_CODE = 'VIOLATION' THEN
		DECODE(ExmEntertainmentPolicies.POLICY_VIOLATION_FLAG,'Y','Yes','No')
	END) RES_POLICY_VIOLATION_WARNING
,ExmEntertainmentPolicies.WARNING_TOLERANCE RES_WARNING_TOLERANCE_PERCENTA
,(CASE
	WHEN ExmEntertainmentPolicies.POLICY_ENFORCEMENT_CODE = 'VIOLATION' AND ExmEntertainmentPolicies.POLICY_VIOLATION_FLAG = 'Y' THEN
		DECODE(ExmEntertainmentPolicies.DISP_WARNING_TO_USER_FLAG,'Y','Yes','No')
	END) RES_DISPLAY_WARNING_TO_USER
,(CASE
	WHEN ExmEntertainmentPolicies.POLICY_ENFORCEMENT_CODE = 'VIOLATION' THEN
		DECODE(ExmEntertainmentPolicies.PREVENT_SUBMISSION_FLAG,'Y','Yes','No')
	END) RES_PREVENT_REPORT_SUBMISSION
,ExmEntertainmentPolicies.ERROR_TOLERANCE RES_ERROR_TOLERANCE_PERCENTAGE
,ExmEntertainmentPolicies.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmEntertainmentPolicies.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmEntertainmentPolicies.CREATED_BY RSC_CREATED_BY
,ExmEntertainmentPolicies.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_ENTERTAINMENT_POLICIES ExmEntertainmentPolicies
ORDER BY ExmEntertainmentPolicies.POLICY_NAME