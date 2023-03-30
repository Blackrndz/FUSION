/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT XleEntityProfiles.NAME RES_LEGAL_ENTITY
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'ZX_SUBSCRIPTION_OPTION'
	AND LOOKUP_CODE   = ZxSubscriptionOptions.SUBSCRIPTION_OPTION_CODE
	) RES_CONFIGURATION_FOR_TAXES_AN
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'ZX_SUBSCRIPTION_OPTION'
	AND LOOKUP_CODE   = ZxSubscriptionOptions.EXCEPTION_OPTION_CODE
	) RES_CONFIGURATION_FOR_PRODUCT_
,(SELECT fpo.party_name
	FROM zx_subscription_details det
	,zx_first_party_orgs_moac_v fpo
	WHERE fpo.PARTY_TAX_PROFILE_ID = det.first_pty_org_id
	AND det.first_pty_org_id       = ZxSubscriptionOptions.PARENT_FIRST_PTY_ORG_ID
	AND det.VIEW_OPTIONS_CODE      = 'VFC'
	AND det.first_pty_org_id      <> - 99
	AND rownum                    <= 1
	) RES_PARENT_FIRST_PARTY_ORGANIZ
,TO_CHAR(ZxSubscriptionOptions.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(ZxSubscriptionOptions.EFFECTIVE_To,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,DECODE(ZxSubscriptionOptions.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,ZxRegimes.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZxRegimes.TAX_REGIME_NAME RES_TAX_REGIME_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'ZX_INDIRECT_TAX_OR_WHT'
	AND LOOKUP_CODE   = NVL(zxRegimes.REGIME_TYPE_FLAG,'I')
	) RES_REGIME_TYPE
,(SELECT ter.territory_short_name
	FROM fnd_territories_vl ter
	WHERE ter.territory_code = zxRegimes.country_code
	) RES_COUNTRY
,zxRegimes.geography_type RES_TAX_GEOGRAPHY_TYPE
,(SELECT geography_name
	FROM hz_geographies hzGeo
	WHERE hzGeo.geography_id = zxRegimes.geography_id
	) RES_TAX_GEOGRAPHY_NAME
,ZxSubscriptionOptions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxSubscriptionOptions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxSubscriptionOptions.CREATED_BY RSC_CREATED_BY
,ZxSubscriptionOptions.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,XleEntityProfiles.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLE_REGISTRATIONS XleRegistrations
,XLE_ENTITY_PROFILES XleEntityProfiles
,ZX_PARTY_TAX_PROFILE LegalEntityTaxProfileEO
,XLE_LOCATIONS_V LocationDPEO
,ZX_SUBSCRIPTION_OPTIONS ZxSubscriptionOptions
,ZX_REGIMES_USAGES ZxRegimesUsages
,ZX_REGIMES_VL ZxRegimes
WHERE XleEntityProfiles.legal_entity_id = XleRegistrations.source_id
AND XleRegistrations.source_table       = 'XLE_ENTITY_PROFILES'
AND XleRegistrations.identifying_flag   = 'Y'
AND XleEntityProfiles.PARTY_ID          = LegalEntityTaxProfileEO.PARTY_ID
AND xleregistrations.location_id        = locationdpeo.location_id
AND ZxRegimesUsages.Regime_usage_id     = ZxSubscriptionOptions.Regime_usage_id
AND LegalEntityTaxProfileEO.PARTY_TAX_PROFILE_ID            = ZxRegimesUsages.FIRST_PTY_ORG_ID
AND ZxRegimes.tax_regime_code           = ZxRegimesUsages.Tax_regime_code
ORDER BY UPPER(XleEntityProfiles.NAME)
,RES_CONFIGURATION_FOR_TAXES_AN