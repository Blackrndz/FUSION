/* ****************************************************************************
 * $Revision: 54841 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-04-29 15:18:22 +0700 (Fri, 29 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Locations%20-%20Asset%20Locations.sql $:
 * $Id: Manage Asset Locations - Asset Locations.sql 54841 2016-04-29 08:18:22Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FND_DF_CTX_VALIDATORS_VL

SELECT flexfieldsE0.NAME RES_FLEXFIELD_NAME
,flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE RES_FLEXFIELD_CODE
,contextsE0.NAME RES_DISPLAY_NAME
,contextsE0.CONTEXT_CODE RES_CONTEXT_CODE
,validatorsE0.VALIDATOR_CODE RES_VALIDATOR_CODE
,validatorsE0.VALIDATOR_EXPRESSION RES_VALIDATOR_EXPRESSION
,validatorsE0.ERROR_MESSAGE RES_ERROR_MESSAGE
,validatorsE0.DESCRIPTION RES_DESCRIPTION
,validatorsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,validatorsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,validatorsE0.CREATED_BY RSC_CREATED_BY
,validatorsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL flexfieldsE0
,FND_DF_CONTEXTS_VL contextsE0
,FND_DF_CTX_VALIDATORS_VL validatorsE0
WHERE flexfieldsE0.FLEXFIELD_TYPE = 'EFF'
AND flexfieldsE0.APPLICATION_ID = 10008
AND flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = contextsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfieldsE0.APPLICATION_ID = contextsE0.APPLICATION_ID
AND flexfieldsE0.DESCRIPTIVE_FLEXFIELD_CODE = validatorsE0.DESCRIPTIVE_FLEXFIELD_CODE
AND flexfieldsE0.APPLICATION_ID = validatorsE0.APPLICATION_ID
AND contextsE0.CONTEXT_CODE = validatorsE0.CONTEXT_CODE
ORDER BY flexfieldsE0.NAME
,contextsE0.NAME
,validatorsE0.VALIDATOR_CODE