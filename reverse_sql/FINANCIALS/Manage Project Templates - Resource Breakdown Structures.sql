/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Resource%20Breakdown%20Structures.sql $:
* $Id: Manage Project Templates - Resource Breakdown Structures.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(CASE
	WHEN resBreakdownE0.PRIMARY_REPORTING_RBS_FLAG = 'Y' THEN
		'Planning and reporting'
	WHEN resBreakdownE0.PRIMARY_PLANNING_RBS_FLAG = 'Y' AND resBreakdownE0.PRIMARY_REPORTING_RBS_FLAG = 'N' THEN 
		'Planning'
	END) RES_PRIMARY
,(CASE
	WHEN EXISTS (SELECT 1 FROM PJF_RBS_HEADERS_VL WHERE RBS_HEADER_ID = resourcesE0.SOURCE_RBS_HEADER_ID AND RBS_TYPE = 'PLANNING') THEN 
		(SELECT NAME FROM PJF_RBS_HEADERS_VL WHERE RBS_HEADER_ID = resourcesE0.SOURCE_RBS_HEADER_ID AND RBS_TYPE = 'PLANNING')
	ELSE 
		resourcesE0.NAME 
	END) RES_NAME
,(CASE
	WHEN resBreakdownE0.REPORTING_USAGE_FLAG = 'Y' THEN
		'Planning and reporting'
	WHEN resBreakdownE0.PLANNING_USAGE_FLAG = 'Y' AND resBreakdownE0.REPORTING_USAGE_FLAG = 'N' THEN 
		'Planning'
	END) RES_USAGE
,resBreakdownE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,resBreakdownE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,resBreakdownE0.CREATED_BY  RSC_CREATED_BY
,resBreakdownE0.CREATION_DATE  RSC_CREATION_DATE
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
,PJF_RBS_PRJ_ASSIGNMENTS resBreakdownE0
,PJF_RBS_HEADERS_VL resourcesE0
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = resBreakdownE0.PROJECT_ID
AND resBreakdownE0.RBS_HEADER_ID = resourcesE0.RBS_HEADER_ID
ORDER BY projTemplatesE0.NAME
,DECODE(resBreakdownE0.PRIMARY_REPORTING_RBS_FLAG,'Y',1,2)