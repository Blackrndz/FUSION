/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Environment%20Health%20and%20Safety%20Configuration%20Settings%20-%20Lookup%20Codes.sql $:
* $Id: Manage Environment Health and Safety Configuration Settings - Lookup Codes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT LookupTypeEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupValueE0.LOOKUP_CODE RES_LOOKUP_CODE
,LookupValueE0.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,DECODE(LookupValueE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(LookupValueE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(LookupValueE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,LookupValueE0.MEANING RES_MEANING
,LookupValueE0.DESCRIPTION RES_DESCRIPTION
,LookupValueE0.TAG RES_TAG
,LookupValueE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupValueE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupValueE0.CREATED_BY RSC_CREATED_BY
,LookupValueE0.CREATION_DATE RSC_CREATION_DATE
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
,FND_LOOKUP_VALUES_VL LookupValueE0
WHERE LookupTypeEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID
AND LookupTypeEO.VIEW_APPLICATION_ID = 3
AND LookupTypeEO.VIEW_APPLICATION_ID = LookupValueE0.VIEW_APPLICATION_ID
AND LookupTypeEO.LOOKUP_TYPE = LookupValueE0.LOOKUP_TYPE
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'HNS'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY LookupTypeEO.LOOKUP_TYPE
,LookupValueE0.DISPLAY_SEQUENCE
,LookupValueE0.LOOKUP_CODE