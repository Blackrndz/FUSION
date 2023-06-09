/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-04-19 $:
 * $HeadURL:  $:
 * $Id: Manage Receiving Profile Options - Profile Values.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_PRODUCT_NAME/GET_SYSTEM_PROFILE_VALUE
-- FIELD_TO_APPLY_FUNCTION=RES_USER_NAME/GET_SYSTEM_PROFILE_VALUE
-- FIELD_TO_APPLY_FUNCTION=RES_PROFILE_VALUE/GET_SYSTEM_PROFILE_VALUE

SELECT ProfileOptionEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,ProfileOptionEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
,PROFILELEVELEO.DESCRIPTION RES_PROFILE_LEVEL
,(
	CASE
		WHEN PROFILEOPTIONVALUEEO.LEVEL_NAME = 'PRODUCT'
		THEN PROFILEOPTIONVALUEEO.LEVEL_VALUE||'##RES##LEVEL:'||PROFILELEVELEO.LEVEL_NAME
		ELSE NULL
	END) RES_PRODUCT_NAME
,(
	CASE
		WHEN PROFILEOPTIONVALUEEO.LEVEL_NAME = 'USER'
		THEN PROFILEOPTIONVALUEEO.LEVEL_VALUE||'##RES##LEVEL:'||PROFILELEVELEO.LEVEL_NAME
		ELSE NULL
	END) RES_USER_NAME
,PROFILEOPTIONVALUEEO.profile_option_value||'##RES##'||DECODE(PROFILEOPTIONEO.SQL_VALIDATION,NULL,NULL,'OPTION:'||PROFILEOPTIONEO.PROFILE_OPTION_ID) RES_PROFILE_VALUE
,PROFILEOPTIONVALUEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PROFILEOPTIONVALUEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PROFILEOPTIONVALUEEO.CREATED_BY RSC_CREATED_BY
,PROFILEOPTIONVALUEEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_PROFILE_OPTION_VALUES PROFILEOPTIONVALUEEO
,FND_PROFILE_LEVELS ProfileLevelEO
WHERE (ProfileOptionEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'DOO'
	AND at.module_id     = rf.ancestor_module_id
	))
AND(PROFILEOPTIONEO.APPLICATION_ID    = PROFILEOPTIONVALUEEO.APPLICATION_ID)
AND(PROFILEOPTIONEO.PROFILE_OPTION_ID = PROFILEOPTIONVALUEEO.PROFILE_OPTION_ID)
AND PROFILEOPTIONVALUEEO.LEVEL_NAME   = PROFILELEVELEO.LEVEL_NAME
ORDER BY ProfileOptionEO.PROFILE_OPTION_NAME 