/* ****************************************************************************
 * $Revision: 79100 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-08-01 16:28:55 +0700 (Mon, 01 Aug 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Programs%20-%20Enrollment%20Life%20Event%20Period%20for%20Plan.sql $:
 * $Id: Manage Benefit Programs - Enrollment Life Event Period for Plan.sql 79100 2022-08-01 09:28:55Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT benPGMEO.NAME RES_PROGRAM_NAME
,TO_CHAR(benPGMEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT NAME FROM BEN_PGM_F WHERE PGM_ID = benPOPLENRTEO.PGM_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_PROGRAM_HIERARCHY
,'Programs' RES_PROGRAM_HIERARCHY_DESCRIPT
,(SELECT NAME FROM BEN_LER_F_VL WHERE LER_ID = benLEERSNEO.LER_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_LIFE_EVENT
,TO_CHAR(benENRTPERDFORPLEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_LIFE_EVENT_EFFECTIVE_START
,DECODE(TO_CHAR(benENRTPERDFORPLEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(benENRTPERDFORPLEO.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_LIFE_EVENT_PERIOD_FOR_PLAN
,(SELECT NAME FROM BEN_PL_F WHERE PL_ID = benENRTPERDFORPLEO.PL_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE ,TO_DATE('31-12-4712','DD-MM-YYYY'))) RES_PLAN
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_ENRT_CVG_STRT'
    AND LOOKUP_CODE = benENRTPERDFORPLEO.ENRT_CVG_STRT_DT_CD
    ) RES_COVERAGE_START_DATE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = benENRTPERDFORPLEO.ENRT_CVG_STRT_DT_RL
    ) RES_COVERAGE_START_FORMULA
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_ENRT_CVG_END'
    AND LOOKUP_CODE = benENRTPERDFORPLEO.ENRT_CVG_END_DT_CD
    ) RES_PREVIOUS_COVERAGE_END_DATE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = benENRTPERDFORPLEO.ENRT_CVG_END_DT_RL
    ) RES_PREVIOUS_COVERAGE_END_FORM
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_RT_STRT'
    AND LOOKUP_CODE = benENRTPERDFORPLEO.RT_STRT_DT_CD
    ) RES_RATE_START_DATE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = benENRTPERDFORPLEO.RT_STRT_DT_RL
    ) RES_RATE_START_FORMULA
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_RT_END'
    AND LOOKUP_CODE = benENRTPERDFORPLEO.RT_END_DT_CD
    ) RES_PREVIOUS_RATE_END_DATE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = benENRTPERDFORPLEO.RT_END_DT_RL
    ) RES_PREVIOUS_RATE_END_FORMULA

,benENRTPERDFORPLEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benENRTPERDFORPLEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benENRTPERDFORPLEO.CREATED_BY RSC_CREATED_BY
,benENRTPERDFORPLEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benPGMEO.LEGISLATION_CODE RSC_COUNTRY_ID
	
	
FROM BEN_PGM_F benPGMEO
,BEN_POPL_ENRT_TYP_CYCL benPOPLENRTEO
,BEN_LEE_RSN_F benLEERSNEO
,BEN_ENRT_PERD_FOR_PL_F benENRTPERDFORPLEO
WHERE benPGMEO.PGM_ID = benPOPLENRTEO.PGM_ID 
AND benPOPLENRTEO.POPL_ENRT_TYP_CYCL_ID = benLEERSNEO.POPL_ENRT_TYP_CYCL_ID
AND benLEERSNEO.LEE_RSN_ID = benENRTPERDFORPLEO.LEE_RSN_ID
AND benPOPLENRTEO.ENRT_TYP_CYCL_CD in ('L')
AND benLEERSNEO.LER_ID NOT IN (SELECT LER_ID FROM BEN_LER_F_VL WHERE TYP_CD IN ('SCHEDDA','SCHEDDO')
				AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY')))
AND SYSDATE BETWEEN benPGMEO.EFFECTIVE_START_DATE AND NVL(benPGMEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benLEERSNEO.EFFECTIVE_START_DATE AND NVL(benLEERSNEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benENRTPERDFORPLEO.EFFECTIVE_START_DATE AND NVL(benENRTPERDFORPLEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))

ORDER BY 1,2,3,4