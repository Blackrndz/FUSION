/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT QRSLT.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_CODE
,QRSLT.TAX_JURISDICTION_NAME RES_TAX_JURISDICTION_NAME
,QRSLT.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,QRSLT.TAX RES_TAX
,QRSLT.GEOGRAPHY_TYPE RES_GEOGRAPHY_TYPE
,QRSLT.GEOGRAPHY_NAME RES_GEOGRAPHY_NAME
,QRSLT.prnt_geoType_edt RES_PARENT_GEOGRAPHY_TYPE
,QRSLT.prnt_geoName_edt RES_PARENT_GEOGRAPHY_NAME
,TO_CHAR(QRSLT.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(QRSLT.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,DECODE(QRSLT.DEFAULT_JURISDICTION_FLAG,'Y','Yes','No') RES_SET_AS_DEFAULT_JURISDICTIO
,TO_CHAR(QRSLT.DEFAULT_FLG_EFFECTIVE_FROM,'DD-Mon-YYYY') RES_DEFAULT_START_DATE
,TO_CHAR(QRSLT.DEFAULT_FLG_EFFECTIVE_TO,'DD-Mon-YYYY') RES_DEFAULT_END_DATE
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
	,ZxJurisdictionsVl.EFFECTIVE_FROM
	,ZxJurisdictionsVl.EFFECTIVE_TO
	,ZxJurisdictionsVl.TAX_REGIME_CODE
	,ZxJurisdictionsVl.TAX
	,ZxJurisdictionsVl.DEFAULT_JURISDICTION_FLAG
	,ZxJurisdictionsVl.DEFAULT_FLG_EFFECTIVE_FROM
	,ZxJurisdictionsVl.DEFAULT_FLG_EFFECTIVE_TO
	,ZxJurisdictionsVl.CREATED_BY
	,ZxJurisdictionsVl.CREATION_DATE
	,ZxJurisdictionsVl.LAST_UPDATED_BY
	,ZxJurisdictionsVl.LAST_UPDATE_DATE
	,ZxJurisdictionsVl.TAX_JURISDICTION_NAME
	,HzGeographies.GEOGRAPHY_CODE
	,HzGeographies.GEOGRAPHY_NAME
	,TaxTLEO.TAX_FULL_NAME
	,RegimeTLEO.TAX_REGIME_NAME
	,NULL AS CODE_DUPLICATED
	,DECODE(HzGeographies.GEOGRAPHY_TYPE,TaxTLEO.ZONE_GEOGRAPHY_TYPE,TaxTLEO.PARENT_GEOGRAPHY_TYPE,NULL)
		PARENT_GEOGRAPHY_TYPE
	,DECODE(HzGeographies.GEOGRAPHY_TYPE,TaxTLEO.ZONE_GEOGRAPHY_TYPE,HzGeographiesParent.GEOGRAPHY_NAME,NULL)
		PARENT_GEOGRAPHY_NAME
	,(SELECT HzGeographies1.geography_name
		FROM HZ_GEOGRAPHIES HzGeographies1
		,HZ_HIERARCHY_NODES GeoHiererchy
		WHERE GeoHiererchy.PARENT_ID  = HzGeographies1.GEOGRAPHY_ID
		AND GeoHiererchy.CHILD_ID     = HzGeographies.GEOGRAPHY_ID
		AND GeoHiererchy.LEVEL_NUMBER = 1
		AND rownum                   <= 1
		) AS prnt_geoName_edt
	,(SELECT HzGeographies1.GEOGRAPHY_TYPE
		FROM HZ_GEOGRAPHIES HzGeographies1
		,HZ_HIERARCHY_NODES GeoHiererchy
		WHERE GeoHiererchy.PARENT_ID  = HzGeographies1.GEOGRAPHY_ID
		AND GeoHiererchy.CHILD_ID     = HzGeographies.GEOGRAPHY_ID
		AND GeoHiererchy.LEVEL_NUMBER = 1
		AND rownum                   <= 1
		)                            AS prnt_geoType_edt
	,HzGeographies.geography_name AS geoName_edt
	,HzGeographies.geography_type
	,NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') AS REGIME_TYPE_FLAG
	FROM ZX_JURISDICTIONS_VL ZxJurisdictionsVl
	,HZ_GEOGRAPHY_TYPES_VL HzGeoTypes
	,ZX_TAXES_VL TaxTLEO
	,ZX_REGIMES_VL RegimeTLEO
	,HZ_GEOGRAPHIES HzGeographies
	,HZ_GEOGRAPHIES HzGeographiesParent
	WHERE TaxTLEO.SOURCE_TAX_FLAG                    = 'Y'
	AND HzGeoTypes.GEOGRAPHY_TYPE                    = HzGeographies.GEOGRAPHY_TYPE
	AND TaxTLEO.TAX                                  = ZxJurisdictionsVl.TAX
	AND TaxTLEO.TAX_REGIME_CODE                      = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND RegimeTLEO.TAX_REGIME_CODE                   = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND ZxJurisdictionsVl.ZONE_GEOGRAPHY_ID          = HzGeographies.GEOGRAPHY_ID
	AND TaxTLEO.PARENT_GEOGRAPHY_ID                  = HzGeographiesParent.GEOGRAPHY_ID(+)
	) QRSLT
WHERE QRSLT.REGIME_TYPE_FLAG <> 'I'
ORDER BY QRSLT.TAX_JURISDICTION_CODE