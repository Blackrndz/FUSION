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

SELECT 'Accommodations' RES_EXPENSE_CATEGORY
,ExmAccomPolicies.POLICY_NAME RES_POLICY_NAME
,ExmAccomPolicyLines.DAILY_LIMIT RES_DAILY_LIMIT
,TO_CHAR(ExmAccomPolicyLines.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExmAccomPolicyLines.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ExmAccomPolicyLines.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmAccomPolicyLines.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmAccomPolicyLines.CREATED_BY RSC_CREATED_BY
,ExmAccomPolicyLines.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_ACCOM_POLICIES ExmAccomPolicies
,EXM_ACCOM_POL_LINES ExmAccomPolicyLines
WHERE ExmAccomPolicies.ACCOM_POLICY_ID = ExmAccomPolicyLines.ACCOM_POLICY_ID
ORDER BY ExmAccomPolicies.POLICY_NAME