/* ****************************************************************************
* $Revision: 79209 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-08-11 16:09:45 +0700 (Thu, 11 Aug 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Rates%20and%20Tax%20Recovery%20Rates%20-%20Transaction%20Tax%20Rate.sql $:
* $Id: Manage Tax Rates and Tax Recovery Rates - Transaction Tax Rate.sql 79209 2022-08-11 09:09:45Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT ZxRatesVl.TAX_REGIME_CODE                   					RES_TAX_REGIME_CODE,
party.PARTY_NAME                                          						RES_CONFIGURATION_OWNER,
 ZxRatesVl.TAX                                                                 	RES_TAX,
(ZxRatesVl.tax_status_code)                               						RES_TAX_STATUS_CODE,
ZxRatesVl.tax_jurisdiction_code                          						RES_TAX_JURISDICTION_CODE,
ZxRatesVl.tax_rate_code                                   						RES_TAX_RATE_CODE,
NVL((select  LookupPEO.MEANING FROM FND_LOOKUPS LookupPEO
 WHERE  LookupPEO.LOOKUP_TYPE     = 'ZX_RATE_TYPE' 
 and    LookupPEO.LOOKUP_CODE  =  ZxRatesVl.rate_type_code),'No')               RES_TAX_RATE_TYPE,
(CASE WHEN ZxRatesVl.rate_type_code = 'UNIT_PRICE_SCHEDULE_RATE'
	THEN 'Yes'
	ELSE 'No' END) RES_APPLY_SINGLE_RATE_ON_TOTAL,
NVL((select  Max(Decode(FndLookup.LOOKUP_TYPE,'ZX_OUTPUT_CLASSIFICATIONS','Yes','No'))
 FROM FND_LOOKUP_VALUES_VL FndLookup
 WHERE  FndLookup.LOOKUP_CODE = ZXRatesVl.tax_rate_code 
 AND FndLookup.LOOKUP_TYPE = 'ZX_OUTPUT_CLASSIFICATIONS' ),'No')      				RES_ORDER_TO_CASH,
NVL((select  Max(Decode(FndLookup.LOOKUP_TYPE,'ZX_INPUT_CLASSIFICATIONS','Yes','No'))
 FROM FND_LOOKUP_VALUES_VL FndLookup
 WHERE  FndLookup.LOOKUP_CODE = ZXRatesVl.tax_rate_code 
 AND FndLookup.LOOKUP_TYPE = 'ZX_INPUT_CLASSIFICATIONS'  ),'No')      				RES_PROCURE_TO_PAY,
(select Max(Decode(FndLookup.LOOKUP_TYPE,'ZX_WEB_EXP_TAX_CLASSIFICATIONS','Yes','No'))
 FROM FND_LOOKUP_VALUES_VL FndLookup
 WHERE  FndLookup.LOOKUP_CODE = ZXRatesVl.tax_rate_code 
 AND FndLookup.LOOKUP_TYPE = 'ZX_WEB_EXP_TAX_CLASSIFICATIONS'  )       			RES_EXPENSES
,ZxRatesVl.LAST_UPDATED_BY 														RSC_LAST_UPDATED_BY
,ZxRatesVl.LAST_UPDATE_DATE 													RSC_LAST_UPDATE_DATE
,ZxRatesVl.CREATED_BY 															RSC_CREATED_BY
,ZxRatesVl.CREATION_DATE 														RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN party.PARTY_TYPE_CODE = 'OU' THEN
		party.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN party.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN
		party.LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
	
FROM (SELECT TAX_REGIME_CODE
	,TAX
	,TAX_STATUS_CODE
	,TAX_JURISDICTION_CODE
	,TAX_RATE_CODE
	,CONTENT_OWNER_ID
	,RATE_TYPE_CODE
	,LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
	,ROW_NUMBER() OVER (PARTITION BY TAX_REGIME_CODE,TAX,TAX_STATUS_CODE,TAX_JURISDICTION_CODE,TAX_RATE_CODE,CONTENT_OWNER_ID ORDER BY LAST_UPDATE_DATE DESC) ROWNUMBER
	FROM ZX_RATES_VL
	WHERE ACTIVE_FLAG = 'Y'
	AND RATE_TYPE_CODE <> 'RECOVERY' 
	) ZxRatesVl,
ZX_FIRST_PARTY_ORGS_MOAC_V party,
ZX_REGIMES_VL RegimeTLEO, 
HZ_GEOGRAPHIES Regimes_HzGeographies,
HZ_GEOGRAPHY_TYPES_VL Regimes_HzGeoTypes,
FND_TERRITORIES_VL ,
ZX_MCO_LV_TAXES_V Tax
WHERE RegimeTLEO.TAX_REGIME_CODE         = ZxRatesVl.TAX_REGIME_CODE
AND party.party_tax_profile_id           = ZxRatesVl.CONTENT_OWNER_ID
AND FND_TERRITORIES_VL.TERRITORY_CODE(+) = RegimeTLEO.COUNTRY_CODE
AND RegimeTLEO.GEOGRAPHY_TYPE = Regimes_HzGeoTypes.GEOGRAPHY_TYPE(+)
AND RegimeTLEO.GEOGRAPHY_ID = Regimes_HzGeographies.GEOGRAPHY_ID(+)
AND Tax.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
AND Tax.TAX = ZxRatesVl.TAX
AND Tax.CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
AND ZxRatesVl.ROWNUMBER = 1
AND UPPER(NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I')) = UPPER('I')  
ORDER BY (SELECT DECODE(TAX_TYPE_CODE,'OFFSET',1,2) 
	FROM ZX_TAXES_VL 
	WHERE TAX = ZxRatesVl.TAX 
	AND CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
	AND TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
	)
,RES_TAX_REGIME_CODE
,RES_TAX_RATE_CODE