/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT 
(SELECT ITEM_CLASS_NAME
	FROM EGP_ITEM_CLASSES_VL
	WHERE ITEM_CLASS_ID = ItemClassPEO.PARENT_ITEM_CLASS_ID
	) RES_PARENT_ITEM_CLASS 
,ItemClassPEO.ITEM_CLASS_NAME RES_ITEM_CLASS
--,FndEfUiPages.SEQUENCE_NUMBER RES_SEQUENCE
,FndEfUiPages.NAME RES_DISPLAY_NAME
,FndEfUiPages.PAGE_CODE RES_INTERNAL_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGO_RL_BUS_ENTS'
	AND LOOKUP_CODE = FndEfUiPages.FLEXFIELD_USAGE_CODE
	) RES_DATA_LEVEL
,FndEfUiPageTaskFlows.SEQUENCE_NUMBER RES_ATTRIBUTE_GROUPS_SEQUENCE
,FndDfContexts.NAME RES_ATTRIBUTE_GROUPS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FND_EF_CONTEXT_MULTIROW_TYPES'
	AND LOOKUP_CODE = FndDfContexts.MULTIROW_FLAG
	) RES_BEHAVIOR
,ItemClassPEO.ITEM_CLASS_NAME RES_ATTRIBUTE_GROUPS_ITEM_CLAS
,FndDfContexts.DESCRIPTION RES_DESCRIPTION
,FndEfUiPageTaskFlows.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,FndEfUiPageTaskFlows.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,FndEfUiPageTaskFlows.CREATED_BY  RSC_CREATED_BY
,FndEfUiPageTaskFlows.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_CLASSES_VL ItemClassPEO
,FND_EF_UI_PAGES_VL FndEfUiPages
,FND_EF_UI_PAGE_TASK_FLOWS FndEfUiPageTaskFlows
,FND_DF_CONTEXTS_VL FndDfContexts
WHERE ItemClassPEO.ITEM_CLASS_CODE = FndEfUiPages.CATEGORY_CODE
AND FndEfUiPages.CATEGORY_CODE = FndEfUiPageTaskFlows.CATEGORY_CODE
AND FndEfUiPages.PAGE_CODE = FndEfUiPageTaskFlows.PAGE_CODE
AND FndEfUiPageTaskFlows.DESCRIPTIVE_FLEXFIELD_CODE = FndDfContexts.DESCRIPTIVE_FLEXFIELD_CODE
AND FndEfUiPageTaskFlows.APPLICATION_ID = FndDfContexts.APPLICATION_ID
AND FndEfUiPageTaskFlows.CONTEXT_CODE = FndDfContexts.CONTEXT_CODE
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS,RES_ITEM_CLASS