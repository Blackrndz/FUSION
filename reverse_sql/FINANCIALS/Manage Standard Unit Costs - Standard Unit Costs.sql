/* ****************************************************************************
 * $Revision: 63805 $:
 * $Author: phermwit.seethong $:
 * $Date: 2017-09-12 15:37:52 +0700 (Tue, 12 Sep 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.18.10/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Calendar%20Options.sql $:
 * $Id: Manage Accounting Calendars - Calendar Options.sql 63805 2017-09-12 08:37:52Z phermwit.seethong $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT FaBooksE0.BOOK_TYPE_NAME RES_ASSET_BOOK
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'FA'
	,KEY_FLEX_CODE => (SELECT KEY_FLEXFIELD_CODE FROM FND_KF_STR_INSTANCES_VL WHERE STRUCTURE_INSTANCE_NUMBER= assetCategoriesE0.STRUCTURE_INSTANCE_NUMBER)
	,STRUCTURE_NUMBER => assetCategoriesE0.STRUCTURE_INSTANCE_NUMBER
	,COMBINATION_ID => assetCategoriesE0.CATEGORY_ID) RES_ASSET_CATEGORY
,ledgersE0.CURRENCY_CODE RES_ASSET_BOOK_CURRENCY
,stdCostsE0.STANDARD_UNIT_COST RES_COST_PER_UNIT
,stdCostsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,stdCostsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,stdCostsE0.CREATED_BY  RSC_CREATED_BY
,stdCostsE0.CREATION_DATE  RSC_CREATION_DATE
,FaBooksE0.SET_OF_BOOKS_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJC_STANDARD_UNIT_COSTS stdCostsE0
,FA_BOOK_CONTROLS FaBooksE0
,FA_CATEGORIES_B assetCategoriesE0
,GL_LEDGERS ledgersE0
WHERE stdCostsE0.BOOK_TYPE_CODE = FaBooksE0.BOOK_TYPE_CODE
AND stdCostsE0.ASSET_CATEGORY_ID = assetCategoriesE0.CATEGORY_ID(+)
AND FaBooksE0.SET_OF_BOOKS_ID = ledgersE0.LEDGER_ID
ORDER BY FaBooksE0.BOOK_TYPE_NAME