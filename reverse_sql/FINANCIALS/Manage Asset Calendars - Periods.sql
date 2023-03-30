/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Calendars%20-%20Periods.sql $:
 * $Id: Manage Asset Calendars - Periods.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select QRSLT.CALENDAR_TYPE  RES_NAME
,QRSLT.PERIOD_NAME RES_PERIOD_NAME
,QRSLT.PERIOD_NUM RES_PERIOD_NUMBER
,TO_CHAR(QRSLT.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,to_Char(QRSLT.END_DATE,'DD-Mon-YYYY') RES_END_DATE
  ,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,QRSLT.CREATED_BY  RSC_CREATED_BY
  ,QRSLT.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from (
SELECT
CalendarPeriodEO.CALENDAR_TYPE
,CalendarPeriodEO.PERIOD_NAME
,CalendarPeriodEO.PERIOD_NUM
,CalendarPeriodEO.START_DATE
,CalendarPeriodEO.END_DATE
,CalendarPeriodEO.LAST_UPDATE_DATE
,CalendarPeriodEO.LAST_UPDATED_BY
,CalendarPeriodEO.CREATED_BY
,CalendarPeriodEO.CREATION_DATE
,CalendarPeriodEO.LAST_UPDATE_LOGIN
,CalendarPeriodEO.OBJECT_VERSION_NUMBER
,CALENDARPERIODEO.CALENDAR_PERIOD_ID
from FA_CALENDAR_PERIODS CALENDARPERIODEO
,FA_CALENDAR_TYPES CALENDARTYPEEO
where CALENDARPERIODEO.CALENDAR_TYPE = CALENDARTYPEEO.CALENDAR_TYPE
order by CALENDARPERIODEO.START_DATE desc
) QRSLT
order by QRSLT.CALENDAR_TYPE,QRSLT.START_DATE