/* ****************************************************************************
 * $Revision: 53810 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-23 11:43:41 +0700 (Wed, 23 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Item%20Profile%20Options%20-%20Profile%20Options.sql $:
 * $Id: Manage Item Profile Options - Profile Options.sql 53810 2016-03-23 04:43:41Z pisan.jariyasettachok $:
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
															where TASK_SHORT_NAME = 'ORA_ZCA_MANAGE_COMMON_CRM_BUSINESS_UNIT_PROFILE_OPTIONS'
															))
order by PROFILEOPTIONEO.PROFILE_OPTION_NAME,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME