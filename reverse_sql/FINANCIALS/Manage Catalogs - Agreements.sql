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
,poHeadersE0.SEGMENT1 RES_AGREEMENT
,(SELECT PTY.PARTY_NAME 
	FROM POZ_SUPPLIERS sup
	,HZ_PARTIES PTY
	WHERE sup.PARTY_ID = PTY.PARTY_ID
	AND sup.VENDOR_ID = poHeadersE0.VENDOR_ID
	) RES_SUPPLIER
,(SELECT PTYSITE.PARTY_SITE_NAME 
	FROM POZ_SUPPLIER_SITES_ALL_M supSites
	,HZ_PARTY_SITES PTYSITE
	WHERE supSites.PARTY_SITE_ID = PTYSITE.PARTY_SITE_ID
	AND supSites.VENDOR_SITE_ID = poHeadersE0.VENDOR_SITE_ID
	) RES_SUPPLIER_SITE
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
,PO_HEADERS_ALL poHeadersE0
WHERE porCatalogsEO.CATALOG_TYPE = 'LOCAL'
AND porCatalogsEO.CATALOG_ID = porLocalCatsE0.CATALOG_ID
AND porCatalogsEO.CATALOG_ID = porAssignmentsE0.CATALOG_ID
AND porAssignmentsE0.ASSIGNMENT_TYPE = 'AGREEMENT'
AND porAssignmentsE0.ASSIGNMENT_ID = poHeadersE0.PO_HEADER_ID
ORDER BY 1,2,3