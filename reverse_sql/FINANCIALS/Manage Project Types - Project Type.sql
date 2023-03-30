/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Types%20-%20Project%20Type.sql $:
 * $Id: Manage Project Types - Project Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT pjfPROTypeE0.PROJECT_TYPE RES_NAME
 ,fndSETidE0.SET_NAME RES_SET
 ,pjfPROTypeE0.DESCRIPTION RES_DESCRIPTION
 ,TO_CHAR(pjfPROTypeE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
 ,TO_CHAR(pjfPROTypeE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
 ,pjfWORKTypeE0.NAME	RES_WORK_TYPE
 ,DECODE(pjfPROTypeE0.BURDEN_COST_FLAG,'Y','Yes','No') RES_ENABLE_BURDENING
 ,DECODE(pjfPROTypeE0.ENABLE_BILLING_FLAG,'Y','Yes','No') RES_ENABLE_BILLING
 ,DECODE(pjfPROTypeE0.ENABLE_CAPITALIZATION_FLAG,'Y','Yes','No') RES_ENABLE_CAPITALIZATION
 ,DECODE(pjfPROTypeE0.SPONSORED_FLAG,'Y','Yes','No') RES_ENABLE_SPONSORED_PROJECTS
 ,pjfPROTypeE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,pjfPROTypeE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,pjfPROTypeE0.CREATED_BY RSC_CREATED_BY
 ,pjfPROTypeE0.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECT_TYPES_VL pjfPROTypeE0
,FND_SETID_SETS fndSETidE0
,PJF_WORK_TYPES_VL pjfWORKTypeE0
WHERE pjfPROTypeE0.SET_ID = fndSETidE0.SET_ID
AND pjfPROTypeE0.LANGUAGE = fndSETidE0.LANGUAGE
AND pjfPROTypeE0.WORK_TYPE_ID = pjfWORKTypeE0.WORK_TYPE_ID (+)
ORDER BY pjfPROTypeE0.PROJECT_TYPE