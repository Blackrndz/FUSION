/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Journal%20Reversal%20Criteria%20Sets%20-%20Manage%20Journal%20Reversal%20Criteria%20Sets.sql $:
 * $Id: Manage Journal Reversal Criteria Sets - Manage Journal Reversal Criteria Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT AutorevCriteriaSetEO.CRITERIA_SET_NAME AS RES_NAME
,AutorevCriteriaSetEO.CRITERIA_SET_DESC AS RES_DESCRIPTION
,AutorevCriteriaSetEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,AutorevCriteriaSetEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,AutorevCriteriaSetEO.CREATED_BY  RSC_CREATED_BY
,AutorevCriteriaSetEO.CREATION_DATE  RSC_CREATION_DATE
,LedgersE0.LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_AUTOREV_CRITERIA_SETS AutorevCriteriaSetEO
,GL_LEDGERS LedgersE0
WHERE AutorevCriteriaSetEO.CRITERIA_SET_ID = LedgersE0.CRITERIA_SET_ID(+)
ORDER BY RES_NAME

/*Add GL_LEDGERS table to the query due to consultant need to change this query to Ledger level for filter.
Please note that this condition might cause duplication data when extract it with out Bu filter.*/