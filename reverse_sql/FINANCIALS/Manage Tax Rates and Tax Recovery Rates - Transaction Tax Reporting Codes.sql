/* ****************************************************************************
* $Revision: 79217 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-08-15 13:18:17 +0700 (Mon, 15 Aug 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Rates%20and%20Tax%20Recovery%20Rates%20-%20Transaction%20Tax%20Reporting%20Codes.sql $:
* $Id: Manage Tax Rates and Tax Recovery Rates - Transaction Tax Reporting Codes.sql 79217 2022-08-15 06:18:17Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT ZxRatesVl.TAX_REGIME_CODE RES_TAX_REGIME_CODE,
party.PARTY_NAME RES_CONFIGURATION_OWNER,
ZxRatesVl.TAX RES_TAX,
(ZxRatesVl.tax_status_code) RES_TAX_STATUS_CODE,
ZxRatesVl.tax_jurisdiction_code RES_TAX_JURISDICTION_CODE,
ZxRatesVl.tax_rate_code RES_TAX_RATE_CODE,
ZxRatesVl.PERCENTAGE_RATE RES_RATE_PERCENTAGE,
ZxRatesVl.UOM_CODE RES_UOM_CODE,
UnitOfMeasurePEO.UNIT_OF_MEASURE RES_UOM_NAME,
ZxRatesVl.QUANTITY_RATE RES_RATE_QUANTITY,
to_char(ZxRatesVl.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_RATE_PERIODS_EFFECTIVE_STA,
BB.reporting_type_code RES_TAX_REPORTING_TYPE_CODE,
AA.reporting_code_char_value RES_TAX_REPORTING_CODE,
to_char(AA.effective_from,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE,
to_char(AA.effective_to,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,AA.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AA.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AA.CREATED_BY RSC_CREATED_BY
,AA.CREATION_DATE RSC_CREATION_DATE
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
	
FROM ZX_RATES_VL ZxRatesVl,
ZX_FIRST_PARTY_ORGS_MOAC_V party,
ZX_REGIMES_VL RegimeTLEO, 
ZX_MCO_CHECK_ACCESS_V ZMCAV,
ZX_MCO_LV_TAXES_V Tax,
ZX_REPORT_CODES_ASSOC AA,
ZX_REPORTING_TYPES_VL BB,
INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
WHERE RegimeTLEO.TAX_REGIME_CODE         = ZxRatesVl.TAX_REGIME_CODE
AND party.party_tax_profile_id           = ZxRatesVl.CONTENT_OWNER_ID
AND ZxRatesVl.ACTIVE_FLAG                = 'Y'
AND ZMCAV.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
AND ZMCAV.PARENT_FIRST_PTY_ORG_ID = ZxRatesVl.CONTENT_OWNER_ID
AND Tax.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
AND Tax.TAX = ZxRatesVl.TAX
AND Tax.CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
AND ZxRatesVl.rate_type_code <> 'RECOVERY'  
AND UPPER(NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I')) = UPPER('I') 
AND ZxRatesVl.UOM_CODE = UnitOfMeasurePEO.UOM_CODE(+)
AND ZxRatesVl.tax_rate_id   = AA.entity_id
AND AA.reporting_type_id = BB.reporting_type_id
ORDER BY (SELECT DECODE(TAX_TYPE_CODE,'OFFSET',1,2) 
	FROM ZX_TAXES_VL 
	WHERE TAX = ZxRatesVl.TAX 
	AND CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
	AND TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
	)
,RES_TAX_REGIME_CODE 
,ZxRatesVl.tax_rate_code
,AA.LAST_UPDATE_DATE desc