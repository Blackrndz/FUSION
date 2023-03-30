/* ****************************************************************************
 * $Revision: 64353 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-10-09 17:36:19 +0700 (Mon, 09 Oct 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 64353 2017-10-09 10:36:19Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT AnalysisGroupsE0.ANALYSIS_GROUP_CODE RES_ANALYSIS_GROUP
,AnalysisGroupsE0.ANALYSIS_GROUP_DESC RES_DESCRIPTION
,AnalysisGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AnalysisGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AnalysisGroupsE0.CREATED_BY RSC_CREATED_BY
,AnalysisGroupsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_ANALYSIS_GROUPS_VL AnalysisGroupsE0
ORDER BY AnalysisGroupsE0.ANALYSIS_GROUP_CODE