
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
,(SELECT DISPLAY_NAME
    FROM PER_PERSON_NAMES_F
    WHERE NAME_TYPE = 'GLOBAL'
    AND PERSON_ID = collabsE0.PERSON_ID
     ) RES_COLLABORATOR
,collabsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,collabsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,collabsE0.CREATED_BY RSC_CREATED_BY
,collabsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_REQUISITIONS_VL jobReqTemplatesE0
,IRC_TEAM_MEMBERS collabsE0
WHERE jobReqTemplatesE0.REQ_USAGE_CODE = 'ORA_TEMPLATE'
AND collabsE0.OBJECT_TYPE = 'ORA_REQUISITION'
AND collabsE0.MEMBER_TYPE_CODE = 'ORA_COLLABORATOR'
AND jobReqTemplatesE0.REQUISITION_ID = collabsE0.OBJECT_ID
ORDER BY jobReqTemplatesE0.REQUISITION_NUMBER