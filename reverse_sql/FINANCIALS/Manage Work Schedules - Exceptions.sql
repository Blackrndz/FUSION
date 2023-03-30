/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT schedulesE0.SCHEDULE_NAME RES_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PER_SHDL_EXCEPTION_TYPES'
    AND LOOKUP_CODE = exceptionsE0.EXCEPTION_TYPE
    ) RES_TYPE
,(CASE
    WHEN exceptionsE0.EXCEPTION_TYPE = 'EVENTCATEGORY' THEN
        (SELECT MEANING
            FROM FND_LOOKUP_VALUES
            WHERE LANGUAGE = USERENV('LANG')
            AND LOOKUP_TYPE = 'PER_CAL_EVENT_CATEGORY'
            AND LOOKUP_CODE = exceptionsE0.EXCEPTION_CODE)
    WHEN exceptionsE0.EXCEPTION_TYPE = 'RESEXCEPTION' THEN
        resourceExceptionsE0.EXCEPTION_NAME
    WHEN exceptionsE0.EXCEPTION_TYPE = 'EVENT' THEN
        calendarEventsE0.NAME
    END) RES_EXCEPTION_NAME
,(CASE
	WHEN exceptionsE0.EXCEPTION_TYPE = 'RESEXCEPTION' THEN
        TO_CHAR(resourceExceptionsE0.START_DATE_TIME,'DD-Mon-YYYY')
    WHEN exceptionsE0.EXCEPTION_TYPE = 'EVENT' THEN
        TO_CHAR(calendarEventsE0.START_DATE_TIME,'DD-Mon-YYYY')
	END) RES_START_DATE
,(CASE
	WHEN exceptionsE0.EXCEPTION_TYPE = 'RESEXCEPTION' THEN
        TO_CHAR(resourceExceptionsE0.END_DATE_TIME,'DD-Mon-YYYY')
    WHEN exceptionsE0.EXCEPTION_TYPE = 'EVENT' THEN
        TO_CHAR(calendarEventsE0.END_DATE_TIME,'DD-Mon-YYYY')
	END) RES_END_DATE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ZMM_SR_AVAILABILITY'
    AND LOOKUP_CODE = exceptionsE0.AVAILABILITY_CODE
    ) RES_AVAILABILITY
,exceptionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,exceptionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,exceptionsE0.CREATED_BY RSC_CREATED_BY
,exceptionsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_SCHEDULES_VL schedulesE0
,PER_SCHEDULE_EXCEPTIONS exceptionsE0
,PER_CALENDAR_EVENTS_VL calendarEventsE0
,PER_RESOURCE_EXCEPTIONS resourceExceptionsE0
WHERE schedulesE0.SCHEDULE_ID = exceptionsE0.SCHEDULE_ID
AND exceptionsE0.EXCEPTION_ID = calendarEventsE0.CALENDAR_EVENT_ID(+)
AND exceptionsE0.EXCEPTION_ID = resourceExceptionsE0.EXCEPTION_ID(+)
ORDER BY schedulesE0.SCHEDULE_NAME