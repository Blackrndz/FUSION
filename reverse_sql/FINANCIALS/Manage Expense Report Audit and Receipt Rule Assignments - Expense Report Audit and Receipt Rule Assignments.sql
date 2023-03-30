/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Expense Report Audit and Receipt Rule Assignments - Expense Report Audit and Receipt Rule Assignments.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select name							RES_BUSINESS_UNIT 
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,bu_id RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (
   select bu_id , bu_name name,
  (select name from exm_aud_rule_sets rs, exm_aud_rule_assignments a1 where rs.aud_rule_set_id = a1.rule_set_id and rule_set_type='AUDIT_RULE' and a1.org_id=bu_id
   and (trunc(sysdate) between effective_start_date and nvl(effective_end_date, sysdate))) as audit_selection_rule,
  (select name from exm_exp_type_rule_sets rs, exm_aud_rule_assignments a1 where rs.exp_type_rule_set_id = a1.rule_set_id and rule_set_type='EXPENSE_TYPE' and a1.org_id=bu_id
   and (trunc(sysdate) between effective_start_date and nvl(effective_end_date, sysdate))) as exp_type_rule,
  (select name from exm_aud_list_rule_sets rs, exm_aud_rule_assignments a1 where rs.aud_list_rule_set_id = a1.rule_set_id and rule_set_type='AUDIT_LIST' and a1.org_id=bu_id
   and (trunc(sysdate) between effective_start_date and nvl(effective_end_date, sysdate))) as audit_list_rule,
  (select name from exm_rcpt_notif_rule_sets rs, exm_aud_rule_assignments a1 where rs.rcpt_notif_rule_set_id = a1.rule_set_id and rule_set_type='RECEIPT' and a1.org_id=bu_id
   and (trunc(sysdate) between effective_start_date and nvl(effective_end_date, sysdate))) as receipt_rule
,LAST_UPDATED_BY 
,LAST_UPDATE_DATE 
,CREATED_BY 
,CREATION_DATE 
from fun_all_business_units_v

)
where (audit_selection_rule is not null 
      OR exp_type_rule is not null  
      OR audit_list_rule is not null  
      OR receipt_rule is not null)
ORDER BY NAME