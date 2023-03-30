/* ****************************************************************************
 * $Revision: 54943 $:
 * $Author: paul.wakefield $:
 * $Date: 2016-05-04 13:45:23 +0700 (Wed, 04 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Trading%20Community%20Person%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Trading Community Person Lookups - Standard Lookup Type.sql 54943 2016-05-04 06:45:23Z paul.wakefield $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT DISTINCT payFLOWEO.FLOW_NAME RES_FLOW_PATTERN
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = payFLOWTASK.CATEGORY_TYPE
		AND LOOKUP_TYPE = 'PAY_TASK_CATEGORY' AND LANGUAGE = USERENV('LANG')
		AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_ACTIVITIES_TO_INCLUDE
	

,payFLOWEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payFLOWEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payFLOWEO.CREATED_BY RSC_CREATED_BY
,payFLOWEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_FLOWS_VL payFLOWEO
,PAY_FLOW_TASKS_VL payFLOWTASK
WHERE payFLOWEO.FLOW_ID = payFLOWTASK.BASE_FLOW_ID 
AND payFLOWTASK.CATEGORY_TYPE IS NOT NULL
ORDER BY payFLOWEO.FLOW_NAME