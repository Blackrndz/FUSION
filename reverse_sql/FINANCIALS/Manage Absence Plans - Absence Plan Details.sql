/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=ANC_ABSENCE_PLANS_F

SELECT absencePlansTLE0.NAME RES_PLAN
,(SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL
	WHERE TERRITORY_CODE = absencePlansE0.LEGISLATION_CODE 
	) RES_LEGISLATION
,(SELECT NAME
	FROM PER_LEGISLATIVE_DATA_GROUPS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND LEGISLATIVE_DATA_GROUP_ID = absencePlansE0.LEGISLATIVE_DATA_GROUP_ID 
	) RES_LEGISLATIVE_DATA_GROUP
,TO_CHAR(absencePlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(absencePlansE0.EFFECTIVE_END_DATE ,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(absencePlansE0.EFFECTIVE_END_DATE ,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ANC_ENTL_METHOD'
	AND LOOKUP_CODE = absencePlansE0.ENTL_METHOD_CD 
	) RES_PLAN_TYPE
,absencePlansTLE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ANC_DURATION_UOM'
	AND LOOKUP_CODE = absencePlansE0.PLAN_UOM
	) RES_PLAN_UOM
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_AGREE','ORA_ANC_DON') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ZMM_SR_SCHEDULE_CATEGORY'
			AND LOOKUP_CODE = absencePlansE0.WS_CATEGORY_CD)
	END) RES_ALTERNATIVE_SCHEDULE_CATEG
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ORA_ANC_PLAN_LEG_GROUPING'
	AND LOOKUP_CODE = absencePlansE0.LEG_GROUPING_CD 
	) RES_LEGISLATIVE_GROUPING_CODE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ANC_SETUP_OBJ_STATUS'
	AND LOOKUP_CODE = absencePlansE0.PLAN_STATUS 
	) RES_STATUS
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD <> 'ORA_ANC_DON' THEN
		DECODE(absencePlansE0.STATUTORY_FLAG,'Y','Yes','No') 
	END) RES_ENABLE_CONCURRENT_ENTITLEM
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD <> 'ORA_ANC_DON' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ANC_PROCESSING_LEVEL'
			AND LOOKUP_CODE = absencePlansE0.PROCESSING_LEVEL_CD)
	END) RES_PROCESSING_LEVEL
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('A','ORA_ANC_AGREE','ORA_ANC_DON','N','Q') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_ANC_COMP_EXP_RULE'
			AND LOOKUP_CODE = absencePlansE0.EXPIRATION_TERM_CD)
	END) RES_EARNED_TIME_EXPIRATION_RUL
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('A','ORA_ANC_AGREE','ORA_ANC_DON','N','Q') THEN
		absencePlansE0.EXPIRATION_LIMIT 
	END) RES_EXPIRATION_LIMIT
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('A','ORA_ANC_AGREE','ORA_ANC_DON','N','Q') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_ANC_COMP_EXP_UOM'
			AND LOOKUP_CODE = absencePlansE0.EXPIRATION_UOM_CD)
	END) RES_EXPIRATION_PERIOD_UOM
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('A','ORA_ANC_AGREE','ORA_ANC_DON','N','Q') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_ANC_COMP_DISP'
			AND LOOKUP_CODE = absencePlansE0.EXPIRATION_ACTION_CD)
	END) RES_ON_EXPIRATION
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_DON') THEN
		(SELECT BASE_FORMULA_NAME 
			FROM FF_FORMULAS_VL 
			WHERE FORMULA_ID = absencePlansE0.ABSENCE_DURATION_FORMULA_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD')))
	END) RES_CONVERSION_FORMULA
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N','Q') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_ANC_PLAN_CATEGORY'
			AND LOOKUP_CODE = absencePlansE0.TRANSFR_PLAN_CATEGORY)
	END) RES_PLAN_CATEGORY
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_DON') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ANC_PLAN_PERIOD_TYPE'
			AND LOOKUP_CODE = absencePlansE0.PLAN_PERIOD_TYPE)
	END) RES_TYPE
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','Q') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'A' THEN
				(SELECT MEANING
					FROM FND_LOOKUP_VALUES
					WHERE LANGUAGE = USERENV('LANG')
					AND LOOKUP_TYPE = 'ANC_ANNIVERSARY_EVENT'
					AND LOOKUP_CODE = absencePlansE0.ANNIVERSARY_EVENT_RULE)
			END)
	END) RES_ANNIVERSARY_EVENT_RULE
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','Q') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'A' THEN
				(SELECT BASE_FORMULA_NAME 
					FROM FF_FORMULAS_VL 
					WHERE FORMULA_ID = absencePlansE0.ANNIVERSARY_EVENT_FORMULA_ID
					AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD')))
			END)
	END) RES_ANNIVERSARY_EVENT_FORMULA
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'C' THEN
				DECODE(LENGTH(TO_CHAR(absencePlansE0.CALENDAR_START_DAY)),1,'0'||TO_CHAR(absencePlansE0.CALENDAR_START_DAY),2,TO_CHAR(absencePlansE0.CALENDAR_START_DAY))
				||'-'||
				DECODE(absencePlansE0.CALENDAR_START_MONTH,'01','Jan'
					,'02','Feb'
					,'03','Mar'
					,'04','Apr'
					,'05','May'
					,'06','Jun'
					,'07','Jul'
					,'08','Aug'
					,'09','Sep'
					,'10','Oct'
					,'11','Nov'
					,'12','Dec')
				||'-'||
				TO_CHAR(SYSDATE,'YYYY')
			END)
	END) RES_CALENDAR
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'C' THEN
				absencePlansE0.CALENDAR_START_MONTH 
			END)
	END) RES_START_MONTH
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'C' THEN
				absencePlansE0.CALENDAR_START_DAY
				--DECODE(LENGTH(TO_CHAR(absencePlansE0.CALENDAR_START_DAY)),1,'0'||TO_CHAR(absencePlansE0.CALENDAR_START_DAY),2,TO_CHAR(absencePlansE0.CALENDAR_START_DAY))
			END)
	END) RES_START_DAY
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'RF' THEN
				(SELECT MEANING
					FROM FND_LOOKUP_VALUES
					WHERE LANGUAGE = USERENV('LANG')
					AND LOOKUP_TYPE = 'ANC_ROLL_FORWARD'
					AND LOOKUP_CODE = absencePlansE0.ROLL_FORWARD_START_RULE)
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'RB' THEN
				(SELECT MEANING
					FROM FND_LOOKUP_VALUES
					WHERE LANGUAGE = USERENV('LANG')
					AND LOOKUP_TYPE = 'ANC_ROLL_BACKWARD'
					AND LOOKUP_CODE = absencePlansE0.ROLL_BACKWARD_END_RULE)
			END)
	END) RES_START_RULE
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'RF' THEN
				(SELECT BASE_FORMULA_NAME 
					FROM FF_FORMULAS_VL 
					WHERE FORMULA_ID = absencePlansE0.ROLL_FORWARD_START_FORMULA_ID
					AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD')))
			WHEN absencePlansE0.PLAN_PERIOD_TYPE = 'RB' THEN
				(SELECT BASE_FORMULA_NAME 
					FROM FF_FORMULAS_VL 
					WHERE FORMULA_ID = absencePlansE0.ROLL_BACKWARD_END_FORMULA_ID
					AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD')))
			END)
	END) RES_START_FORMULA
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE IN ('RB') THEN
				(SELECT MEANING
					FROM FND_LOOKUP_VALUES
					WHERE LANGUAGE = USERENV('LANG')
					AND LOOKUP_TYPE = 'ANC_OVERLAP'
					AND LOOKUP_CODE = absencePlansE0.OVERLAP_CD)
			END)
	END) RES_OVERLAP_RULE
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE IN ('RB','RF') THEN
				absencePlansE0.ROLL_PERIOD_DURATION
			END)
	END) RES_TERM_DURATION
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N') THEN
		(CASE
			WHEN absencePlansE0.PLAN_PERIOD_TYPE IN ('RB','RF') THEN
				(SELECT MEANING
					FROM FND_LOOKUP_VALUES
					WHERE LANGUAGE = USERENV('LANG')
					AND LOOKUP_TYPE = 'ANC_DURATION_UOM'
					AND LOOKUP_CODE = absencePlansE0.PERIOD_UOM)
			END)
	END) RES_TERM_DURATION_UOM
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N','Q') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_ANC_BAL_DISPLAY'
			AND LOOKUP_CODE = absencePlansE0.ACC_EMP_BAL_DISPLAY)
	END) RES_WORKER_BALANCE_DISPLAY
