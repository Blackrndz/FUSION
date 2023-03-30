/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_MEALS_POLICIES

SELECT 'Meals' RES_EXPENSE_CATEGORY
,ExmMealPolicies.POLICY_NAME RES_POLICY_NAME
,ExmMealPolicyLines.SINGLE_INSTANCE_LIMIT RES_SINGLE_INSTANCE_LIMIT
,ExmMealPolicyLines.DAILY_LIMIT RES_DAILY_SUM_LIMIT
,TO_CHAR(ExmMealPolicyLines.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExmMealPolicyLines.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ExmMealPolicyLines.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmMealPolicyLines.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmMealPolicyLines.CREATED_BY RSC_CREATED_BY
,ExmMealPolicyLines.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_MEALS_POLICIES ExmMealPolicies
,EXM_MEALS_POL_LINES ExmMealPolicyLines
WHERE ExmMealPolicies.MEALS_POLICY_ID = ExmMealPolicyLines.MEALS_POLICY_ID
ORDER BY ExmMealPolicies.POLICY_NAME