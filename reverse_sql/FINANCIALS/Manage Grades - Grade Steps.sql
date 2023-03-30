/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT TO_CHAR(gradesE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,gradesE0.NAME RES_NAME
,gradesE0.GRADE_CODE RES_CODE
,gradeStepsE0.SEQUENCE RES_STEP_NUMBER
,gradeStepsE0.NAME RES_STEP_NAME
,(CASE 
	WHEN gradesE0.CEILING_STEP_ID = gradeStepsE0.GRADE_STEP_ID THEN 'Yes'
	ELSE 'No'
	END) RES_CEILING_STEP
,gradeStepsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,gradeStepsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,gradeStepsE0.CREATED_BY  RSC_CREATED_BY
,gradeStepsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,gradesE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM PER_GRADES_F_VL gradesE0
,PER_GRADE_STEPS_F_VL gradeStepsE0
WHERE gradesE0.GRADE_ID = gradeStepsE0.GRADE_ID
AND gradesE0.EFFECTIVE_END_DATE BETWEEN gradeStepsE0.EFFECTIVE_START_DATE AND gradeStepsE0.EFFECTIVE_END_DATE
ORDER BY gradesE0.NAME
,gradesE0.GRADE_CODE
,gradesE0.EFFECTIVE_START_DATE
,gradeStepsE0.SEQUENCE