/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_TAX_LIABILITY_ACCOUNT/GET_CODE_COMBINATION

SELECT DISTINCT QRSLT.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_CODE
,QRSLT.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,QRSLT.TAX RES_TAX
,(SELECT name
	FROM gl_ledgers
	WHERE ledger_id = QRSLT.ledger_id
	) RES_LEDGER
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = QRSLT.INTERNAL_ORGANIZATION_ID
	) RES_BUSINESS_UNIT
,QRSLT.TAX_LIAB_ACCT_CCID RES_TAX_LIABILITY_ACCOUNT
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,QRSLT.INTERNAL_ORGANIZATION_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ZxJurisdictionsVl.TAX_JURISDICTION_CODE
	,ZxJurisdictionsVl.TAX_REGIME_CODE
	,ZxJurisdictionsVl.TAX
	,ZxJurisdictionsVl.EFFECTIVE_FROM
	,NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') AS REGIME_TYPE_FLAG
	,TaxAccount.ledger_id
	,TaxAccount.INTERNAL_ORGANIZATION_ID
	,TaxAccount.TAX_LIAB_ACCT_CCID
	,TaxAccount.CREATED_BY
	,TaxAccount.CREATION_DATE
	,TaxAccount.LAST_UPDATED_BY
	,TaxAccount.LAST_UPDATE_DATE
	FROM ZX_JURISDICTIONS_VL ZxJurisdictionsVl
	,ZX_REGIMES_VL RegimeTLEO
	,ZX_TAXES_VL TaxTLEO
	,ZX_ACCOUNTS TaxAccount
	WHERE TaxTLEO.SOURCE_TAX_FLAG                    = 'Y'
	AND TaxTLEO.TAX                                  = ZxJurisdictionsVl.TAX
	AND TaxTLEO.TAX_REGIME_CODE                      = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND RegimeTLEO.TAX_REGIME_CODE                   = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND ZxJurisdictionsVl.TAX_JURISDICTION_ID        = TaxAccount.TAX_ACCOUNT_ENTITY_ID
	AND REGIME_TYPE_FLAG                             <> 'I'
	) QRSLT
ORDER BY QRSLT.TAX_JURISDICTION_CODE
,RES_BUSINESS_UNIT