/* ****************************************************************************
* $Revision: 78735 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-06-13 20:34:08 +0700 (Mon, 13 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Rates%20and%20Tax%20Recovery%20Rates%20-%20Transaction%20Tax%20Recovery%20Rate.sql $:
* $Id: Manage Tax Rates and Tax Recovery Rates - Transaction Tax Recovery Rate.sql 78735 2022-06-13 13:34:08Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT RES_TAX_REGIME_CODE
,RES_CONFIGURATION_OWNER
,RES_TAX
,RES_TAX_RECOVERY_RATE_CODE
,RES_RECOVERY_TYPE
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN PARTY_TYPE_CODE = 'OU' THEN
		BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN PARTY_TYPE_CODE = 'FIRST_PARTY' THEN
		LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
	
FROM (
SELECT DISTINCT ZxRatesVl.TAX_REGIME_CODE 					AS RES_TAX_REGIME_CODE
	,party.PARTY_NAME                           				AS RES_CONFIGURATION_OWNER
	,ZxRatesVl.TAX                								AS RES_TAX
	,ZxRatesVl.TAX_RATE_CODE      								AS RES_TAX_RECOVERY_RATE_CODE
	,ZxRatesVl.RECOVERY_TYPE_CODE 								AS RES_RECOVERY_TYPE
	,ZxRatesVl.LAST_UPDATED_BY 									AS RSC_LAST_UPDATED_BY
	,ZxRatesVl.LAST_UPDATE_DATE 								AS RSC_LAST_UPDATE_DATE
	,ZxRatesVl.CREATED_BY 										AS RSC_CREATED_BY
	,ZxRatesVl.CREATION_DATE 									AS RSC_CREATION_DATE
	,ZxRatesVl.CONTENT_OWNER_ID RES_CONTENT_OWNER_ID
	,party.PARTY_TYPE_CODE
	,party.BU_ID
	,party.LEGAL_ENTITY_ID
	FROM ZX_RATES_VL ZxRatesVl
	,ZX_FIRST_PARTY_ORGS_MOAC_V party
	,ZX_REGIMES_VL RegimeTLEO
	,HZ_GEOGRAPHIES Regimes_HzGeographies
	,HZ_GEOGRAPHY_TYPES_VL Regimes_HzGeoTypes
	,FND_TERRITORIES_VL
	,ZX_MCO_CHECK_ACCESS_V ZMCAV
	,ZX_MCO_LV_TAXES_V Tax
	WHERE RegimeTLEO.TAX_REGIME_CODE         = ZxRatesVl.TAX_REGIME_CODE
	AND party.party_tax_profile_id           = ZxRatesVl.CONTENT_OWNER_ID
	AND ZxRatesVl.ACTIVE_FLAG                = 'Y'
	AND ZxRatesVl.RATE_TYPE_CODE = 'RECOVERY'
	AND UPPER(NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I')) = UPPER('I')  
	AND FND_TERRITORIES_VL.TERRITORY_CODE(+) = RegimeTLEO.COUNTRY_CODE
	AND RegimeTLEO.GEOGRAPHY_TYPE = Regimes_HzGeoTypes.GEOGRAPHY_TYPE(+)
	AND RegimeTLEO.GEOGRAPHY_ID = Regimes_HzGeographies.GEOGRAPHY_ID(+) 
	AND ZMCAV.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
	AND ZMCAV.PARENT_FIRST_PTY_ORG_ID = ZxRatesVl.CONTENT_OWNER_ID
	AND Tax.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
	AND Tax.TAX = ZxRatesVl.TAX
	AND Tax.CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
	)
ORDER BY (SELECT DECODE(TAX_TYPE_CODE,'OFFSET',1,2) 
	FROM ZX_TAXES_VL 
	WHERE TAX = RES_TAX
	AND CONTENT_OWNER_ID = RES_CONTENT_OWNER_ID
	AND TAX_REGIME_CODE = RES_TAX_REGIME_CODE
	)
,RES_TAX_REGIME_CODE
,RES_TAX_RECOVERY_RATE_CODE