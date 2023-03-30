/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT RATING_NAME
    FROM HRT_RATING_MODELS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RATING_MODEL_ID = pfsE0.PERFORMANCE_RATING_MODEL_ID
    ) RES_PERFORMANCE_RATING_MODEL
,(SELECT RATING_NAME
    FROM HRT_RATING_MODELS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RATING_MODEL_ID = pfsE0.POTENTIAL_RATING_MODEL_ID
    ) RES_POTENTIAL_RATING_MODEL
,labelsE0.BOX_LABEL RES_BOX_CHART_CELL_LABELS
,pfsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pfsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pfsE0.CREATED_BY RSC_CREATED_BY
,pfsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRA_ANLYT_BOX_DEFNS pfsE0
,HRA_ANLYT_BOX_LBLS_VL labelsE0
WHERE pfsE0.ANALYTIC_BOX_DEFN_ID = labelsE0.ANALYTIC_BOX_DEFN_ID(+)
ORDER BY 1,2,labelsE0.BOX_SEQUENCE