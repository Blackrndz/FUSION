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
,(SELECT RATING_SHORT_DESCR
    FROM HRT_RATING_LEVELS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND RATING_LEVEL_ID = tkRtDistsE0.RATING_LEVEL_ID
     ) RES_RATING_LEVEL
,tkRtDistsE0.DISTRIBUTION_PCT RES_DISTRIBUTION_PERCENTAGE

,tkRtDistsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,tkRtDistsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,tkRtDistsE0.CREATED_BY  RSC_CREATED_BY
,tkRtDistsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRT_OBJ_RATING_DIST_VL tkRtsE0
,HRT_RATING_DISTRIBUTIONS tkRtDistsE0
WHERE tkRtsE0.OBJ_RATING_DIST_ID = tkRtDistsE0.OBJ_RATING_DIST_ID
ORDER BY tkRtsE0.RATING_DIST_NAME