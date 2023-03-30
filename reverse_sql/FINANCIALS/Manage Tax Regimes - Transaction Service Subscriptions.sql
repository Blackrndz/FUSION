/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Regimes%20-%20Transaction%20Service%20Subscriptions.sql $:
 * $Id: Manage Tax Regimes - Transaction Service Subscriptions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT QRSLT.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,QRSLT.TAX_REGIME_NAME RES_TAX_REGIME_NAME
,QRSLT.PARTY_NAME RES_PARTY_NAME
,QRSLT.PARTY_TYPE RES_PARTY_TYPE
,QRSLT.REGIME_COUNTRY RES_COUNTRY
,ServiceProvider.LOOKUP_CODE RES_SERVICE_PROVIDER_NAME
,ServiceProvider.PARTY_NAME RES_SERVICE_PROVIDER_CODE
,ServiceProvider.MEANING RES_SERVICE_PROVIDER_TYPE
,QRSLT.PROD_FAMILY_GRP_CODE_view RES_BUSINESS_PROCESS_FLOW
,TO_CHAR(QRSLT.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(QRSLT.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,DECODE(QRSLT.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(
	CASE
		WHEN QRSLT.PARTY_TYPE_CODE = 'OU'
		THEN QRSLT.FILTER_ID
		ELSE NULL
	END) RSC_BUSINESS_UNIT_ID
,(
	CASE
		WHEN QRSLT.PARTY_TYPE_CODE = 'FIRST_PARTY'
		THEN QRSLT.FILTER_ID
		ELSE NULL
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ZxSrvcSubscriptions.EFFECTIVE_FROM
	,ZxSrvcSubscriptions.EFFECTIVE_TO
	,ZxSrvcSubscriptions.ENABLED_FLAG
	,ZxSrvcSubscriptions.CREATION_DATE
	,ZxSrvcSubscriptions.CREATED_BY
	,ZxSrvcSubscriptions.LAST_UPDATE_DATE
	,ZxSrvcSubscriptions.LAST_UPDATED_BY
	,pty.party_name party_name
	,(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE Lookup_type = 'ZX_PTP_PARTY_TYPE'
		AND lookup_code   = pty.party_type_code
		)                               AS party_type
	,zxRegimesUsages.tax_regime_code AS tax_regime_code
	,zxRegimes.tax_regime_name       AS tax_regime_name
	,ter.territory_short_name regime_country
	,lookup.meaning PROD_FAMILY_GRP_CODE_view
	,NVL(zxRegimes.REGIME_TYPE_FLAG,'I') AS REGIME_TYPE_FLAG
	,srvcPtp.party_id
	,pty.PARTY_TYPE_CODE
	,BU_LE_FILTER.party_id FILTER_ID
	FROM ZX_SRVC_SUBSCRIPTIONS ZxSrvcSubscriptions
	,zx_regimes_usages zxRegimesUsages
	,zx_regimes_vl zxRegimes
	,zx_first_party_orgs_all_v pty
	,fnd_territories_vl ter
	,fnd_lookups lookup
	,fnd_lookups srvcPvr
	,zx_party_tax_profile srvcPtp
	,zx_party_tax_profile BU_LE_FILTER
	WHERE zxRegimesUsages.regime_usage_id (+) = ZxSrvcSubscriptions.REGIME_USAGE_ID
	AND pty.party_tax_profile_id (+)          = zxRegimesUsages.FIRST_PTY_ORG_ID
	AND zxRegimesUsages.tax_regime_id         = zxRegimes.tax_regime_id
	AND ter.territory_code(+)                 = pty.country_code
	AND lookup.lookup_code (+)                = ZxSrvcSubscriptions.PROD_FAMILY_GRP_CODE
	AND srvcPtp.party_tax_profile_id          = ZxSrvcSubscriptions.SRVC_PROVIDER_ID
	AND srvcPtp.party_type_code               = 'TAX_PARTNER'
	AND srvcPtp.provider_type_code           IN('SERVICES','BOTH')
	AND srvcPvr.lookup_code (+)               = srvcPtp.provider_type_code
	AND lookup.lookup_type (+)                = 'ZX_PRODUCT_FAMILY_GROUP'
	AND srvcPvr.lookup_type (+)               = 'ZX_PROVIDER_TYPE'
	AND zxRegimesUsages.FIRST_PTY_ORG_ID      = BU_LE_FILTER.party_tax_profile_id(+)
	ORDER BY tax_regime_code
	) QRSLT
,(SELECT pty.PARTY_ID
	,party_name
	,party_tax_profile_id
	,lookup.meaning
	,lookup2.lookup_code
	FROM zx_party_tax_profile ptp
	,hz_parties pty
	,fnd_lookups lookup
	,fnd_lookups lookup2
	WHERE ptp.party_id          = pty.party_id
	AND ptp.party_type_code     = 'TAX_PARTNER'
	AND ptp.provider_type_code IN('SERVICES','BOTH')
	AND lookup.lookup_code      = ptp.provider_type_code
	AND lookup.lookup_type      = 'ZX_PROVIDER_TYPE'
	AND lookup2.meaning         = pty.party_name
	AND lookup2.lookup_type     = 'HZ_GEO_DATA_PROVIDER'
	AND TRUNC(SYSDATE) BETWEEN lookup.start_date_active AND NVL(lookup.end_date_active,TRUNC(SYSDATE))
	AND NVL(lookup.enabled_flag,'N') = 'Y'
	) ServiceProvider
WHERE QRSLT.PARTY_ID = ServiceProvider.PARTY_ID(+)
ORDER BY QRSLT.TAX_REGIME_CODE
,QRSLT.PARTY_NAME