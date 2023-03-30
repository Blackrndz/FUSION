/* ****************************************************************************
 * $Revision: 78875 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-27 14:11:47 +0700 (Mon, 27 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Enrollment%20Life%20Event%20Formulas.sql $:
 * $Id: Manage Benefit Plans - Enrollment Life Event Formulas.sql 78875 2022-06-27 07:11:47Z tanawat.wongjan $:
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
    AND LER_ID = lifeEventsE0.LER_ID
    ) RES_LIFE_EVENT
,lifeEventFormulasE0.ORDR_TO_APLY_NUM RES_SEQUENCE
,(SELECT FORMULA_NAME
    FROM FF_FORMULAS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND FORMULA_ID = lifeEventFormulasE0.FORMULA_ID
    ) RES_ENROLLMENT_FORMULA
,TO_CHAR(lifeEventFormulasE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_LIFE_EVENT_FORMULAS_START_
,DECODE(TO_CHAR(lifeEventFormulasE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(lifeEventFormulasE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_LIFE_EVENT_FORMULAS_END_DA
,lifeEventFormulasE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,lifeEventFormulasE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,lifeEventFormulasE0.CREATED_BY  RSC_CREATED_BY
,lifeEventFormulasE0.CREATION_DATE  RSC_CREATION_DATE
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
    WHERE LER_ID IN (SELECT LER_ID FROM BEN_LER_F WHERE TYP_CD = 'SCHEDDU')
    ) restrictsE0
,(SELECT *
	FROM BEN_POPL_ENRT_TYP_CYCL 
	WHERE COMP_OBJ_TYPE = 'PLN'
	AND ENRT_TYP_CYCL_CD = 'U'
	) schedulPeriodsE0
,BEN_LEE_RSN_F lifeEventsE0
,BEN_LEE_RSN_RL_F lifeEventFormulasE0
WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
AND benPlansE0.PL_ID = restrictsE0.PL_ID
AND benPlansE0.PL_ID = schedulPeriodsE0.PL_ID
AND restrictsE0.LER_ID = lifeEventsE0.LER_ID
AND schedulPeriodsE0.POPL_ENRT_TYP_CYCL_ID = lifeEventsE0.POPL_ENRT_TYP_CYCL_ID
AND benPlansE0.EFFECTIVE_END_DATE BETWEEN lifeEventsE0.EFFECTIVE_START_DATE AND lifeEventsE0.EFFECTIVE_END_DATE
AND lifeEventsE0.LEE_RSN_ID = lifeEventFormulasE0.LEE_RSN_ID
ORDER BY benPlansE0.NAME
,benPlansE0.EFFECTIVE_START_DATE