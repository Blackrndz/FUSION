/* ****************************************************************************
 * $Revision: 77370 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2021-11-25 13:24:52 +0700 (Thu, 25 Nov 2021) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Benefit%20Plan.sql $:
 * $Id: Manage Benefit Plans - Benefit Plan.sql 77370 2021-11-25 06:24:52Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=BEN_PL_F
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(benPlansE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(benPlansE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,planTypesE0.NAME RES_PLAN_TYPE
,benPlansE0.CONFIG_CHAR_2 RES_DESCRIPTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_PL'
    AND LOOKUP_CODE = benPlansE0.PL_CD
    ) RES_USAGE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_PL_FUNCTION'
    AND LOOKUP_CODE = benPlansE0.FUNCTION_CODE
    ) RES_PLAN_FUNCTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_STAT'
    AND LOOKUP_CODE = benPlansE0.PL_STAT_CD
    ) RES_STATUS
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_ENRT_INFO_RT_FREQ'
    AND LOOKUP_CODE = benPlansE0.NIP_ENRT_INFO_RT_FREQ_CD
    ) RES_COMMUNICATED_RATE_FREQUENC
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_ACTY_REF_PERD'
    AND LOOKUP_CODE = benPlansE0.NIP_ACTY_REF_PERD_CD
    ) RES_DEFINED_RATE_FREQUENCY
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_BEN_RT_LVL'
    AND LOOKUP_CODE = NVL(benPlansE0.CONFIG_CHAR_3,'ORA_LE')
    ) RES_RATE_LEVEL
,(CASE
	WHEN benPlansE0.PL_CD = 'MYNTBPGM' THEN
		(SELECT NAME
			FROM FND_CURRENCIES_VL
			WHERE CURRENCY_CODE = benPlansE0.NIP_PL_UOM)
    END) RES_PLAN_DEFAULT_CURRENCY
,benPlansE0.SHORT_NAME RES_SHORT_NAME
,benPlansE0.SHORT_CODE RES_SHORT_CODE
,benPlansE0.IVR_IDENT RES_INTERACTIVE_VOICE_RESPONSE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_IMPTD_INCM_CALC'
    AND LOOKUP_CODE = benPlansE0.IMPTD_INCM_CALC_CD
    )  RES_IMPUTED_INCOME_CALCULATION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_IMPTD_INCM_TYP'
    AND LOOKUP_CODE = benPlansE0.SUBJ_TO_IMPTD_INCM_TYP_CD
    ) RES_SUBJECT_TO_IMPUTED_INCOME
,TO_CHAR(benPlansE0.INCPTN_DT,'DD-Mon-YYYY') RES_INCEPTION_DATE
,(SELECT NAME FROM ANC_ABSENCE_PLANS_F_TL WHERE ABSENCE_PLAN_ID = CONFIG_ID_1  AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND 
	NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD')) AND LANGUAGE = USERENV('LANG')) RES_ABSENCE_PLAN
,benPlansE0.URL_REF_NAME RES_WEB_ADDRESS
,benPlansE0.ORDR_NUM RES_SEQUENCE
,DECODE(benPlansE0.GLOBAL_FLAG,'Y','Yes','No') RES_GLOBAL_PLAN
,DECODE(benPlansE0.ALWS_UNRSTRCTD_ENRT_FLAG,'Y','Yes','No') RES_ENABLE_UNRESTRICTED_ENROLL
,benPlansE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benPlansE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benPlansE0.CREATED_BY  RSC_CREATED_BY
,benPlansE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,benPlansE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_PL_F benPlansE0
,(SELECT NAME
	,PL_TYP_ID
    FROM BEN_PL_TYP_F
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND OPT_TYP_CD != 'FLXCR'
	) planTypesE0
WHERE benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE