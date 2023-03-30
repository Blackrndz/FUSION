/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_ALLOCATIONS_HDR_VL

SELECT timeAlloecationsE0.ALLOCATION_NAME RES_ALLOCATION_NAME
,timeAlloecationsE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(timeAlloecationsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(timeAlloecationsE0.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(timeAlloecationsE0.EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,timeAlloecationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,timeAlloecationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,timeAlloecationsE0.CREATED_BY RSC_CREATED_BY
,timeAlloecationsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,timeAlloecationsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_ALLOCATIONS_HDR_VL timeAlloecationsE0
WHERE SYSDATE BETWEEN timeAlloecationsE0.EFFECTIVE_START_DATE AND NVL(timeAlloecationsE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY timeAlloecationsE0.ALLOCATION_NAME