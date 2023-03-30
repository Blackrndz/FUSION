/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=ZX_EVNT_CLS_OPTIONS
 
SELECT QRSLT.PARTY_NAME RES_CONFIGURATION_OWNER
,QRSLT.PARTY_TYPE_NAME RES_PARTY_TYPE
,QRSLT.APPLICATION_NAME RES_APPLICATION_NAME
,QRSLT.EVENT_CLASS_NAME RES_EVENT_CLASS
,QRSLT.ENTITY_NAME RES_ENTITY_NAME
,TO_CHAR(QRSLT.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(QRSLT.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,DECODE(QRSLT.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,(SELECT  meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_ROUND_LEVEL_HIER'
	AND lookup_code   = QRSLT.ROUNDING_LEVEL_HIER_1_CODE
	AND language  = userenv('LANG')
	) RES_ROUNDING_PRECEDENCE_1
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_ROUND_LEVEL_HIER'
	AND lookup_code   = QRSLT.ROUNDING_LEVEL_HIER_2_CODE
	AND language  = userenv('LANG')
	) RES_ROUNDING_PRECEDENCE_2
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_ROUND_LEVEL_HIER'
	AND lookup_code   = QRSLT.ROUNDING_LEVEL_HIER_3_CODE
	AND language  = userenv('LANG')
	) RES_ROUNDING_PRECEDENCE_3
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_ROUND_LEVEL_HIER'
	AND lookup_code   = QRSLT.ROUNDING_LEVEL_HIER_4_CODE
	AND language  = userenv('LANG')
	) RES_ROUNDING_PRECEDENCE_4
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_ROUNDING_LEVEL'
	AND lookup_code   = QRSLT.DEFAULT_ROUNDING_LEVEL_CODE
	AND language  = userenv('LANG')
	) RES_ROUNDING_LEVEL
,DECODE(QRSLT.ALLOW_EXEMPTIONS_FLAG,'Y','Yes','No') RES_ALLOW_EXEMPTIONS
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_EXEMPTION_PARTY_BASIS'
	AND lookup_code   = QRSLT.EXMPTN_PTY_BASIS_HIER_1_CODE
	AND language  = userenv('LANG')
	) RES_EXEMPTIONS_PARTY_BASIS_1
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_EXEMPTION_PARTY_BASIS'
	AND lookup_code   = QRSLT.EXMPTN_PTY_BASIS_HIER_2_CODE
	AND language  = userenv('LANG')
	) RES_EXEMPTIONS_PARTY_BASIS_2
,QRSLT.TAX_REG_DET_NAME RES_REGIME_DETERMINATION_SET_N
,QRSLT.DET_FACTOR_TEMPL_CODE RES_REGIME_DETERMINATION_SET_C
,DECODE(QRSLT.PERF_ADDNL_APPL_FOR_IMPRT_FLAG,'Y','Yes','No') RES_PERFORM_ADDITIONAL_APPLICA
,DECODE(QRSLT.ENFORCE_TAX_FROM_REF_DOC_FLAG,'Y','Yes','No') RES_ENFORCE_TAX_FROM_REFERENCE
,DECODE(QRSLT.ENFORCE_TAX_FROM_ACCT_FLAG,'Y','Yes','No') RES_ENFORCE_TAX_FROM_ACCOUNT
,DECODE(QRSLT.ALLOW_OFFSET_TAX_CALC_FLAG,'Y','Yes','No') RES_ALLOW_OFFSET_TAX_CALCULATI
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_OFFSET_TAX_BASIS'
	AND lookup_code   = QRSLT.OFFSET_TAX_BASIS_CODE
	AND language  = userenv('LANG')
	) RES_OFFSET_TAX_BASIS
