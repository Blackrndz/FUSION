/* ****************************************************************************
 * $Revision: 60395 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-12-23 16:41:23 +0700 (Fri, 23 Dec 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Lookups - Standard Lookup Type.sql 60395 2016-12-23 09:41:23Z nasrullah.dusenmahamad $:
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
WHERE LOOKUP_TYPE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'EGP_MANAGE_CROSS_REFERENCE_TYPES'
		))
	)
And Lookuptypeeo.View_Application_Id  = 0
ORDER BY LOOKUP_TYPE