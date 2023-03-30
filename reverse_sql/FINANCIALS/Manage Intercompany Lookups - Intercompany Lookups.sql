/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Intercompany%20Lookups%20-%20Intercompany%20Lookups.sql $:
* $Id: Manage Intercompany Lookups - Intercompany Lookups.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT LookupTypeEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupTypeEO.REFERENCE_GROUP_NAME RES_REFERENCE_GROUP_NAME
,LookupTypeEO.MEANING RES_MEANING
,LookupTypeEO.DESCRIPTION RES_DESCRIPTION
,ApplTaxonomyPEO.USER_MODULE_NAME RES_APPLICATION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND ENABLED_FLAG  = 'Y'
	AND LOOKUP_CODE   = LookupTypeEO.CUSTOMIZATION_LEVEL 
	) RES_CONFIGURATION_LEVEL
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
AND LookupTypeEO.VIEW_APPLICATION_ID      = 0
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'FUN'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY LookupTypeEO.LOOKUP_TYPE