,DECODE(QRSLT.PROCESS_FOR_APPLICABILITY_FLAG,'Y','Yes','No') RES_ALLOW_TAX_APPLICABILITY
,DECODE(QRSLT.ALLOW_MANUAL_LINES_FLAG,'Y','Yes','No') RES_ALLOW_ENTRY_OF_MANUAL_TAX_
,DECODE(QRSLT.ALLOW_MANUAL_LIN_RECALC_FLAG,'Y','Yes','No') RES_ALLOW_RECALCULATION_OF_MAN
,DECODE(QRSLT.CTRL_EFF_OVRD_CALC_LINES_FLAG,'Y','Yes','No')  RES_SHOW_TAX_CALCULATION_ERROR
,DECODE(QRSLT.ALLOW_OVERRIDE_FLAG,'Y','Yes','No') RES_ALLOW_OVERRIDE_OF_CALCULAT
,DECODE(QRSLT.ENTER_OVRD_INCL_TAX_LINES_FLAG,'Y','Yes','No') RES_ALLOW_OVERRIDE_AND_ENTRY_O
,DECODE(QRSLT.TAX_VARIANCE_CALC_FLAG,'Y','Yes','No') RES_ALLOW_SUPPLIER_TAX_VARIANC
	------------>
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_TAX_POINT_BASIS'
	AND lookup_code   = QRSLT.DEF_TAX_POINT_BASIS
	AND language  = userenv('LANG')
	) RES_DEFAULT_TAX_POINT_BASIS
,DECODE(QRSLT.ACCT_REP_TREATMENT_CODE,NULL,'No','A','Yes') RES_CREATE_ACCOUNTING
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_INCL_TREATMENT_TYPE'
	AND lookup_code   = QRSLT.INCLUSIVE_TREATMENT_CODE
	AND language  = userenv('LANG')
	) RES_INCLUSIVE_TREATMENT_FOR_CA
