/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT DECODE(QRSLT.REGIME_TYPE_FLAG,'I','Transaction Tax','W','Withholding Tax') RES_SEARCH_FOR
,DECODE(QRSLT.FORMULA_TYPE_CODE,'TAXABLE_BASIS','Taxable Basis Formulas','TAX_CALCULATION','Tax Calculation Formulas')
	RES_TAX_FORMULA_TYPE
,QRSLT.PARTY_NAME RES_CONFIGURATION_OWNER
,QRSLT.FORMULA_CODE RES_TAX_FORMULA_CODE
,QRSLT.COMPOUNDING_TAX_REGIME_CODE RES_COMPOUNDING_TAX_REGIME_COD
,QRSLT.COMPOUNDING_TAX RES_COMPOUNDING_TAX
,(SELECT meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = 'ZX_COMPOUNDING_TYPES'
	AND lookup_code   = QRSLT.COMPOUNDING_TYPE_CODE
	) RES_COMPOUNDING_RULE
,DECODE(QRSLT.ENFORCE_COMPOUNDING_FLAG,'Y','Yes','No') RES_ENFORCE_COMPOUNDING
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN QRSLT.PARTY_TYPE_CODE = 'OU' THEN
		QRSLT.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN QRSLT.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN
		QRSLT.LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ZxFormulaVl.FORMULA_TYPE_CODE
	,ZxFormulaVl.CONTENT_OWNER_ID
	,ZxFormulaVl.TAX
	,ZxFormulaVl.EFFECTIVE_FROM
	,ZxFormulaVl.EFFECTIVE_TO
	,ZxFormulaVl.FORMULA_CODE
	,ZxFormulaVl.TAX_REGIME_CODE
	,ZxFormulaVl.ENABLED_FLAG
	,ZxFormulaVl.BASE_RATE_MODIFIER
	,ZxFormulaVl.CASH_DISCOUNT_APPL_FLAG
	,ZxFormulaVl.TAXABLE_BASIS_TYPE_CODE
	,ZxFormulaVl.RECORD_TYPE_CODE
	,ZxFormulaVl.VOLUME_DISCOUNT_APPL_FLAG
	,ZxFormulaVl.TRADING_DISCOUNT_APPL_FLAG
	,ZxFormulaVl.FORMULA_ID
	,ZxFormulaVl.TRANSPORT_CHARGE_APPL_FLAG
	,ZxFormulaVl.TRANSFER_CHARGE_APPL_FLAG
	,ZxFormulaVl.INSURANCE_CHARGE_APPL_FLAG
	,ZxFormulaVl.OTHER_CHARGE_APPL_FLAG
	,ZxFormulaVl.FORMULA_NAME
	,ZxFormulaVl.FORMULA_DESCRIPTION
	,ZxFormulaVl.PROGRAM_APP_NAME
	,ZxFormulaVl.PROGRAM_NAME
	,ZFPOMV.PARTY_NAME
	,ZxFormulaVl.FORMULA_TYPE_CODE AS TaxFormulaTypeCodeForSearch
	,FndLookup.MEANING             AS FORMULA_TYPE_CODE_MEANING
	,FndLookup1.MEANING            AS TAXABLE_TYPE_CODE_MEANING
	,DECODE(
		(SELECT NVL(numeric_result,NULL) FROM zx_process_results WHERE numeric_result = ZxFormulaVl.formula_id
		AND ROWNUM                                                                    = 1
		),NULL,'N','Y') AS LineAmountFlag
	,DECODE(
		(SELECT NVL(DEF_TAX_CALC_FORMULA,NULL) FROM zx_taxes_b WHERE DEF_TAX_CALC_FORMULA = ZxFormulaVl.formula_code
		AND ROWNUM                                                                        = 1
		),NULL,'N','Y') AS TaxCalcFormulaFlag
	,DECODE(
		(SELECT NVL(DEF_TAXABLE_BASIS_FORMULA,NULL) FROM zx_taxes_b WHERE DEF_TAXABLE_BASIS_FORMULA =
			ZxFormulaVl.formula_code
		AND ROWNUM = 1
		),NULL,'N','Y') AS TaxableBasisFormulaFlag
	,ZxRegimesVl.REGIME_PRECEDENCE
	,ZxRegimesVl.CROSS_REGIME_COMPOUNDING_FLAG
	,ZxFormulaVl.FORMULA_CODE    AS FormulaCodeForSearch
	,ZxFormulaVl.FORMULA_NAME    AS FormulaNameForSearch
	,ZxFormulaVl.TAX_REGIME_CODE AS TaxRegimeCodeForSearch
	,ZFPOMV.PARTY_NAME           AS PartyNameForSearch
	,ZxFormulaVl.TAX             AS TaxForSearch
	,ZFPOMV.BU_ID
	,NVL(ZxRegimesVl.Regime_Type_Flag,'I') AS REGIME_TYPE_FLAG
	,ZxFormulaVl.APPLY_TXBS_VAL_ADD_FLAG
	,ZxFormulaVl.APPLY_UNIT_PRC_THRSHLD_FLAG
	,ZxRegimesVl.country_code
	,ZxFormulaDetail.COMPOUNDING_TAX_REGIME_CODE
	,ZxFormulaDetail.COMPOUNDING_TAX
	,ZxFormulaDetail.COMPOUNDING_TYPE_CODE
	,ZxFormulaDetail.ENFORCE_COMPOUNDING_FLAG
	,ZxFormulaDetail.LAST_UPDATE_DATE
	,ZxFormulaDetail.LAST_UPDATED_BY
	,ZxFormulaDetail.CREATION_DATE
	,ZxFormulaDetail.CREATED_BY
	,ZFPOMV.LEGAL_ENTITY_ID
	,ZFPOMV.PARTY_TYPE_CODE
	FROM ZX_FORMULA_VL ZxFormulaVl
	,ZX_FORMULA_DETAILS ZxFormulaDetail
	,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
	,ZX_REGIMES_VL ZxRegimesVl
	,FND_LOOKUP_VALUES_VL FndLookup
	,FND_LOOKUP_VALUES_VL FndLookup1
	WHERE ZxFormulaVl.CONTENT_OWNER_ID = ZFPOMV.PARTY_TAX_PROFILE_ID
	AND ZxFormulaVl.TAX_REGIME_CODE    = ZxRegimesVl.TAX_REGIME_CODE(+)
	AND ZxFormulaVl.FORMULA_ID         = ZxFormulaDetail.FORMULA_ID
	AND FndLookup.lookup_code          = FORMULA_TYPE_CODE
	AND FndLookup.lookup_type          = 'ZX_FORMULA_TYPES'
	AND FndLookup1.lookup_code(+)      = TAXABLE_BASIS_TYPE_CODE
	AND FndLookup1.lookup_type(+)      = 'ZX_TAXABLE_BASIS_TYPES'
	
	AND ZxFormulaVl.FORMULA_TYPE_CODE = 'TAX_CALCULATION'
	
	) QRSLT
WHERE QRSLT.REGIME_TYPE_FLAG != 'I'
ORDER BY FORMULA_CODE
,RES_COMPOUNDING_TAX_REGIME_COD