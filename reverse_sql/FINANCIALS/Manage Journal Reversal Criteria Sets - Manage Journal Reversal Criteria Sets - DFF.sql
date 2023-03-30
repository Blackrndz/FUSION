/* ****************************************************************************
 * $Revision: 53543 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:46:40 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Journal%20Reversal%20Criteria%20Sets%20-%20Manage%20Journal%20Reversal%20Criteria%20Sets.sql $:
 * $Id: Manage Journal Reversal Criteria Sets - Manage Journal Reversal Criteria Sets.sql 53543 2016-03-15 08:46:40Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_AUTOREV_CRITERIA_SETS
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT AutorevCriteriaSetEO.CRITERIA_SET_NAME RES_NAME
,AutorevCriteriaSetEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,AutorevCriteriaSetEO.ATTRIBUTE1
,AutorevCriteriaSetEO.ATTRIBUTE2
,AutorevCriteriaSetEO.ATTRIBUTE3
,AutorevCriteriaSetEO.ATTRIBUTE4
,AutorevCriteriaSetEO.ATTRIBUTE5
,AutorevCriteriaSetEO.ATTRIBUTE6
,AutorevCriteriaSetEO.ATTRIBUTE7
,AutorevCriteriaSetEO.ATTRIBUTE8
,AutorevCriteriaSetEO.ATTRIBUTE9
,AutorevCriteriaSetEO.ATTRIBUTE10
,AutorevCriteriaSetEO.ATTRIBUTE11
,AutorevCriteriaSetEO.ATTRIBUTE12
,AutorevCriteriaSetEO.ATTRIBUTE13
,AutorevCriteriaSetEO.ATTRIBUTE14
,AutorevCriteriaSetEO.ATTRIBUTE15 
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
AND (AutorevCriteriaSetEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE1 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE2 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE3 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE4 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE5 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE6 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE7 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE8 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE9 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE10 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE11 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE12 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE13 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE14 IS NOT NULL OR
  AutorevCriteriaSetEO.ATTRIBUTE15 IS NOT NULL)
ORDER BY RES_NAME

/*Add GL_LEDGERS table to the query due to consultant need to change this query to Ledger level for filter.
Please note that this condition might cause duplication data when extract it with out Bu filter.*/