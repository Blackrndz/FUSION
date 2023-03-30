/* ****************************************************************************
 * $Revision: 78867 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-24 16:46:08 +0700 (Fri, 24 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Dependent%20Eligibility.sql $:
 * $Id: Manage Benefit Plans - Dependent Eligibility.sql 78867 2022-06-24 09:46:08Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=BEN_PL_F
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT NAME
    FROM BEN_ELIGY_PRFL
    WHERE SYSDATE BETWEEN START_DATE AND END_DATE
    AND ELIGY_PRFL_ID = eligibilityPfsE0.DPNT_CVG_ELIGY_PRFL_ID
    ) RES_ELIGIBILITY_PROFILE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = eligibilityPfsE0.APLD_DPNT_CVG_ELIG_RL
    ) RES_ELIGIBILITY_FORMULA
,DECODE(eligibilityPfsE0.MNDTRY_FLAG,'Y','Yes','No') RES_REQUIRED
,TO_CHAR(eligibilityPfsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_ELIGIBILITY_EFFECTIVE_STAR
,DECODE(TO_CHAR(eligibilityPfsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(eligibilityPfsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_ELIGIBILITY_EFFECTIVE_END_
,eligibilityPfsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,eligibilityPfsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,eligibilityPfsE0.CREATED_BY  RSC_CREATED_BY
,eligibilityPfsE0.CREATION_DATE  RSC_CREATION_DATE
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
,BEN_APLD_DPNT_CVG_ELIG_PRFL_F eligibilityPfsE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = eligibilityPfsE0.PL_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE