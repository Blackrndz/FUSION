/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20and%20Withholding%20Tax%20Options%20-%20Withholding%20Tax%20Options.sql $:
 * $Id: Manage Tax Reporting and Withholding Tax Options - Withholding Tax Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT FunBU.BU_NAME AS RES_BUSINESS_UNIT
,(SELECT NAME
	FROM XLA_EVENT_CLASSES_VL
	WHERE EVENT_CLASS_CODE = ZxEvntClsOptions.EVENT_CLASS_CODE
	) AS RES_EVENT_CLASS
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = ZxEvntClsOptions.PROCESS_FOR_APPLICABILITY_FLAG
	),'No')                                                                      AS RES_APPLY_WITHHOLDING
,DECODE(ZxEvntClsOptions.TRX_TAX_WHT_APPLICABILITY_FLAG,'Y','Yes','No') AS RES_PROCESS_TRANSACTION_TAXES
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = ZxEvntClsOptions.ALLOW_MANUAL_LINES_FLAG
	),'No')                                        AS RES_ALLOW_MANUAL_WITHHOLDING
,ZxDetFactorTemplVl.DET_FACTOR_TEMPL_NAME AS RES_REGIME_DETERMINATION_SET
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'ZX_WHT_CALC_POINT'
	AND LOOKUP_CODE   = ZxEvntClsOptions.WHT_CALC_POINT_FLAG)
	,'""') AS RES_CALCULATION_POINT
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'ZX_TAX_AUTH_INV_CRT_POINT'
	AND LOOKUP_CODE   = ZxEvntClsOptions.TAX_AUTH_INV_CREATION_POINT)
	,'""') AS RES_TAX_INVOICE_CREATION_POINT
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = ZxEvntClsOptions.WHT_CASH_DISCOUNT_APPL_FLAG
	),'No') AS RES_INCLUDE_DISCOUNT
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_LEVEL'
	AND LOOKUP_CODE   = ZxEvntClsOptions.DEFAULT_ROUNDING_LEVEL_CODE
	)                                                      AS RES_ROUNDING_LEVEL
,TO_CHAR(ZxEvntClsOptions.EFFECTIVE_FROM,'DD-Mon-YYYY') AS RES_START_DATE
,TO_CHAR(ZxEvntClsOptions.EFFECTIVE_TO,'DD-Mon-YYYY')   AS RES_END_DATE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_WHT_DATE_BASIS'
	AND LOOKUP_CODE   = ZxEvntClsOptions.DEF_TAX_POINT_BASIS
	) RES_TAX_DETERMINATION_DATE
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = ZxEvntClsOptions.ENABLED_FLAG
	) AS RES_ENABLE
,ZxEvntClsOptions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxEvntClsOptions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxEvntClsOptions.CREATED_BY RSC_CREATED_BY
,ZxEvntClsOptions.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,FunBU.BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_EVNT_CLS_OPTIONS ZxEvntClsOptions
,FUN_ALL_BUSINESS_UNITS_V FunBU
,zx_party_tax_profile ZXParty
,AP_SYSTEM_PARAMETERS_ALL AP_SYS
,ZX_DET_FACTOR_TEMPL_VL ZxDetFactorTemplVl
WHERE ZxEvntClsOptions.FIRST_PTY_ORG_ID                                      = ZXParty.PARTY_TAX_PROFILE_ID
AND AP_SYS.ORG_ID                                                            = ZXParty.PARTY_ID
AND ZXParty.PARTY_ID                                                         = FunBU.BU_ID
AND ZxDetFactorTemplVl.DET_FACTOR_TEMPL_CODE                                 = ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
AND DECODE(SUBSTR(ZxDetFactorTemplVl.TEMPLATE_USAGE_CODE,1,3),'WHT','W','I') = 'W'
AND ZXParty.USE_LE_AS_SUBSCRIBER_FLAG = 'N'
ORDER BY RES_BUSINESS_UNIT
,RES_EVENT_CLASS