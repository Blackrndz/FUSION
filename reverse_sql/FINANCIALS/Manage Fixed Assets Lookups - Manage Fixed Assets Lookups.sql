/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Lookups%20-%20Manage%20Fixed%20Assets%20Lookups.sql $:
 * $Id: Manage Fixed Assets Lookups - Manage Fixed Assets Lookups.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT LOOKUPTYPEEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,SetIdReferenceGroupPEO.VISIBLE_GROUP_NAME RES_REFERENCE_GROUP_NAME
,LOOKUPTYPEEO.MEANING RES_MEANING
,LOOKUPTYPEEO.DESCRIPTION RES_DESCRIPTION
,APPLTAXONOMYEO.USER_MODULE_NAME RES_APPLICATION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND LOOKUP_CODE = LOOKUPTYPEEO.CUSTOMIZATION_LEVEL
	AND ENABLED_FLAG = 'Y') RES_CONFIGURATION_LEVEL
,LOOKUPTYPEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LOOKUPTYPEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
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
,FND_SETID_REFERENCE_GROUPS_VL SetIdReferenceGroupPEO
WHERE LOOKUPTYPEEO.MODULE_ID = APPLTAXONOMYEO.MODULE_ID
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,FND_APPL_TAXONOMY AT
	WHERE AT.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'FA'
	AND at.module_id     = rf.ancestor_module_id
	))
AND LOOKUPTYPEEO.REFERENCE_GROUP_NAME = SetIdReferenceGroupPEO.REFERENCE_GROUP_NAME(+)
ORDER BY LOOKUPTYPEEO.LOOKUP_TYPE