/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Distribution%20Sets%20-%20Distribution%20Set%20Details.sql $:
 * $Id: Manage Distribution Sets - Distribution Set Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- FIELD_TO_APPLY_FUNCTION=RES_DISTRIBUTION_COMBINATION/GET_CODE_COMBINATION

SELECT BUSINESSUNITPEO.BU_NAME RES_BUSINESS_UNIT
,APDISTRIBUTIONSETSALL.DISTRIBUTION_SET_NAME RES_NAME
,APDISTRIBUTIONSETLINESALL.DISTRIBUTION_SET_LINE_NUMBER RES_LINE
,APDISTRIBUTIONSETLINESALL.PERCENT_DISTRIBUTION RES_DISTRIBUTION
,APDISTRIBUTIONSETLINESALL.DESCRIPTION RES_DESCRIPTION
,APDISTRIBUTIONSETLINESALL.DIST_CODE_COMBINATION_ID RES_DISTRIBUTION_COMBINATION
,NULL RES_COMBINATION_DESCRIPTION
,APINCOMETAXTYPES.DESCRIPTION RES_INCOME_TAX_TYPE
,APDISTRIBUTIONSETLINESALL.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,APDISTRIBUTIONSETLINESALL.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,APDISTRIBUTIONSETLINESALL.CREATED_BY RSC_CREATED_BY
,APDISTRIBUTIONSETLINESALL.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,APDISTRIBUTIONSETLINESALL.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUN_ALL_BUSINESS_UNITS_V BUSINESSUNITPEO
,AP_DISTRIBUTION_SETS_ALL APDISTRIBUTIONSETSALL
,AP_DISTRIBUTION_SET_LINES_ALL APDISTRIBUTIONSETLINESALL
,AP_INCOME_TAX_TYPES ApIncomeTaxTypes
WHERE BUSINESSUNITPEO.BU_ID                   = APDISTRIBUTIONSETSALL.ORG_ID
AND APDISTRIBUTIONSETSALL.DISTRIBUTION_SET_ID = APDISTRIBUTIONSETLINESALL.DISTRIBUTION_SET_ID
AND APDISTRIBUTIONSETLINESALL.TYPE_1099       = APINCOMETAXTYPES.INCOME_TAX_TYPE(+)
ORDER BY BUSINESSUNITPEO.BU_NAME
,APDISTRIBUTIONSETSALL.DISTRIBUTION_SET_NAME
,APDISTRIBUTIONSETLINESALL.DISTRIBUTION_SET_LINE_NUMBER