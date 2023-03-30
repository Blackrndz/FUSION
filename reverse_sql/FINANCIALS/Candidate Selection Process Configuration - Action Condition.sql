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
,phasesE0.NAME RES_PHASES_NAME
,StatesE0.NAME RES_STATE_NAME
,(SELECT ACTION_NAME
	FROM IRC_LC_ACTIONS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND ACTION_ID = actionsE0.ACTION_ID
	) RES_ACTION_NAME
,(CASE
	WHEN actionEventsE0.FORMULA_ID IS NOT NULL THEN
		(SELECT FORMULA_NAME
			FROM FF_FORMULAS_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND FORMULA_ID = actionEventsE0.FORMULA_ID )
	ELSE
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_IRC_PROC_ACTION_CONDITION'
			AND LOOKUP_CODE = actionEventsE0.REF_TYPE_CODE)
	END) RES_ACTION_CONDITION
,actionEventsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,actionEventsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,actionEventsE0.CREATED_BY RSC_CREATED_BY
,actionEventsE0.CREATION_DATE RSC_CREATION_DATE
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
    WHERE TYPE_CODE = 'STATE'
    ) rStepStatesE0
,(SELECT *
    FROM IRC_STATES_TL
    WHERE LANGUAGE = USERENV('LANG')
    ) StatesE0
,(SELECT *
    FROM IRC_FN_EXPRESSION_REFS
    WHERE OBJECT_TYPE = 'SETTING_ID'
    ) actionEventsE0
,(SELECT *
    FROM IRC_LC_ACTION_USAGES_VL
    ) actionsE0
WHERE configPoolsE0.TYPE_CODE = 'CSW'
AND configPoolsE0.USAGE_CODE = 'TEMPLATE'
AND configPoolsE0.PROCESS_ID = rountingStepsE0.PROCESS_ID
AND rountingStepsE0.PHASE_ID = phasesE0.PHASE_ID
AND rountingStepsE0.SUB_PROCESS_ID = rStepStatesE0.PROCESS_ID
AND rStepStatesE0.STATE_ID = StatesE0.STATE_ID
AND rStepStatesE0.ROUTING_STEP_ID = actionsE0.ROUTING_STEP_ID
AND actionsE0.SETTING_ID = actionEventsE0.OBJECT_ID
ORDER BY configPoolsE0.NAME
,rountingStepsE0.SEQUENCE_NUMBER
,rStepStatesE0.SEQUENCE_NUMBER