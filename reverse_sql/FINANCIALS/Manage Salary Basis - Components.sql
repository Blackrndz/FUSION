/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Salary%20Basis%20-%20Components.sql $:
 * $Id: Manage Salary Basis - Components.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_SALARY_BASES_VL 
 
 --Cannot find table for input values on RES_SALARY_COMPONENT , RES_DISPLAY_SEQUENCE and RES_DESCRIPTION
 
SELECT cMPSBEO.SALARY_BASIS_NAME RES_NAME 
,cMPSBEO.CODE RES_CODE 
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = DECODE(cMPSBEO.COMPONENT_USAGE,'NO_COMPONENT',NULL,cMPSBEO.COMPONENT_USAGE)
	AND LOOKUP_TYPE = 'CMP_COMPONENT_USAGE' AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_COMPONENTS_TO_DISPLAY_WHEN
,NULL RES_SALARY_COMPONENT
,NULL RES_DISPLAY_SEQUENCE
,NULL RES_DESCRIPTION
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
WHERE LANGUAGE = USERENV('LANG')
































