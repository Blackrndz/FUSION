/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=IRC_APPLY_FLOWS_VL

SELECT flowsE0.APPLY_FLOW_NAME RES_APPLICATION_FLOW_NAME
,flowsE0.AF_CODE RES_CODE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_APPLY_FLOW_TYPE'
    AND LOOKUP_CODE = flowsE0.AF_TYPE_CODE
    ) RES_APPLICATION_FLOW_TYPE
,flowsE0.DESCRIPTION RES_DESCRIPTION
,flowsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,flowsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,flowsE0.CREATED_BY RSC_CREATED_BY
,flowsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_APPLY_FLOWS_VL flowsE0
ORDER BY flowsE0.APPLY_FLOW_NAME