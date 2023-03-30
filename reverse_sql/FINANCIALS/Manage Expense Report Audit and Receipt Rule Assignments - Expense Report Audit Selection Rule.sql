/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-24 $:
 * $HeadURL: $:
 * $Id: Manage Expense Report Audit and Receipt Rule Assignments - Audit List Rule.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--NOZERODATEFORMAT_FIELDS = RES_EFFECTIVE_START_DATE,RES_EFFECTIVE_END_DATE

select 
BusinessUnitPEO.BU_NAME                                                            			RES_BUSINESS_UNIT
,RcptNotifRuleSetEO.name                                                                    RES_NAME
,to_char(AuditRuleAssignmentEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY')                         	RES_EFFECTIVE_START_DATE
,to_char(AuditRuleAssignmentEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY')                           	RES_EFFECTIVE_END_DATE
,AuditRuleAssignmentEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AuditRuleAssignmentEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AuditRuleAssignmentEO.CREATED_BY RSC_CREATED_BY
,AuditRuleAssignmentEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,BusinessUnitPEO.bu_id RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from exm_aud_rule_sets RcptNotifRuleSetEO
    ,exm_aud_rule_assignments AuditRuleAssignmentEO 
    ,fun_all_business_units_v   BusinessUnitPEO
where RcptNotifRuleSetEO.aud_rule_set_id = AuditRuleAssignmentEO.rule_set_id 
and rule_set_type='AUDIT_RULE' 
and AuditRuleAssignmentEO.org_id= BusinessUnitPEO.bu_id
ORDER BY BusinessUnitPEO.BU_NAME 
,AuditRuleAssignmentEO.EFFECTIVE_START_DATE 