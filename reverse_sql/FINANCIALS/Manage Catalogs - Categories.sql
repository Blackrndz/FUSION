/* ****************************************************************************
 * $Revision: 54841 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-04-29 15:18:22 +0700 (Fri, 29 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Locations%20-%20Asset%20Locations.sql $:
 * $Id: Manage Asset Locations - Asset Locations.sql 54841 2016-04-29 08:18:22Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT BU_NAME
  FROM FUN_ALL_BUSINESS_UNITS_V
  WHERE BU_ID = porCatalogsEO.PRC_BU_ID
  ) RES_PROCUREMENT_BU
,porCatalogsEO.CATALOG_NAME RES_CATALOG
,(CASE
  WHEN porAssignmentsE0.ASSIGNMENT_TYPE = 'PURCHASING_CATEGORY' THEN
    egpCatsE0.CATEGORY_NAME
  WHEN porAssignmentsE0.ASSIGNMENT_TYPE = 'BROWSING_CATEGORY' THEN
    porCatsE0.CATEGORY_NAME
  END) RES_CATEGORY_NAME
,(CASE
  WHEN porAssignmentsE0.ASSIGNMENT_TYPE = 'PURCHASING_CATEGORY' THEN
    egpCatsE0.DESCRIPTION
  WHEN porAssignmentsE0.ASSIGNMENT_TYPE = 'BROWSING_CATEGORY' THEN
    porCatsE0.CATEGORY_DESCRIPTION
  END) RES_DESCRIPTION
,porAssignmentsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,porAssignmentsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,porAssignmentsE0.CREATED_BY RSC_CREATED_BY
,porAssignmentsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,porCatalogsEO.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POR_CATALOGS_ALL_VL porCatalogsEO
,POR_LOCAL_CATALOGS porLocalCatsE0
,POR_CATALOG_ASSIGNMENTS porAssignmentsE0
,EGP_CATEGORIES_VL egpCatsE0
,POR_BROWSE_CATEGORIES_VL porCatsE0
WHERE porCatalogsEO.CATALOG_TYPE = 'LOCAL'
AND porCatalogsEO.CATALOG_ID = porLocalCatsE0.CATALOG_ID
AND porCatalogsEO.CATALOG_ID = porAssignmentsE0.CATALOG_ID
AND porAssignmentsE0.ASSIGNMENT_TYPE != 'AGREEMENT'
AND porAssignmentsE0.ASSIGNMENT_ID = egpCatsE0.CATEGORY_ID(+)
AND porAssignmentsE0.ASSIGNMENT_ID = porCatsE0.CATEGORY_ID(+)
ORDER BY 1,2,3