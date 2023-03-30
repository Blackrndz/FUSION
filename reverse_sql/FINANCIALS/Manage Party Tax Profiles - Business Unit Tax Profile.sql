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

SELECT FinancialsBusinessUnitPEO.BU_NAME RES_BUSINESS_UNIT
,LocationDPEO.ADDRESS_LINE_1||','||LocationDPEO.ADDRESS_LINE_2||','||LocationDPEO.ADDRESS_LINE_3||','||
	LocationDPEO.TOWN_OR_CITY||',' ||DECODE(region_2,NULL,region_3,region_2) ||','||LocationDPEO.postal_code||','||
	TerritoryPEO.TERRITORY_SHORT_NAME RES_ADDRESS
,TerritoryPEO.TERRITORY_SHORT_NAME RES_COUNTRY
,BusinessUnitTaxProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BusinessUnitTaxProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BusinessUnitTaxProfileEO.CREATED_BY RSC_CREATED_BY
,BusinessUnitTaxProfileEO.CREATION_DATE RSC_CREATION_DATE
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
,(SELECT *
	FROM HR_LOCATIONS_ALL_F_VL
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) LocationDPEO
,FND_TERRITORIES_VL TerritoryPEO
WHERE BusinessUnitTaxProfileEO.PARTY_ID = FinancialsBusinessUnitPEO.BU_ID
AND LocationDPEO.LOCATION_ID (+)        = FinancialsBusinessUnitPEO.LOCATION_ID
AND LocationDPEO.COUNTRY                = TerritoryPEO.TERRITORY_CODE(+)
AND (EXISTS (SELECT 1 
		FROM ZX_REPORT_CODES_ASSOC 
		WHERE ENTITY_ID = BusinessUnitTaxProfileEO.PARTY_TAX_PROFILE_ID)
	OR EXISTS (SELECT 1 
		FROM ZX_PRODUCT_OPTIONS_ALL 
		WHERE ORG_ID = FinancialsBusinessUnitPEO.BU_ID)
	OR (BusinessUnitTaxProfileEO.TAX_GROSS_NET_FLAG IS NOT NULL	
		OR BusinessUnitTaxProfileEO.USE_LE_AS_SUBSCRIBER_FLAG != 'N'
		OR BusinessUnitTaxProfileEO.WHT_USE_LE_AS_SUBSCRIBER_FLAG != 'N')
	OR EXISTS (SELECT 1 
		FROM ZX_SUBSCRIPTION_OPTIONS ZxSubscriptionOptions
		,ZX_REGIMES_USAGES ZxRegimesUsages
		,ZX_FIRST_PARTY_ORGS_MOAC_V PTY 
		WHERE ZxRegimesUsages.Regime_usage_id = ZxSubscriptionOptions.Regime_usage_id
		AND PTY.PARTY_TAX_PROFILE_ID = ZxRegimesUsages.FIRST_PTY_ORG_ID
		AND PTY.BU_ID = FinancialsBusinessUnitPEO.BU_ID)
	OR EXISTS (SELECT 1 
		FROM ZX_SRVC_SUBSCRIPTIONS ZxSrvcSubscriptions
		,ZX_REGIMES_USAGES ZxRegimesUsages
		,ZX_FIRST_PARTY_ORGS_MOAC_V PTY 
		WHERE ZxRegimesUsages.Regime_usage_id = ZxSrvcSubscriptions.Regime_usage_id
		AND PTY.PARTY_TAX_PROFILE_ID = ZxRegimesUsages.FIRST_PTY_ORG_ID
		AND PTY.BU_ID = FinancialsBusinessUnitPEO.BU_ID)
	)
ORDER BY FinancialsBusinessUnitPEO.BU_NAME