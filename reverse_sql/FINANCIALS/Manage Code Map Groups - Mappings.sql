/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT CodeMapGroupEO.CODE_MAP_GROUP_NAME RES_NAME
,CodeMapFieldEO.CODE_MAP_FIELD_NAME RES_FIELD
,CodeMapFieldEO.INPUT_VALUE_SET RES_INPUT_VALUES_LOOKUP_TYPE
,CodeMapFieldEO.OUTPUT_VALUE_SET RES_OUTPUT_VALUES_LOOKUP_TYPE
,CodeMapFieldEO.DEFAULT_VALUE RES_DEFAULT_OUTPUT_VALUE
,DECODE(CodeMapFieldEO.RETURN_INPUT_FLAG,'Y','Yes','No') RES_RETURN_INPUT_IF_NO_MATCH
,CodeMapFieldEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CodeMapFieldEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CodeMapFieldEO.CREATED_BY RSC_CREATED_BY
,CodeMapFieldEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_CODE_MAP_GROUPS_VL CodeMapGroupEO
,IBY_CODE_MAP_FIELDS CodeMapFieldEO
WHERE CodeMapFieldEO.CODE_MAP_GROUP_CODE = CodeMapGroupEO.CODE_MAP_GROUP_CODE
ORDER BY RES_NAME
,RES_FIELD