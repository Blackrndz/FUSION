/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Data%20Access%20Sets%20-%20Access%20Set%20Assignments%20-%20DFF.sql $:
 * $Id: Manage Data Access Sets - Access Set Assignments - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_ACCESS_SET_NORM_ASSIGN
--  DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 

SELECT GlAccessSets.NAME AS RES_NAME
,(SELECT name
	FROM GL_LEDGERS
	WHERE LEDGER_ID = GlAccessSetNormAssign.LEDGER_ID
	) AS RES_LEDGER_OR_LEDGER_SET
,GlAccessSetNormAssign.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,GlAccessSetNormAssign.ATTRIBUTE1 
,GlAccessSetNormAssign.ATTRIBUTE2
,GlAccessSetNormAssign.ATTRIBUTE3
,GlAccessSetNormAssign.ATTRIBUTE4
,GlAccessSetNormAssign.ATTRIBUTE5
,GlAccessSetNormAssign.ATTRIBUTE6 
,GlAccessSetNormAssign.ATTRIBUTE7
,GlAccessSetNormAssign.ATTRIBUTE8
,GlAccessSetNormAssign.ATTRIBUTE9
,GlAccessSetNormAssign.ATTRIBUTE10
,GlAccessSetNormAssign.ATTRIBUTE11 
,GlAccessSetNormAssign.ATTRIBUTE12
,GlAccessSetNormAssign.ATTRIBUTE13
,GlAccessSetNormAssign.ATTRIBUTE14
,GlAccessSetNormAssign.ATTRIBUTE15
,GlAccessSetNormAssign.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GlAccessSetNormAssign.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GlAccessSetNormAssign.CREATED_BY  RSC_CREATED_BY
,GlAccessSetNormAssign.CREATION_DATE  RSC_CREATION_DATE
,GlAccessSets.DEFAULT_LEDGER_ID RSC_LEDGER_ID
,GlAccessSets.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from GL_ACCESS_SETS GlAccessSets,
GL_ACCESS_SET_NORM_ASSIGN GlAccessSetNormAssign
where GlAccessSets.ACCESS_SET_ID = GlAccessSetNormAssign.ACCESS_SET_ID
and GLACCESSSETS.AUTOMATICALLY_CREATED_FLAG = 'N'
and (GlAccessSetNormAssign.ATTRIBUTE_CATEGORY IS NOT NULL OR
GlAccessSetNormAssign.ATTRIBUTE1 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE2 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE3 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE4 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE5 IS NOT NULL OR
GlAccessSetNormAssign.ATTRIBUTE6 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE7 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE8 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE9 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE10 IS NOT NULL OR
GlAccessSetNormAssign.ATTRIBUTE11 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE12 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE13 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE14 IS NOT NULL OR 
GlAccessSetNormAssign.ATTRIBUTE15 IS NOT NULL) 
ORDER BY RES_NAME