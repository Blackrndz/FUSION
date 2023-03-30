/* ****************************************************************************
 * $Revision: 63805 $:
 * $Author: phermwit.seethong $:
 * $Date: 2017-09-12 15:37:52 +0700 (Tue, 12 Sep 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Revaluations%20-%20Revaluations.sql $:
 * $Id: Manage Revaluations - Revaluations.sql 63805 2017-09-12 08:37:52Z phermwit.seethong $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT RES_CODE
,RES_NAME
,RES_COMMITMENT_TYPE
,RES_INCLUDE_IN_SUMMARIZATION
,RES_STATUS
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,RSC_LEDGER_ID
,RSC_CHART_OF_ACCOUNTS_ID
,RSC_BUSINESS_UNIT_ID
,RSC_LEGAL_ENTITY_ID
,RSC_ORGANIZATION_ID
,RSC_BUSINESS_GROUP_ID
,RSC_ENTERPRISE_ID
,RSC_COUNTRY_ID

FROM 
(SELECT (SELECT ORG_INFORMATION1
    FROM HR_ORGANIZATION_INFORMATION_F
    WHERE ORG_INFORMATION_CONTEXT = 'PRJ_PU_ATTRIBUTES'
    AND ORGANIZATION_ID = org.ORGANIZATION_ID) RES_CODE
,org.NAME RES_NAME
,'Requisitions' RES_COMMITMENT_TYPE
,reportSettingsE0.ENABLE RES_INCLUDE_IN_SUMMARIZATION
,(SELECT MEANING FROM FND_LOOKUPS
     WHERE LOOKUP_TYPE = 'PJF_COMMITMENT_STATUS' AND LOOKUP_CODE = reportSettingsE0.COMMITMENT_STATUS_REQ) RES_STATUS
,reportSettingsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,reportSettingsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,reportSettingsE0.CREATED_BY RSC_CREATED_BY
,reportSettingsE0.CREATION_DATE RSC_CREATION_DATE
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
,(SELECT PU_ID,COMMITMENT_STATUS_REQ,DECODE(COMMITMENT_STATUS_REQ,'N','No','Yes') AS ENABLE 
	,LAST_UPDATED_BY,LAST_UPDATE_DATE,CREATED_BY,CREATION_DATE FROM PJF_PU_REPORTING_SETTINGS) reportSettingsE0 
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
AND puImpleE0.PU_ID = reportSettingsE0.PU_ID

UNION

SELECT (SELECT ORG_INFORMATION1
    FROM HR_ORGANIZATION_INFORMATION_F
    WHERE ORG_INFORMATION_CONTEXT = 'PRJ_PU_ATTRIBUTES'
    AND ORGANIZATION_ID = org.ORGANIZATION_ID) RES_CODE
,org.NAME RES_NAME
,'Purchase orders' RES_COMMITMENT_TYPE
,reportSettingsE0.ENABLE RES_INCLUDE_IN_SUMMARIZATION
,(SELECT MEANING FROM FND_LOOKUPS
     WHERE LOOKUP_TYPE = 'PJF_COMMITMENT_STATUS' AND LOOKUP_CODE = reportSettingsE0.COMMITMENT_STATUS_PO) RES_STATUS
,reportSettingsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,reportSettingsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,reportSettingsE0.CREATED_BY RSC_CREATED_BY
,reportSettingsE0.CREATION_DATE RSC_CREATION_DATE
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
,(SELECT PU_ID,COMMITMENT_STATUS_PO,DECODE(COMMITMENT_STATUS_PO,'N','No','Yes') AS ENABLE 
	,LAST_UPDATED_BY,LAST_UPDATE_DATE,CREATED_BY,CREATION_DATE FROM PJF_PU_REPORTING_SETTINGS) reportSettingsE0 
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
AND puImpleE0.PU_ID = reportSettingsE0.PU_ID

UNION

SELECT (SELECT ORG_INFORMATION1
    FROM HR_ORGANIZATION_INFORMATION_F
    WHERE ORG_INFORMATION_CONTEXT = 'PRJ_PU_ATTRIBUTES'
    AND ORGANIZATION_ID = org.ORGANIZATION_ID) RES_CODE
,org.NAME RES_NAME
,'Supplier invoices' RES_COMMITMENT_TYPE 
,reportSettingsE0.ENABLE RES_INCLUDE_IN_SUMMARIZATION
,(SELECT MEANING FROM FND_LOOKUPS
     WHERE LOOKUP_TYPE = 'PJF_COMMITMENT_STATUS' AND LOOKUP_CODE = reportSettingsE0.COMMITMENT_STATUS_SUPINV) RES_STATUS
,reportSettingsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,reportSettingsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,reportSettingsE0.CREATED_BY RSC_CREATED_BY
,reportSettingsE0.CREATION_DATE RSC_CREATION_DATE
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
,(SELECT PU_ID,COMMITMENT_STATUS_SUPINV,DECODE(COMMITMENT_STATUS_SUPINV,'N','No','Yes') AS ENABLE
,LAST_UPDATED_BY,LAST_UPDATE_DATE,CREATED_BY,CREATION_DATE FROM PJF_PU_REPORTING_SETTINGS) reportSettingsE0 
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
AND puImpleE0.PU_ID = reportSettingsE0.PU_ID

UNION

SELECT (SELECT ORG_INFORMATION1
    FROM HR_ORGANIZATION_INFORMATION_F
    WHERE ORG_INFORMATION_CONTEXT = 'PRJ_PU_ATTRIBUTES'
    AND ORGANIZATION_ID = org.ORGANIZATION_ID) RES_CODE
,org.NAME RES_NAME
,'Other commitments' RES_COMMITMENT_TYPE
,reportSettingsE0.ENABLE RES_INCLUDE_IN_SUMMARIZATION
,NULL RES_STATUS
,reportSettingsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,reportSettingsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,reportSettingsE0.CREATED_BY RSC_CREATED_BY
,reportSettingsE0.CREATION_DATE RSC_CREATION_DATE
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
,(SELECT PU_ID,COMMITMENT_STATUS_EXTERNAL,DECODE(COMMITMENT_STATUS_EXTERNAL,'N','No','Yes') AS ENABLE 
	,LAST_UPDATED_BY,LAST_UPDATE_DATE,CREATED_BY,CREATION_DATE FROM PJF_PU_REPORTING_SETTINGS ) reportSettingsE0 
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
AND puImpleE0.PU_ID = reportSettingsE0.PU_ID)
ORDER BY 1,2,3