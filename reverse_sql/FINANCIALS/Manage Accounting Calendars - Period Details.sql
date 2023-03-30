/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Period%20Details.sql $:
 * $Id: Manage Accounting Calendars - Period Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT GlCalendars.USER_PERIOD_SET_NAME RES_NAME
,GlPeriods.PERIOD_NAME RES_PERIOD_NAME
,GlPeriods.PERIOD_YEAR RES_YEAR
,GlPeriods.PERIOD_NUM RES_PERIOD_NUMBER
,GlPeriods.QUARTER_NUM RES_QUARTER_NUMBER
,TO_CHAR(GlPeriods.START_DATE, 'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(GlPeriods.END_DATE, 'DD-Mon-YYYY') RES_END_DATE
,DECODE(GlPeriods.ADJUSTMENT_PERIOD_FLAG, 'Y', 'Yes', 'No') RES_ADJUSTING_PERIOD
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
,GlPeriods.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_CALENDARS GlCalendars
,GL_PERIODS GlPeriods
WHERE GlCalendars.CALENDAR_TYPE_CODE = 'ACCOUNTING'
AND GlCalendars.PERIOD_SET_NAME = GlPeriods.PERIOD_SET_NAME
ORDER BY RES_NAME
,GlPeriods.PERIOD_YEAR Desc
,GlPeriods.PERIOD_NUM ASC