/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT pModelsE0.MODEL_NAME RES_PREDICTIVE_MODEL

,pModelsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pModelsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pModelsE0.CREATED_BY RSC_CREATED_BY
,pModelsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HWP_MODELS_VL pModelsE0

ORDER BY pModelsE0.MODEL_NAME
