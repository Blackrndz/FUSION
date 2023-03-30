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

SELECT 'Entertainment' RES_EXPENSE_CATEGORY
,ExmEntPolicies.POLICY_NAME RES_POLICY_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EXM_ATTENDEE_TYPES'
	AND LOOKUP_CODE = ExmEntPolicyLines.TYPE_OF_ATTENDE_CODE
	) RES_NONEMPLOYEE_ATTENDEE_TYPES
,ExmEntPolicyLines.SINGLE_INSTANCE_LIMIT RES_SINGLE_INSTANCE_LIMIT
,ExmEntPolicyLines.YEARLY_LIMIT RES_YEARLY_LIMIT
,ExmEntPolicyLines.CURRENCY_CODE RES_CURRENCY
,TO_CHAR(ExmEntPolicyLines.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExmEntPolicyLines.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ExmEntPolicyLines.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmEntPolicyLines.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmEntPolicyLines.CREATED_BY RSC_CREATED_BY
,ExmEntPolicyLines.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_ENTERTAINMENT_POLICIES ExmEntPolicies
,EXM_ENTERTAINMENT_POL_LINES ExmEntPolicyLines
WHERE ExmEntPolicies.ENTERTAINMENT_POLICY_ID = ExmEntPolicyLines.ENTERTAINMENT_POLICY_ID
AND NVL(ExmEntPolicyLines.TYPE_OF_ATTENDE_CODE,'EMPLOYEE') != 'EMPLOYEE'
ORDER BY ExmEntPolicies.POLICY_NAME