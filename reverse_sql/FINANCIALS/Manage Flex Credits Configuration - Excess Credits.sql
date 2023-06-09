/* ****************************************************************************
 * $Revision: 54943 $:
 * $Author: paul.wakefield $:
 * $Date: 2016-05-04 13:45:23 +0700 (Wed, 04 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Trading%20Community%20Person%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Trading Community Person Lookups - Standard Lookup Type.sql 54943 2016-05-04 06:45:23Z paul.wakefield $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT DISTINCT benPLEO.NAME RES_PLAN_NAME
,benPGMEO.NAME RES_PROGRAM_NAME 
,(SELECT NAME FROM HR_ORGANIZATION_UNITS
				WHERE SYSDATE BETWEEN DATE_FROM AND DATE_TO
				AND ORGANIZATION_ID = benACTYPOOLE0.LEGAL_ENTITY_ID) RES_LEGAL_EMPLOYER
,(SELECT FORMULA_NAME FROM FF_FORMULAS_TL
	WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = benCRDTSPNDE0.RLOVR_VAL_RL) RES_FORMULA
,benCRDTSPNDE0.ORDR_NUM RES_SEQUENCE
,benRatesE0.NAME RES_RATE_NAME
,(SELECT NAME
    FROM BEN_OPT_F
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND OPT_ID = benRatesE0.CONTEXT_OPT_ID
    ) RES_OPTION_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_RLVR_DSTRBN_LMT'
    AND LOOKUP_CODE = benCRDTSPNDE0.RLVR_DSTRBN_RSTRCN_CD
    ) RES_ROLLOVER_LIMIT_RULE
,TO_CHAR(benCRDTSPNDE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(benCRDTSPNDE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,benCRDTSPNDE0.MN_RLVR_DSTRBL_VAL RES_MAXIMUM
,benCRDTSPNDE0.MX_RLVR_DSTRBL_VAL RES_MINIMUM

,benCRDTSPNDE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benCRDTSPNDE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benCRDTSPNDE0.CREATED_BY RSC_CREATED_BY
,benCRDTSPNDE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benPLEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_PL_F benPLEO
,BEN_PLIP_F benPLIPEO
,BEN_PGM_F benPGMEO
,BEN_PL_TYP_F benPLTYPEO
,BEN_ACTY_BASE_RT_F benACTYPOOLE0
,BEN_CRDT_POOL_SPND_RLVR_OPT_F benCRDTSPNDE0
,BEN_ACTY_BASE_RT_F benRatesE0
WHERE benPLEO.PL_TYP_ID = benPLTYPEO.PL_TYP_ID 
AND benPLEO.PL_ID = benPLIPEO.PL_ID
AND benPLIPEO.PGM_ID = benPGMEO.PGM_ID
AND benPLEO.INVK_FLX_CR_PL_FLAG = 'Y'
AND benPGMEO.PGM_ID = benACTYPOOLE0.PGM_ID
AND benACTYPOOLE0.ACTY_BASE_RT_ID = benCRDTSPNDE0.ACTY_BASE_RT_ID
AND benCRDTSPNDE0.CRDT_POOL_ACTY_BASE_RT_ID = benRatesE0.ACTY_BASE_RT_ID
AND benACTYPOOLE0.COMP_OBJ_TYPE = 'PGM'
AND SYSDATE BETWEEN benPLEO.EFFECTIVE_START_DATE AND NVL(benPLEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benPLIPEO.EFFECTIVE_START_DATE AND NVL(benPLIPEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benPGMEO.EFFECTIVE_START_DATE AND NVL(benPGMEO.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benACTYPOOLE0.EFFECTIVE_START_DATE AND NVL(benACTYPOOLE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benCRDTSPNDE0.EFFECTIVE_START_DATE AND NVL(benCRDTSPNDE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN benRatesE0.EFFECTIVE_START_DATE AND NVL(benRatesE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))


ORDER BY RES_PLAN_NAME,RES_PROGRAM_NAME,RES_LEGAL_EMPLOYER