/* ****************************************************************************
 * $Revision: 53810 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-23 11:43:41 +0700 (Wed, 23 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Item%20Profile%20Options%20-%20Profile%20Values.sql $:
 * $Id: Manage Item Profile Options - Profile Values.sql 53810 2016-03-23 04:43:41Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- FIELD_TO_APPLY_FUNCTION=RES_PRODUCT_NAME/GET_SYSTEM_PROFILE_VALUE
-- FIELD_TO_APPLY_FUNCTION=RES_USER_NAME/GET_SYSTEM_PROFILE_VALUE
-- FIELD_TO_APPLY_FUNCTION=RES_PROFILE_VALUE/GET_SYSTEM_PROFILE_VALUE
 
SELECT ProfileOptionEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,ProfileOptionEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
,ProfileLevelEO.DESCRIPTION RES_PROFILE_LEVEL
,(
	CASE
		WHEN ProfileOptionValueEO.LEVEL_NAME = 'PRODUCT'
		THEN ProfileOptionValueEO.LEVEL_VALUE||'##RES##LEVEL:'||PROFILELEVELEO.LEVEL_NAME
		ELSE NULL
	END) RES_PRODUCT_NAME
,(
	CASE
		WHEN ProfileOptionValueEO.LEVEL_NAME = 'USER'
		THEN ProfileOptionValueEO.LEVEL_VALUE||'##RES##LEVEL:'||PROFILELEVELEO.LEVEL_NAME
		ELSE NULL
	END) RES_USER_NAME
,PROFILEOPTIONVALUEEO.profile_option_value||'##RES##'||DECODE(PROFILEOPTIONEO.SQL_VALIDATION,NULL,NULL,'OPTION:'||PROFILEOPTIONEO.PROFILE_OPTION_ID) RES_PROFILE_VALUE
,ProfileOptionValueEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionValueEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProfileOptionValueEO.CREATED_BY RSC_CREATED_BY
,ProfileOptionValueEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,ProfileOptionValueEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
,FND_PROFILE_OPTION_VALUES ProfileOptionValueEO
,FND_PROFILE_OPTION_LEVELS ProfileOptionLevelEO
,FND_PROFILE_LEVELS ProfileLevelEO
WHERE ProfileOptionEO.MODULE_ID            = ApplTaxonomyPEO.MODULE_ID
AND ProfileOptionValueEO.PROFILE_OPTION_ID = ProfileOptionEO.PROFILE_OPTION_ID
AND(ProfileOptionEO.MODULE_ID             IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'AR'
	AND at.module_id     = rf.ancestor_module_id
	))
AND((ProfileOptionValueEO.APPLICATION_ID   = ProfileOptionLevelEO.APPLICATION_ID)
AND(ProfileOptionValueEO.PROFILE_OPTION_ID = ProfileOptionLevelEO.PROFILE_OPTION_ID))
AND(ProfileOptionValueEO.LEVEL_NAME        = ProfileOptionLevelEO.LEVEL_NAME)
AND ProfileOptionLevelEO.ENABLED_FLAG      = 'Y'
AND PROFILEOPTIONVALUEEO.LEVEL_NAME        = PROFILELEVELEO.LEVEL_NAME
ORDER BY RES_PROFILE_OPTION_CODE