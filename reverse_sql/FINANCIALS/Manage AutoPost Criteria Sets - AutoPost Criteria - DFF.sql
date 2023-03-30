/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_AUTOMATIC_POSTING_OPTIONS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select GLAUTOMATICPOSTINGSETS.AUTOPOST_SET_NAME  RES_NAME
,LedgerAllEO.LEDGER_NAME RES_LEDGER_OR_LEDGER_SET
,SourceAutoPostAllEO.USER_JE_SOURCE_NAME RES_SOURCE
,(CategoryAutoPostAllEO.USER_JE_CATEGORY_NAME) RES_CATEGORY
,GlAutomaticPostingOptions.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,GlAutomaticPostingOptions.ATTRIBUTE1
,GlAutomaticPostingOptions.ATTRIBUTE2
,GlAutomaticPostingOptions.ATTRIBUTE3
,GlAutomaticPostingOptions.ATTRIBUTE4
,GlAutomaticPostingOptions.ATTRIBUTE5
,GlAutomaticPostingOptions.ATTRIBUTE6
,GlAutomaticPostingOptions.ATTRIBUTE7
,GlAutomaticPostingOptions.ATTRIBUTE8
,GlAutomaticPostingOptions.ATTRIBUTE9
,GlAutomaticPostingOptions.ATTRIBUTE10
,GlAutomaticPostingOptions.ATTRIBUTE11
,GlAutomaticPostingOptions.ATTRIBUTE12
,GlAutomaticPostingOptions.ATTRIBUTE13
,GlAutomaticPostingOptions.ATTRIBUTE14
,GlAutomaticPostingOptions.ATTRIBUTE15
,GlAutomaticPostingOptions.LAST_UPDATED_BY   RSC_LAST_UPDATED_BY
,GlAutomaticPostingOptions.LAST_UPDATE_DATE   RSC_LAST_UPDATE_DATE
,GlAutomaticPostingOptions.CREATED_BY  RSC_CREATED_BY
,GlAutomaticPostingOptions.CREATION_DATE  RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from GL_AUTOMATIC_POSTING_SETS GLAUTOMATICPOSTINGSETS
,GL_AUTOMATIC_POSTING_OPTIONS GlAutomaticPostingOptions
,GL_LEDGERS_ALL_V LedgerAllEO
,GL_JE_CATEGORIES_AUTOPOST_V CategoryAutoPostAllEO
,GL_JE_SOURCES_AUTOPOST_V SourceAutoPostAllEO
,GL_PERIODS_AUTOPOST_V PeriodAllEO
,(select RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
where (GlAutomaticPostingOptions.ATTRIBUTE_CATEGORY IS NOT NULL OR
GlAutomaticPostingOptions.ATTRIBUTE1 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE2 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE3 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE4 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE5 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE6 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE7 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE8 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE9 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE10 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE11 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE12 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE13 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE14 IS NOT NULL OR 
GlAutomaticPostingOptions.ATTRIBUTE15 IS NOT NULL 
) and ((GlAutomaticPostingOptions.LEDGER_ID     = LedgerAllEO.LEDGER_ID)
AND(GlAutomaticPostingOptions.JE_CATEGORY_NAME = CategoryAutoPostAllEO.JE_CATEGORY_NAME)
AND(GlAutomaticPostingOptions.JE_SOURCE_NAME   = SourceAutoPostAllEO.JE_SOURCE_NAME)
AND(GlAutomaticPostingOptions.PERIOD_NAME      = PeriodAllEO.PERIOD_NAME)
AND((LedgerAllEO.PERIOD_SET_NAME               = PeriodAllEO.PERIOD_SET_NAME
AND LedgerAllEO.ACCOUNTED_PERIOD_TYPE          = PeriodAllEO.PERIOD_TYPE)
or(PERIODALLEO.PERIOD_NAME                     = 'ALL')))
and GLAUTOMATICPOSTINGSETS.AUTOPOST_SET_ID	  = GLAUTOMATICPOSTINGOPTIONS.AUTOPOST_SET_ID
AND GlAutomaticPostingOptions.LEDGER_ID = PGL.TARGET_LEDGER_ID(+)
ORDER BY GLAUTOMATICPOSTINGSETS.AUTOPOST_SET_NAME