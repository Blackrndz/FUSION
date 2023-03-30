/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT hzparty.party_name RES_TAX_PARTNER_NAME
,PTY.PARTY_NAME RES_PARTY_NAME
,PTY.PARTY_TYPE RES_PARTY_TYPE
,ZxRegimesUsages.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZxRegimes.TAX_REGIME_NAME RES_TAX_REGIME_NAME
,TerritoriesE0.TERRITORY_SHORT_NAME RES_COUNTRY
,lookup.MEANING RES_BUSINESS_PROCESS_FLOW
,TO_CHAR(ZxSrvcSubscriptions.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(ZxSrvcSubscriptions.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,DECODE(ZxSrvcSubscriptions.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,ZxSrvcSubscriptions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxSrvcSubscriptions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxSrvcSubscriptions.CREATED_BY RSC_CREATED_BY
,ZxSrvcSubscriptions.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE ptp
,HZ_PARTIES hzparty
,ZX_SRVC_SUBSCRIPTIONS ZxSrvcSubscriptions
,ZX_REGIMES_USAGES ZxRegimesUsages
,(SELECT ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
	,FBU.BU_ID   AS PARTY_ID
	,FBU.BU_NAME AS PARTY_NAME
	,ZxPartyTaxProfile.PARTY_TYPE_CODE
	,lkupPtp.Meaning AS PARTY_TYPE
	,FBU.BU_ID       AS bu_id
	FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
	,FUN_ALL_BUSINESS_UNITS_V FBU
	,FND_LOOKUPS lkupPtp
	WHERE FBU.BU_ID                       = ZxPartyTaxProfile.PARTY_ID
	AND ZxPartyTaxProfile.PARTY_TYPE_CODE = 'OU'
	AND lkupPtp.Lookup_type               = 'ZX_PTP_PARTY_TYPE'
	AND lkupPtp.Lookup_code               = ZxPartyTaxProfile.PARTY_TYPE_CODE
	UNION ALL
	SELECT ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
	,XLEP.PARTY_ID
	,XLEP.NAME AS PARTY_NAME
	,ZxPartyTaxProfile.PARTY_TYPE_CODE
	,lkupPtp.Meaning AS PARTY_TYPE
	, - 9999         AS bu_id
	FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
	,HZ_PARTIES HZP
	,XLE_ENTITY_PROFILES XLEP
	,FND_LOOKUPS lkupPtp
	WHERE HZP.PARTY_ID                    = ZxPartyTaxProfile.PARTY_ID
	AND ZxPartyTaxProfile.PARTY_TYPE_CODE = 'FIRST_PARTY'
	AND HZP.PARTY_ID                      = XLEP.PARTY_ID
	AND lkupPtp.Lookup_type               = 'ZX_PTP_PARTY_TYPE'
	AND lkupPtp.Lookup_code               = ZxPartyTaxProfile.PARTY_TYPE_CODE
	) pty
,ZX_REGIMES_VL ZxRegimes
,FND_TERRITORIES_VL TerritoriesE0
,fnd_lookups lookup
WHERE ptp.party_type_code               = 'TAX_PARTNER'
AND ptp.PARTY_ID                        = hzparty.PARTY_ID
AND ptp.PARTY_TAX_PROFILE_ID            = ZxSrvcSubscriptions.SRVC_PROVIDER_ID
AND ZxSrvcSubscriptions.REGIME_USAGE_ID = ZxRegimesUsages.REGIME_USAGE_ID
AND ZxRegimesUsages.FIRST_PTY_ORG_ID    = PTY.PARTY_TAX_PROFILE_ID
AND ZxRegimesUsages.Regime_usage_id     = ZxSrvcSubscriptions.Regime_usage_id
AND ZxRegimes.tax_regime_code           = ZxRegimesUsages.Tax_regime_code
AND TerritoriesE0.TERRITORY_CODE(+)     = ZxRegimes.COUNTRY_CODE
AND lookup.lookup_type (+)              = 'ZX_PRODUCT_FAMILY_GROUP'
AND lookup.lookup_code (+)              = ZxSrvcSubscriptions.PROD_FAMILY_GRP_CODE
ORDER BY hzparty.party_name
,PTY.PARTY_TYPE
,PTY.PARTY_NAME