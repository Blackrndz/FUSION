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
,QRSLT.TAX_JURISDICTION_NAME RES_TAX_JURISDICTION_NAME
,QRSLT.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,QRSLT.TAX RES_TAX
,QRSLT.GEOGRAPHY_TYPE RES_GEOGRAPHY_TYPE
,QRSLT.GEOGRAPHY_NAME RES_GEOGRAPHY_NAME
,QRSLT.prnt_geoType_edt RES_PARENT_GEOGRAPHY_TYPE
,QRSLT.prnt_geoName_edt RES_PARENT_GEOGRAPHY_NAME
,DECODE(QRSLT.INNER_CITY_JURISDICTION_FLAG,'Y','Yes','No') RES_INNER_CITY_JURISDICTION
,QRSLT.PRECEDENCE_LEVEL RES_PRECEDENCE_LEVEL
,QRSLT.RepTaxAuthName RES_REPORTING_TAX_AUTHORITY
,QRSLT.CollTaxAuthName RES_COLLECTING_TAX_AUTHORITY
,TO_CHAR(QRSLT.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(QRSLT.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,NVL(QRSLT.Validation_Type,'""') RES_VALIDATION_TYPE
,NVL((SELECT meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = 'ZX_VALIDATION_LEVEL'
	AND lookup_code   = QRSLT.Validation_Level
	),'""') RES_VALIDATION_LEVEL
,NVL((SELECT meaning
	FROM fnd_lookup_values_vl
	WHERE lookup_type = 'ZX_UNIQUENESS_VALIDATION_LVL'
	AND lookup_code   = QRSLT.Uniqueness_Validation_Level
	),'""') RES_DUPLICATE_VALIDATION_LEVEL
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
	(SELECT ZxJurisdictionsVl.TAX_JURISDICTION_ID
	,ZxJurisdictionsVl.TAX_JURISDICTION_CODE
	,ZxJurisdictionsVl.EFFECTIVE_FROM
	,ZxJurisdictionsVl.EFFECTIVE_TO
	,ZxJurisdictionsVl.TAX_REGIME_CODE
	,ZxJurisdictionsVl.REP_TAX_AUTHORITY_ID
	,ZxJurisdictionsVl.COLL_TAX_AUTHORITY_ID
	,ZxJurisdictionsVl.ZONE_GEOGRAPHY_ID
	,ZxJurisdictionsVl.TAX
	,ZxJurisdictionsVl.DEFAULT_JURISDICTION_FLAG
	,ZxJurisdictionsVl.DEFAULT_FLG_EFFECTIVE_FROM
	,ZxJurisdictionsVl.DEFAULT_FLG_EFFECTIVE_TO
	,ZxJurisdictionsVl.INNER_CITY_JURISDICTION_FLAG
	,ZxJurisdictionsVl.PRECEDENCE_LEVEL
	,ZxJurisdictionsVl.ALLOW_TAX_REGISTRATIONS_FLAG
	,ZxJurisdictionsVl.OBJECT_VERSION_NUMBER
	,ZxJurisdictionsVl.TAX_ACCT_SRC_JURISDICT_ID
	,ZxJurisdictionsVl.TAX_EXMPT_SRC_JURISDICT_ID
	,ZxJurisdictionsVl.RECORD_TYPE_CODE
	,ZxJurisdictionsVl.CREATED_BY
	,ZxJurisdictionsVl.CREATION_DATE
	,ZxJurisdictionsVl.LAST_UPDATED_BY
	,ZxJurisdictionsVl.LAST_UPDATE_DATE
	,ZxJurisdictionsVl.LAST_UPDATE_LOGIN
	,ZxJurisdictionsVl.TAX_JURISDICTION_NAME
	,RegimeTLEO.COUNTRY_OR_GROUP_CODE REGIME_LEVEL_SRCH
	,FND_TERRITORIES_VL.TERRITORY_SHORT_NAME AS COUNTRY_NAME_SRCH
	,HzGeoTypes.GEOGRAPHY_TYPE GEOGRAPHY_TYPE_NAME_srch
	,RegimeTLEO.COUNTRY_CODE COUNTRY_CODE_SRCH
	,HzGeographies.GEOGRAPHY_TYPE ZONE_GEOGRAPHY_TYPE
	,HzGeographies.GEOGRAPHY_CODE
	,RepTaxAuthorities.PARTY_NAME RepTaxAuthName
	,CollTaxAuthorities.PARTY_NAME CollTaxAuthName
	,TaxTLEO.CONTENT_OWNER_ID
	,HzGeographies.GEOGRAPHY_NAME
	,HzGeoTypes.GEOGRAPHY_TYPE_NAME
	,TaxTLEO.TAX_FULL_NAME
	,RegimeTLEO.TAX_REGIME_NAME
	,NULL AS CODE_DUPLICATED
	,DECODE(HzGeographies.GEOGRAPHY_TYPE,TaxTLEO.ZONE_GEOGRAPHY_TYPE,TaxTLEO.PARENT_GEOGRAPHY_TYPE,NULL)
		PARENT_GEOGRAPHY_TYPE
	,DECODE(HzGeographies.GEOGRAPHY_TYPE,TaxTLEO.ZONE_GEOGRAPHY_TYPE,HzGeographiesParent.GEOGRAPHY_NAME,NULL)
		PARENT_GEOGRAPHY_NAME
	,'ZX_JURISDICTIONS'                     AS ENTITY_CODE
	,'JURISDICTION'                         AS TAX_ACNT_ENTITY_CODE
	,TaxTLEO.TAX_ACCOUNT_SOURCE_TAX         AS TAX_ACCOUNT_SOURCE_TAX
	,TaxTLEO.TAX_ACCOUNT_CREATE_METHOD_CODE AS TAX_ACCOUNT_CREATE_METHOD_CODE
	,TaxTLEO.TAX_EXMPT_SOURCE_TAX
	,TaxTLEO.TAX_EXMPT_CR_METHOD_CODE
	,AccJur.TAX_JURISDICTION_CODE  AS ACC_JURISDICTION_CODE
	,ExmpJur.TAX_JURISDICTION_CODE AS EXMP_JURISDICTION_CODE
	,HzGeographies.GEOGRAPHY_USE
	,ZxJurisdictionsVl.TAX_REGIME_CODE TRANS_REGIME_CODE
	,ZxJurisdictionsVl.TAX TRANS_TAX
	,TaxTLEO.parent_geography_id parent_geography_id
	,RegimeTLEO.has_other_jurisdictions_flag AS Allow_Multiple_Jurisdictions
	,(SELECT party_name
		FROM zx_first_party_orgs_moac_v ZFPMV
		WHERE ZFPMV.party_tax_profile_id = TaxTLEO.content_owner_id
		)                            AS content_owner
	,HzGeographies.geography_type AS geo_typeName_edt
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
	,'N'                          AS Default_juris_status
	,CASE
			WHEN ZxJurisdictionsVl.effective_to IS NULL
			THEN 'Y'
			WHEN SYSDATE > ZxJurisdictionsVl.effective_to
			THEN 'N'
			ELSE 'Y'
		END                                  AS effective_to_status
	,TaxTLEO.has_other_jurisdictions_flag AS Allow_Multiple_Tax_Juris
	,TaxTLEO.zone_geography_type          AS TaxGeoType
	,TaxTLEO.override_geography_type
	,(SELECT DISTINCT 'Y'
		FROM ZX_REPORTING_TYPES_B
		WHERE TAX_REGIME_CODE = ZxJurisdictionsVl.TAX_REGIME_CODE
		) REP_EXIST
	,TaxTLEO.DEF_INCLUSIVE_TAX_FLAG
	,TaxTLEO.TAX_INCLUSIVE_OVERRIDE_FLAG
	,ZxJurisdictionsVl.Validation_Type
	,ZxJurisdictionsVl.Validation_Level
	,ZxJurisdictionsVl.Uniqueness_Validation_Level
	,ZxJurisdictionsVl.WHT_BUCKET_LEVEL_FLAG
	,NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') AS REGIME_TYPE_FLAG
	,CASE
			WHEN(SELECT THRSHLD_SCHEDULE_GRP_LVL_FLAG
				FROM ZX_THREHLDS_SCHDL_CNTRLS_F sch
				WHERE sch.tax                            = TaxTLEO.tax
				AND sch.tax_regime_code                  = TaxTLEO.tax_regime_code
				AND sch.content_owner_id                 = TaxTLEO.content_owner_id
				AND sch.tax_jurisdiction_code            = ZxJurisdictionsVl.tax_jurisdiction_code
				AND NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') = 'I'
				AND rownum                               = 1) IS NULL
			THEN 'L'
			ELSE
				(SELECT THRSHLD_SCHEDULE_GRP_LVL_FLAG
				FROM ZX_THREHLDS_SCHDL_CNTRLS_F sch
				WHERE sch.tax                            = TaxTLEO.tax
				AND sch.tax_regime_code                  = TaxTLEO.tax_regime_code
				AND sch.content_owner_id                 = TaxTLEO.content_owner_id
				AND sch.tax_jurisdiction_code            = ZxJurisdictionsVl.tax_jurisdiction_code
				AND NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I') = 'I'
				AND rownum                               = 1
				)
		END AS taxable_basis
	,HzGeographiesParent.geography_name PRNT_GEO_NAME_FRM_TAX
	,TaxTLEO.allow_recoverability_flag
	FROM ZX_JURISDICTIONS_VL ZxJurisdictionsVl
	,HZ_GEOGRAPHY_TYPES_VL HzGeoTypes
	,ZX_TAXES_VL TaxTLEO
	,ZX_REGIMES_VL RegimeTLEO
	,ZX_JURISDICTIONS_B AccJur
	,ZX_JURISDICTIONS_B ExmpJur
	,HZ_GEOGRAPHIES HzGeographies
	,HZ_GEOGRAPHIES HzGeographiesParent
	,HZ_PARTIES RepTaxAuthorities
	,HZ_PARTIES CollTaxAuthorities
	,ZX_PARTY_TAX_PROFILE RepPTP
	,ZX_PARTY_TAX_PROFILE COllPTP
	,FND_TERRITORIES_VL
	WHERE TaxTLEO.SOURCE_TAX_FLAG                    = 'Y'
	AND HzGeoTypes.GEOGRAPHY_TYPE                    = HzGeographies.GEOGRAPHY_TYPE
	AND TaxTLEO.TAX                                  = ZxJurisdictionsVl.TAX
	AND TaxTLEO.TAX_REGIME_CODE                      = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND RegimeTLEO.TAX_REGIME_CODE                   = ZxJurisdictionsVl.TAX_REGIME_CODE
	AND ZxJurisdictionsVl.ZONE_GEOGRAPHY_ID          = HzGeographies.GEOGRAPHY_ID
	AND TaxTLEO.PARENT_GEOGRAPHY_ID                  = HzGeographiesParent.GEOGRAPHY_ID(+)
	AND ZxJurisdictionsVl.TAX_ACCT_SRC_JURISDICT_ID  = AccJur.TAX_JURISDICTION_ID(+)
	AND ZxJurisdictionsVl.TAX_EXMPT_SRC_JURISDICT_ID = ExmpJur.TAX_JURISDICTION_ID(+)
	AND ZxJurisdictionsVl.REP_TAX_AUTHORITY_ID       = RepPTP.PARTY_TAX_PROFILE_ID (+)
	AND RepPTP.PARTY_ID                              = RepTaxAuthorities.PARTY_ID (+)
	AND ZxJurisdictionsVl.COLL_TAX_AUTHORITY_ID      = CollPTP.PARTY_TAX_PROFILE_ID (+)
	AND CollPTP.PARTY_ID                             = CollTaxAuthorities.PARTY_ID (+)
	AND FND_TERRITORIES_VL.TERRITORY_CODE(+)         = RegimeTLEO.COUNTRY_CODE
	) QRSLT
WHERE QRSLT.REGIME_TYPE_FLAG = 'I'
ORDER BY QRSLT.TAX_JURISDICTION_CODE