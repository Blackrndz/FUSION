/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 --RSC_PREREQUISITE_OBJECTS=ZX_PARTY_TAX_PROFILE

SELECT XleEntityProfiles.NAME RES_LEGAL_ENTITY
,XleEntityProfiles.LEGAL_ENTITY_IDENTIFIER RES_LEGAL_ENTITY_IDENTIFIER
,LocationDPEO.ADDRESS_LINE_1||','||LocationDPEO.ADDRESS_LINE_2||','||LocationDPEO.ADDRESS_LINE_3||','||
	LocationDPEO.TOWN_OR_CITY||',' ||DECODE(region_2,NULL,region_3,region_2) ||','||LocationDPEO.postal_code||','||
	TerritoryPEO.TERRITORY_SHORT_NAME RES_ADDRESS
,TerritoryPEO.TERRITORY_SHORT_NAME RES_COUNTRY
,XleEntityProfiles.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,XleEntityProfiles.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,XleEntityProfiles.CREATED_BY RSC_CREATED_BY
,XleEntityProfiles.CREATION_DATE RSC_CREATION_DATE
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
,FND_TERRITORIES_VL TerritoryPEO
,XLE_LOCATIONS_V LocationDPEO
WHERE xleentityprofiles.legal_entity_id = xleregistrations.source_id
AND xleregistrations.source_table       = 'XLE_ENTITY_PROFILES'
AND xleregistrations.identifying_flag   = 'Y'
AND XleEntityProfiles.PARTY_ID          = LegalEntityTaxProfileEO.PARTY_ID
AND xleregistrations.location_id        = locationdpeo.location_id
AND territorypeo.territory_code         = locationdpeo.country
AND (EXISTS (SELECT 1 
		FROM ZX_REPORT_CODES_ASSOC 
		WHERE ENTITY_ID = LegalEntityTaxProfileEO.PARTY_TAX_PROFILE_ID)
	OR EXISTS (SELECT 1 
		FROM HZ_CODE_ASSIGNMENTS 
		WHERE OWNER_TABLE_NAME = 'ZX_PARTY_TAX_PROFILE'
		AND OWNER_TABLE_ID = LegalEntityTaxProfileEO.PARTY_TAX_PROFILE_ID)
	OR EXISTS (SELECT 1 
		FROM ZX_SUBSCRIPTION_OPTIONS ZxSubscriptionOptions
		,ZX_REGIMES_USAGES ZxRegimesUsages
		,ZX_REGIMES_VL ZxRegimes
		WHERE ZxRegimesUsages.Regime_usage_id = ZxSubscriptionOptions.Regime_usage_id
		AND ZxRegimes.tax_regime_code = ZxRegimesUsages.Tax_regime_code
		AND ZxRegimesUsages.FIRST_PTY_ORG_ID = LegalEntityTaxProfileEO.PARTY_TAX_PROFILE_ID)
	OR EXISTS (SELECT 1 
		FROM ZX_SRVC_SUBSCRIPTIONS ZxSrvcSubscriptions
		,ZX_REGIMES_USAGES ZxRegimesUsages
		,ZX_REGIMES_VL ZxRegimes
		WHERE ZxRegimesUsages.Regime_usage_id = ZxSrvcSubscriptions.Regime_usage_id
		AND ZxRegimes.tax_regime_code = ZxRegimesUsages.Tax_regime_code
		AND ZxRegimesUsages.FIRST_PTY_ORG_ID = LegalEntityTaxProfileEO.PARTY_TAX_PROFILE_ID)
	OR (LegalEntityTaxProfileEO.TAX_GROSS_NET_FLAG IS NOT NULL
		OR LegalEntityTaxProfileEO.ROUNDING_LEVEL_CODE IS NOT NULL
		OR LegalEntityTaxProfileEO.ROUNDING_RULE_CODE IS NOT NULL
		OR LegalEntityTaxProfileEO.INCLUSIVE_TAX_FLAG IS NOT NULL))
ORDER BY UPPER(XleEntityProfiles.NAME)