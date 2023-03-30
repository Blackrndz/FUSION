/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

SELECT configPoolsE0.NAME RES_NAME
,configPoolsE0.CODE RES_CODE
,phasesE0.NAME RES_PHASE_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_PROC_ACTION_EVENT'
    AND LOOKUP_CODE = eventHandlersE0.CODE 
	) RES_ADD_EVENT
,eventHandlersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,eventHandlersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,eventHandlersE0.CREATED_BY RSC_CREATED_BY
,eventHandlersE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_PROCESSES_VL configPoolsE0
,(SELECT *
    FROM IRC_ROUTING_STEPS_B
    WHERE TYPE_CODE = 'PHASE'
    ) rountingStepsE0
,(SELECT *
    FROM IRC_PHASES_TL
    WHERE LANGUAGE = USERENV('LANG')
    ) phasesE0
,(SELECT *
    FROM IRC_ROUTING_STEPS_B
    WHERE TYPE_CODE = 'EVENT_HANDLER'
    ) eventHandlersE0
WHERE configPoolsE0.TYPE_CODE = 'CSW'
AND configPoolsE0.USAGE_CODE = 'TEMPLATE'
AND configPoolsE0.PROCESS_ID = rountingStepsE0.PROCESS_ID
AND rountingStepsE0.PHASE_ID = phasesE0.PHASE_ID
AND rountingStepsE0.SUB_PROCESS_ID = eventHandlersE0.PROCESS_ID
ORDER BY configPoolsE0.NAME
,rountingStepsE0.SEQUENCE_NUMBER
,eventHandlersE0.SEQUENCE_NUMBER