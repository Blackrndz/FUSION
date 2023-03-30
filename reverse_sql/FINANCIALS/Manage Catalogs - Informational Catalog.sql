/* ****************************************************************************
 * $Revision: 54841 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-04-29 15:18:22 +0700 (Fri, 29 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Locations%20-%20Asset%20Locations.sql $:
 * $Id: Manage Asset Locations - Asset Locations.sql 54841 2016-04-29 08:18:22Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- REPLACE_HTML_KEYWORD = RES_CATALOG
-- REPLACE_HTML_KEYWORD = RES_DESCRIPTION
-- REPLACE_HTML_KEYWORD = RES_URL
-- REPLACE_HTML_KEYWORD = RES_KEYWORDS

SELECT (SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = porCatalogsEO.PRC_BU_ID
	) RES_PROCUREMENT_BU
,REPLACE(REPLACE(REPLACE(porCatalogsEO.CATALOG_NAME,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_CATALOG
,REPLACE(REPLACE(REPLACE(porCatalogsEO.CATALOG_DESCRIPTION,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_DESCRIPTION
,REPLACE(REPLACE(REPLACE(porInfoCatsE0.URL,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_URL
,REPLACE(REPLACE(REPLACE(porCatalogsEO.KEYWORDS,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_KEYWORDS
,porInfoCatsE0.IMAGE_LOCATION RES_IMAGE_URL
,porInfoCatsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,porInfoCatsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,porInfoCatsE0.CREATED_BY RSC_CREATED_BY
,porInfoCatsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,porCatalogsEO.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POR_CATALOGS_ALL_VL porCatalogsEO
,POR_INFO_CATALOGS porInfoCatsE0
WHERE porCatalogsEO.CATALOG_TYPE = 'INFORMATIONAL'
AND porCatalogsEO.CATALOG_ID = porInfoCatsE0.CATALOG_ID
ORDER BY 1,2