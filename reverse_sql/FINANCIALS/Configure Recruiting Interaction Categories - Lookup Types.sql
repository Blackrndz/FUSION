/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Recruiting%20Interaction%20Categories%20-%20Lookup%20Types.sql $:
 * $Id: Configure Recruiting Interaction Categories - Lookup Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=FND_LOOKUP_TYPES_VL

SELECT LookupTypeEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupTypeEO.MEANING RES_MEANING
,LookupTypeEO.DESCRIPTION RES_DESCRIPTION
,(SELECT user_module_name
	FROM FND_APPL_TAXONOMY_VL
	WHERE module_id = LookupTypeEO.MODULE_ID
	) RES_MODULE
,(SELECT MEANING
	FROM FND_LOOKUPS 
	WHERE LOOKUP_TYPE = 'LOOKUP_CUSTOMIZATION_LEVEL'
	AND ENABLED_FLAG = 'Y'
	AND LOOKUP_CODE = LookupTypeEO.CUSTOMIZATION_LEVEL
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
WHERE LookupTypeEO.LOOKUP_TYPE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'ORA_IRC_CONFIGURE_RECRUITING_INTERACTION_CATEGORIES'
		))
	)
AND LookupTypeEO.VIEW_APPLICATION_ID  = 3
ORDER BY LookupTypeEO.LOOKUP_TYPE