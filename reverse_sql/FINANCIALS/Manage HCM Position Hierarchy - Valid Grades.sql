/* ****************************************************************************
 * $Revision: 73970 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2020-04-15 21:09:13 +0700 (Wed, 15 Apr 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Positions%20-%20Valid%20Grades.sql $:
 * $Id: Manage Positions - Valid Grades.sql 73970 2020-04-15 14:09:13Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT TO_CHAR(hrALLPOSTIONEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = hrALLPOSTIONEO.BUSINESS_UNIT_ID 
	) RES_BUSINESS_UNIT
,hrALLPOSTIONEO.NAME RES_NAME
,hrALLPOSTIONEO.POSITION_CODE RES_CODE
,perGRADEO.NAME RES_GRADE_NAME
,perGRADEO.GRADE_CODE RES_GRADE_CODE
,(SELECT SET_NAME
	FROM FND_SETID_SETS
	WHERE SET_ID = perGRADEO.SET_ID
	AND LANGUAGE = USERENV('LANG')
	)RES_SET_NAME
,perVALIDGRADEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,perVALIDGRADEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,perVALIDGRADEO.CREATED_BY RSC_CREATED_BY
,perVALIDGRADEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ALL_POSITIONS_F_VL hrALLPOSTIONEO
,PER_VALID_GRADES_F perVALIDGRADEO
,PER_GRADES_F_VL perGRADEO
WHERE hrALLPOSTIONEO.POSITION_ID = perVALIDGRADEO.POSITION_ID(+)
AND hrALLPOSTIONEO.EFFECTIVE_START_DATE BETWEEN perVALIDGRADEO.EFFECTIVE_START_DATE AND NVL(perVALIDGRADEO.EFFECTIVE_END_DATE ,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND perVALIDGRADEO.GRADE_ID = perGRADEO.GRADE_ID
AND perVALIDGRADEO.EFFECTIVE_START_DATE BETWEEN perGRADEO.EFFECTIVE_START_DATE AND NVL(perGRADEO.EFFECTIVE_END_DATE ,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY hrALLPOSTIONEO.NAME
,hrALLPOSTIONEO.POSITION_CODE
,hrALLPOSTIONEO.EFFECTIVE_START_DATE
,perGRADEO.NAME