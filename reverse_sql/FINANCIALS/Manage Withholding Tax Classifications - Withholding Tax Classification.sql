/* ****************************************************************************
 * $Revision: 55079 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-05-10 11:46:06 +0700 (Tue, 10 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Public%20Unique%20Identifier%20Profile%20Options%20-%20Profile%20Options.sql $:
 * $Id: Manage Public Unique Identifier Profile Options - Profile Options.sql 55079 2016-05-10 04:46:06Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

Select DISTINCT Conditiongroup.Condition_Group_Code RES_TAX_CLASSIFICATION_CODE
,Conditiongroup.Condition_Group_Desc RES_DESCRIPTION
,To_Char(Rules.Effective_From,'DD-Mon-YYYY') RES_START_DATE
,To_Char(Rules.Effective_To,'DD-Mon-YYYY') RES_END_DATE
,Conditiongroup.LAST_UPDATED_BY RSC_LAST_UPDATED_BY 
,Conditiongroup.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Conditiongroup.CREATED_BY RSC_CREATED_BY
,Conditiongroup.CREATION_DATE RSC_CREATION_DATE
,Conditiongroup.Ledger_Id RSC_LEDGER_ID
,ConditionGroup.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_CONDITION_GROUPS_VL ConditionGroup
,ZX_RULES_B Rules
WHERE ConditionGroup.CONDITION_GROUP_CODE = Rules.TAX_RULE_CODE
AND Rules.SERVICE_TYPE_CODE               = 'DET_DIRECT_RATE_STCC'
ORDER BY ConditionGroup.CONDITION_GROUP_CODE