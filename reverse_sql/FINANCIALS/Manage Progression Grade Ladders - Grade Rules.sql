/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Progression%20Grade%20Ladders%20-%20Grade%20Rules.sql $:
 * $Id: Manage Progression Grade Ladders - Grade Rules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
-- RSC_PREREQUISITE_OBJECTS=PER_GRADE_LADDERS_F_VL
  
SELECT perGRADELADEO.NAME RES_NAME
,TO_CHAR(cmpELIGEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,perGRADEO.NAME RES_GRADE_NAME
,perGRADEO.GRADE_CODE RES_GRADE_CODE
,perGRADEINLADEO.SEQUENCE RES_GRADE_SEQUENCE
,(SELECT NAME FROM BEN_ELIGY_PRFL WHERE  ELIGY_PRFL_ID = cmpELIGEO.ELIGIBILITY_PROFILE_ID 
	AND SYSDATE BETWEEN START_DATE  AND NVL(END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_RULE_NAME


,cmpELIGEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpELIGEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpELIGEO.CREATED_BY RSC_CREATED_BY
,cmpELIGEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_GRADE_LADDERS_F_VL perGRADELADEO
,(SELECT * FROM CMP_GSP_ELIGIBILITY_F WHERE GRADE_STEP_ID IS NULL 
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE  AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))) cmpELIGEO
,PER_GRADES_IN_LADDERS_F perGRADEINLADEO
,PER_GRADES_F_VL perGRADEO
WHERE perGRADELADEO.GRADE_LADDER_ID = perGRADEINLADEO.GRADE_LADDER_ID
AND perGRADEINLADEO.GRADE_LADDER_ID = cmpELIGEO.GRADE_LADDER_ID
AND perGRADEINLADEO.GRADE_ID = cmpELIGEO.GRADE_ID
AND perGRADEINLADEO.GRADE_ID = perGRADEO.GRADE_ID
AND perGRADELADEO.AUTO_PROGRESSION_CODE IS NOT NULL
AND SYSDATE BETWEEN perGRADELADEO.EFFECTIVE_START_DATE  AND NVL(perGRADELADEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN perGRADEINLADEO.EFFECTIVE_START_DATE  AND NVL(perGRADEINLADEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))

ORDER BY perGRADELADEO.NAME,cmpELIGEO.EFFECTIVE_START_DATE,perGRADEINLADEO.SEQUENCE