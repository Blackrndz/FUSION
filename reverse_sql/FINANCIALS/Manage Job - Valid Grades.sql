/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Job%20-%20Valid%20Grades.sql $:
 * $Id: Manage Job - Valid Grades.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select JOBDEO.name RES_NAME
,JobDEO.JOB_CODE RES_CODE
,TO_CHAR(ValidGradeEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY')  RES_EFFECTIVE_START_DATE
,TO_CHAR(ValidGradeEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,GRADEDPEO.NAME RES_GRADE_NAME
,GRADEDPEO.GRADE_CODE RES_GRADE_CODE
,ValidGradeEO.LAST_UPDATED_BY as RSC_LAST_UPDATED_BY
,ValidGradeEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,ValidGradeEO.CREATED_BY  RSC_CREATED_BY
,ValidGradeEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM PER_JOBS_F_VL JOBDEO
,PER_VALID_GRADES_F ValidGradeEO
,(SELECT NAME,GRADE_CODE,GRADE_ID FROM PER_GRADES_F_VL 
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))) GRADEDPEO
where JOBDEO.JOB_ID  = ValidGradeEO.JOB_ID
and VALIDGRADEEO.GRADE_ID = GRADEDPEO.GRADE_ID
and JOBDEO.EFFECTIVE_END_DATE BETWEEN ValidGradeEO.EFFECTIVE_START_DATE and ValidGradeEO.EFFECTIVE_END_DATE
order by JOBDEO.name,JobDEO.JOB_CODE,JobDEO.EFFECTIVE_START_DATE,GRADEDPEO.NAME,GRADEDPEO.GRADE_CODE
