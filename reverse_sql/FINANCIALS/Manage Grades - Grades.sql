/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT gradesE0.NAME RES_NAME
,gradesE0.GRADE_CODE RES_CODE
,gradesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gradesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gradesE0.CREATED_BY RSC_CREATED_BY
,gradesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,gradesE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM (SELECT NAME
	,GRADE_CODE
	,LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
	,BUSINESS_GROUP_ID
	,ROW_NUMBER() OVER(PARTITION BY GRADE_CODE ORDER BY CREATION_DATE) R1
	FROM PER_GRADES_F_VL
	) gradesE0
WHERE R1 = 1
ORDER BY gradesE0.NAME
,gradesE0.GRADE_CODE