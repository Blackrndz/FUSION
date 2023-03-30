/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_PERIODS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT GlCalendars.USER_PERIOD_SET_NAME RES_NAME
,GlPeriods.PERIOD_NAME RES_PERIOD_NAME
,GlPeriods.PERIOD_YEAR RES_BUDGET_YEAR_NUMBER
,GlPeriods.PERIOD_NUM RES_PERIOD_NUMBER
,GlPeriods.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,GlPeriods.ATTRIBUTE1
,GlPeriods.ATTRIBUTE2
,GlPeriods.ATTRIBUTE3
,GlPeriods.ATTRIBUTE4
,GlPeriods.ATTRIBUTE5
,GlPeriods.ATTRIBUTE6
,GlPeriods.ATTRIBUTE7
,GlPeriods.ATTRIBUTE8
,GlPeriods.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GlPeriods.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GlPeriods.CREATED_BY RSC_CREATED_BY
,GlPeriods.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,null RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_CALENDARS GlCalendars
,GL_PERIODS GlPeriods
WHERE GlCalendars.CALENDAR_TYPE_CODE = 'COMMITMENT'
AND GlCalendars.PERIOD_SET_NAME = GlPeriods.PERIOD_SET_NAME
AND (GlPeriods.ATTRIBUTE_CATEGORY IS NOT NULL
	OR GlPeriods.ATTRIBUTE1 IS NOT NULL
	OR GlPeriods.ATTRIBUTE2 IS NOT NULL
	OR GlPeriods.ATTRIBUTE3 IS NOT NULL
	OR GlPeriods.ATTRIBUTE4 IS NOT NULL
	OR GlPeriods.ATTRIBUTE5 IS NOT NULL
	OR GlPeriods.ATTRIBUTE6 IS NOT NULL
	OR GlPeriods.ATTRIBUTE7 IS NOT NULL
	OR GlPeriods.ATTRIBUTE8 IS NOT NULL)
ORDER BY RES_NAME
,GlPeriods.PERIOD_YEAR ASC
,GlPeriods.PERIOD_NUM ASC