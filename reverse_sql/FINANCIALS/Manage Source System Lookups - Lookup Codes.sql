/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date:  $:
* $HeadURL:  $:
* $Id: Manage FOB Lookup - Standard Lookup Type.sql  $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT LookupEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupEO.LOOKUP_CODE RES_LOOKUP_CODE
,LookupEO.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,DECODE(LookupEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(LookupEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(LookupEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,LookupEO.MEANING RES_MEANING
,LookupEO.DESCRIPTION RES_DESCRIPTION
,LookupEO.TAG RES_TAG
,LookupEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupEO.CREATED_BY RSC_CREATED_BY
,LookupEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_VALUES_VL LookupEO
WHERE LookupEO.VIEW_APPLICATION_ID = 0
AND LookupEO.SET_ID                = 0
AND LookupEO.LOOKUP_TYPE           IN (SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BoAttributeValuesEO
	WHERE BoAttributeValuesEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT AskTasksVl.TASK_ID
		FROM ASK_TASKS_VL AskTasksVl
		WHERE AskTasksVl.TASK_SHORT_NAME = 'HZ_MANAGE_SOURCE_SYSTEM_LOOKUPS'
		)
	)
AND LookupEO.VIEW_APPLICATION_ID   = LookupEO.VIEW_APPLICATION_ID
ORDER BY LookupEO.LOOKUP_TYPE 
,LookupEO.DISPLAY_SEQUENCE
,LookupEO.MEANING