
/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

SELECT jobReqTemplatesE0.NAME RES_NAME
,jobReqTemplatesE0.REQUISITION_NUMBER RES_CODE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_REQ_TEMPLATE_TYPE'
    AND LOOKUP_CODE = jobReqTemplatesE0.REQ_USAGE_TYPE 
    ) RES_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_OBJECT_STATUS'
    AND LOOKUP_CODE = jobReqTemplatesE0.OBJECT_STATUS  
	) RES_STATUS
,'' RES_LAST_UPDATE_DATE
,'' RES_CREATE_BY
,jobReqTemplatesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,jobReqTemplatesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,jobReqTemplatesE0.CREATED_BY RSC_CREATED_BY
,jobReqTemplatesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_REQUISITIONS_VL jobReqTemplatesE0
,IRC_GEO_HIER_NODES geoMapsE0
,HRT_PROFILE_ITEMS profilesE0
WHERE jobReqTemplatesE0.REQ_USAGE_CODE = 'ORA_TEMPLATE'
AND jobReqTemplatesE0.GEOGRAPHY_NODE_ID = geoMapsE0.GEOGRAPHY_NODE_ID(+)
AND jobReqTemplatesE0.PROFILE_ID = profilesE0.PROFILE_ID(+)
ORDER BY jobReqTemplatesE0.REQUISITION_NUMBER