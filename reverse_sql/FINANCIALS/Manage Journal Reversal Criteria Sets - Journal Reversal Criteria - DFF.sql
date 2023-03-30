/* ****************************************************************************
 * $Revision: 53543 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:46:40 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Journal%20Reversal%20Criteria%20Sets%20-%20Journal%20Reversal%20Criteria.sql $:
 * $Id: Manage Journal Reversal Criteria Sets - Journal Reversal Criteria.sql 53543 2016-03-15 08:46:40Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_AUTOREVERSE_OPTIONS
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT AutorevCriteriaSetEO.CRITERIA_SET_NAME AS RES_NAME
,(SELECT USER_JE_CATEGORY_NAME
	FROM GL_JE_CATEGORIES
	WHERE JE_CATEGORY_NAME = glautoreverseop.JE_CATEGORY_NAME
	) AS RES_CATEGORY,
glautoreverseop.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE ,
glautoreverseop.ATTRIBUTE1 ,
glautoreverseop.ATTRIBUTE2 ,
glautoreverseop.ATTRIBUTE3 ,
glautoreverseop.ATTRIBUTE4 ,
glautoreverseop.ATTRIBUTE5 ,
glautoreverseop.ATTRIBUTE6 ,
glautoreverseop.ATTRIBUTE7 ,
glautoreverseop.ATTRIBUTE8 ,
glautoreverseop.ATTRIBUTE9 ,
glautoreverseop.ATTRIBUTE10 ,
glautoreverseop.ATTRIBUTE11 ,
glautoreverseop.ATTRIBUTE12 ,
glautoreverseop.ATTRIBUTE13 ,
glautoreverseop.ATTRIBUTE14 ,
glautoreverseop.ATTRIBUTE15 
,glautoreverseop.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,glautoreverseop.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,glautoreverseop.CREATED_BY  RSC_CREATED_BY
,glautoreverseop.CREATION_DATE  RSC_CREATION_DATE
,LedgersE0.LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_AUTOREVERSE_OPTIONS glautoreverseop
,GL_AUTOREV_CRITERIA_SETS AutorevCriteriaSetEO
,GL_LEDGERS LedgersE0
WHERE AutorevCriteriaSetEO.CRITERIA_SET_ID = LedgersE0.CRITERIA_SET_ID(+)
AND glautoreverseop.CRITERIA_SET_ID = AutorevCriteriaSetEO.CRITERIA_SET_ID
AND (glautoreverseop.ATTRIBUTE_CATEGORY IS NOT NULL OR
  glautoreverseop.ATTRIBUTE1 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE2 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE3 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE4 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE5 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE6 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE7 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE8 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE9 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE10 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE11 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE12 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE13 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE14 IS NOT NULL OR
  glautoreverseop.ATTRIBUTE15 IS NOT NULL)
ORDER BY RES_NAME

/*Add GL_LEDGERS table to the query due to consultant need to change this query to Ledger level for filter.
Please note that this condition might cause duplication data when extract it with out Bu filter.*/