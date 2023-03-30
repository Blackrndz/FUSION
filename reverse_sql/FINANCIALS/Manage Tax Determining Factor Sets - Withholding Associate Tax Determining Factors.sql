/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ZxDetFactorTemplVl.DET_FACTOR_TEMPL_CODE RES_TAX_DETERMINING_FACTOR_SET
,(SELECT meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = 'ZX_DETERMINING_FACTOR_CLASS'
	AND lookup_code   = AssociateTax.DETERMINING_FACTOR_CLASS_CODE
	) RES_DETERMINING_FACTOR_CLASS
,(SELECT meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = (CASE 
							WHEN AssociateTax.DETERMINING_FACTOR_CLASS_CODE = 'REGISTRATION' THEN
								'ZX_REGISTRATION_CQ'
							WHEN AssociateTax.DETERMINING_FACTOR_CLASS_CODE = 'GEOGRAPHY' OR AssociateTax.DETERMINING_FACTOR_CLASS_CODE = 'USER_DEFINED_GEOGRAPHY' THEN
								'ZX_PLACE_OF_SUPPLY_TYPE'
							WHEN AssociateTax.DETERMINING_FACTOR_CLASS_CODE = 'DOCUMENT' OR AssociateTax.DETERMINING_FACTOR_CLASS_CODE = 'TRX_GENERIC_CLASSIFICATION' OR AssociateTax.DETERMINING_FACTOR_CLASS_CODE = 'PRODUCT_GENERIC_CLASSIFICATION' THEN
								'ZX_PROD_TRX_CATEG'
							WHEN AssociateTax.DETERMINING_FACTOR_CLASS_CODE = 'PARTY_FISCAL_CLASS' THEN
								'ZX_PARTY_CQ'
						END)
	AND lookup_code   = AssociateTax.DETERMINING_FACTOR_CQ_CODE
	) RES_TAX_CLASS_QUALIFIER
,(SELECT ZxDeterminingFactorsVl.DETERMINING_FACTOR_NAME
	FROM ZX_DETERMINING_FACTORS_VL ZxDeterminingFactorsVl
	WHERE ZxDeterminingFactorsVl.DETERMINING_FACTOR_CLASS_CODE = AssociateTax.DETERMINING_FACTOR_CLASS_CODE
	AND ZxDeterminingFactorsVl.DETERMINING_FACTOR_CODE         = AssociateTax.DETERMINING_FACTOR_CODE
	) RES_DETERMINING_FACTOR_NAME
,(SELECT meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = 'ZX_TAX_REGIME_DET_LEVEL'
	AND lookup_code   = AssociateTax.tax_regime_det_level_code
	) RES_REGIME_DETERMINATION_LEVEL
,DECODE(AssociateTax.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED
,AssociateTax.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AssociateTax.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AssociateTax.CREATED_BY RSC_CREATED_BY
,AssociateTax.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_DET_FACTOR_TEMPL_VL ZxDetFactorTemplVl
,ZX_DET_FACTOR_TEMPL_DTL AssociateTax
WHERE ZxDetFactorTemplVl.DET_FACTOR_TEMPL_ID                                  = AssociateTax.DET_FACTOR_TEMPL_ID
AND DECODE(SUBSTR(ZxDetFactorTemplVl.TEMPLATE_USAGE_CODE,1,3),'WHT','W','I') <> 'I'
ORDER BY ZxDetFactorTemplVl.DET_FACTOR_TEMPL_CODE
,RES_DETERMINING_FACTOR_CLASS
,RES_DETERMINING_FACTOR_NAME