,(CASE
	WHEN absencePlansE0.ENTL_METHOD_CD NOT IN ('ORA_ANC_COMP','ORA_ANC_AGREE','ORA_ANC_DON','N','Q') THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_ANC_BAL_DISPLAY'
			AND LOOKUP_CODE = absencePlansE0.ACC_MGR_BAL_DISPLAY)
	END) RES_MANAGER_BALANCE_DISPLAY
,absencePlansE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,absencePlansE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,absencePlansE0.CREATED_BY  RSC_CREATED_BY
,absencePlansE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,absencePlansE0.LEGISLATION_CODE RSC_COUNTRY_ID
 
FROM ANC_ABSENCE_PLANS_F absencePlansE0
,(SELECT ABSENCE_PLAN_ID
	,NAME
	,DESCRIPTION
	,EFFECTIVE_START_DATE
	FROM ANC_ABSENCE_PLANS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	) absencePlansTLE0
WHERE absencePlansE0.ABSENCE_PLAN_ID = absencePlansTLE0.ABSENCE_PLAN_ID
AND absencePlansE0.EFFECTIVE_START_DATE = absencePlansTLE0.EFFECTIVE_START_DATE
ORDER BY absencePlansTLE0.NAME
,absencePlansE0.EFFECTIVE_START_DATE