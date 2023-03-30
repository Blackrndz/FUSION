/* ****************************************************************************
 * $Revision: 78905 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-07-01 16:32:47 +0700 (Fri, 01 Jul 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Benefit%20Certification%20Life%20Event%20Details.sql $:
 * $Id: Manage Benefit Plans - Benefit Certification Life Event Details.sql 78905 2022-07-01 09:32:47Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=BEN_PL_F
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,benPlansE0.NAME RES_PLAN_OR_OPTION_NAME
,'Plan' RES_PLAN_OR_OPTION_DESCRIPTION
,(SELECT NAME
    FROM BEN_LER_F_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LER_ID = enrollBenLeE0.LER_ID
    ) RES_LIFE_EVENT
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_ENRT_CTFN_TYP'
    AND LOOKUP_CODE = enrollBenLeCertTypesE0.ENRT_CTFN_TYP_CD
    ) RES_CERTIFICATION_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'BEN_DET_CTFN'
    AND LOOKUP_CODE = enrollBenLeCertTypesE0.CTFN_DETERMINE_CD
    ) RES_DETERMINATION_RULE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = enrollBenLeCertTypesE0.CTFN_RQD_WHEN_RL
    ) RES_DETERMINATION_FORMULA
,DECODE(enrollBenLeCertTypesE0.RQD_FLAG,'Y','Yes','No') RES_REQUIRED
,TO_CHAR(enrollBenLeCertTypesE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_LIFE_EVENT_DETAILS_EFFECTI
,DECODE(TO_CHAR(enrollBenLeCertTypesE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(enrollBenLeCertTypesE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_LIFE_EVENT_DETAILS_EFFEC_0
,enrollBenLeCertTypesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,enrollBenLeCertTypesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,enrollBenLeCertTypesE0.CREATED_BY  RSC_CREATED_BY
,enrollBenLeCertTypesE0.CREATION_DATE  RSC_CREATION_DATE
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
,BEN_LER_BNFT_RSTRN_F enrollBenLeE0
,(SELECT *
    FROM BEN_LER_POPL_ACTN_TYP_F
    WHERE ACTN_TYP_LVL_CD = 'RSTRNCTFN'
    ) enrollBenLeCertsE0
,BEN_LER_BNFT_RSTRN_CTFN_F enrollBenLeCertTypesE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = enrollBenLeE0.PL_ID
AND enrollBenLeE0.PL_ID = enrollBenLeCertsE0.PL_ID
AND enrollBenLeE0.LER_ID = enrollBenLeCertsE0.LER_ID
AND enrollBenLeCertsE0.LER_POPL_ACTN_TYP_ID = enrollBenLeCertTypesE0.LER_POPL_ACTN_TYP_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE