/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Standard%20Lookups%20-%20Standard%20Lookups.sql $:
 * $Id: Manage Applications Core Standard Lookups - Standard Lookups.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=FND_LOOKUP_TYPES_VL

SELECT LOOKUPTYPEEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LOOKUPTYPEEO.MEANING RES_MEANING
,LOOKUPTYPEEO.DESCRIPTION RES_DESCRIPTION
,APPLTAXONOMYEO.USER_MODULE_NAME RES_MODULE
,DECODE(LOOKUPTYPEEO.CUSTOMIZATION_LEVEL,'S','System','U','User','E','Extension') RES_CUSTOMIZATION_LEVEL
,(SELECT MEANING
	FROM FND_LOOKUPS 
	WHERE LOOKUP_TYPE = 'ORA_FND_REST_ACCESS_SECURED'
	AND ENABLED_FLAG = 'Y'
	AND LOOKUP_CODE = LookupTypeEO.REST_ACCESS_SECURED 
	) RES_REST_ACCESS_SECURED
,LOOKUPTYPEEO.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,LOOKUPTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LOOKUPTYPEEO.CREATED_BY RSC_CREATED_BY
,LOOKUPTYPEEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL LOOKUPTYPEEO
,FND_APPL_TAXONOMY_VL APPLTAXONOMYEO
WHERE LOOKUPTYPEEO.MODULE_ID = APPLTAXONOMYEO.MODULE_ID
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,FND_APPL_TAXONOMY AT
	WHERE AT.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'FND'
	AND at.module_id     = rf.ancestor_module_id
	))
AND((((LookupTypeEO.VIEW_APPLICATION_ID = 0))))
ORDER BY LOOKUPTYPEEO.LOOKUP_TYPE