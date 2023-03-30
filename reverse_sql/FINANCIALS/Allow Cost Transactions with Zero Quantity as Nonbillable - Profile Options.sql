/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Allow%20Cost%20Transactions%20with%20Zero%20Quantity%20as%20Nonbillable%20-%20Profile%20Options.sql $:
 * $Id: Allow Cost Transactions with Zero Quantity as Nonbillable - Profile Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select  PROFILEOPTIONEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
  ,PROFILEOPTIONEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,PROFILEOPTIONEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,PROFILEOPTIONEO.CREATED_BY  RSC_CREATED_BY
  ,PROFILEOPTIONEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_PROFILE_HIERARCHIES PROFILEHIERARCHYEO
where PROFILEOPTIONEO.HIERARCHY_NAME      = PROFILEHIERARCHYEO.HIERARCHY_NAME
and PROFILEOPTIONEO.PROFILE_OPTION_NAME in (select BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_VALUE
														from ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
														WHERE BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'profileOptionName'
														AND BoAttributeValuesEO.TASK_ID  IN
															(SELECT task_id
															FROM ASK_TASKS_VL
															where TASK_SHORT_NAME = 'ORA_PJC_ZERO_QTY_NONBILL_SETUP_TASK'
															))
order by PROFILEOPTIONEO.PROFILE_OPTION_NAME,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME