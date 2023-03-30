/* ****************************************************************************
* $Revision: 61485 $:
* $Author: chanatip.buabhom $:
* $Date: 2017-03-21 17:10:25 +0700 (Tue, 21 Mar 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Expense%20Fields%20by%20Category%20-%20Meals.sql $:
* $Id: Manage Expense Fields by Category - Meals.sql 61485 2017-03-21 10:10:25Z chanatip.buabhom $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_MATRIX_CLASSES_VL

SELECT matrixClassesE0.DYNAMIC_MATRIX_CLASS_NAME RES_NAME
,matrixConditionsE0.DYNAMIC_MATRIX_DIMENSION_NAME RES_RESULT_NAME
,matrixConditionsE0.SOURCE_CODE_NAME RES_SOURCE_CODE_NAME
,DECODE(matrixConditionsE0.REQD_DIMN_FOR_CLASS_EXPR,'Y','Yes','No') RES_REQUIRED
,DECODE(matrixConditionsE0.IS_NULLABLE_FLAG,'Y','Yes','No') RES_ALLOW_NULL
,matrixConditionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,matrixConditionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,matrixConditionsE0.CREATED_BY  RSC_CREATED_BY
,matrixConditionsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_MATRIX_CLASSES_VL matrixClassesE0
,QP_MATRIX_DIMENSIONS_VL matrixConditionsE0
WHERE matrixClassesE0.DYNAMIC_MATRIX_CLASS_ID = matrixConditionsE0.DYNAMIC_MATRIX_CLASS_ID
AND matrixClassesE0.OWNER_APPLICATION = 'pricing'
AND matrixConditionsE0.DIMENSION_TYPE = 'Result'
ORDER BY matrixClassesE0.DYNAMIC_MATRIX_CLASS_NAME
,matrixConditionsE0.DISPLAY_SEQUENCE_NUM