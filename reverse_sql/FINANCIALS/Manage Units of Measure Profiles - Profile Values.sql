/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Values.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Values.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- FIELD_TO_APPLY_FUNCTION=RES_PRODUCT_NAME/GET_SYSTEM_PROFILE_VALUE
-- FIELD_TO_APPLY_FUNCTION=RES_USER_NAME/GET_SYSTEM_PROFILE_VALUE
-- FIELD_TO_APPLY_FUNCTION=RES_PROFILE_VALUE/GET_SYSTEM_PROFILE_VALUE

SELECT PROFILEOPTIONEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
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
,PROFILEOPTIONVALUEEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_APPL_TAXONOMY_VL APPLTAXONOMYPEO
,FND_PROFILE_OPTION_VALUES PROFILEOPTIONVALUEEO
,FND_PROFILE_LEVELS ProfileLevelEO
WHERE ProfileOptionEO.MODULE_ID       = ApplTaxonomyPEO.MODULE_ID
AND PROFILEOPTIONEO.APPLICATION_ID    = PROFILEOPTIONVALUEEO.APPLICATION_ID
AND PROFILEOPTIONEO.PROFILE_OPTION_ID = PROFILEOPTIONVALUEEO.PROFILE_OPTION_ID
AND PROFILEOPTIONVALUEEO.LEVEL_NAME   = PROFILELEVELEO.LEVEL_NAME
AND(ProfileOptionEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'RCS'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY PROFILEOPTIONEO.PROFILE_OPTION_NAME 