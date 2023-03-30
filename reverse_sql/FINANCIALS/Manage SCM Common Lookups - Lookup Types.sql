/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20SCM%20Common%20Lookups%20-%20Lookup%20Types.sql $:
 * $Id: Manage SCM Common Lookups - Lookup Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=FND_LOOKUP_TYPES_VL
 
 
SELECT LOOKUP_TYPE RES_LOOKUP_TYPE
,MEANING RES_MEANING
,DESCRIPTION RES_DESCRIPTION
,(SELECT user_module_name
	FROM Fusion.FND_APPL_TAXONOMY_VL
	WHERE module_id = LookupTypeEO.MODULE_ID
	) RES_MODULE
,(SELECT LookupPEO.MEANING
	FROM Fusion.FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND LookupPEO.ENABLED_FLAG  = 'Y'
	AND lookup_code             = LookupTypeEO.CUSTOMIZATION_LEVEL
	) RES_CUSTOMIZATION_LEVEL
,(SELECT MEANING
	FROM FND_LOOKUPS 
	WHERE LOOKUP_TYPE = 'ORA_FND_REST_ACCESS_SECURED'
	AND ENABLED_FLAG = 'Y'
	AND LOOKUP_CODE = LookupTypeEO.REST_ACCESS_SECURED 
	) RES_REST_ACCESS_SECURED
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Fusion.FND_LOOKUP_TYPES_VL LookupTypeEO
WHERE MODULE_ID   in   (SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'RCS'
	AND AT.MODULE_ID     = RF.ANCESTOR_MODULE_ID
	)
AND LookupTypeEO.VIEW_APPLICATION_ID  = 0
ORDER BY LOOKUP_TYPE