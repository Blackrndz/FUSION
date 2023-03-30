/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Applications Core Value Sets - Manage Applications Core Value Sets.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT TaxTLEO.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZFPOMV.PARTY_NAME RES_CONFIGURATION_OWNER
,TaxTLEO.TAX RES_TAX
,TaxTLEO.TAX_FULL_NAME RES_TAX_NAME
,(SELECT PartyPEO.PARTY_NAME
	FROM POZ_SUPPLIERS SupplierPEO
	,HZ_PARTIES PartyPEO
	WHERE SupplierPEO.PARTY_ID = PartyPEO.PARTY_ID
	AND SupplierPEO.VENDOR_ID  = TaxSettlementAuthorityEO.SUPPLIER_ID
	AND ROWNUM                 = 1
	) RES_COLLECTING_TAX_AUTHORITY
,TaxSettlementAuthorityEO.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_CODE
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V BU
	WHERE BU.BU_ID = TaxSettlementAuthorityEO.INTERNAL_ORGANIZATION_ID
	) RES_BUSINESS_UNIT
,(SELECT SupplierSiteDPEO.VENDOR_SITE_CODE
	FROM POZ_SUPPLIER_SITES_ALL_M SupplierSiteDPEO
	,POZ_SITE_ASSIGNMENTS_ALL_M SupplierSiteAssignmentDPEO
	,FUN_ALL_BUSINESS_UNITS_V BusinessUnit
	WHERE SupplierSiteDPEO.VENDOR_SITE_ID                    = SupplierSiteAssignmentDPEO.VENDOR_SITE_ID
	AND TaxSettlementAuthorityEO.SUPP_SITE_USG_ASSIGNMENT_ID = SupplierSiteAssignmentDPEO.VENDOR_SITE_ID
	AND BusinessUnit.BU_ID                                   = TaxSettlementAuthorityEO.INTERNAL_ORGANIZATION_ID
	AND BusinessUnit.BU_ID                                   = SupplierSiteAssignmentDPEO.BU_ID
	AND ROWNUM                                               = 1
	) RES_COLLECTING_TAX_AUTHORITY_S
,TO_CHAR(TaxSettlementAuthorityEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(Extract(YEAR FROM TaxSettlementAuthorityEO.EFFECTIVE_END_DATE),'4712',NULL,TO_CHAR(TaxSettlementAuthorityEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,TaxTLEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TaxTLEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TaxTLEO.CREATED_BY RSC_CREATED_BY
,TaxTLEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE 
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'OU' THEN	
		ZFPOMV.BU_ID
	ELSE
		NULL
	END) RSC_BUSINESS_UNIT_ID
,(CASE 
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN	
		ZFPOMV.LEGAL_ENTITY_ID
	ELSE
		NULL
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_TAXES_VL TaxTLEO
,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
,ZX_REGIMES_VL RegimeTLEO
,ZX_TAX_SETTLEMENT_AUTHS_F TaxSettlementAuthorityEO
WHERE ZFPOMV.PARTY_TAX_PROFILE_ID                = TaxTLEO.CONTENT_OWNER_ID
AND RegimeTLEO.TAX_REGIME_CODE                   = TaxTLEO.TAX_REGIME_CODE
AND TaxTLEO.TAX_REGIME_CODE       = TaxSettlementAuthorityEO.TAX_REGIME_CODE
AND TaxTLEO.TAX                   = TaxSettlementAuthorityEO.TAX
AND NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') <> 'I'