/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT
	(SELECT PartyPEO.PARTY_NAME
	FROM HZ_PARTIES PartyPEO
	WHERE ZxPartyTaxProfile.PARTY_ID = PartyPEO.PARTY_ID
	AND rownum                       = 1
	) RES_PARTY_NAME
,(SELECT PartyPEO.PARTY_NUMBER
	FROM HZ_PARTIES PartyPEO
	WHERE ZxPartyTaxProfile.PARTY_ID = PartyPEO.PARTY_ID
	AND rownum                       = 1
	) RES_PARTY_NUMBER
,(SELECT
		CASE
			WHEN ptp.supplier_flag = 'Y'
			AND(ptp.customer_flag  = 'N'
			OR ptp.customer_flag  IS NULL)
			THEN 'SUPPLIER'
			WHEN ptp.customer_flag = 'Y'
			AND(ptp.supplier_flag  = 'N'
			OR ptp.supplier_flag  IS NULL)
			THEN 'CUSTOMER'
			WHEN ptp.customer_flag = 'Y'
			AND ptp.supplier_flag  = 'Y'
			THEN 'SUPPLIER,CUSTOMER'
		END
		CASE
			FROM zx_party_tax_profile PTP
			WHERE PTP.PARTY_TAX_PROFILE_ID = ZxExemptions.PARTY_TAX_PROFILE_ID
	) RES_PARTY_USAGE
,(SELECT HzParties.ADDRESS1||','|| HzParties.ADDRESS2||','|| HzParties.ADDRESS3||','|| HzParties.CITY||','||
		HzParties.postal_code||','||
		(SELECT TerritoriesPEO.TERRITORY_SHORT_NAME
		FROM FND_TERRITORIES_VL TerritoriesPEO
		WHERE HzParties.Country = TerritoriesPEO.TERRITORY_CODE
		)
	FROM HZ_PARTIES HzParties
	WHERE ZxPartyTaxProfile.PARTY_ID = HzParties.PARTY_ID
	AND rownum                       = 1
	) RES_ADDRESS
,(SELECT TerritoriesPEO.TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL TerritoriesPEO
	,HZ_PARTIES HzParties
	WHERE HzParties.Country        = TerritoriesPEO.TERRITORY_CODE
	AND ZxPartyTaxProfile.PARTY_ID = HzParties.PARTY_ID
	AND rownum                     = 1
	) RES_COUNTRY
,ZxExemptions.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZFPOMV.PARTY_NAME RES_CONFIGURATION_OWNER
,ZxExemptions.TAX RES_TAX
,ZxExemptions.TAX_STATUS_CODE RES_TAX_STATUS_CODE
,ZxExemptions.TAX_RATE_CODE RES_TAX_RATE_CODE
,JurisdictionEO.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_CODE
,OOD.ORGANIZATION_CODE RES_ORGANIZATION
,ItemVL.ITEM_NUMBER RES_ITEM
,TO_CHAR(ZxExemptions.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ZxExemptions.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,RegimesVL.TAX_REGIME_NAME RES_TAX_REGIME_NAME
,(SELECT tax_full_name
	FROM zx_taxes_vl taxes
	WHERE taxes.tax_regime_code = ZxExemptions.tax_regime_code
	AND taxes.tax               = ZxExemptions.tax
	AND rownum                  = 1
	) RES_TAX_NAME
,(SELECT tax_status_name
	FROM zx_status_vl status
	WHERE status.tax_regime_code = ZxExemptions.tax_regime_code
	AND status.tax               = ZxExemptions.tax
	AND status.tax_status_code   = ZxExemptions.tax_status_code
	AND rownum                   = 1
	) RES_TAX_STATUS_NAME
,(SELECT tax_rate_name
	FROM zx_rates_vl rates
	WHERE rates.tax_regime_code = ZxExemptions.tax_regime_code
	AND rates.tax               = ZxExemptions.tax
	AND rates.tax_status_code   = ZxExemptions.tax_status_code
	AND rates.tax_rate_code     = ZxExemptions.tax_rate_code
	AND rownum                  = 1
	) RES_TAX_RATE_NAME
,JurisTL.TAX_JURISDICTION_NAME RES_TAX_JURISDICTION_NAME
,OOD.ORGANIZATION_NAME RES_INVENTORY_ORGANIZATION
,ItemVL.DESCRIPTION RES_ITEM_DESCRIPTION
,ZxExemptions.EXEMPT_CERTIFICATE_NUMBER RES_CERTIFICATE_NUMBER
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE LANGUAGE = USERENV('LANG') 
	AND lookup_type = 'ZX_EXEMPTION_TYPE'
	AND lookup_code   = ZxExemptions.EXEMPTION_TYPE_CODE
	) RES_EXEMPTION_RATE_TYPE
