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
,FndEfUiPages.SEQUENCE_NUMBER RES_SEQUENCE
,FndEfUiPages.NAME RES_DISPLAY_NAME
,'' RES_INHERITED  -- Not found in Internal instance
,DECODE(FndEfUiPages.PROTECTED_FLAG,'Y','Yes','N','No') RES_PROTECTED
,FndEfUiPages.PAGE_CODE RES_INTERNAL_NAME
,FndEfUiPages.DESCRIPTION RES_DESCRIPTION
,FndEfUiPages.INSTRUCTION_HELP_TEXT RES_INSTRUCTION_HELP_TEXT
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGO_RL_BUS_ENTS'
	AND LOOKUP_CODE = FndEfUiPages.FLEXFIELD_USAGE_CODE
	) RES_DATA_LEVEL
,FndEfUiPages.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,FndEfUiPages.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,FndEfUiPages.CREATED_BY  RSC_CREATED_BY
,FndEfUiPages.CREATION_DATE  RSC_CREATION_DATE
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
WHERE ItemClassPEO.ITEM_CLASS_CODE = FndEfUiPages.CATEGORY_CODE
CONNECT BY ItemClassPEO.PARENT_ITEM_CLASS_ID = ItemClassPEO.ITEM_CLASS_ID
ORDER SIBLINGS BY RES_PARENT_ITEM_CLASS,RES_ITEM_CLASS