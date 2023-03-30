/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-19 $:
 * $HeadURL: Manage Purchasing Profile Options - Profile Options $:
 * $Id: Manage Purchasing Profile Options - Profile Options.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PROFILEOPTIONEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
,ProfileOptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionEO.last_update_date RSC_LAST_UPDATE_DATE
,ProfileOptionEO.CREATED_BY RSC_CREATED_BY
,ProfileOptionEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
    
FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
WHERE ProfileOptionEO.MODULE_ID IN (SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,FND_APPL_TAXONOMY AT
	WHERE AT.MODULE_TYPE = 'LBA'
	AND at.module_key    = 'PrcPoCommonPo'
	AND at.module_id     = rf.ancestor_module_id)
ORDER BY PROFILEOPTIONEO.PROFILE_OPTION_NAME
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME