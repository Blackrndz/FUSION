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
,(SELECT DECODE(STRING_VALUE,'Y','Yes','No')
    FROM IRC_LC_SETTING_ITEMS
    WHERE ITEM_KEY_NAME = 'IsMandatory'
    AND SETTING_ID = rountingStepsE0.SETTING_ID
    ) RES_MANDATORY
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_PROC_PHASE_RESTRICTED'
    AND LOOKUP_CODE = (SELECT STRING_VALUE
        FROM IRC_LC_SETTING_ITEMS
        WHERE ITEM_KEY_NAME = 'IsRestricted'
        AND SETTING_ID = rountingStepsE0.SETTING_ID
		AND ROWNUM = 1)
    ) RES_VISIBILITY
,(SELECT DECODE(STRING_VALUE,'Y','Yes','No')
    FROM IRC_LC_SETTING_ITEMS
    WHERE ITEM_KEY_NAME = 'IsOfferSkipExtend'
    AND SETTING_ID = rountingStepsE0.SETTING_ID
    ) RES_BYPASS_EXTENDING_OFFER
,(SELECT DECODE(STRING_VALUE,'Y','Yes','No')
    FROM IRC_LC_SETTING_ITEMS
    WHERE ITEM_KEY_NAME = 'IsCandidateAllowedToProvideReasons'
    AND SETTING_ID = rountingStepsE0.SETTING_ID
    ) RES_ALLOW_CANDIDATE_REASON_AND
,'' RES_ADD_EVENT
,rountingStepsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rountingStepsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rountingStepsE0.CREATED_BY RSC_CREATED_BY
,rountingStepsE0.CREATION_DATE RSC_CREATION_DATE
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
WHERE configPoolsE0.TYPE_CODE = 'CSW'
AND configPoolsE0.USAGE_CODE = 'TEMPLATE'
AND configPoolsE0.PROCESS_ID = rountingStepsE0.PROCESS_ID
AND rountingStepsE0.PHASE_ID = phasesE0.PHASE_ID
ORDER BY configPoolsE0.NAME
,rountingStepsE0.SEQUENCE_NUMBER