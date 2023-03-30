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
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_RECRUITING_TYPE'
    AND LOOKUP_CODE = contextsE0.RECRUITING_TYPE_CODE
     ) RES_RECRUITING_TYPE_1
,DECODE(contextsE0.DEFAULT_FLAG,'Y','Default') RES_RECRUITING_TYPE_2
,contextsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contextsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contextsE0.CREATED_BY RSC_CREATED_BY
,contextsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_APPLY_FLOWS_VL flowsE0
,(SELECT *
    FROM IRC_AVAILABILITY_CONTEXT
    WHERE OBJECT_TYPE_CODE = 'ORA_APPLY_FLOW'
    ) contextsE0
WHERE flowsE0.APPLY_FLOW_ID = contextsE0.OBJECT_ID
ORDER BY flowsE0.APPLY_FLOW_NAME