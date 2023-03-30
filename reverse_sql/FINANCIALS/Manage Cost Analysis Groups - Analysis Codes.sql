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
,AnalysisCodes.ANALYSIS_CODE RES_ANALYSIS_CODE
,AnalysisCodes.ANALYSIS_DESC RES_DESCRIPTION
,DECODE(AnalysisCodes.DEFAULT_ANALYSIS_CODE_FLAG,'Y','Yes','No') RES_DEFAULT
,AnalysisCodes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AnalysisCodes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AnalysisCodes.CREATED_BY RSC_CREATED_BY
,AnalysisCodes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_ANALYSIS_GROUPS_VL AnalysisGroupsE0
,CST_ANALYSIS_CODES_VL AnalysisCodes
WHERE AnalysisGroupsE0.ANALYSIS_GROUP_ID = AnalysisCodes.ANALYSIS_GROUP_ID
ORDER BY AnalysisGroupsE0.ANALYSIS_GROUP_CODE
,AnalysisCodes.ANALYSIS_CODE