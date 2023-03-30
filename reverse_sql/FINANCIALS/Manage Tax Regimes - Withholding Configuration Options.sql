/* ****************************************************************************
 * $Revision: 59216 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-10-27 17:36:29 +0700 (Thu, 27 Oct 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Regimes%20-%20Transaction%20Tax%20Regimes.sql $:
 * $Id: Manage Tax Regimes - Transaction Tax Regimes.sql 59216 2016-10-27 10:36:29Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ZxRegimesVl.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZxRegimesVl.TAX_REGIME_NAME RES_TAX_REGIME_NAME
,PTY.PARTY_NAME RES_PARTY_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_PTP_PARTY_TYPE'
	AND LOOKUP_CODE   = PTY.PARTY_TYPE_CODE
	) RES_PARTY_TYPE
,(SELECT TER.TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL TER
	WHERE PTY.COUNTRY_CODE = TER.TERRITORY_CODE
	) RES_COUNTRY
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'ZX_SUBSCRIPTION_OPTION'
	AND LOOKUP_CODE   = ZxSubscriptionOptions.SUBSCRIPTION_OPTION_CODE
	) AS RES_CONFIGURATION_FOR_TAXES_AN
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'ZX_SUBSCRIPTION_OPTION'
	AND LOOKUP_CODE   = ZxSubscriptionOptions.EXCEPTION_OPTION_CODE
	) RES_CONFIGURATION_FOR_PRODUCT_
,(SELECT fpo.party_name
	FROM ZX_SUBSCRIPTION_DETAILS det
	,ZX_FIRST_PARTY_ORGS_MOAC_V fpo
	WHERE fpo.PARTY_TAX_PROFILE_ID = det.FIRST_PTY_ORG_ID
	AND det.FIRST_PTY_ORG_ID       = ZxSubscriptionOptions.PARENT_FIRST_PTY_ORG_ID
	AND det.VIEW_OPTIONS_CODE      = 'VFC'
	AND det.FIRST_PTY_ORG_ID      <> - 99
	AND rownum                    <= 1
	) RES_PARENT_FIRST_PARTY_ORGANIZ
,TO_CHAR(ZxSubscriptionOptions.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(ZxSubscriptionOptions.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,DECODE(ZxSubscriptionOptions.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,ZxRegimesUsages.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxRegimesUsages.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxRegimesUsages.CREATED_BY RSC_CREATED_BY
,ZxRegimesUsages.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_REGIMES_VL ZxRegimesVl
,ZX_REGIMES_USAGES ZxRegimesUsages
,ZX_FIRST_PARTY_ORGS_ALL_V PTY
,ZX_SUBSCRIPTION_OPTIONS ZxSubscriptionOptions
WHERE ZxRegimesVl.TAX_REGIME_ID            = ZxRegimesUsages.TAX_REGIME_ID
AND PTY.PARTY_TAX_PROFILE_ID               = ZxRegimesUsages.FIRST_PTY_ORG_ID
AND ZxRegimesUsages.Regime_usage_id        = ZxSubscriptionOptions.Regime_usage_id
AND NVL(ZxRegimesVl.REGIME_TYPE_FLAG,'I') <> 'I'
ORDER BY ZxRegimesVl.REGIME_TYPE_FLAG
,ZxRegimesVl.TAX_REGIME_CODE
,PTY.PARTY_NAME