/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Catalogs%20-%20Category.sql $:
 * $Id: Manage Catalogs - Category.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=EGP_CATEGORY_SETS_VL

SELECT CatalogEO.CATEGORY_SET_NAME RES_CATALOG_NAME
,(SELECT CATEGORY_NAME FROM EGP_CATEGORIES_VL WHERE CATEGORY_ID = CatalogCatagoriesE0.PARENT_CATEGORY_ID )RES_PARENT_CATEGORY_NAME
--,CatalogEO.CATALOG_CODE RES_CATALOG_CODE
,CatagoriesE0.CATEGORY_NAME RES_CATEGORY_NAME
,CatagoriesE0.CATEGORY_CODE RES_CATEGORY_CODE
,CatagoriesE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(CatagoriesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(CatagoriesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,DECODE(CatagoriesE0.CATEGORY_CONTENT_CODE,'ITEM_ONLY','Yes','MIXED','No') RES_RESTRICT_CATEGORY_TO_ITEM_
,CatagoriesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CatagoriesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CatagoriesE0.CREATED_BY RSC_CREATED_BY
,CatagoriesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_CATEGORY_SETS_VL CatalogEO
,EGP_CATEGORY_SET_VALID_CATS CatalogCatagoriesE0
,EGP_CATEGORIES_VL CatagoriesE0
,EGP_DEFAULT_CATEGORY_SETS DefaultCatalogEO
WHERE ((DefaultCatalogEO.CATEGORY_SET_ID(+) = CatalogEO.CATEGORY_SET_ID))
AND CatalogEO.CATEGORY_SET_ID NOT IN (SELECT CATEGORY_SET_ID FROM EGP_DEFAULT_CATEGORY_SETS)
AND CatalogEO.CATEGORY_SET_ID = CatalogCatagoriesE0.CATEGORY_SET_ID
AND CatalogCatagoriesE0.CATEGORY_ID = CatagoriesE0.CATEGORY_ID
ORDER BY CatalogEO.CATEGORY_SET_NAME
,CatagoriesE0.CATEGORY_NAME