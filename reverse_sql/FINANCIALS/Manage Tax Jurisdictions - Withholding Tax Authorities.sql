/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT DISTINCT QRSLT.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_CODE
,QRSLT.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,QRSLT.TAX RES_TAX
,QRSLT.SUPPLIER_NAME RES_COLLECTING_TAX_AUTHORITY
,QRSLT.BU_NAME RES_BUSINESS_UNIT
,QRSLT.SUPPLIER_SITE RES_COLLECTING_TAX_AUTHORITY_S
,TO_CHAR(QRSLT.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(Extract(YEAR FROM QRSLT.EFFECTIVE_END_DATE),'4712',NULL,TO_CHAR(QRSLT.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,QRSLT.INTERNAL_ORGANIZATION_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ZxJurisdictionsVl.TAX_JURISDICTION_CODE
	,ZxJurisdictionsVl.TAX_REGIME_CODE
	,ZxJurisdictionsVl.TAX
	,ZxJurisdictionsVl.EFFECTIVE_FROM START_DATE
	,NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') AS REGIME_TYPE_FLAG
	,(SELECT PartyPEO.PARTY_NAME
		FROM POZ_SUPPLIERS SupplierPEO
		,HZ_PARTIES PartyPEO
		WHERE SupplierPEO.PARTY_ID = PartyPEO.PARTY_ID
		AND SupplierPEO.VENDOR_ID  = TaxSettlementAuthorityEO.SUPPLIER_ID
		AND ROWNUM                 = 1
		) AS SUPPLIER_NAME
	,(SELECT BU_NAME
		FROM FUN_ALL_BUSINESS_UNITS_V BU
		WHERE BU.BU_ID = TaxSettlementAuthorityEO.INTERNAL_ORGANIZATION_ID
		) AS BU_NAME
	,(SELECT SupplierSiteDPEO.VENDOR_SITE_CODE
		FROM POZ_SUPPLIER_SITES_ALL_M SupplierSiteDPEO
		,POZ_SITE_ASSIGNMENTS_ALL_M SupplierSiteAssignmentDPEO
		,FUN_ALL_BUSINESS_UNITS_V BusinessUnit
		WHERE SupplierSiteDPEO.VENDOR_SITE_ID                    = SupplierSiteAssignmentDPEO.VENDOR_SITE_ID
		AND TaxSettlementAuthorityEO.SUPP_SITE_USG_ASSIGNMENT_ID = SupplierSiteAssignmentDPEO.VENDOR_SITE_ID
		AND BusinessUnit.BU_ID                                   = TaxSettlementAuthorityEO.INTERNAL_ORGANIZATION_ID
		AND BusinessUnit.BU_ID                                   = SupplierSiteAssignmentDPEO.BU_ID
		AND ROWNUM                                               = 1
		) AS SUPPLIER_SITE
	,TaxSettlementAuthorityEO.INTERNAL_ORGANIZATION_ID
	,TaxSettlementAuthorityEO.EFFECTIVE_START_DATE
	,TaxSettlementAuthorityEO.EFFECTIVE_END_DATE
	,TaxSettlementAuthorityEO.CREATED_BY
	,TaxSettlementAuthorityEO.CREATION_DATE
	,TaxSettlementAuthorityEO.LAST_UPDATED_BY
	,TaxSettlementAuthorityEO.LAST_UPDATE_DATE
	FROM ZX_JURISDICTIONS_VL ZxJurisdictionsVl
	,ZX_REGIMES_VL RegimeTLEO
	,HZ_GEOGRAPHY_TYPES_VL HzGeoTypes
	,ZX_TAXES_VL TaxTLEO
	,HZ_GEOGRAPHIES HzGeographies
	,ZX_TAX_SETTLEMENT_AUTHS_F TaxSettlementAuthorityEO
	WHERE TaxTLEO.SOURCE_TAX_FLAG               = 'Y'
	AND HzGeoTypes.GEOGRAPHY_TYPE               = HzGeographies.GEOGRAPHY_TYPE
	AND TaxTLEO.TAX                             = ZxJurisdictionsVl.TAX
	AND TaxTLEO.TAX_REGIME_CODE                 = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND RegimeTLEO.TAX_REGIME_CODE              = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND ZxJurisdictionsVl.ZONE_GEOGRAPHY_ID     = HzGeographies.GEOGRAPHY_ID
	AND ZxJurisdictionsVl.TAX_REGIME_CODE       = TaxSettlementAuthorityEO.TAX_REGIME_CODE
	AND ZxJurisdictionsVl.TAX                   = TaxSettlementAuthorityEO.TAX
	AND ZxJurisdictionsVl.TAX_JURISDICTION_CODE = TaxSettlementAuthorityEO.TAX_JURISDICTION_CODE
	) QRSLT
WHERE QRSLT.REGIME_TYPE_FLAG <> 'I'
ORDER BY RES_TAX_JURISDICTION_CODE
,RES_COLLECTING_TAX_AUTHORITY