,QRSLT.TAX_TOLERANCE RES_TOLERANCE_PERCENTAGE
,QRSLT.TAX_TOL_AMT_RANGE RES_TOLERANCE_RANGE_AMOUNT
,(CASE WHEN QRSLT.EVENT_CLASS_NAME = 'Standard Invoices' THEN
		DECODE(ReceiptTaxOption.ENABLED_FLAG,'Y','Yes','No')
	END
) RES_ALLOW_DELIVERY_BASED_TAX_C
,(CASE WHEN QRSLT.EVENT_CLASS_NAME = 'Standard Invoices' THEN
		DECODE(ReceiptTaxOption.PROCESS_FOR_APPLICABILITY_FLAG,'Y','Receipt','N','Invoice')
	END
) RES_REPORT_DELIVERY_BASED_TAXE
,(CASE WHEN QRSLT.EVENT_CLASS_NAME = 'Standard Invoices' THEN
		DECODE(ReceiptTaxOption.DEF_TAX_POINT_BASIS,'DELIVERY','Receipt date','INVOICE','Invoice date')
	END
) RES_TAX_POINT_DATE
,(CASE WHEN QRSLT.EVENT_CLASS_NAME = 'Standard Invoices' THEN
		DECODE(ReceiptTaxOption.PROCESS_FOR_APPLICABILITY_FLAG,'Y','Delivery','N','Invoice')
	END
) RES_TAX_POINT_BASIS
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN QRSLT.party_type_code = 'OU' THEN
		QRSLT.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN QRSLT.party_type_code = 'FIRST_PARTY' THEN
		QRSLT.LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT *
	FROM
		(SELECT ZxEvntClsOptions.ALLOW_EXEMPTIONS_FLAG
		,ZxEvntClsOptions.ALLOW_MANUAL_LIN_RECALC_FLAG
		,ZxEvntClsOptions.ALLOW_MANUAL_LINES_FLAG
		,ZxEvntClsOptions.ALLOW_OFFSET_TAX_CALC_FLAG
		,ZxEvntClsOptions.ALLOW_OVERRIDE_FLAG
		,ZxEvntClsOptions.Allow_User_Api_Extn_Flag
		,ZxEvntClsOptions.Allow_Tax_Param_Extn_Flag
		,ZxEvntClsOptions.APPLICATION_ID
		,ZxEvntClsOptions.CREATED_BY
		,ZxEvntClsOptions.CREATION_DATE
		,ZxEvntClsOptions.CTRL_EFF_OVRD_CALC_LINES_FLAG
		,ZxEvntClsOptions.DEF_INTRCMP_TRX_BIZ_CATEGORY
		,ZxEvntClsOptions.DEFAULT_ROUNDING_LEVEL_CODE
		,ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
		,ZxEvntClsOptions.EFFECTIVE_FROM
		,ZxEvntClsOptions.EFFECTIVE_TO
		,ZxEvntClsOptions.ENFORCE_TAX_FROM_ACCT_FLAG
		,ZxEvntClsOptions.ENFORCE_TAX_FROM_REF_DOC_FLAG
		,ZxEvntClsOptions.ENTER_OVRD_INCL_TAX_LINES_FLAG
		,ZxEvntClsOptions.ENTITY_CODE
		,ZxEvntClsOptions.EVENT_CLASS_CODE
		,ZxEvntClsOptions.EVENT_CLASS_OPTIONS_ID
		,ZxEvntClsOptions.EXMPTN_PTY_BASIS_HIER_1_CODE
		,ZxEvntClsOptions.EXMPTN_PTY_BASIS_HIER_2_CODE
		,ZxEvntClsOptions.FIRST_PTY_ORG_ID
		,ZxEvntClsOptions.LAST_UPDATE_DATE
		,ZxEvntClsOptions.LAST_UPDATE_LOGIN
		,ZxEvntClsOptions.LAST_UPDATED_BY
		,ZxEvntClsOptions.OBJECT_VERSION_NUMBER
		,ZxEvntClsOptions.OFFSET_TAX_BASIS_CODE
		,ZxEvntClsOptions.PERF_ADDNL_APPL_FOR_IMPRT_FLAG
		,ZxEvntClsOptions.PROCESS_FOR_APPLICABILITY_FLAG
		,ZxEvntClsOptions.RECORD_TYPE_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_1_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_2_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_3_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_4_CODE
		,ZxEvntClsOptions.TAX_TOL_AMT_RANGE
		,ZxEvntClsOptions.TAX_TOLERANCE
		,FPO.PARTY_NAME AS PARTY_NAME_SEARCH
		,FndApplicationEO.APPLICATION_NAME
		,XlaEventClassEO.NAME AS EVENT_CLASS_NAME_SEARCH
		,FPO.PARTY_TAX_PROFILE_ID
		,FPO.PARTY_NAME
		,XlaEntityTypeEO.APPLICATION_ID   AS APPLICATION_ID1
		,XlaEntityTypeEO.ENTITY_CODE      AS ENTITY_CODE1
		,XlaEntityTypeEO.NAME             AS ENTITY_NAME
		,XlaEventClassEO.APPLICATION_ID   AS APPLICATION_ID2
		,XlaEventClassEO.ENTITY_CODE      AS ENTITY_CODE2
		,XlaEventClassEO.EVENT_CLASS_CODE AS EVENT_CLASS_CODE1
		,XlaEventClassEO.NAME             AS EVENT_CLASS_NAME
		,FndApplicationEO.APPLICATION_ID  AS APPLICATION_ID3
		,(SELECT DISTINCT t.DET_FACTOR_TEMPL_NAME
			FROM ZX_DET_FACTOR_TEMPL_VL t
			WHERE t.DET_FACTOR_TEMPL_CODE = ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
			)                   AS TAX_REG_DET_NAME
		,fpo1.party_id       AS PartyId
		,ptptype.lookup_code AS party_type_code
		,ptptype.meaning     AS party_type_name
		,(SELECT DISTINCT t.DET_FACTOR_TEMPL_NAME
			FROM ZX_DET_FACTOR_TEMPL_VL t
			WHERE t.DET_FACTOR_TEMPL_CODE = ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
			)               AS TAX_REG_DET_NAME_SRCH
		,ptptype.meaning AS party_type_name_srch
		,FPO.BU_ID BU_ID
		,ZxEvntClsOptions.DEF_TAX_POINT_BASIS
		,ZxEvntClsOptions.TAX_VARIANCE_CALC_FLAG
		,ZxEvntClsOptions.ACCT_REP_TREATMENT_CODE
		,ZxEvntClsOptions.INCLUSIVE_TREATMENT_CODE
		,NVL(ZxEvntClsOptions.INDIRECT_TAX_OR_WHT_FLAG,'I') INDIRECT_TAX_OR_WHT_FLAG
		,ZxEvntClsOptions.PROCESS_FOR_APPLICABILITY_FLAG AS WHT_PROCESS_FOR_APPL_FLAG
		,ZxEvntClsOptions.ALLOW_MANUAL_LINES_FLAG        AS ALLOW_MANUAL_LINES_FLAG1
		,ZxEvntClsOptions.WHT_CALC_POINT_FLAG
		,'Y'                           AS SAVED_RECORD
		,ZxEvntClsOptions.ENABLED_FLAG AS ENABLED_FLAG1
		,ZxEvntClsOptions.Wht_Cash_Discount_Appl_Flag
		,ZxEvntClsOptions.Trx_Tax_Wht_Applicability_Flag
		,ZxEvntClsOptions.Tax_Auth_Inv_Creation_Point
		,ZxEvntClsOptions.PROCESS_FOR_APPLICABILITY_FLAG AS TAX_TREATMENT
		,ZxEvntClsOptions.ENABLED_FLAG
		,ZxEvntClsOptions.DEF_TAX_POINT_BASIS AS TAX_DET_DATE
		,FPO.LEGAL_ENTITY_ID LEGAL_ENTITY_ID
		FROM ZX_EVNT_CLS_OPTIONS ZxEvntClsOptions
		,XLA_ENTITY_TYPES_TL XlaEntityTypeEO
		,XLA_EVENT_CLASSES_TL XlaEventClassEO
		,FND_APPLICATION_TL FndApplicationEO
		,ZX_FIRST_PARTY_ORGS_MOAC_V FPO
		,zx_party_tax_profile fpo1
		,fnd_lookups ptptype
		WHERE ZxEvntClsOptions.FIRST_PTY_ORG_ID = FPO.PARTY_TAX_PROFILE_ID
		AND fpo1.party_tax_profile_id           = fpo.party_tax_profile_id
		AND ZxEvntClsOptions.EVENT_CLASS_CODE   = XlaEventClassEO.EVENT_CLASS_CODE
		AND ZxEvntClsOptions.APPLICATION_ID     = XlaEventClassEO.APPLICATION_ID
		AND ZxEvntClsOptions.ENTITY_CODE        = XlaEventClassEO.ENTITY_CODE
		AND XlaEventClassEO.LANGUAGE            = UserEnv('LANG')
		AND ZxEvntClsOptions.APPLICATION_ID     = FndApplicationEO.APPLICATION_ID
		AND FndApplicationEO.LANGUAGE           = UserEnv('LANG')
		AND ZxEvntClsOptions.ENTITY_CODE        = XlaEntityTypeEO.ENTITY_CODE
		AND ZxEvntClsOptions.APPLICATION_ID     = XlaEntityTypeEO.APPLICATION_ID
		AND XlaEntityTypeEO.LANGUAGE            = UserEnv('LANG')
		AND NOT(ZxEvntClsOptions.APPLICATION_ID = 707
		AND ZxEvntClsOptions.ENTITY_CODE        = 'RCV_ACCOUNTING_EVENTS'
		AND ZxEvntClsOptions.EVENT_CLASS_CODE   = 'RCPT_REC_INSP')
		AND fpo1.party_type_code                = ptptype.lookup_code(+)
		AND ptptype.lookup_type                 = 'ZX_PTP_PARTY_TYPE'
		UNION
		SELECT ZxEvntClsOptions.ALLOW_EXEMPTIONS_FLAG
		,ZxEvntClsOptions.ALLOW_MANUAL_LIN_RECALC_FLAG
		,ZxEvntClsOptions.ALLOW_MANUAL_LINES_FLAG
		,ZxEvntClsOptions.ALLOW_OFFSET_TAX_CALC_FLAG
		,ZxEvntClsOptions.ALLOW_OVERRIDE_FLAG
		,ZxEvntClsOptions.Allow_User_Api_Extn_Flag
		,ZxEvntClsOptions.Allow_Tax_Param_Extn_Flag
		,ZxEvntClsOptions.APPLICATION_ID
		,ZxEvntClsOptions.CREATED_BY
		,ZxEvntClsOptions.CREATION_DATE
		,ZxEvntClsOptions.CTRL_EFF_OVRD_CALC_LINES_FLAG
		,ZxEvntClsOptions.DEF_INTRCMP_TRX_BIZ_CATEGORY
		,ZxEvntClsOptions.DEFAULT_ROUNDING_LEVEL_CODE
		,ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
		,ZxEvntClsOptions.EFFECTIVE_FROM
		,ZxEvntClsOptions.EFFECTIVE_TO
		,ZxEvntClsOptions.ENFORCE_TAX_FROM_ACCT_FLAG
		,ZxEvntClsOptions.ENFORCE_TAX_FROM_REF_DOC_FLAG
		,ZxEvntClsOptions.ENTER_OVRD_INCL_TAX_LINES_FLAG
		,ZxEvntClsOptions.ENTITY_CODE
		,ZxEvntClsOptions.EVENT_CLASS_CODE
		,ZxEvntClsOptions.EVENT_CLASS_OPTIONS_ID
		,ZxEvntClsOptions.EXMPTN_PTY_BASIS_HIER_1_CODE
		,ZxEvntClsOptions.EXMPTN_PTY_BASIS_HIER_2_CODE
		,ZxEvntClsOptions.FIRST_PTY_ORG_ID
		,ZxEvntClsOptions.LAST_UPDATE_DATE
		,ZxEvntClsOptions.LAST_UPDATE_LOGIN
		,ZxEvntClsOptions.LAST_UPDATED_BY
		,ZxEvntClsOptions.OBJECT_VERSION_NUMBER
		,ZxEvntClsOptions.OFFSET_TAX_BASIS_CODE
		,ZxEvntClsOptions.PERF_ADDNL_APPL_FOR_IMPRT_FLAG
		,ZxEvntClsOptions.PROCESS_FOR_APPLICABILITY_FLAG
		,ZxEvntClsOptions.RECORD_TYPE_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_1_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_2_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_3_CODE
		,ZxEvntClsOptions.ROUNDING_LEVEL_HIER_4_CODE
		,ZxEvntClsOptions.TAX_TOL_AMT_RANGE
		,ZxEvntClsOptions.TAX_TOLERANCE
		,FPO.PARTY_NAME AS PARTY_NAME_SEARCH
		,FndApplicationEO.APPLICATION_NAME
		,taxlkp.Meaning AS EVENT_CLASS_NAME_SEARCH
		,FPO.PARTY_TAX_PROFILE_ID
		,FPO.PARTY_NAME
		,ZxEvntClsOptions.APPLICATION_ID   AS APPLICATION_ID1
		,ZxEvntClsOptions.ENTITY_CODE      AS ENTITY_CODE1
		,NULL                              AS ENTITY_NAME
		,ZxEvntClsOptions.APPLICATION_ID   AS APPLICATION_ID2
		,ZxEvntClsOptions.ENTITY_CODE      AS ENTITY_CODE2
		,ZxEvntClsOptions.EVENT_CLASS_CODE AS EVENT_CLASS_CODE1
		,taxlkp.Meaning                    AS EVENT_CLASS_NAME
		,FndApplicationEO.APPLICATION_ID   AS APPLICATION_ID3
		,(SELECT DISTINCT t.DET_FACTOR_TEMPL_NAME
			FROM ZX_DET_FACTOR_TEMPL_VL t
			WHERE t.DET_FACTOR_TEMPL_CODE = ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
			)                   AS TAX_REG_DET_NAME
		,fpo1.party_id       AS PartyId
		,ptptype.lookup_code AS party_type_code
		,ptptype.meaning     AS party_type_name
		,(SELECT DISTINCT t.DET_FACTOR_TEMPL_NAME
			FROM ZX_DET_FACTOR_TEMPL_VL t
			WHERE t.DET_FACTOR_TEMPL_CODE = ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
			)               AS TAX_REG_DET_NAME_SRCH
		,ptptype.meaning AS party_type_name_srch
		,FPO.BU_ID BU_ID
		,ZxEvntClsOptions.DEF_TAX_POINT_BASIS
		,ZxEvntClsOptions.TAX_VARIANCE_CALC_FLAG
		,ZxEvntClsOptions.ACCT_REP_TREATMENT_CODE
		,ZxEvntClsOptions.INCLUSIVE_TREATMENT_CODE
		,NVL(ZxEvntClsOptions.INDIRECT_TAX_OR_WHT_FLAG,'I') INDIRECT_TAX_OR_WHT_FLAG
		,ZxEvntClsOptions.PROCESS_FOR_APPLICABILITY_FLAG AS WHT_PROCESS_FOR_APPL_FLAG
		,ZxEvntClsOptions.ALLOW_MANUAL_LINES_FLAG        AS ALLOW_MANUAL_LINES_FLAG1
		,ZxEvntClsOptions.WHT_CALC_POINT_FLAG
		,'Y'                           AS SAVED_RECORD
		,ZxEvntClsOptions.ENABLED_FLAG AS ENABLED_FLAG1
		,ZxEvntClsOptions.Wht_Cash_Discount_Appl_Flag
		,ZxEvntClsOptions.Trx_Tax_Wht_Applicability_Flag
		,ZxEvntClsOptions.Tax_Auth_Inv_Creation_Point
		,ZxEvntClsOptions.PROCESS_FOR_APPLICABILITY_FLAG AS TAX_TREATMENT
		,ZxEvntClsOptions.ENABLED_FLAG
		,ZxEvntClsOptions.DEF_TAX_POINT_BASIS AS TAX_DET_DATE
		,FPO.LEGAL_ENTITY_ID LEGAL_ENTITY_ID
		FROM ZX_EVNT_CLS_OPTIONS ZxEvntClsOptions
		,FND_APPLICATION_TL FndApplicationEO
		,ZX_FIRST_PARTY_ORGS_MOAC_V FPO
		,zx_party_tax_profile fpo1
		,fnd_lookups ptptype
		,fnd_lookups taxlkp
		WHERE ZxEvntClsOptions.FIRST_PTY_ORG_ID = FPO.PARTY_TAX_PROFILE_ID
		AND fpo1.party_tax_profile_id           = fpo.party_tax_profile_id
		AND ZxEvntClsOptions.EVENT_CLASS_CODE   = taxlkp.Lookup_CODE
		AND ZxEvntClsOptions.APPLICATION_ID     = FndApplicationEO.APPLICATION_ID
		AND FndApplicationEO.LANGUAGE           = UserEnv('LANG')
		AND fpo1.party_type_code                = ptptype.lookup_code(+)
		AND ptptype.lookup_type                 = 'ZX_PTP_PARTY_TYPE'
		AND taxlkp.lookup_type                  = 'ZX_EXTERNAL_EVENT_CLASSES'
		AND ZxEvntClsOptions.application_id     = 235
		) TaxOption
	WHERE TaxOption.EVENT_CLASS_CODE <> 'RECEIVING'
	) QRSLT
,(SELECT FIRST_PTY_ORG_ID
	,EFFECTIVE_FROM
	,EFFECTIVE_TO
	,ENABLED_FLAG
	,PROCESS_FOR_APPLICABILITY_FLAG
	,DEF_TAX_POINT_BASIS
	FROM ZX_EVNT_CLS_OPTIONS ZxEvntClsOptions
	WHERE EVENT_CLASS_CODE = 'RECEIVING'
	) ReceiptTaxOption
WHERE QRSLT.FIRST_PTY_ORG_ID = ReceiptTaxOption.FIRST_PTY_ORG_ID(+)
AND(QRSLT.EFFECTIVE_FROM     = ReceiptTaxOption.EFFECTIVE_FROM(+))
AND QRSLT.INDIRECT_TAX_OR_WHT_FLAG = 'I'
ORDER BY QRSLT.PARTY_NAME
,QRSLT.APPLICATION_NAME
,QRSLT.EVENT_CLASS_NAME