/* ****************************************************************************
 * $Revision: 73701 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-03-05 12:34:33 +0700 (Thu, 05 Mar 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Remittance%20Bank%20Account.sql $:
 * $Id: Manage Receipt Classes and Methods - Remittance Bank Account.sql 73701 2020-03-05 05:34:33Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT TO_CHAR(laddersE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,laddersE0.NAME RES_NAME
,legisDataGroupsE0.NAME RES_LEGISLATIVE_DATA_GROUP
,gradeStepRatesE0.NAME RES_RATE_NAME
,(SELECT NAME
    FROM PER_GRADES_F_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND GRADE_ID = gradeLaddersE0.GRADE_ID
    ) RES_GRADE_NAME
,gardeStepsE0.NAME RES_GRADE_RATE_NAME
,(CASE
	WHEN INSTR(rateValuesE0.VALUE,'.',1,1) = 0 THEN 
		TO_CHAR(rateValuesE0.VALUE)||'.00'
	ELSE
		TO_CHAR(rateValuesE0.VALUE)
	END) RES_GRADE_RATE_VALUE
,rateValuesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rateValuesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rateValuesE0.CREATED_BY RSC_CREATED_BY
,rateValuesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_GRADE_LADDERS_F_VL laddersE0
,PER_GRADES_IN_LADDERS_F gradeLaddersE0
,PER_RATES_F_VL gradeStepRatesE0
,(SELECT LEGISLATIVE_DATA_GROUP_ID
    ,NAME
    FROM PER_LEGISLATIVE_DATA_GROUPS_TL
    WHERE LANGUAGE = USERENV('LANG')
    ) legisDataGroupsE0
,(SELECT *
    FROM PER_RATE_VALUES_F
    WHERE RATE_OBJECT_TYPE = 'STEP'
    ) rateValuesE0
,PER_GRADE_STEPS_F_VL gardeStepsE0
WHERE laddersE0.GRADE_LADDER_ID = gradeLaddersE0.GRADE_LADDER_ID
AND laddersE0.EFFECTIVE_END_DATE BETWEEN gradeLaddersE0.EFFECTIVE_START_DATE AND gradeLaddersE0.EFFECTIVE_END_DATE
AND gradeLaddersE0.GRADE_LADDER_ID = gradeStepRatesE0.GRADE_LADDER_ID
AND gradeLaddersE0.EFFECTIVE_END_DATE BETWEEN gradeStepRatesE0.EFFECTIVE_START_DATE AND gradeStepRatesE0.EFFECTIVE_END_DATE
AND gradeStepRatesE0.LEGISLATIVE_DATA_GROUP_ID = legisDataGroupsE0.LEGISLATIVE_DATA_GROUP_ID
AND gradeStepRatesE0.RATE_ID = rateValuesE0.RATE_ID
AND gradeStepRatesE0.EFFECTIVE_END_DATE BETWEEN rateValuesE0.EFFECTIVE_START_DATE AND rateValuesE0.EFFECTIVE_END_DATE
AND rateValuesE0.RATE_OBJECT_ID = gardeStepsE0.GRADE_STEP_ID
AND rateValuesE0.EFFECTIVE_END_DATE BETWEEN gardeStepsE0.EFFECTIVE_START_DATE AND gardeStepsE0.EFFECTIVE_END_DATE
ORDER BY laddersE0.NAME
,laddersE0.EFFECTIVE_START_DATE
,legisDataGroupsE0.NAME
,gradeStepRatesE0.NAME
,gradeLaddersE0.SEQUENCE
,rateValuesE0.SEQUENCE
,gardeStepsE0.NAME