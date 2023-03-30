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
,porCatalogsEO.CATALOG_DESCRIPTION RES_DESCRIPTION
,(CASE
	WHEN porLocalCatsE0.AGREEMENT_DIMENSION = 'INCLUDE_ALL' THEN
		'Include items from all agreements'
	WHEN porLocalCatsE0.AGREEMENT_DIMENSION = 'INCLUDE_SPECIFIC' THEN
		'Include items from specific agreements'
	WHEN porLocalCatsE0.AGREEMENT_DIMENSION = 'EXCLUDE_SPECIFIC' THEN
		'Exclude items from specific agreements'
	WHEN porLocalCatsE0.AGREEMENT_DIMENSION = 'EXCLUDE_SOURCED' THEN
		'Exclude items that are sourced through agreements'
	END) RES_AGREEMENT_OPTION
,(CASE
	WHEN porLocalCatsE0.CATEGORY_DIMENSION = 'INCLUDE_ALL' THEN
		'Include items from all categories'
	WHEN porLocalCatsE0.CATEGORY_DIMENSION = 'INCLUDE_SPECIFIC' THEN
		'Include items from specific categories'
	WHEN porLocalCatsE0.AGREEMENT_DIMENSION = 'EXCLUDE_SPECIFIC' THEN
		'Exclude items from specific categories'
	END) RES_CATEGORY_OPTION
,DECODE(porLocalCatsE0.INCLUDE_MASTER_ITEMS_FLAG,'Y','Yes','No') RES_INCLUDE_ALL_MASTER_ITEMS
,porLocalCatsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,porLocalCatsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,porLocalCatsE0.CREATED_BY RSC_CREATED_BY
,porLocalCatsE0.CREATION_DATE RSC_CREATION_DATE
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
WHERE porCatalogsEO.CATALOG_TYPE = 'LOCAL'
AND porCatalogsEO.CATALOG_ID = porLocalCatsE0.CATALOG_ID
ORDER BY 1,2