/* ****************************************************************************
* $Revision: 79660 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-11-22 09:22:32 +0700 (Tue, 22 Nov 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Rates%20and%20Tax%20Recovery%20Rates%20-%20Transaction%20Main%20Details.sql $:
* $Id: Manage Tax Rates and Tax Recovery Rates - Transaction Main Details.sql 79660 2022-11-22 02:22:32Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=ZX_RATES_VL

SELECT ZxRatesVl.TAX_REGIME_CODE RES_TAX_REGIME_CODE,
party.PARTY_NAME RES_CONFIGURATION_OWNER,
ZxRatesVl.TAX RES_TAX,
ZxRatesVl.tax_status_code RES_TAX_STATUS_CODE,
ZxRatesVl.tax_jurisdiction_code RES_TAX_JURISDICTION_CODE,
ZxRatesVl.tax_rate_code RES_TAX_RATE_CODE,
ZxRatesVl.PERCENTAGE_RATE RES_RATE_PERCENTAGE,
ZxRatesVl.UOM_CODE RES_UOM_CODE,
UnitOfMeasurePEO.UNIT_OF_MEASURE RES_UOM_NAME,
ZxRatesVl.QUANTITY_RATE RES_RATE_QUANTITY,
to_char(ZxRatesVl.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE,
REPLACE(REPLACE(ZxRatesVl.TAX_RATE_NAME,CHR(10),' '),CHR(13),' ') RES_RATE_PERIOD_NAME,
REPLACE(REPLACE(ZxRatesVl.DESCRIPTION,CHR(10),' '),CHR(13),' ') RES_RATE_PERIOD_DESCRIPTION,
REPLACE(REPLACE(ZxRatesVl.DESCRIPTION,CHR(10),' '),CHR(13),' ') RES_TAX_RATE_DESCRIPTION,
(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_JEBE_VAT_TRANS_TYPE'
	AND LOOKUP_CODE = ZxRatesVl.vat_transaction_type_code   
	) RES_TAX_TRANSACTION_TYPE,
ZxRatesVl.OFFSET_tax_RATE_CODE RES_OFFSET_RATE_CODE,
ZxRatesVl.default_rec_rate_code RES_DEFAULT_RECOVERY_RATE_CODE,
ZxRatesVl.recovery_rule_code RES_RULE_CODE_OF_RECOVERY_RATE, 
ZxRatesVl.INPUT_IC_AP_TAX_RATE_CODE RES_INPUT_TAX_RATE_CODE, 
(select LookupPEO.MEANING 
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE =   'ZX_INCLUSIVE_TAX' 
	and LookupPEO.LOOKUP_CODE = ZxRatesVl.INCLUSIVE_TAX_FLAG 
	) RES_TAX_INCLUSION_METHOD  ,
decode(ZxRatesVl.tax_inclusive_override_flag,'Y','Yes','No') RES_ALLOW_OVERRIDE_AND_ENTRY_O ,
decode(ZxRatesVl.allow_exemptions_flag,'Y','Yes','No') RES_ALLOW_TAX_EXEMPTIONS  ,
decode(ZxRatesVl.allow_exceptions_flag,'Y','Yes','No') RES_ALLOW_TAX_EXCEPTIONS  ,
decode(ZxRatesVl.allow_adhoc_tax_rate_flag,'Y','Yes','No') RES_ALLOW_AD_HOC_TAX_RATE,
(select LookupPEO.MEANING 
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'ZX_ADJ_FOR_ADHOC_AMT' 
	and LookupPEO.LOOKUP_CODE = ZxRatesVl.adj_for_adhoc_amt_code 
	) RES_ADJUSTMENT_FOR_AD_HOC_TAX_,
(select LookupPEO.MEANING 
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'ZX_TAX_POINT_BASIS' 
	and LookupPEO.LOOKUP_CODE = ZxRatesVl.def_rec_settlement_option_code 
	) RES_TAX_POINT_BASIS
,ZxRatesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxRatesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxRatesVl.CREATED_BY RSC_CREATED_BY
,ZxRatesVl.CREATION_DATE RSC_CREATION_DATE
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
INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
WHERE RegimeTLEO.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
AND party.party_tax_profile_id = ZxRatesVl.CONTENT_OWNER_ID
AND ZxRatesVl.ACTIVE_FLAG = 'Y'
AND ZMCAV.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
AND ZMCAV.PARENT_FIRST_PTY_ORG_ID = ZxRatesVl.CONTENT_OWNER_ID
AND Tax.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
AND Tax.TAX = ZxRatesVl.TAX
AND Tax.CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
AND ZxRatesVl.rate_type_code <> 'RECOVERY'  
AND UPPER(NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I')) = UPPER('I') 
AND ZxRatesVl.UOM_CODE = UnitOfMeasurePEO.UOM_CODE(+)
ORDER BY (SELECT DECODE(TAX_TYPE_CODE,'OFFSET',1,2) 
	FROM ZX_TAXES_VL 
	WHERE TAX = ZxRatesVl.TAX 
	AND CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
	AND TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
	)
,RES_TAX_REGIME_CODE