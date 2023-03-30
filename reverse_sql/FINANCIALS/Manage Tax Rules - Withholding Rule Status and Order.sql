/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-03-17 $:
 * $HeadURL:  $:
 * $Id: Manage Tax Rules - Withholding Tax Determining Factors.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT DECODE(ZxRulesVl.SERVICE_TYPE_CODE,'DET_APPLICABLE_TAXES','Tax Applicability Rules','DET_PLACE_OF_SUPPLY',
	'Place of Supply Rules','DET_DIRECT_RATE','Direct Tax Rate Rules','DET_RECOVERY_RATE','Recovery Rate Rules',
	'DET_TAXABLE_BASIS','Taxable Basis Rules','CALCULATE_TAX_AMOUNTS','Tax Calculation Rules','DET_TAX_RATE',
	'Tax Rate Rules','DET_TAX_REGISTRATION','Tax Registration Rules','DET_TAX_STATUS','Tax Status Rules',
	'DET_DIRECT_RATE_ENF_ACCT','Account-Based Direct Tax Rate Rules','DET_DIRECT_RATE_STCC',
	'Tax Classification-Based Direct Tax Rate Rules') RES_TAX_RULE_TYPE
,ZxRulesVl.TAX_RULE_CODE RES_RULE_CODE
,ZxRulesVl.PRIORITY RES_RULE_ORDER
,TO_CHAR(ZxRulesVl.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,DECODE(ZxRulesVl.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,ZxRulesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxRulesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxRulesVl.CREATED_BY RSC_CREATED_BY
,ZxRulesVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'OU' THEN
		ZFPOMV.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN
		ZFPOMV.LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_RULES_VL ZxRulesVl
,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
,ZX_REGIMES_VL ZxRegimesVl
,ZX_DET_FACTOR_TEMPL_VL ZxDetFactorTemplVl
WHERE ZxRegimesVl.TAX_REGIME_CODE         = ZxRulesVl.TAX_REGIME_CODE
AND ZxRulesVl.CONTENT_OWNER_ID            = ZFPOMV.PARTY_TAX_PROFILE_ID
AND NVL(ZxRegimesVl.REGIME_TYPE_FLAG,'I') = 'W'
AND ZxRulesVl.SERVICE_TYPE_CODE NOT      IN('DET_DIRECT_RATE_ENF_ACCT','DET_DIRECT_RATE_STCC')
AND ZxRulesVl.DET_FACTOR_TEMPL_CODE       = ZxDetFactorTemplVl.DET_FACTOR_TEMPL_CODE(+)
ORDER BY 1,3,2