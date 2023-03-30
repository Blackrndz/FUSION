/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Data%20Access%20Sets%20-%20Manage%20Data%20Access%20Sets%20-%20DFF.sql $:
 * $Id: Manage Data Access Sets - Manage Data Access Sets - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_ACCESS_SETS
--  DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 

SELECT GlAccessSets.NAME AS RES_NAME
,GlAccessSets.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,GlAccessSets.ATTRIBUTE1 
,GlAccessSets.ATTRIBUTE2
,GlAccessSets.ATTRIBUTE3
,GlAccessSets.ATTRIBUTE4
,GlAccessSets.ATTRIBUTE5
,GlAccessSets.ATTRIBUTE6 
,GlAccessSets.ATTRIBUTE7
,GlAccessSets.ATTRIBUTE8
,GlAccessSets.ATTRIBUTE9
,GlAccessSets.ATTRIBUTE10
,GlAccessSets.ATTRIBUTE11 
,GlAccessSets.ATTRIBUTE12
,GlAccessSets.ATTRIBUTE13
,GlAccessSets.ATTRIBUTE14
,GlAccessSets.ATTRIBUTE15
,GlAccessSets.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GlAccessSets.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GlAccessSets.CREATED_BY  RSC_CREATED_BY
,GlAccessSets.CREATION_DATE  RSC_CREATION_DATE
,GlAccessSets.DEFAULT_LEDGER_ID RSC_LEDGER_ID
,GlAccessSets.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from GL_ACCESS_SETS GlAccessSets
where  GLACCESSSETS.AUTOMATICALLY_CREATED_FLAG = 'N'
and (GlAccessSets.ATTRIBUTE_CATEGORY IS NOT NULL OR
GlAccessSets.ATTRIBUTE1 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE2 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE3 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE4 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE5 IS NOT NULL OR
GlAccessSets.ATTRIBUTE6 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE7 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE8 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE9 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE10 IS NOT NULL OR
GlAccessSets.ATTRIBUTE11 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE12 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE13 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE14 IS NOT NULL OR 
GlAccessSets.ATTRIBUTE15 IS NOT NULL) 
ORDER BY RES_NAME