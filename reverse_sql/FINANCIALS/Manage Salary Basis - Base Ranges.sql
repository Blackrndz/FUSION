/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Salary%20Basis%20-%20Base%20Ranges.sql $:
 * $Id: Manage Salary Basis - Base Ranges.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_SALARY_BASES_VL 
 
SELECT cMPSBEO.SALARY_BASIS_NAME RES_NAME 
,cMPSBEO.CODE RES_CODE 
,perRATEFEO.NAME RES_GRADE_RATE
,(SELECT NAME FROM PER_GRADES_F_VL WHERE GRADE_ID = perRATEVALFEO.RATE_OBJECT_ID 
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	)RES_GRADE
,perRATEVALFEO.MINIMUM RES_MINIMUM
,perRATEVALFEO.MID_VALUE RES_MIDPOINT
,perRATEVALFEO.MAXIMUM RES_MAXIMUM

,NULL RES_EFFECTIVE_AS_OF_DATE

,perRATEVALFEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,perRATEVALFEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,perRATEVALFEO.CREATED_BY RSC_CREATED_BY
,perRATEVALFEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_SALARY_BASES_VL  cMPSBEO
,PER_RATES_F_VL perRATEFEO
,PER_RATE_VALUES_F  perRATEVALFEO
WHERE cMPSBEO.GRADE_RATE_ID = perRATEFEO.RATE_ID
AND perRATEFEO.RATE_ID = perRATEVALFEO.RATE_ID 
AND SYSDATE BETWEEN perRATEFEO.EFFECTIVE_START_DATE AND NVL(perRATEFEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN perRATEVALFEO.EFFECTIVE_START_DATE AND NVL(perRATEVALFEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND cMPSBEO.LANGUAGE = USERENV('LANG')
































