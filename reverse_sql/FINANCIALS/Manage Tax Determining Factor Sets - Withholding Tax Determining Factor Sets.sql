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
,ZxDetFactorTemplVl.DET_FACTOR_TEMPL_NAME RES_TAX_DETERMINING_FACTOR_S_0
,DFUsageLookup.MEANING RES_SET_USAGE
,ZxDetFactorTemplVl.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,(SELECT NAME
	FROM GL_LEDGERS
	WHERE LEDGER_ID = ZxDetFactorTemplVl.LEDGER_ID) RES_LEDGER
,ZxDetFactorTemplVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxDetFactorTemplVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxDetFactorTemplVl.CREATED_BY RSC_CREATED_BY
,ZxDetFactorTemplVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_DET_FACTOR_TEMPL_VL ZxDetFactorTemplVl
,FND_LOOKUPS DFUsageLookup
WHERE DFUsageLookup.lookup_type = 'ZX_TEMPLATE_USAGE'
AND DFUsageLookup.lookup_code = ZxDetFactorTemplVl.TEMPLATE_USAGE_CODE
AND DECODE(SUBSTR(ZxDetFactorTemplVl.TEMPLATE_USAGE_CODE,1,3),'WHT','W','I') <> 'I'
ORDER BY DET_FACTOR_TEMPL_CODE