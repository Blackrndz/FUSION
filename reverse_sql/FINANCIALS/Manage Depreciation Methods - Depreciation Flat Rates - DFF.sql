/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=140##RES##FA_FLAT_RATES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT QRSLT.METHOD_CODE RES_NAME
,QRSLT.SET_NAME RES_REFERENCE_DATA_SET
,QRSLT.MEANING RES_METHOD_TYPE
,TRUNC(QRSLT.LIFE_IN_MONTHS / 12) RES_LIFE_IN_YEARS
,MOD(QRSLT.LIFE_IN_MONTHS,12) RES_LIFE_IN_MONTHS
,DECODE(USE_LIFE_IN_PERIODS_FLAG,'Y',QRSLT.LIFE_IN_MONTHS,NULL) RES_LIFE_IN_PERIODS
,(QRSLT.BASIC_RATE     * 100) RES_BASIC_RATE
,(QRSLT.ADJUSTING_RATE * 100) RES_ADJUSTING_RATE
,QRSLT.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,QRSLT.ATTRIBUTE1
,QRSLT.ATTRIBUTE2
,QRSLT.ATTRIBUTE3
,QRSLT.ATTRIBUTE4
,QRSLT.ATTRIBUTE5
,QRSLT.ATTRIBUTE6
,QRSLT.ATTRIBUTE7
,QRSLT.ATTRIBUTE8
,QRSLT.ATTRIBUTE9
,QRSLT.ATTRIBUTE10
,QRSLT.ATTRIBUTE11
,QRSLT.ATTRIBUTE12
,QRSLT.ATTRIBUTE13
,QRSLT.ATTRIBUTE14
,QRSLT.ATTRIBUTE15
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
	(SELECT DEPRECIATIONMETHODEO.METHOD_CODE
	,DepreciationFlatRateEO.METHOD_ID
	,DepreciationFlatRateEO.FLAT_RATE_ID
	,DepreciationFlatRateEO.BASIC_RATE
	,DepreciationFlatRateEO.ADJUSTING_RATE
	,DepreciationFlatRateEO.ADJUSTED_RATE
	,DepreciationFlatRateEO.LAST_UPDATE_DATE
	,DepreciationFlatRateEO.LAST_UPDATED_BY
	,DepreciationFlatRateEO.ATTRIBUTE1
	,DepreciationFlatRateEO.ATTRIBUTE2
	,DepreciationFlatRateEO.ATTRIBUTE3
	,DepreciationFlatRateEO.ATTRIBUTE4
	,DepreciationFlatRateEO.ATTRIBUTE5
	,DepreciationFlatRateEO.ATTRIBUTE6
	,DepreciationFlatRateEO.ATTRIBUTE7
	,DepreciationFlatRateEO.ATTRIBUTE8
	,DepreciationFlatRateEO.ATTRIBUTE9
	,DepreciationFlatRateEO.ATTRIBUTE10
	,DepreciationFlatRateEO.ATTRIBUTE11
	,DepreciationFlatRateEO.ATTRIBUTE12
	,DepreciationFlatRateEO.ATTRIBUTE13
	,DepreciationFlatRateEO.ATTRIBUTE14
	,DepreciationFlatRateEO.ATTRIBUTE15
	,DepreciationFlatRateEO.ATTRIBUTE_CATEGORY_CODE
	,DEPRECIATIONFLATRATEEO.CREATED_BY
	,DepreciationFlatRateEO.CREATION_DATE
	,SETIDSETSEO.SET_NAME
	,LookupMethodTypePEO.meaning
	,DEPRECIATIONMETHODEO.LIFE_IN_MONTHS
	,DEPRECIATIONMETHODEO.USE_LIFE_IN_PERIODS_FLAG
	FROM FA_FLAT_RATES DEPRECIATIONFLATRATEEO
	, FA_METHODS DEPRECIATIONMETHODEO
	, FND_SETID_SETS_VL SETIDSETSEO
	, FND_LOOKUPS LookupMethodTypePEO
	WHERE DEPRECIATIONFLATRATEEO.METHOD_ID              = DEPRECIATIONMETHODEO.METHOD_ID
	AND DEPRECIATIONMETHODEO.SET_ID                     = SETIDSETSEO.SET_ID(+)
	AND LookupMethodTypePEO.LOOKUP_TYPE (+)             = 'FA_RATE_SOURCE_RULE'
	AND DepreciationMethodEO.RATE_SOURCE_RULE           = LookupMethodTypePEO.LOOKUP_CODE (+)
	AND(DepreciationFlatRateEO.ATTRIBUTE_CATEGORY_CODE IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE1               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE2               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE3               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE4               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE5               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE6               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE7               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE8               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE9               IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE10              IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE11              IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE12              IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE13              IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE14              IS NOT NULL
	OR DepreciationFlatRateEO.ATTRIBUTE15              IS NOT NULL)
	) QRSLT