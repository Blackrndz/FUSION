/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Environment%20Health%20and%20Safety%20Configuration%20Settings%20-%20Configuration%20Settings.sql $:
 * $Id: Manage Environment Health and Safety Configuration Settings - Configuration Settings.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS=FND_LOOKUP_TYPES_VL 
 
SELECT LookupTypeEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupTypeEO.MEANING RES_MEANING
,LookupTypeEO.DESCRIPTION RES_DESCRIPTION
,(SELECT user_module_name
	FROM Fusion.FND_APPL_TAXONOMY_VL
	WHERE module_id = LookupTypeEO.MODULE_ID
	) RES_MODULE
,(SELECT LookupPEO.MEANING
	FROM Fusion.FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND LookupPEO.ENABLED_FLAG  = 'Y'
	AND lookup_code             = LookupTypeEO.CUSTOMIZATION_LEVEL
	) RES_LOOKUP_CONFIGURATION_LEVEL
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = LookupTypeEO.REST_ACCESS_SECURED 
	AND LOOKUP_TYPE = 'ORA_FND_REST_ACCESS_SECURED' AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_REST_ACCESS_SECURED
/*,(SELECT LookupPEO.MEANING
	FROM Fusion.FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND LookupPEO.ENABLED_FLAG  = 'Y'
	AND lookup_code             = LookupTypeEO.CUSTOMIZATION_LEVEL
	) RES_CUSTOMIZATION_LEVEL*/
,LookupTypeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupTypeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupTypeEO.CREATED_BY RSC_CREATED_BY
,LookupTypeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL LookupTypeEO
,FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
WHERE LookupTypeEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID
AND LookupTypeEO.VIEW_APPLICATION_ID  = 3
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'HNS'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY LookupTypeEO.LOOKUP_TYPE

