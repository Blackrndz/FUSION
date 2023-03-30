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
,matrixClassesE0.CONTEXT_CONSUMER RES_SERVICE
,DECODE(matrixClassesE0.ADD_NEW_DIMENSIONS_FLAG,'Y','Yes','No') RES_CAN_ADD_NEW_COLUMNS
,DECODE(matrixClassesE0.DATE_EFF_ENABLED_FLAG,'Y','Yes','No') RES_DATE_EFFECTIVITY_ENABLED
,DECODE(matrixClassesE0.PUBLIC_FLAG,'Y','Yes','No') RES_PUBLIC
,matrixClassesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,matrixClassesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,matrixClassesE0.CREATED_BY  RSC_CREATED_BY
,matrixClassesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_MATRIX_CLASSES_VL matrixClassesE0
WHERE matrixClassesE0.OWNER_APPLICATION = 'pricing'
ORDER BY matrixClassesE0.DYNAMIC_MATRIX_CLASS_NAME
