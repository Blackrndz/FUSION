/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT FinancialsBusinessUnitPEO.BU_NAME RES_BUSINESS_UNIT
,zxRegimesUsages.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,zxRegimes.TAX_REGIME_NAME RES_TAX_REGIME_NAME
,(SELECT DISTINCT ter.territory_short_name
	FROM zx_first_party_orgs_all_v pty
	,fnd_territories_vl ter
	WHERE pty.party_tax_profile_id = ZxRegimesUsages.FIRST_PTY_ORG_ID
	AND pty.country_code           = ter.territory_code
	) RES_COUNTRY
,zxRegimes.geography_type RES_TAX_GEOGRAPHY_TYPE
,(SELECT geography_name
	FROM hz_geographies hzGeo
	WHERE hzGeo.geography_id = zxRegimes.geography_id
	) RES_TAX_GEOGRAPHY_NAME
,srvcPty.party_name RES_SERVICE_PROVIDER
,lookup.meaning RES_BUSINESS_PROCESS_FLOW
,TO_CHAR(ZxSrvcSubscriptions.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(ZxSrvcSubscriptions.EFFECTIVE_To,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,DECODE(ZxSrvcSubscriptions.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,ZxSrvcSubscriptions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxSrvcSubscriptions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxSrvcSubscriptions.CREATED_BY RSC_CREATED_BY
,ZxSrvcSubscriptions.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,FinancialsBusinessUnitPEO.BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE BusinessUnitTaxProfileEO
,FUN_ALL_BUSINESS_UNITS_V FinancialsBusinessUnitPEO
,ZX_SRVC_SUBSCRIPTIONS ZxSrvcSubscriptions
,ZX_REGIMES_USAGES ZxRegimesUsages
,ZX_FIRST_PARTY_ORGS_MOAC_V PTY
,ZX_REGIMES_VL ZxRegimes
,zx_party_tax_profile srvcPtp
,hz_parties srvcpty
,fnd_lookups lookup
WHERE BusinessUnitTaxProfileEO.PARTY_ID = FinancialsBusinessUnitPEO.BU_ID
AND ZxRegimesUsages.Regime_usage_id     = ZxSrvcSubscriptions.Regime_usage_id
AND PTY.PARTY_TAX_PROFILE_ID            = ZxRegimesUsages.FIRST_PTY_ORG_ID
AND PTY.BU_ID                           = FinancialsBusinessUnitPEO.BU_ID
AND ZxRegimes.tax_regime_code           = ZxRegimesUsages.Tax_regime_code
AND srvcPtp.party_tax_profile_id        = ZxSrvcSubscriptions.SRVC_PROVIDER_ID
AND srvcPtp.party_type_code             = 'TAX_PARTNER'
AND srvcPtp.provider_type_code         IN('SERVICES','BOTH')
AND srvcPty.party_id                    = srvcPtp.party_id
AND lookup.lookup_type (+)              = 'ZX_PRODUCT_FAMILY_GROUP'
AND lookup.lookup_code (+)              = ZxSrvcSubscriptions.PROD_FAMILY_GRP_CODE
ORDER BY FinancialsBusinessUnitPEO.BU_NAME
,zxRegimesUsages.TAX_REGIME_CODE
,ZxSrvcSubscriptions.EFFECTIVE_FROM