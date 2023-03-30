/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS = HRT_REVIEW_PERIODS_TL
 
SELECT pfTemplatesE0.NAME RES_NAME
,docPeriodsE0.CUSTOMARY_NAME RES_PERIOD_NAME
,(SELECT REVIEW_PERIOD_NAME
    FROM HRT_REVIEW_PERIODS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND REVIEW_PERIOD_ID = docPeriodsE0.REVIEW_PERIOD_ID
    ) RES_REVIEW_PERIOD
,TO_CHAR(docPeriodsE0.NOMINAL_FROM_DATE,'DD-Mon-YYYY') RES_PERFORMANCE_DOCUMENT_START
,TO_CHAR(docPeriodsE0.NOMINAL_TO_DATE,'DD-Mon-YYYY') RES_PERFORMANCE_DOCUMENT_END_D
,docPeriodsE0.SHORT_NAME RES_SHORT_NAME
,DECODE(docPeriodsE0.AVAILABLE_TO_USE,'Y','Yes','No') RES_AVAILABLE_TO_USE
/*,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HRA_GOAL_ALGORITHM_TYPE'
    AND LOOKUP_CODE = docPeriodsE0.GOAL_ALGORITHM_TYPE_CODE
     ) X4*/


,docPeriodsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,docPeriodsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,docPeriodsE0.CREATED_BY  RSC_CREATED_BY
,docPeriodsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRA_TMPL_DEFNS_VL pfTemplatesE0
,HRA_TMPL_PERIODS_VL docPeriodsE0
WHERE pfTemplatesE0.TEMPLATE_DEFN_ID = docPeriodsE0.TEMPLATE_DEFN_ID
ORDER BY pfTemplatesE0.NAME
