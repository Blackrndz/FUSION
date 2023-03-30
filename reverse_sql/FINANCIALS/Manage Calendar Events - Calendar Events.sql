/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Calendar%20Events%20-%20Calendar%20Events.sql $:
* $Id: Manage Calendar Events - Calendar Events.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_FLEX_SEGMENT_MAPPINGS

SELECT calendarEventsE0.NAME RES_NAME
,calendarEventsE0.SHORT_CODE RES_SHORT_CODE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
   WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PER_CAL_EVENT_CATEGORY'
    AND LOOKUP_CODE = calendarEventsE0.CATEGORY
    ) RES_CATEGORY
,calendarEventsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(calendarEventsE0.HALF_DAY_FOR_ELAPSED,'Y','Yes','No') RES_HALF_DAY_FOR_ELAPSED_WORK_
,TO_CHAR(calendarEventsE0.START_DATE_TIME,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(calendarEventsE0.END_DATE_TIME,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,DECODE(calendarEventsE0.TREE_STRUCTURE_CODE,'PER_GEO_TREE_STRUCTURE','Geographic','PER_ORG_TREE_STRUCTURE','Organization') RES_HIERARCHY_TYPE
,(SELECT TREE_NAME
    FROM FND_TREE_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TREE_STRUCTURE_CODE = calendarEventsE0.TREE_STRUCTURE_CODE
    AND TREE_CODE = calendarEventsE0.TREE_CODE
    ) RES_HIERARCHY
,calendarEventsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,calendarEventsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,calendarEventsE0.CREATED_BY RSC_CREATED_BY
,calendarEventsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_CALENDAR_EVENTS_VL calendarEventsE0
ORDER BY calendarEventsE0.NAME