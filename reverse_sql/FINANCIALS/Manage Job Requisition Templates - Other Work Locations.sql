
/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=IRC_REQ_LANGUAGES

SELECT jobReqTemplatesE0.NAME RES_NAME
,jobReqTemplatesE0.REQUISITION_NUMBER RES_CODE
,(SELECT LOCATION_NAME
    FROM PER_LOCATION_DETAILS_F_VL
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND LOCATION_ID = workLocationsE0.LOCATION_ID
    ) RES_OTHER_WORK_LOCATIONS
,workLocationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,workLocationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,workLocationsE0.CREATED_BY RSC_CREATED_BY
,workLocationsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_REQUISITIONS_VL jobReqTemplatesE0
,IRC_REQ_WORK_LOCATIONS workLocationsE0
WHERE jobReqTemplatesE0.REQ_USAGE_CODE = 'ORA_TEMPLATE'
AND jobReqTemplatesE0.REQUISITION_ID = workLocationsE0.REQUISITION_ID
ORDER BY jobReqTemplatesE0.REQUISITION_NUMBER