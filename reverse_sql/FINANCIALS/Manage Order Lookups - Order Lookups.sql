/* ****************************************************************************
* $Revision: 59053 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-20 13:59:22 +0700 (Wed, 19 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Time%20Shift.sql $:
* $Id: Manage Buyer Assignment Rule Sets Lookup - Standard Lookup Type.sql 59053 2016-10-19 06:59:22Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=FND_LOOKUP_TYPES_VL

SELECT LookupTypeEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupTypeEO.MEANING RES_MEANING
,LookupTypeEO.DESCRIPTION RES_DESCRIPTION
,ApplTaxonomyPEO.USER_MODULE_NAME RES_MODULE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND ENABLED_FLAG  = 'Y'
	AND LOOKUP_CODE   = LookupTypeEO.CUSTOMIZATION_LEVEL
	) RES_CUSTOMIZATION_LEVEL
,(SELECT MEANING
	FROM FND_LOOKUPS 
	WHERE LOOKUP_TYPE = 'ORA_FND_REST_ACCESS_SECURED'
	AND ENABLED_FLAG = 'Y'
	AND LOOKUP_CODE = LookupTypeEO.REST_ACCESS_SECURED 
	) RES_REST_ACCESS_SECURED
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
	AND at.module_key    = 'DOO'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY LookupTypeEO.LOOKUP_TYPE