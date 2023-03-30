/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT benPlansE0.NAME RES_PLAN_NAME
,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,benPlansE0.NAME RES_PLAN_OR_OPTION_NAME
,'Plan' RES_PLAN_OR_OPTION_DESCRIPTION
,(SELECT NAME
    FROM BEN_LER_F_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LER_ID = restrictsE0.LER_ID
    ) RES_SCHEDULED
,TO_CHAR(periodsE0.STRT_DT,'DD-Mon-YYYY') RES_ENROLLMENT_PERIOD_START_DA
,TO_CHAR(periodsE0.END_DT,'DD-Mon-YYYY') RES_ENROLLMENT_PERIOD_END_DATE
,TO_CHAR(periodsE0.ASND_LF_EVT_DT,'DD-Mon-YYYY')  RES_ASSIGNED_LIFE_EVENT_DATE
,periodFormulasE0.ORDR_TO_APLY_NUM RES_SEQUENCE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = periodFormulasE0.FORMULA_ID
    ) RES_ENROLLMENT_FORMULA
,TO_CHAR(periodFormulasE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_ENROLLMENT_FORMULAS_START_
,DECODE(TO_CHAR(periodFormulasE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(periodFormulasE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_ENROLLMENT_FORMULAS_END_DA
,periodFormulasE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,periodFormulasE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,periodFormulasE0.CREATED_BY  RSC_CREATED_BY
,periodFormulasE0.CREATION_DATE  RSC_CREATION_DATE
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
,(SELECT *
    FROM BEN_LER_CHG_PL_NIP_ENRT_F
    WHERE LER_ID IN (SELECT LER_ID FROM BEN_LER_F WHERE TYP_CD = 'SCHEDDUO')
    ) restrictsE0
,(SELECT *
	FROM BEN_POPL_ENRT_TYP_CYCL 
	WHERE COMP_OBJ_TYPE = 'PLN'
	) schedulPeriodsE0
,BEN_ENRT_PERD periodsE0
,BEN_SCHEDD_ENRT_RL_F periodFormulasE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = restrictsE0.PL_ID
AND benPlansE0.PL_ID = schedulPeriodsE0.PL_ID
AND restrictsE0.LER_ID = periodsE0.LER_ID
AND schedulPeriodsE0.POPL_ENRT_TYP_CYCL_ID = periodsE0.POPL_ENRT_TYP_CYCL_ID
AND periodsE0.ENRT_PERD_ID = periodFormulasE0.ENRT_PERD_ID
ORDER BY 1,2