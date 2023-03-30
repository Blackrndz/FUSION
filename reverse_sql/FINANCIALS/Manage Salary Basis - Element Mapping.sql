/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Salary%20Basis%20-%20Element%20Mapping.sql $:
 * $Id: Manage Salary Basis - Element Mapping.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_SALARY_BASES_VL  
 
SELECT cMPSBEO.SALARY_BASIS_NAME RES_NAME 
,cMPSBEO.CODE RES_CODE 
,(SELECT ELEMENT_NAME FROM PAY_ELEMENT_TYPES_VL
	WHERE ELEMENT_TYPE_ID = cMPSBEO.ELEMENT_TYPE_ID AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_PAYROLL_ELEMENT
,(SELECT NAME FROM PAY_INPUT_VALUES_VL
	WHERE INPUT_VALUE_ID = cMPSBEO.INPUT_VALUE_ID AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_INPUT_VALUE

,cMPSBEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cMPSBEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cMPSBEO.CREATED_BY RSC_CREATED_BY
,cMPSBEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,cMPSBEO.BUSINESS_GROUP_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_SALARY_BASES_VL  cMPSBEO

WHERE cMPSBEO.LANGUAGE = USERENV('LANG')
































