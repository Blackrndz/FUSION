/* ****************************************************************************
* $Revision: 54489 $:
* $Author: Nasrullah.dusenmahamad $:
* $Date: 2016-11-04 17:28:51 +0700 (Tue, 19 Apr 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Rates%20and%20Tax%20Recovery%20Rates%20-%20Manage%20Tax%20Recovery%20Rate.sql $:
* $Id: Manage Tax Rates and Tax Recovery Rates - Transaction Rate Periods.sql 54489 2016-04-19 10:28:51Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT ZxRatesVl.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,party.PARTY_NAME RES_CONFIGURATION_OWNER
,ZxRatesVl.TAX RES_TAX
,ZxRatesVl.tax_status_code RES_TAX_STATUS_CODE
,ZxRatesVl.tax_jurisdiction_code RES_TAX_JURISDICTION_CODE
,ZxRatesVl.tax_rate_code RES_TAX_RATE_CODE
,ZxRatesVl.PERCENTAGE_RATE RES_RATE_PERCENTAGE
,TO_CHAR(ZxRatesVl.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TaxRateSchedulesEO.START_TAXABLE_AMT RES_FROM_AMOUNT
,TaxRateSchedulesEO.END_TAXABLE_AMT RES_TO_AMOUNT
,TaxRateSchedulesEO.PERCENTAGE_RATE RES_RATE_PERIODS_RATE_PERCENTA
,TaxRateSchedulesEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TaxRateSchedulesEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TaxRateSchedulesEO.CREATED_BY RSC_CREATED_BY
,TaxRateSchedulesEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE 
	WHEN party.PARTY_TYPE_CODE = 'OU' THEN	
		party.BU_ID
	ELSE
		NULL
	END) RSC_BUSINESS_UNIT_ID
,(CASE 
	WHEN party.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN	
		party.LEGAL_ENTITY_ID
	ELSE
		NULL
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_RATES_VL ZxRatesVl
,ZX_FIRST_PARTY_ORGS_MOAC_V party
,ZX_REGIMES_VL RegimeTLEO
,ZX_MCO_CHECK_ACCESS_V ZMCAV
,ZX_MCO_LV_TAXES_V Tax
,ZX_RATE_SCHEDULES_F TaxRateSchedulesEO
WHERE RegimeTLEO.TAX_REGIME_CODE                 = ZxRatesVl.TAX_REGIME_CODE
AND party.party_tax_profile_id                   = ZxRatesVl.CONTENT_OWNER_ID
AND ZxRatesVl.ACTIVE_FLAG                        = 'Y'
AND ZMCAV.TAX_REGIME_CODE                        = ZxRatesVl.TAX_REGIME_CODE
AND ZMCAV.PARENT_FIRST_PTY_ORG_ID                = ZxRatesVl.CONTENT_OWNER_ID
AND Tax.TAX_REGIME_CODE                          = ZxRatesVl.TAX_REGIME_CODE
AND Tax.TAX                                      = ZxRatesVl.TAX
AND Tax.CONTENT_OWNER_ID                         = ZxRatesVl.CONTENT_OWNER_ID
AND ZxRatesVl.rate_type_code                    <> 'RECOVERY'
AND UPPER(NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I')) <> UPPER('I')
AND ZxRatesVl.TAX_RATE_ID = TaxRateSchedulesEO.TAX_RATE_ID
ORDER BY (SELECT DECODE(TAX_TYPE_CODE,'OFFSET',1,2) 
	FROM ZX_TAXES_VL 
	WHERE TAX = ZxRatesVl.TAX 
	AND CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
	AND TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
	)
,ZxRatesVl.TAX_REGIME_CODE
,ZxRatesVl.tax_status_code
,RES_EFFECTIVE_START_DATE