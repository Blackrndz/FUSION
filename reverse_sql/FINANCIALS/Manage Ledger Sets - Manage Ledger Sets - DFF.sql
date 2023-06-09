/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Ledger%20Sets%20-%20Manage%20Ledger%20Sets%20-%20DFF.sql $:
 * $Id: Manage Ledger Sets - Manage Ledger Sets - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_LEDGERS
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select DISTINCT LedgerSetEO.name AS RES_NAME
,LedgerSetEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,LedgerSetEO.ATTRIBUTE1
,LedgerSetEO.ATTRIBUTE2
,LedgerSetEO.ATTRIBUTE3
,LedgerSetEO.ATTRIBUTE4
,LedgerSetEO.ATTRIBUTE5
,LedgerSetEO.ATTRIBUTE6
,LedgerSetEO.ATTRIBUTE7
,LedgerSetEO.ATTRIBUTE8
,LedgerSetEO.ATTRIBUTE9
,LedgerSetEO.ATTRIBUTE10
,LedgerSetEO.ATTRIBUTE11
,LedgerSetEO.ATTRIBUTE12
,LedgerSetEO.ATTRIBUTE13
,LedgerSetEO.ATTRIBUTE14
,LedgerSetEO.ATTRIBUTE15
,LedgerSetEO.ATTRIBUTE_NUMBER1
,LedgerSetEO.ATTRIBUTE_NUMBER2
,LedgerSetEO.ATTRIBUTE_NUMBER3
,LedgerSetEO.ATTRIBUTE_NUMBER4
,LedgerSetEO.ATTRIBUTE_NUMBER5
, TO_CHAR(LedgerSetEO.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1
, TO_CHAR(LedgerSetEO.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2
, TO_CHAR(LedgerSetEO.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3
, TO_CHAR(LedgerSetEO.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4
, TO_CHAR(LedgerSetEO.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5
,LedgerSetEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LedgerSetEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LedgerSetEO.CREATED_BY  RSC_CREATED_BY
,LedgerSetEO.CREATION_DATE  RSC_CREATION_DATE
,GLLEDGERSETNORMASSIGN.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM GL_LEDGERS LedgerSetEO 
,GL_ACCESS_SETS GlAccessSets
,GL_CALENDARS GLCALENDARS
,(SELECT GLLEDGERSETNORMASSIGN.LEDGER_SET_ID
		,PGL.PRIMARY_LEDGER_ID
		FROM GL_LEDGER_SET_NORM_ASSIGN GLLEDGERSETNORMASSIGN
		,(SELECT RSHIP.TARGET_LEDGER_ID, RSHIP.PRIMARY_LEDGER_ID from GL_LEDGER_RELATIONSHIPS RSHIP
			WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
			AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
			OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
			AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
			WHERE GlLedgerSetNormAssign.LEDGER_ID = PGL.TARGET_LEDGER_ID
			) GLLEDGERSETNORMASSIGN
where (LedgerSetEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
LedgerSetEO.ATTRIBUTE1 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE2 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE3 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE4 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE5 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE6 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE7 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE8 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE9 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE10 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE11 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE12 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE13 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE14 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE15 IS NOT NULL OR
LedgerSetEO.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_DATE1 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_DATE2 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_DATE3 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_DATE4 IS NOT NULL OR 
LedgerSetEO.ATTRIBUTE_DATE5 IS NOT NULL  
)
AND ((LedgerSetEO.IMPLICIT_ACCESS_SET_ID = GlAccessSets.ACCESS_SET_ID)
AND((LedgerSetEO.PERIOD_SET_NAME          = GlCalendars.PERIOD_SET_NAME)
AND(LedgerSetEO.ACCOUNTED_PERIOD_TYPE     = GlCalendars.PERIOD_TYPE)))
AND(LEDGERSETEO.OBJECT_TYPE_CODE          = 'S')
AND LEDGERSETEO.LEDGER_ID                 = GLLEDGERSETNORMASSIGN.LEDGER_SET_ID(+)
ORDER BY RES_NAME