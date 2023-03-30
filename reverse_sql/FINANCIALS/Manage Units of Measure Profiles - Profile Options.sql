/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Options.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Options.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT ProfileOptionEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,ProfileOptionEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
,ProfileOptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProfileOptionEO.CREATED_BY RSC_CREATED_BY
,ProfileOptionEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
,FND_APPLICATION_VL AppNameE0
WHERE ProfileOptionEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID
AND ProfileOptionEO.APPLICATION_ID = AppNameE0.APPLICATION_ID
AND(ProfileOptionEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'RCS'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY ProfileOptionEO.PROFILE_OPTION_NAME