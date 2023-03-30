/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Summarized%20Financial%20Plan%20Types.sql $:
* $Id: Manage Project Templates - Summarized Financial Plan Types.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,DECODE(fpTypesE0.ENABLE_FLAG,'Y','Yes','No') RES_ENABLED_FOR_USE
,'Plan type '||fpTypesE0.PLAN_TYPE_NUMBER RES_PLAN_TYPE
,planTypesE0.NAME RES_FINANCIAL_PLAN_TYPE_NAME
,projTemplatesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,projTemplatesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,projTemplatesE0.CREATED_BY  RSC_CREATED_BY
,projTemplatesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJS_PLAN_TYPES fpTypesE0
,PJO_PLAN_TYPES_TL planTypesE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = fpTypesE0.PROJECT_ID
AND fpTypesE0.USER_PLAN_TYPE_ID = planTypesE0.PLAN_TYPE_ID
AND planTypesE0.LANGUAGE = USERENV('LANG')
ORDER BY projTemplatesE0.NAME
,fpTypesE0.PLAN_TYPE_NUMBER