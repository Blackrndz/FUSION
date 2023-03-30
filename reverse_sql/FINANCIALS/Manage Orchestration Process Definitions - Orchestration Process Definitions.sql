/* ****************************************************************************
 * $Revision: 63386 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-08-17 11:10:02 +0700 (Thu, 17 Aug 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Manage%20Revaluations%20-%20Revaluations.sql $:
 * $Id: Manage Revaluations - Revaluations.sql 63386 2017-08-17 04:10:02Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT ProcessDefinitionEO.PROCESS_NAME RES_PROCESS_NAME
,ProcessDefinitionEO.PROCESS_DISPLAY_NAME RES_PROCESS_DISPLAY_NAME
,(SELECT PROCESS_CLASS_NAME
	FROM DOO_PROCESS_CLASSES_VL
	WHERE PROCESS_CLASS_ID = ProcessDefinitionEO.PROCESS_CLASS_ID
	) RES_PROCESS_CLASS
,ProcessDefinitionEO.STATUS_CATALOG_ID RES_STATUS_CATALOG
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'DOO_CHANGE_MODE'
	AND LOOKUP_CODE = ProcessDefinitionEO.CHANGE_MANAGEMENT_MODE
	AND LANGUAGE = USERENV('LANG')
	)RES_CHANGE_MODE
,ProcessDefinitionEO.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(ProcessDefinitionEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(ProcessDefinitionEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,(SELECT SET_NAME 
	FROM FND_SETID_SETS
	WHERE SET_ID = ProcessDefinitionEO.SET_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_SET
,DECODE(ProcessDefinitionEO.MAIN_PROCESS_FLAG,'Y','Yes','No') RES_PARENT_PROCESS
,DECODE(ProcessDefinitionEO.USE_FLEX_ATTR_IN_DELTA_COMP,'Y','Yes','No') RES_USE_FLEXFIELD_ATTRIBUTES
,DECODE(ProcessDefinitionEO.USE_DYNAMIC_ATTR_IN_DELTA_COMP,'Y','Yes','No') RES_USE_TRANSACTIONAL_ITEM_ATT
,DECODE(ProcessDefinitionEO.REPLAN_FLAG,'Y','Yes','No') RES_REPLAN_INSTANTLY
,ProcessDefinitionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProcessDefinitionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProcessDefinitionEO.CREATED_BY RSC_CREATED_BY
,ProcessDefinitionEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM DOO_PROCESS_DEFINITIONS_VL ProcessDefinitionEO
ORDER BY ProcessDefinitionEO.PROCESS_NAME