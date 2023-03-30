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
-- DFF_LOGIC_TO_APPLY=101##RES##GL_AUTOMATIC_POSTING_SETS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select DISTINCT GLAUTOMATICPOSTINGSETS.AUTOPOST_SET_NAME  RES_NAME
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE1
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE2
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE3
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE4
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE5
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE6
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE7
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE8
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE9
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE10
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE11
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE12
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE13
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE14
,GLAUTOMATICPOSTINGSETS.ATTRIBUTE15
,GLAUTOMATICPOSTINGSETS.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,GLAUTOMATICPOSTINGSETS.LAST_UPDATE_DATE   RSC_LAST_UPDATE_DATE
,GLAUTOMATICPOSTINGSETS.CREATED_BY  RSC_CREATED_BY
,GLAUTOMATICPOSTINGSETS.CREATION_DATE  RSC_CREATION_DATE
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
,(select RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
where (GLAUTOMATICPOSTINGSETS.ATTRIBUTE_CATEGORY IS NOT NULL OR
GLAUTOMATICPOSTINGSETS.ATTRIBUTE1 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE2 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE3 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE4 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE5 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE6 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE7 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE8 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE9 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE10 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE11 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE12 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE13 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE14 IS NOT NULL OR 
GLAUTOMATICPOSTINGSETS.ATTRIBUTE15 IS NOT NULL 
) 
AND GLAUTOMATICPOSTINGSETS.AUTOPOST_SET_ID	  = GLAUTOMATICPOSTINGOPTIONS.AUTOPOST_SET_ID(+)
AND GlAutomaticPostingOptions.LEDGER_ID = PGL.TARGET_LEDGER_ID(+)
ORDER BY GlAutomaticPostingSets.AUTOPOST_SET_NAME