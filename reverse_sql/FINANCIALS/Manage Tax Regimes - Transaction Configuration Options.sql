/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Regimes%20-%20Transaction%20Configuration%20Options.sql $:
 * $Id: Manage Tax Regimes - Transaction Configuration Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT QRSLT.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,QRSLT.TAX_REGIME_NAME RES_TAX_REGIME_NAME
,QRSLT.PARTY_NAME RES_PARTY_NAME
,QRSLT.PARTY_TYPE RES_PARTY_TYPE
,QRSLT.COUNTRY_CODE RES_COUNTRY
,QRSLT.SUBS_OPTION_CODE_VIEW RES_CONFIGURATION_FOR_TAXES_AN
,QRSLT.EXCPTN_OPTION_CODE_VIEW RES_CONFIGURATION_FOR_PRODUCT_
,QRSLT.PARENT_FIRST_PTY_ORG RES_PARENT_FIRST_PARTY_ORGANIZ
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
	(SELECT ZxSubscriptionOptions.CREATED_BY
	,ZxSubscriptionOptions.CREATION_DATE
	,ZxSubscriptionOptions.EFFECTIVE_FROM
	,ZxSubscriptionOptions.EFFECTIVE_TO
	,ZxSubscriptionOptions.ENABLED_FLAG
	,ZxSubscriptionOptions.LAST_UPDATE_DATE
	,ZxSubscriptionOptions.LAST_UPDATE_LOGIN
	,ZxSubscriptionOptions.LAST_UPDATED_BY
	,pty.party_name
	,pty.party_type_code
	,(SELECT MEANING
		FROM FND_LOOKUPS
		WHERE Lookup_type = 'ZX_PTP_PARTY_TYPE'
		AND lookup_code   = pty.party_type_code
		) AS party_type
	,(SELECT ter.territory_short_name
		FROM fnd_territories_vl ter
		WHERE pty.country_code = ter.territory_code
		) country_code
	,(SELECT fpo.party_name
		FROM zx_subscription_details det
		,zx_first_party_orgs_moac_v fpo
		WHERE fpo.PARTY_TAX_PROFILE_ID = det.first_pty_org_id
		AND det.first_pty_org_id       = ZxSubscriptionOptions.PARENT_FIRST_PTY_ORG_ID
		AND det.VIEW_OPTIONS_CODE      = 'VFC'
		AND det.first_pty_org_id      <> - 99
		AND rownum                    <= 1
		) parent_first_pty_org
	,zxRegimes.Tax_Regime_code AS Tax_regime_code
	,zxRegimes.Tax_Regime_name AS Tax_regime_name
	,(SELECT MEANING
		FROM FND_LOOKUP_VALUES_VL
		WHERE LOOKUP_TYPE = 'ZX_SUBSCRIPTION_OPTION'
		AND LOOKUP_CODE   = ZxSubscriptionOptions.SUBSCRIPTION_OPTION_CODE
		) AS SUBS_OPTION_CODE_VIEW
	,(SELECT MEANING
		FROM FND_LOOKUP_VALUES_VL
		WHERE LOOKUP_TYPE = 'ZX_SUBSCRIPTION_OPTION'
		AND LOOKUP_CODE   = ZxSubscriptionOptions.EXCEPTION_OPTION_CODE
		)   AS EXCPTN_OPTION_CODE_VIEW
	,(SELECT party_id
		FROM zx_party_tax_profile
		WHERE zxRegimesUsages.FIRST_PTY_ORG_ID = party_tax_profile_id
		) FILTER_ID
	FROM ZX_SUBSCRIPTION_OPTIONS ZxSubscriptionOptions
	,ZX_REGIMES_USAGES ZxRegimesUsages
	,zx_regimes_vl zxRegimes
	,zx_first_party_orgs_all_v pty
	WHERE ZxRegimesUsages.Regime_usage_id = ZxSubscriptionOptions.Regime_usage_id
	AND zxRegimes.tax_regime_code         = ZxRegimesUsages.Tax_regime_code
	AND pty.party_tax_profile_id(+)       = ZxRegimesUsages.FIRST_PTY_ORG_ID
	AND NVL(zxRegimes.REGIME_TYPE_FLAG,'I') = 'I'
	ORDER BY TAX_REGIME_CODE
	) QRSLT
ORDER BY QRSLT.TAX_REGIME_CODE
,QRSLT.PARTY_NAME