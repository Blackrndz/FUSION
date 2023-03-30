/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Key%20Performance%20Indicators.sql $:
* $Id: Manage Project Templates - Key Performance Indicators.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT RULE_NAME
    FROM PJS_PERF_RULES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RULE_ID = kpiE0.RULE_ID
    ) RES_NAME
,DECODE(kpiE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED_FOR_USE
,DECODE(kpiE0.FAVE_FLAG,'Y','Yes','No') RES_KPI_WATCHLIST_ITEM
,DECODE(kpiE0.TASK_TRACK_FLAG,'Y','Yes','No') RES_TRACK_KPI_BY_TASK
,DECODE(kpiE0.RESOURCE_TRACK_FLAG,'Y','Yes','No') RES_TRACK_KPI_BY_RESOURCE
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
,PJS_PERF_OBJECT_RULES kpiE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = kpiE0.OBJECT_ID
AND kpiE0.OBJECT_TYPE = 'PA_PROJECTS'
ORDER BY projTemplatesE0.NAME,2