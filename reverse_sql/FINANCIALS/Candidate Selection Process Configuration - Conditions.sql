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
,(CASE
	WHEN conditionsE0.FORMULA_ID IS NOT NULL THEN
		(SELECT FORMULA_NAME
			FROM FF_FORMULAS_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND FORMULA_ID = conditionsE0.FORMULA_ID )
	ELSE
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_IRC_PROC_ACTION_CONDITION'
			AND LOOKUP_CODE = conditionsE0.REF_TYPE_CODE)
	END) RES_CONDITION
,conditionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,conditionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,conditionsE0.CREATED_BY RSC_CREATED_BY
,conditionsE0.CREATION_DATE RSC_CREATION_DATE
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
,IRC_LC_SETTING_ITEMS settingsE0
,IRC_FN_EXPRESSION_REFS conditionsE0
WHERE configPoolsE0.TYPE_CODE = 'CSW'
AND configPoolsE0.USAGE_CODE = 'TEMPLATE'
AND configPoolsE0.PROCESS_ID = rountingStepsE0.PROCESS_ID
AND rountingStepsE0.PHASE_ID = phasesE0.PHASE_ID
AND rountingStepsE0.SUB_PROCESS_ID = rStepStatesE0.PROCESS_ID
AND rStepStatesE0.STATE_ID = StatesE0.STATE_ID
AND rStepStatesE0.SETTING_ID = settingsE0.SETTING_ID
AND settingsE0.SETTING_ITEM_ID = conditionsE0.OBJECT_ID
AND conditionsE0.OBJECT_TYPE = 'SETTING_ITEM_ID'
ORDER BY configPoolsE0.NAME
,rountingStepsE0.SEQUENCE_NUMBER
,rStepStatesE0.SEQUENCE_NUMBER