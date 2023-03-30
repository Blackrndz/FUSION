/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-09-18  $:
 * $HeadURL: $:
 * $Id: Manage Party Usage Lookups - Standard Lookup Type.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=FND_LOOKUP_TYPES_VL

SELECT LookupTypeEO.LOOKUP_TYPE                                                 RES_LOOKUP_TYPE,
  LookupTypeEO.MEANING                                                          RES_MEANING,
  LookupTypeEO.DESCRIPTION                                                      RES_DESCRIPTION,
 (SELECT user_module_name
	FROM Fusion.FND_APPL_TAXONOMY_VL
	WHERE module_id = LookupTypeEO.MODULE_ID
	) RES_MODULE,
  (select LookupPEO.MEANING
  FROM FND_LOOKUPS LookupPEO
  WHERE LookupPEO.LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
  AND LookupPEO.ENABLED_FLAG    = 'Y'
  and  LookupPEO.LOOKUP_CODE =  LookupTypeEO.CUSTOMIZATION_LEVEL)               RES_CUSTOMIZATION_LEVEL
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
 
FROM Fusion.FND_LOOKUP_TYPES_VL LookupTypeEO
WHERE LOOKUP_TYPE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'HZ_MANAGE_PARTY_USAGE_LOOKUPS'
		))
	)
And Lookuptypeeo.View_Application_Id  = 0
ORDER BY LookupTypeEO.LOOKUP_TYPE

