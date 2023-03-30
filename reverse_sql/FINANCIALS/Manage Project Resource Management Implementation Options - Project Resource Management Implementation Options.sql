/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Resource%20Management%20Implementation%20Options%20-%20Project%20Resource%20Management%20Implementation%20Optio $:
* $Id: Manage Project Resource Management Implementation Options - Project Resource Management Implementation Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PJR_ENTERPRISE_IMPL_OPTION

SELECT DECODE(pjrENTERimplPEO.SEC_RES_FLAG,'Y','Yes','No') RES_SECURE_RESOURCES_IN_PROJEC
,DECODE(pjrENTERimplPEO.ACT_HRS_SRC,'ORA_PJR_PROJECT_COSTING','Project Costing','ORA_PJR_SPREADSHEET_IMPORT','Spreadsheet import') RES_ACTUAL_HOURS_SOURCE
,DECODE(pjrENTERimplPEO.PROJ_RESOURCE_REQ_FLAG,'Y','Yes','No') RES_NOTIFY_STAFFING_OWNER_WHEN
,DECODE(pjrENTERimplPEO.PROJ_RESOURCE_PROP_FLAG,'Y','Yes','No') RES_NOTIFY_WORKFLOW_PARTICIPAN
,DECODE(pjrENTERimplPEO.PROJ_ASSIGN_NOTIFY_FLAG,'Y','Yes','No') RES_NOTIFY_RESOURCE_WHEN_A_PRO
,pjrENTERimplPEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pjrENTERimplPEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pjrENTERimplPEO.CREATED_BY RSC_CREATED_BY
,pjrENTERimplPEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJR_ENTERPRISE_IMPL_OPTION pjrENTERimplPEO
