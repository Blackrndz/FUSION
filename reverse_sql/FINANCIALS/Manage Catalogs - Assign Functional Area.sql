/* ****************************************************************************
 * $Revision: 54841 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-04-29 15:18:22 +0700 (Fri, 29 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Locations%20-%20Asset%20Locations.sql $:
 * $Id: Manage Asset Locations - Asset Locations.sql 54841 2016-04-29 08:18:22Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=EGP_CATEGORY_SETS_VL

SELECT CatalogEO.CATEGORY_SET_NAME 		RES_CATALOG_NAME
,(SELECT MEANING FROM FND_LOOKUPS WHERE LOOKUP_TYPE = 'EGP_CATALOG_FUNCTIONAL_AREAS' 
AND lookup_code = DefaultCatalogEO.functional_area_id ) RES_FUNCTIONAL_AREA

,DefaultCatalogEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DefaultCatalogEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DefaultCatalogEO.CREATED_BY RSC_CREATED_BY
,DefaultCatalogEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_CATEGORY_SETS_VL CatalogEO
,EGP_DEFAULT_CATEGORY_SETS DefaultCatalogEO
WHERE /*((DefaultCatalogEO.CATEGORY_SET_ID(+) = CatalogEO.CATEGORY_SET_ID))
AND CatalogEO.CATEGORY_SET_ID NOT IN (SELECT CATEGORY_SET_ID FROM EGP_DEFAULT_CATEGORY_SETS)*/
CatalogEO.CATEGORY_SET_ID = DefaultCatalogEO.CATEGORY_SET_ID
ORDER BY CatalogEO.CATEGORY_SET_NAME