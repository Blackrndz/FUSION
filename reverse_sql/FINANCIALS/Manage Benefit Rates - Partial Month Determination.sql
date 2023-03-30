/* ****************************************************************************
 * $Revision: 68493 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-29 15:56:19 +0700 (Wed, 29 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Allow%20Account%20Updates%20on%20Project-Related%20Distributions%20-%20Profile%20Options.sql $:
 * $Id: Allow Account Updates on Project-Related Distributions - Profile Options.sql 68493 2018-08-29 08:56:19Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT benRatesE0.NAME RES_RATE_NAME
,TO_CHAR(prorationsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(prorationsE0.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(prorationsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'BEN_RNDG'
	AND LOOKUP_CODE = prorationsE0.RNDG_CD
	) RES_ROUNDING_RULE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_VL
    WHERE FORMULA_ID = prorationsE0.RNDG_RL
    ) RES_ROUNDING_FORMULA
,DECODE(prorationsE0.PRORATE_BY_DAY_TO_MON_FLAG,'Y','Yes','N','No') RES_PRORATE_ON_DAY_OF_MONTH_BA
,(CASE
    WHEN prorationsE0.PRORATE_BY_DAY_TO_MON_FLAG = 'N' THEN
        prorationsE0.FROM_DY_MO_NUM
    END) RES_FROM_DATE
,(CASE
    WHEN prorationsE0.PRORATE_BY_DAY_TO_MON_FLAG = 'N' THEN
        prorationsE0.TO_DY_MO_NUM
    END) RES_TO_DAY_IN_MONTH
,(CASE
    WHEN prorationsE0.PRORATE_BY_DAY_TO_MON_FLAG = 'N' THEN
        prorationsE0.NUM_DAYS_MONTH
    END) RES_APPLIES_TO_MONTH_WITH_DAYS
,(CASE
    WHEN prorationsE0.PRORATE_BY_DAY_TO_MON_FLAG = 'N' THEN
        prorationsE0.PCT_VAL
    END) RES_TOTAL_PERCENTAGE_OF_ACTIVI
,(CASE
    WHEN prorationsE0.PRORATE_BY_DAY_TO_MON_FLAG = 'N' THEN
        (SELECT FORMULA_NAME
            FROM FF_FORMULAS_VL
            WHERE FORMULA_ID = prorationsE0.PRTL_MO_PRORTN_RL)
    END) RES_PRORATION_FORMULA
,(CASE
    WHEN prorationsE0.PRORATE_BY_DAY_TO_MON_FLAG = 'N' THEN
        (SELECT MEANING
            FROM FND_LOOKUP_VALUES
            WHERE LANGUAGE = USERENV('LANG')
            AND LOOKUP_TYPE = 'BEN_STRT_R_STP_CVG'
            AND LOOKUP_CODE = prorationsE0.STRT_R_STP_CVG_CD)
    END) RES_START_AND_STOP_COVERAGE_RU
,prorationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,prorationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,prorationsE0.CREATED_BY RSC_CREATED_BY
,prorationsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ACTY_BASE_RT_F benRatesE0
,BEN_PRTL_MO_RT_PRTN_VAL_F prorationsE0
WHERE SYSDATE BETWEEN benRatesE0.EFFECTIVE_START_DATE AND benRatesE0.EFFECTIVE_END_DATE
AND SYSDATE BETWEEN prorationsE0.EFFECTIVE_START_DATE AND prorationsE0.EFFECTIVE_END_DATE
AND benRatesE0.ACTY_BASE_RT_ID = prorationsE0.ACTY_BASE_RT_ID
ORDER BY benRatesE0.NAME
,prorationsE0.EFFECTIVE_START_DATE