/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Enterprise HCM Information - Attachments.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_MISC_POLICIES

SELECT 'Miscellaneous' RES_EXPENSE_CATEGORY
,ExmMiscPolicies.POLICY_NAME RES_POLICY_NAME
,ExmMiscPolicyLines.REIMBURSEMENT_PERCENTAGE RES_PERCENTAGE_REIMBURSEMENT
,ExmMiscPolicyLines.SINGLE_INSTANCE_LIMIT RES_SINGLE_INSTANCE_LIMIT
,ExmMiscPolicyLines.DAILY_LIMIT RES_DAILY_SUM_LIMIT
,ExmMiscPolicyLines.YEARLY_LIMIT RES_YEARLY_LIMIT
,TO_CHAR(ExmMiscPolicyLines.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExmMiscPolicyLines.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ExmMiscPolicyLines.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmMiscPolicyLines.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmMiscPolicyLines.CREATED_BY RSC_CREATED_BY
,ExmMiscPolicyLines.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_MISC_POLICIES ExmMiscPolicies
,EXM_MISC_POL_LINES ExmMiscPolicyLines
WHERE ExmMiscPolicies.MISC_POLICY_ID = ExmMiscPolicyLines.MISC_POLICY_ID
ORDER BY ExmMiscPolicies.POLICY_NAME