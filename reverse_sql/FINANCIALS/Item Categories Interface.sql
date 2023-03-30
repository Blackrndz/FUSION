/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Values.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Values.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGP_ITEM_CATEGORIES
-- STRICTLY_BATCH_SEQ = RES_ITEM_NUMBER,RES_ORGANIZATION_CODE,RES_CATALOG,RES_CATEGORY

SELECT /*+ PARALLEL(8) */ 'CREATE' RES_TRANSACTION_TYPE
,'' RES_BATCH_ID
,'' RES_BATCH_NUMBER
,ItemsE0.ITEM_NUMBER RES_ITEM_NUMBER
,(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = ItemsE0.ORGANIZATION_ID
	) RES_ORGANIZATION_CODE
,(SELECT CATEGORY_SET_NAME
	FROM EGP_CATEGORY_SETS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CATEGORY_SET_ID = ItemCategoriesE0.CATEGORY_SET_ID
	) RES_CATALOG
,CategoriesE0.CATEGORY_NAME RES_CATEGORY_NAME
,CategoriesE0.CATEGORY_CODE RES_CATEGORY_CODE
,'' RES_OLD_CATEGORY_NAME
,'' RES_OLD_CATEGORY_CODE
,'' RES_SOURCE_SYSTEM_CODE
,'' RES_SOURCE_SYSTEM_REFERENCE
,TO_CHAR(ItemCategoriesE0.START_DATE,'YYYY/MM/DD') RES_START_DATE
,TO_CHAR(ItemCategoriesE0.END_DATE,'YYYY/MM/DD') RES_END_DATE
,ItemCategoriesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ItemCategoriesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ItemCategoriesE0.CREATED_BY  RSC_CREATED_BY
,ItemCategoriesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,ItemsE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_SYSTEM_ITEMS_B ItemsE0
,EGP_ITEM_CATEGORIES ItemCategoriesE0
,EGP_CATEGORIES_VL CategoriesE0
WHERE ItemsE0.INVENTORY_ITEM_ID = ItemCategoriesE0.INVENTORY_ITEM_ID
AND ItemsE0.ORGANIZATION_ID = ItemCategoriesE0.ORGANIZATION_ID
AND ItemCategoriesE0.CATEGORY_ID = CategoriesE0.CATEGORY_ID
AND ItemsE0.TEMPLATE_ITEM_FLAG = 'N'