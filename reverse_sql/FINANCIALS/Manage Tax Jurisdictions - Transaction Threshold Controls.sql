/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT DISTINCT QRSLT.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_CODE
,QRSLT.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,QRSLT.TAX RES_TAX
,(SELECT Meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = 'ZX_THRSHLD_SCHEDULE_GRP_LVL'
	AND lookup_code   = QRSLT.THRSHLD_SCHEDULE_GRP_LVL_FLAG
	) RES_THRESHOLD_BASIS
,(SELECT Meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = 'ZX_THRESHOLD_TYPE'
	AND lookup_code   = QRSLT.THRESHOLD_TYPE_CODE
	) RES_THRESHOLD_TYPE
,(
	CASE QRSLT.THRESHOLD_TYPE_CODE
		WHEN 'TAX_AMOUNT'
		THEN QRSLT.MIN_TAX_THRSHLD
		WHEN 'TAXABLE_AMOUNT'
		THEN QRSLT.MIN_TAXABLE_THRSHLD
		WHEN 'TAX_RATE'
		THEN QRSLT.MIN_RATE_THRSHLD
	END) RES_MINIMUM_VALUE
,(
	CASE QRSLT.THRESHOLD_TYPE_CODE
		WHEN 'TAX_AMOUNT'
		THEN QRSLT.MAX_TAX_THRSHLD
		WHEN 'TAXABLE_AMOUNT'
		THEN QRSLT.MAX_TAXABLE_THRSHLD
		WHEN 'TAX_RATE'
		THEN QRSLT.MAX_RATE_THRSHLD
	END) RES_MAXIMUM_VALUE
,TO_CHAR(QRSLT.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(QRSLT.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(QRSLT.EFFECTIVE_END_DATE,'DD-Mon-YYYY'
	)) RES_EFFECTIVE_END_DATE
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ZxJurisdictionsVl.TAX_JURISDICTION_CODE
	,ZxJurisdictionsVl.TAX_REGIME_CODE
	,ZxJurisdictionsVl.TAX
	,ZxJurisdictionsVl.EFFECTIVE_FROM START_DATE
	,NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') AS REGIME_TYPE_FLAG
	,ZxThresholdControls.THRSHLD_SCHEDULE_GRP_LVL_FLAG
	,ZxThresholdControls.THRESHOLD_TYPE_CODE
	,ZxThresholdControls.MIN_TAXABLE_THRSHLD
	,ZxThresholdControls.MAX_TAXABLE_THRSHLD
	,ZxThresholdControls.MIN_TAX_THRSHLD
	,ZxThresholdControls.MAX_TAX_THRSHLD
	,ZxThresholdControls.MIN_RATE_THRSHLD
	,ZxThresholdControls.MAX_RATE_THRSHLD
	,ZxThresholdControls.EFFECTIVE_START_DATE
	,ZxThresholdControls.EFFECTIVE_END_DATE
	,ZxThresholdControls.TXBL_BSIS_THRSHLD_HNDLNG_FLAG
	,ZxThresholdControls.CALENDAR_NAME
	,ZxThresholdControls.CREATED_BY
	,ZxThresholdControls.CREATION_DATE
	,ZxThresholdControls.LAST_UPDATED_BY
	,ZxThresholdControls.LAST_UPDATE_DATE
	FROM ZX_JURISDICTIONS_VL ZxJurisdictionsVl
	,ZX_REGIMES_VL RegimeTLEO
	,ZX_TAXES_VL TaxTLEO
	,ZX_THREHLDS_SCHDL_CNTRLS_F ZxThresholdControls
	WHERE TaxTLEO.SOURCE_TAX_FLAG               = 'Y'
	AND TaxTLEO.TAX                             = ZxJurisdictionsVl.TAX
	AND TaxTLEO.TAX_REGIME_CODE                 = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND RegimeTLEO.TAX_REGIME_CODE              = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND ZxJurisdictionsVl.TAX_JURISDICTION_CODE = ZxThresholdControls.TAX_JURISDICTION_CODE
	AND ZxJurisdictionsVl.TAX                   = ZxThresholdControls.TAX
	AND ZxJurisdictionsVl.TAX_REGIME_CODE       = ZxThresholdControls.TAX_REGIME_CODE
	) QRSLT
WHERE QRSLT.REGIME_TYPE_FLAG = 'I'
ORDER BY RES_TAX_JURISDICTION_CODE
,QRSLT.TAX_REGIME_CODE
,QRSLT.TAX