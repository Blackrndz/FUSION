/* ****************************************************************************
* $Revision: 54489 $:
* $Author: Nasrullah.dusenmahamad $:
* $Date: 2016-11-04 17:28:51 +0700 (Tue, 19 Apr 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Rates%20and%20Tax%20Recovery%20Rates%20-%20Manage%20Tax%20Recovery%20Rate.sql $:
* $Id: Manage Tax Rates and Tax Recovery Rates - Transaction Rate Period Details.sql 54489 2016-04-19 10:28:51Z dhara.pithadiya $:
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
,REPLACE(REPLACE(ZxRatesVl.TAX_RATE_NAME,CHR(10),' '),CHR(13),' ') RES_RATE_PERIOD_NAME
,REPLACE(REPLACE(ZxRatesVl.DESCRIPTION,CHR(10),' '),CHR(13),' ') RES_RATE_PERIOD_DESCRIPTION
,(SELECT MEANING FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_JEBE_VAT_TRANS_TYPE'
	AND LOOKUP_CODE = ZxRatesVl.vat_transaction_type_code
	) RES_TAX_TRANSACTION_TYPE
,DECODE(ZxRatesVl.allow_exemptions_flag,'Y','Yes','No') RES_ALLOW_TAX_EXEMPTIONS
,DECODE(ZxRatesVl.allow_exceptions_flag,'Y','Yes','No') RES_ALLOW_TAX_EXCEPTIONS
,ZxRatesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxRatesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxRatesVl.CREATED_BY RSC_CREATED_BY
,ZxRatesVl.CREATION_DATE RSC_CREATION_DATE
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
ORDER BY (SELECT DECODE(TAX_TYPE_CODE,'OFFSET',1,2) 
	FROM ZX_TAXES_VL 
	WHERE TAX = ZxRatesVl.TAX 
	AND CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
	AND TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
	)
,ZxRatesVl.TAX_REGIME_CODE
,ZxRatesVl.tax_status_code
,RES_EFFECTIVE_START_DATE