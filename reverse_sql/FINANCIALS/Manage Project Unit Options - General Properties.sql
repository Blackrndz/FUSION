/* ****************************************************************************
 * $Revision: 63805 $:
 * $Author: phermwit.seethong $:
 * $Date: 2017-09-12 15:37:52 +0700 (Tue, 12 Sep 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Revaluations%20-%20Revaluations.sql $:
 * $Id: Manage Revaluations - Revaluations.sql 63805 2017-09-12 08:37:52Z phermwit.seethong $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT ORG_INFORMATION1
    FROM HR_ORGANIZATION_INFORMATION_F
    WHERE ORG_INFORMATION_CONTEXT = 'PRJ_PU_ATTRIBUTES'
    AND ORGANIZATION_ID = org.ORGANIZATION_ID) RES_CODE
,org.NAME RES_NAME
,(SELECT SET_NAME
    FROM FND_SETID_SETS
    WHERE LANGUAGE = USERENV('LANG')
    AND SET_ID = puImpleE0.DEFAULT_SET_ID
    ) RES_DEFAULT_SET
,(SELECT MEANING 
            FROM FND_LOOKUPS
            WHERE LOOKUP_TYPE = 'PJF_PROJECT_NUMBER_ENTRY'
            AND LOOKUP_CODE = puImpleE0.USER_DEFINED_PROJECT_NUM_CODE) RES_METHOD
,(SELECT MEANING 
            FROM FND_LOOKUPS
            WHERE LOOKUP_TYPE = 'PJF_MANUAL_PROJECT_NUMBER'
            AND LOOKUP_CODE = puImpleE0.MANUAL_PROJECT_NUM_TYPE)  RES_TYPE
,(CASE WHEN reportSettingsE0.EXTR_PLAN_FLAG IN ('SY','UY') THEN
	(SELECT MEANING 
            FROM FND_LOOKUPS
            WHERE LOOKUP_TYPE = 'PJF_PLANNING_AMT_ALLOCATION'
            AND LOOKUP_CODE = reportSettingsE0.PLANAMT_ALLOC_METHOD)
				    END) RES_PLANNING_AMOUNT_ALLOCATION

/*,puImpleE0.FTE_DAY RES_DAILY
,puImpleE0.FTE_WEEK RES_WEEKLY*/
,puImpleE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,puImpleE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,puImpleE0.CREATED_BY RSC_CREATED_BY
,puImpleE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,org.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ALL_ORGANIZATION_UNITS org
,PJF_PU_IMPL puImpleE0
,PJF_PU_REPORTING_SETTINGS reportSettingsE0
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
AND puImpleE0.PU_ID = reportSettingsE0.PU_ID
ORDER BY 1