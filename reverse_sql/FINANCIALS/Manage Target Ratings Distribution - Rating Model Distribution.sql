/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT tkRtsE0.RATING_DIST_NAME RES_NAME
,tkRtsE0.RATING_DIST_DESCR RES_DESCRIPTION
,(SELECT NAME
    FROM HRA_TMPL_DEFNS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TEMPLATE_DEFN_ID = tkRtsE0.OBJECT_ID
    ) RES_PERFORMANCE_TEMPLATE
,(SELECT RATING_NAME
    FROM HRT_RATING_MODELS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RATING_MODEL_ID = tkRtsE0.RATING_MODEL_ID
    ) RES_RATING_MODEL
,TO_CHAR(tkRtsE0.DATE_FROM,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(tkRtsE0.DATE_TO,'DD-Mon-YYYY') RES_TO_DATE

,tkRtsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,tkRtsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,tkRtsE0.CREATED_BY  RSC_CREATED_BY
,tkRtsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRT_OBJ_RATING_DIST_VL tkRtsE0
ORDER BY tkRtsE0.RATING_DIST_NAME
