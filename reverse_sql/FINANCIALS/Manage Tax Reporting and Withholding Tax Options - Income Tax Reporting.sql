/* ****************************************************************************
 * $Revision: 78752 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-06-15 11:09:06 +0700 (Wed, 15 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20and%20Withholding%20Tax%20Options%20-%20Income%20Tax%20Reporting.sql $:
 * $Id: Manage Tax Reporting and Withholding Tax Options - Income Tax Reporting.sql 78752 2022-06-15 04:09:06Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT DISTINCT
	(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = AP_SYS.ORG_ID
	) AS RES_BUSINESS_UNIT
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = AP_SYS.COMBINED_FILING_FLAG
	),'No') AS RES_USE_COMBINED_FILING_PROGRA
,DECODE(AP_SYS.INCOME_TAX_REGION_FLAG,'Y','Yes','No') AS RES_USE_SUPPLIER_TAX_REGION
,(SELECT REGION_LONG_NAME
	FROM AP_INCOME_TAX_REGIONS
	WHERE REGION_SHORT_NAME = AP_SYS.INCOME_TAX_REGION
	) AS RES_INCOME_TAX_REGION
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = AP_SYS.ENABLE_1099_ON_AWT_FLAG
	),'No') AS RES_INCLUDE_WITHHOLDING_DISTRI
,AP_SYS.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,AP_SYS.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,AP_SYS.CREATED_BY  RSC_CREATED_BY
,AP_SYS.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,AP_SYS.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_SYSTEM_PARAMETERS_ALL AP_SYS 
,zx_party_tax_profile ZXParty
,ZX_EVNT_CLS_OPTIONS ZxEvntClsOptions
,ZX_DET_FACTOR_TEMPL_VL ZxDetFactorTemplVl
WHERE ZxEvntClsOptions.FIRST_PTY_ORG_ID = ZXParty.PARTY_TAX_PROFILE_ID
AND AP_SYS.ORG_ID = ZXParty.PARTY_ID
AND ZxDetFactorTemplVl.DET_FACTOR_TEMPL_CODE = ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE
AND DECODE(SUBSTR(ZxDetFactorTemplVl.TEMPLATE_USAGE_CODE,1,3),'WHT','W','I') = 'W'
AND ZXParty.USE_LE_AS_SUBSCRIBER_FLAG = 'N'
/*AP_SYS.ORG_ID = (SELECT PARTY_ID
		FROM zx_party_tax_profile
		WHERE PARTY_TAX_PROFILE_ID = ZxEvntClsOptions.FIRST_PTY_ORG_ID
		)*/
ORDER BY RES_BUSINESS_UNIT