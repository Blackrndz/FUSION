/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Catalogs%20-%20Catalog.sql $:
 * $Id: Manage Catalogs - Catalog.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=EGP_CATEGORY_SETS_VL

SELECT CatalogEO.CATEGORY_SET_NAME 													RES_CATALOG_NAME
,CatalogEO.CATALOG_CODE 															RES_CATALOG_CODE
,CatalogEO.DESCRIPTION 																RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGP_CATALOG_CONTROL_LEVEL'
	AND LOOKUP_CODE = CatalogEO.CONTROL_LEVEL
	) 																				RES_CONTROLLED_AT
,(SELECT CATEGORY_NAME
	FROM EGP_CATEGORIES_TL
	WHERE CATEGORY_ID = CatalogEO.DEFAULT_CATEGORY_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_DEFAULT_CATEGORY
,TO_CHAR(CatalogEO.START_DATE,'DD-Mon-YYYY') 										RES_START_DATE
,TO_CHAR(CatalogEO.END_DATE,'DD-Mon-YYYY') 											RES_END_DATE
,decode(CatalogEO.PUBLIC_CATALOG,'Y','Yes','No')                                RES_PUBLIC
,decode(CatalogEO.CATALOG_CONTENT_CODE,'LEAF_ITEMS','Yes','No')                     RES_ASSIGN_ITEMS_TO_LEAF_LEVEL
,'No' RES_ENABLE_DUPLICATE_CATEGORY_
,DECODE(CatalogEO.MULT_ITEM_CAT_ASSIGN_FLAG,'Y','Yes','N','No') RES_ALLOW_MULTIPLE_ITEM_CATEGO
,'No' RES_ENABLE_DELETION_OF_ITEM_CA
,DECODE(CatalogEO.HIERARCHY_ENABLED,'Y','Yes','N','No') RES_ENABLE_HIERARCHY_FOR_CATAL
,'No' RES_ENABLE_DATE_LEVEL_CONTROL_
,'No' RES_DEFAULT_CATEGORY_REQUIRED
,CatalogEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CatalogEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CatalogEO.CREATED_BY RSC_CREATED_BY
,CatalogEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_CATEGORY_SETS_VL CatalogEO
/*,EGP_DEFAULT_CATEGORY_SETS DefaultCatalogEO
WHERE ((DefaultCatalogEO.CATEGORY_SET_ID(+) = CatalogEO.CATEGORY_SET_ID))
AND CatalogEO.CATEGORY_SET_ID NOT IN (SELECT CATEGORY_SET_ID FROM EGP_DEFAULT_CATEGORY_SETS)*/
ORDER BY CatalogEO.CATEGORY_SET_NAME