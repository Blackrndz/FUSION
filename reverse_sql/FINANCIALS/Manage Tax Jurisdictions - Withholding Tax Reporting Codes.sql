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
,QRSLT.REPORTING_TYPE_CODE RES_TAX_REPORTING_TYPE_CODE
,QRSLT.REPORTING_TYPE_DATATYPE_NAME RES_DATA_TYPE
,QRSLT.REPORTING_CODE_CHAR_VALUE RES_TAX_REPORTING_CODE
,QRSLT.REPORTING_CODE_NAME RES_DESCRIPTION
,TO_CHAR(QRSLT.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(QRSLT.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
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
	,ZxDataType.REPORTING_TYPE_CODE
	,ZxDataType.REPORTING_TYPE_DATATYPE_NAME
	,ZxReporting.REPORTING_CODE_CHAR_VALUE
	,ReportingCode.REPORTING_CODE_NAME
	,ReportingCode.EFFECTIVE_FROM
	,ReportingCode.EFFECTIVE_TO
	,ZxReporting.CREATED_BY
	,ZxReporting.CREATION_DATE
	,ZxReporting.LAST_UPDATED_BY
	,ZxReporting.LAST_UPDATE_DATE
	FROM ZX_JURISDICTIONS_VL ZxJurisdictionsVl
	,ZX_REGIMES_VL RegimeTLEO
	,HZ_GEOGRAPHY_TYPES_VL HzGeoTypes
	,ZX_TAXES_VL TaxTLEO
	,HZ_GEOGRAPHIES HzGeographies
	,ZX_REPORT_CODES_ASSOC ZxReporting
	,(SELECT ZxReportingTypesVl.REPORTING_TYPE_ID
		,ZxReportingTypesVl.REPORTING_TYPE_CODE
		,DatatypeLookups.Meaning REPORTING_TYPE_DATATYPE_NAME
		FROM ZX_REPORTING_TYPES_VL ZxReportingTypesVl
		,Zx_Report_Types_Usages RepUsage
		,Fnd_lookups DatatypeLookups
		WHERE ZxReportingTypesVl.Reporting_Type_Id = RepUsage.Reporting_Type_Id
		AND DatatypeLookups.Lookup_type            = 'ZX_REPORTING_DATA'
		AND DatatypeLookups.Lookup_code            = ZxReportingTypesVl.Reporting_Type_Datatype_Code
		AND RepUsage.Entity_Code                   = 'ZX_FC_CODES_B'
		) ZxDataType
	,ZX_REPORTING_CODES_VL ReportingCode
	WHERE TaxTLEO.SOURCE_TAX_FLAG             = 'Y'
	AND HzGeoTypes.GEOGRAPHY_TYPE             = HzGeographies.GEOGRAPHY_TYPE
	AND TaxTLEO.TAX                           = ZxJurisdictionsVl.TAX
	AND TaxTLEO.TAX_REGIME_CODE               = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND RegimeTLEO.TAX_REGIME_CODE            = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND ZxJurisdictionsVl.ZONE_GEOGRAPHY_ID   = HzGeographies.GEOGRAPHY_ID
	AND ZxJurisdictionsVl.TAX_JURISDICTION_ID = ZxReporting.ENTITY_ID
	AND ZxReporting.REPORTING_TYPE_ID         = ZxDataType.REPORTING_TYPE_ID
	AND ZxReporting.REPORTING_CODE_ID         = ReportingCode.REPORTING_CODE_ID
	) QRSLT
WHERE QRSLT.REGIME_TYPE_FLAG <> 'I'
ORDER BY RES_TAX_JURISDICTION_CODE
,RES_TAX_REPORTING_TYPE_CODE
,RES_TAX_REPORTING_CODE
,RES_EFFECTIVE_START_DATE