/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Programs%20-%20Organization%20Roles.sql $:
 * $Id: Manage Benefit Programs - Organization Roles.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT benPGMEO.NAME RES_PROGRAM_NAME 
,TO_CHAR(benPGMEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT NAME FROM HR_ORGANIZATION_V WHERE ORGANIZATION_ID = benPOPLORGEO.ORGANIZATION_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
	AND CLASSIFICATION_CODE = 'DEPARTMENT' ) RES_ORGANIZATION_NAME
,benPOPLORGROLEEO.NAME RES_ORGANIZATION_DESIGNEE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = benPOPLORGROLEEO.ORG_ROLE_TYP_CD
	AND LOOKUP_TYPE = 'BEN_ORG_ROLE_TYP' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE  AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_ORGANIZATION_ROLE
,TO_CHAR(benPOPLORGROLEEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_ORGANIZATION_ROLE_EFFECTIV
,TO_CHAR(benPOPLORGROLEEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_ORGANIZATION_ROLE_EFFECT_0


,benPOPLORGROLEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benPOPLORGROLEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benPOPLORGROLEEO.CREATED_BY RSC_CREATED_BY
,benPOPLORGROLEEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benPGMEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_PGM_F benPGMEO
,BEN_POPL_ORG_F benPOPLORGEO
,BEN_POPL_ORG_ROLE_F benPOPLORGROLEEO
WHERE benPGMEO.PGM_ID = benPOPLORGEO.PGM_ID
AND benPOPLORGEO.POPL_ORG_ID = benPOPLORGROLEEO.POPL_ORG_ID
AND benPOPLORGEO.COMP_OBJ_TYPE = 'PGM'
AND benPOPLORGROLEEO.COMP_OBJ_TYPE = 'PGM'
AND SYSDATE BETWEEN benPGMEO.EFFECTIVE_START_DATE AND NVL(benPGMEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benPOPLORGEO.EFFECTIVE_START_DATE AND NVL(benPOPLORGEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benPOPLORGROLEEO.EFFECTIVE_START_DATE AND NVL(benPOPLORGROLEEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY RES_PROGRAM_NAME,RES_ORGANIZATION_NAME