,ZxExemptions.RATE_MODIFIER RES_EXEMPTION_PERCENTAGE
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE LANGUAGE = USERENV('LANG') 
	AND lookup_type = 'ZX_EXEMPTION_STATUS'
	AND lookup_code   = ZxExemptions.EXEMPTION_STATUS_CODE
	) RES_EXEMPT_STATUS
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE LANGUAGE = USERENV('LANG') 
	AND lookup_type = 'ZX_EXEMPTION_REASON_CODE'
	AND lookup_code   = ZxExemptions.EXEMPT_REASON_CODE
	) RES_EXEMPT_REASON
,IssTaxAuthorities.PARTY_NAME RES_ISSUING_TAX_AUTHORITY
,ZxExemptions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxExemptions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxExemptions.CREATED_BY RSC_CREATED_BY
,ZxExemptions.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'OU' THEN
		ZFPOMV.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN
		ZFPOMV.LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_EXEMPTIONS ZxExemptions
,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
,ZX_JURISDICTIONS_B JurisdictionEO
,HZ_PARTIES IssTaxAuthorities
,ZX_PARTY_TAX_PROFILE PTPIssTaxAuth
,INV_ORGANIZATION_DEFINITIONS_V OOD
,EGP_SYSTEM_ITEMS_VL ItemVL
,zx_regimes_vl RegimesVL
,zx_jurisdictions_vl JurisTL
,ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
WHERE ZFPOMV.PARTY_TAX_PROFILE_ID         = ZxExemptions.CONTENT_OWNER_ID
AND ZxExemptions.PARTY_TAX_PROFILE_ID     = ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
AND ZxExemptions.TAX_JURISDICTION_ID      = JurisdictionEO.TAX_JURISDICTION_ID (+)
AND ZxExemptions.ISSUING_TAX_AUTHORITY_ID = PTPIssTaxAuth.PARTY_TAX_PROFILE_ID (+)
AND PTPIssTaxAuth.PARTY_ID                = IssTaxAuthorities.PARTY_ID (+)
AND ZxExemptions.INVENTORY_ORG_ID         = OOD.ORGANIZATION_ID (+)
AND ZxExemptions.PRODUCT_ID               = ItemVL.INVENTORY_ITEM_ID (+)
AND ZxExemptions.INVENTORY_ORG_ID         = ItemVL.ORGANIZATION_ID (+)
AND JurisdictionEO.TAX_JURISDICTION_ID    = JurisTL.TAX_JURISDICTION_ID (+)
AND ZxExemptions.TAX_REGIME_CODE          = RegimesVL.TAX_REGIME_CODE (+)
AND ZxExemptions.RECORD_TYPE_CODE        IN('USER_DEFINED','MIGRATED')
AND REGIME_TYPE_FLAG                      = 'W'
AND ZxPartyTaxProfile.PARTY_TYPE_CODE     = 'THIRD_PARTY'
ORDER BY RES_PARTY_NAME
,RES_TAX_REGIME_CODE