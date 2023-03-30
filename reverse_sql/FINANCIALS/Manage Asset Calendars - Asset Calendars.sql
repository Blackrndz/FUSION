/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Calendars%20-%20Asset%20Calendars.sql $:
 * $Id: Manage Asset Calendars - Asset Calendars.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select QRSLT.CALENDAR_TYPE RES_NAME
,QRSLT.DESCRIPTION RES_DESCRIPTION
,QRSLT.FISCAL_YEAR_NAME RES_FISCAL_YEAR_NAME
,QRSLT.NUMBER_PER_FISCAL_YEAR RES_PERIODS_PER_YEAR
,QRSLT.MEANING RES_PERIOD_SUFFIX
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

from 
(
SELECT distinct CalendarTypeEO.CALENDAR_TYPE
,CalendarTypeEO.DESCRIPTION
,CalendarTypeEO.FISCAL_YEAR_NAME
,CalendarTypeEO.NUMBER_PER_FISCAL_YEAR
,CalendarTypeEO.PERIOD_SUFFIX_TYPE
,CalendarTypeEO.LAST_UPDATE_DATE
,CalendarTypeEO.LAST_UPDATED_BY
,CalendarTypeEO.CREATED_BY
,CalendarTypeEO.CREATION_DATE
,CalendarTypeEO.LAST_UPDATE_LOGIN
,CalendarTypeEO.ATTRIBUTE1
,CalendarTypeEO.ATTRIBUTE2
,CalendarTypeEO.ATTRIBUTE3
,CalendarTypeEO.ATTRIBUTE4
,CalendarTypeEO.ATTRIBUTE5
,CalendarTypeEO.ATTRIBUTE6
,CalendarTypeEO.ATTRIBUTE7
,CalendarTypeEO.ATTRIBUTE8
,CalendarTypeEO.ATTRIBUTE9
,CalendarTypeEO.ATTRIBUTE10
,CalendarTypeEO.ATTRIBUTE11
,CalendarTypeEO.ATTRIBUTE12
,CalendarTypeEO.ATTRIBUTE13
,CalendarTypeEO.ATTRIBUTE14
,CalendarTypeEO.ATTRIBUTE15
,CalendarTypeEO.ATTRIBUTE_CATEGORY_CODE
,CalendarTypeEO.OBJECT_VERSION_NUMBER
,CALENDARTYPEEO.CALENDAR_TYPE_ID
,LOOKUPEO.MEANING
from FA_CALENDAR_TYPES CALENDARTYPEEO
,FA_CALENDAR_PERIODS CalendarPeriodEO
,FND_LOOKUP_VALUES_VL LOOKUPEO
where CALENDARTYPEEO.PERIOD_SUFFIX_TYPE = LOOKUPEO.LOOKUP_CODE
and LOOKUPEO.LOOKUP_TYPE = 'FA_CAL_PERIOD_SUFFIX'
and CALENDARTYPEEO.CALENDAR_TYPE = CALENDARPERIODEO.CALENDAR_TYPE(+)
) QRSLT
order by  QRSLT.CALENDAR_TYPE