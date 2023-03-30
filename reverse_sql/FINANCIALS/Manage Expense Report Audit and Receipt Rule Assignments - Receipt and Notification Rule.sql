/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-24 $:
 * $HeadURL: $:
 * $Id: Manage Expense Report Audit and Receipt Rule Assignments - Receipt and Notification Rule.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--NOZERODATEFORMAT_FIELDS = RES_EFFECTIVE_START_DATE,RES_EFFECTIVE_END_DATE

SELECT BusinessUnitPEO.BU_NAME RES_BUSINESS_UNIT
,rs.name RES_NAME
,TO_CHAR(AuditRuleAssignmentEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(AuditRuleAssignmentEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,rs.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rs.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rs.CREATED_BY RSC_CREATED_BY
,rs.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,BusinessUnitPEO.bu_id RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM exm_rcpt_notif_rule_sets rs
,exm_aud_rule_assignments AuditRuleAssignmentEO
,fun_all_business_units_v BusinessUnitPEO
WHERE rs.rcpt_notif_rule_set_id  = AuditRuleAssignmentEO.rule_set_id
AND rule_set_type                = 'RECEIPT'
AND AuditRuleAssignmentEO.org_id = BusinessUnitPEO.bu_id
ORDER BY BusinessUnitPEO.BU_NAME
,AuditRuleAssignmentEO.EFFECTIVE_START_DATE