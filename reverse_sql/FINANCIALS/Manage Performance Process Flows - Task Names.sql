/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT pfsE0.NAME RES_NAME
,(SELECT TASK_NAME
    FROM HRA_PF_TASK_DEFNS_VL
    WHERE TASK_CODE = pfTaskRoles.TASK_CODE
    ) RES_TASK
,pfTaskRoles.SEQUENCE_NUMBER RES_SEQUENCE_NUMBER
,pfTaskRoles.MGR_TASK_NAME RES_TASK_NAME_FOR_MANAGER_ROLE
,pfTaskRoles.WKR_TASK_NAME RES_TASK_NAME_FOR_WORKER_ROLE
,pfTaskRoles.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pfTaskRoles.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pfTaskRoles.CREATED_BY RSC_CREATED_BY
,pfTaskRoles.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRA_PF_DEFNS_VL pfsE0
,HRA_PF_TASK_ROLES_VL pfTaskRoles
WHERE pfsE0.PROCESS_FLOW_ID = pfTaskRoles.PROCESS_FLOW_ID
ORDER BY pfsE0.NAME
,pfTaskRoles.SEQUENCE_NUMBER