/* ****************************************************************************
 * $Revision: 77390 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2021-11-30 21:04:30 +0700 (Tue, 30 Nov 2021) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Period%20Details.sql $:
 * $Id: Manage Accounting Calendars - Period Details.sql 77390 2021-11-30 14:04:30Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT GlCalendars.USER_PERIOD_SET_NAME RES_NAME
,GlPeriods.PERIOD_NAME RES_PERIOD_NAME
,GlPeriods.PERIOD_YEAR RES_BUDGET_YEAR_NUMBER
,GlPeriods.PERIOD_NUM RES_PERIOD_NUMBER
,GlPeriods.QUARTER_NUM RES_QUARTER_NUMBER
,TO_CHAR(GlPeriods.START_DATE, 'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(GlPeriods.END_DATE, 'DD-Mon-YYYY') RES_END_DATE
,GlPeriods.PERIOD_YEAR RES_YEAR
--,DECODE(GlPeriods.ADJUSTMENT_PERIOD_FLAG, 'Y', 'Yes', 'No') RES_ADJUSTING_PERIOD
,GlPeriods.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,GlPeriods.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,GlPeriods.CREATED_BY  RSC_CREATED_BY
,GlPeriods.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,null RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_CALENDARS GlCalendars
,GL_PERIODS GlPeriods
WHERE GlCalendars.CALENDAR_TYPE_CODE = 'COMMITMENT'
AND GlCalendars.PERIOD_SET_NAME = GlPeriods.PERIOD_SET_NAME
ORDER BY RES_NAME
,GlPeriods.PERIOD_YEAR Desc
,GlPeriods.PERIOD_NUM ASC