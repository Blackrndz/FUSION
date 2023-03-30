/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT coveragesE0.NAME RES_COVERAGE_NAME
,(SELECT NAME
    FROM BEN_PL_F
    WHERE coveragesE0.EFFECTIVE_END_DATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND PL_ID = coveragesE0.CONTEXT_PL_ID
    ) RES_PLAN_NAME
,TO_CHAR(coveragesE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(coveragesE0.EFFECTIVE_END_DATE ,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(coveragesE0.EFFECTIVE_END_DATE ,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,vFormulasE0.ORDR_TO_APLY_NUM RES_SEQUENCE
, (SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = vFormulasE0.FORMULA_ID
    ) RES_VARIABLE_COVERAGE_FORMULA
,vFormulasE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,vFormulasE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,vFormulasE0.CREATED_BY RSC_CREATED_BY
,vFormulasE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,coveragesE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_CVG_AMT_CALC_MTHD_F coveragesE0
,BEN_BNFT_VRBL_RT_RL_F vFormulasE0
WHERE coveragesE0.CVG_AMT_CALC_MTHD_ID = vFormulasE0.CVG_AMT_CALC_MTHD_ID
ORDER BY coveragesE0.NAME
,coveragesE0.EFFECTIVE_START_DATE
,vFormulasE0.ORDR_TO_APLY_NUM