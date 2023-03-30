/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2018-04-03 $:
 * $HeadURL:  $:
 * $Id: Manage Self Service Procurement Profile Options - Profile Options.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select distinct PROFILEOPTIONEO.PROFILE_OPTION_NAME	RES_PROFILE_OPTION_CODE
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME	RES_PROFILE_DISPLAY_NAME
,ProfileOptionEO.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,ProfileOptionEO.last_update_date  as RSC_LAST_UPDATE_DATE
,ProfileOptionEO.CREATED_BY  RSC_CREATED_BY
,ProfileOptionEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_PROFILE_OPTION_VALUES ProfileOptionValueEO
,FND_PROFILE_HIERARCHIES PROFILEHIERARCHYEO
where PROFILEOPTIONEO.HIERARCHY_NAME      = PROFILEHIERARCHYEO.HIERARCHY_NAME
and PROFILEOPTIONEO.APPLICATION_ID = 10071
and PROFILEOPTIONEO.PROFILE_OPTION_NAME in (select BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_VALUE
														from ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
														WHERE BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'profileOptionName'
														AND BoAttributeValuesEO.TASK_ID  IN
															(SELECT task_id
															FROM ASK_TASKS_VL
															where TASK_SHORT_NAME = 'POR_MANAGE_SELF_SERVICE_PROCUREMENT_PROFILE_OPTIONS'
															))
and ProfileOptionEO.APPLICATION_ID  = ProfileOptionValueEO.APPLICATION_ID(+)
AND ProfileOptionEO.PROFILE_OPTION_ID = ProfileOptionValueEO.PROFILE_OPTION_ID(+)

order by PROFILEOPTIONEO.PROFILE_OPTION_NAME,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME