/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT fcCodesE0.CLASSIFICATION_CODE RES_CODE
,reportingTypesE0.REPORTING_TYPE_NAME RES_TAX_REPORTING_TYPE_CODE
,(SELECT MEANING
  FROM FND_LOOKUPS
  WHERE LOOKUP_TYPE = 'ZX_REPORTING_DATA'
  AND LOOKUP_CODE = reportingTypesE0.REPORTING_TYPE_DATATYPE_CODE
  ) RES_DATA_TYPE
,NVL(reportCodeAsscE0.REPORTING_CODE_CHAR_VALUE
  ,NVL(TO_CHAR(reportCodeAsscE0.REPORTING_CODE_DATE_VALUE,'DD-Mon-YYYY'),TO_CHAR(reportCodeAsscE0.REPORTING_CODE_NUM_VALUE))
  ) RES_TAX_REPORTING_CODE
,reportingCodesE0.REPORTING_CODE_NAME RES_DESCRIPTION
,TO_CHAR(reportCodeAsscE0.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(reportCodeAsscE0.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,reportCodeAsscE0.CREATED_BY AS RSC_CREATED_BY
,reportCodeAsscE0.CREATION_DATE AS RSC_CREATION_DATE
,reportCodeAsscE0.LAST_UPDATED_BY AS RSC_LAST_UPDATED_BY
,reportCodeAsscE0.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM ZX_FC_CODES_VL fcCodesE0
,ZX_REPORT_CODES_ASSOC reportCodeAsscE0
,ZX_REPORTING_TYPES_VL reportingTypesE0
,ZX_REPORTING_CODES_VL reportingCodesE0
WHERE fcCodesE0.CLASSIFICATION_TYPE_CODE = 'PRODUCT_CATEGORY'
AND fcCodesE0.PARENT_CLASSIFICATION_ID IS NULL
AND fcCodesE0.CLASSIFICATION_ID = reportCodeAsscE0.ENTITY_ID
AND reportCodeAsscE0.ENTITY_CODE = 'ZX_FC_CODES_B'
AND reportCodeAsscE0.REPORTING_TYPE_ID = reportingTypesE0.REPORTING_TYPE_ID
AND reportCodeAsscE0.REPORTING_CODE_ID = reportingCodesE0.REPORTING_CODE_ID(+)
ORDER BY fcCodesE0.CLASSIFICATION_CODE
,reportingTypesE0.REPORTING_TYPE_NAME
,NVL(reportCodeAsscE0.REPORTING_CODE_CHAR_VALUE
  ,NVL(TO_CHAR(reportCodeAsscE0.REPORTING_CODE_DATE_VALUE,'DD-Mon-YYYY'),TO_CHAR(reportCodeAsscE0.REPORTING_CODE_NUM_VALUE)))