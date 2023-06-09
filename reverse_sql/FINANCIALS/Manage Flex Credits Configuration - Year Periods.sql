/* ****************************************************************************
 * $Revision: 54943 $:
 * $Author: paul.wakefield $:
 * $Date: 2016-05-04 13:45:23 +0700 (Wed, 04 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Trading%20Community%20Person%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Trading Community Person Lookups - Standard Lookup Type.sql 54943 2016-05-04 06:45:23Z paul.wakefield $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT benPLEO.NAME RES_PLAN_NAME
,TO_CHAR(benYRPERDEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(benYRPERDEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = benYRPERDEO.PERD_TYP_CD 
	AND LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'BEN_PERD_TYP'
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_PERIOD_TYPE
,NULL RES_AVAILABLE	
,NULL RES_SELECTED

,benPOPLYEAREO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benPOPLYEAREO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benPOPLYEAREO.CREATED_BY RSC_CREATED_BY
,benPOPLYEAREO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benPLEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_PL_F benPLEO
,BEN_POPL_YR_PERD benPOPLYEAREO
,BEN_YR_PERD benYRPERDEO
,BEN_PL_TYP_F benPLTYPEO
WHERE benPLEO.PL_TYP_ID = benPLTYPEO.PL_TYP_ID 
AND benPLEO.PL_ID = benPOPLYEAREO.PL_ID
AND benPOPLYEAREO.YR_PERD_ID = benYRPERDEO.YR_PERD_ID
AND benPLEO.INVK_FLX_CR_PL_FLAG = 'Y'
AND SYSDATE BETWEEN benPLEO.EFFECTIVE_START_DATE AND NVL(benPLEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benPLTYPEO.EFFECTIVE_START_DATE AND NVL(benPLTYPEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY RES_PLAN_NAME DESC
