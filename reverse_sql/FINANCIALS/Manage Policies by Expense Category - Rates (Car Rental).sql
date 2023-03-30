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
,ExmCarPolicyLines.DAILY_LIMIT RES_DAILY_LIMIT
,TO_CHAR(ExmCarPolicyLines.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ExmCarPolicyLines.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,ExmCarPolicyLines.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExmCarPolicyLines.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExmCarPolicyLines.CREATED_BY RSC_CREATED_BY
,ExmCarPolicyLines.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_CARRENTAL_POLICIES ExmCarPolicies
,EXM_CARRENTAL_POL_LINES ExmCarPolicyLines
WHERE ExmCarPolicies.CARRENTAL_POLICY_ID = ExmCarPolicyLines.CARRENTAL_POLICY_ID
ORDER BY ExmCarPolicies.POLICY_NAME