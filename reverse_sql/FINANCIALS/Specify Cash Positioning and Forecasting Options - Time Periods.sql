/* ****************************************************************************
 * $Revision: 55239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-16 16:50:09 +0700 (Mon, 16 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Fiscal%20Years%20-%20Fiscal%20Year.sql $:
 * $Id: Manage Fiscal Years - Fiscal Year.sql 55239 2016-05-16 09:50:09Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=CE_CP_OPTION_TIME_DIMS

SELECT GlCalendars.USER_PERIOD_SET_NAME RES_ACCOUNTING_CALENDAR
,GlCalendars.PERIOD_TYPE RES_PERIOD_FREQUENCY
,GlCalendars.DESCRIPTION RES_DESCRIPTION
,OptionTimeE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,OptionTimeE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,OptionTimeE0.CREATED_BY RSC_CREATED_BY
,OptionTimeE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_CP_OPTION_TIME_DIMS OptionTimeE0
,GL_CALENDARS GlCalendars
WHERE OptionTimeE0.ACCOUNTING_CALENDAR_ID = GlCalendars.CALENDAR_ID