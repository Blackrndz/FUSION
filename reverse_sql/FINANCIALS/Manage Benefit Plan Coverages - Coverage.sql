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
,coveragesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,coveragesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,coveragesE0.CREATED_BY RSC_CREATED_BY
,coveragesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,coveragesE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_CVG_AMT_CALC_MTHD_F coveragesE0
WHERE SYSDATE BETWEEN coveragesE0.EFFECTIVE_START_DATE AND coveragesE0.EFFECTIVE_END_DATE
ORDER BY coveragesE0.NAME