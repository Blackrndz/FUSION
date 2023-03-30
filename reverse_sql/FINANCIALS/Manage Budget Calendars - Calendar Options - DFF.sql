/* ****************************************************************************
 * $Revision: 53543 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:46:40 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Calendar%20Options.sql $:
 * $Id: Manage Accounting Calendars - Calendar Options.sql 53543 2016-03-15 08:46:40Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_CALENDARS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT GlCalendars.USER_PERIOD_SET_NAME RES_NAME
,GlCalendars.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,GlCalendars.ATTRIBUTE1
,GlCalendars.ATTRIBUTE2
,GlCalendars.ATTRIBUTE3
,GlCalendars.ATTRIBUTE4
,GlCalendars.ATTRIBUTE5
,GlCalendars.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,GlCalendars.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,GlCalendars.CREATED_BY RSC_CREATED_BY
,GlCalendars.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,null RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_CALENDARS GlCalendars
WHERE GlCalendars.CALENDAR_TYPE_CODE = 'COMMITMENT'
AND (GlCalendars.ATTRIBUTE_CATEGORY IS NOT NULL
OR GlCalendars.ATTRIBUTE1            IS NOT NULL
OR GlCalendars.ATTRIBUTE2            IS NOT NULL
OR GlCalendars.ATTRIBUTE3            IS NOT NULL
OR GlCalendars.ATTRIBUTE4            IS NOT NULL
OR GlCalendars.ATTRIBUTE5            IS NOT NULL)
ORDER BY GlCalendars.USER_PERIOD_SET_NAME