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
,porCatalogsEO.KEYWORDS RES_KEYWORDS
,porPunchoutCatsE0.IMAGE_LOCATION RES_IMAGE_URL
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'EXCHANGE' THEN
		'Oracle Exchange'
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_CXML' THEN
		'Direct cXML supplier punchout'
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_XML' THEN 
		'Direct Oracle native XML supplier punchout'
	END) RES_SOURCE
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_CXML' THEN
		(SELECT PTY.PARTY_NAME 
			FROM POZ_SUPPLIERS sup
			,HZ_PARTIES PTY
			WHERE sup.PARTY_ID = PTY.PARTY_ID
			AND sup.VENDOR_ID = porPunchoutCatsE0.VENDOR_ID)
	END) RES_SUPPLIER
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_CXML' THEN
		(SELECT PTYSITE.PARTY_SITE_NAME 
			FROM POZ_SUPPLIER_SITES_ALL_M supSites
			,HZ_PARTY_SITES PTYSITE
			WHERE supSites.PARTY_SITE_ID = PTYSITE.PARTY_SITE_ID
			AND supSites.VENDOR_SITE_ID = porPunchoutCatsE0.VENDOR_SITE_ID)
	END) RES_SUPPLIER_SITE
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_CXML' THEN
		porPunchoutCatsE0.SUPPLIER_NAME
	END) RES_SUPPLIER_NAME
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_CXML' THEN
		porPunchoutCatsE0.SUPPLIER_NUMBER
	END) RES_SUPPLIER_ID
,'' RES_PUNCHOUT_URL
,porPunchoutCatsE0.USERNAME RES_USER_NAME
,'' RES_PASSWORD
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_XML' THEN
		porPunchoutCatsE0.ENCODING_METHOD
	END) RES_ENCODING_METHOD
,DECODE(porPunchoutCatsE0.SEND_OPTIONAL_INFO_FLAG,'Y','Yes','No') RES_SEND_OPTIONAL_USER_AND_COM
,DECODE(porPunchoutCatsE0.PRICE_NEGOTIATED_FLAG,'Y','Yes','No') RES_ALL_PRICES_ARE_NEGOTIATED
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_CXML' THEN
		porPunchoutCatsE0.BUYER_COMPANY_NAME 
	END) RES_DOMAIN
,(CASE
	WHEN porPunchoutCatsE0.SOURCE = 'SUPPLIER_VIA_CXML' THEN
		porPunchoutCatsE0.BUYER_COMPANY_ID
	END) RES_IDENTITY
,(CASE
	WHEN porPunchoutCatsE0.SOURCE != 'SUPPLIER_VIA_CXML' THEN
		porPunchoutCatsE0.BUYER_COMPANY_NAME 
	END) RES_COMPANY_NAME
,(CASE
	WHEN porPunchoutCatsE0.SOURCE != 'SUPPLIER_VIA_CXML' THEN
		porPunchoutCatsE0.BUYER_COMPANY_ID
	END) RES_COMPANY_ID
,DECODE(porPunchoutCatsE0.APPLY_MAPPING,'Y','Yes','No') RES_APPLY_MAPPING
,(SELECT MAP_SET_NAME 
	FROM POR_MAP_SET_HEADERS_ALL_TL
	WHERE MAP_SET_ID = porPunchoutCatsE0.MAP_SET_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_MAP_SET
,DECODE(porPunchoutCatsE0.ENABLE_ITEM_LVL_PUNCHOUT_FLAG,'Y','Yes','No') RES_ENABLE_ITEM_LEVEL_PUNCHOUT
,porPunchoutCatsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,porPunchoutCatsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,porPunchoutCatsE0.CREATED_BY RSC_CREATED_BY
,porPunchoutCatsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,porCatalogsEO.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POR_CATALOGS_ALL_VL porCatalogsEO
,POR_PUNCHOUT_CATALOGS porPunchoutCatsE0
WHERE porCatalogsEO.CATALOG_TYPE = 'PUNCHOUT'
AND porCatalogsEO.CATALOG_ID = porPunchoutCatsE0.CATALOG_ID
ORDER BY 1,2