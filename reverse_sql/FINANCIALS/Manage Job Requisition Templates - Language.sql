
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
,(SELECT DESCRIPTION
    FROM FND_LANGUAGES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LANGUAGE_CODE = languagesE0.LANGUAGE_CODE
    ) RES_COLLABORATOR
,languagesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,languagesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,languagesE0.CREATED_BY RSC_CREATED_BY
,languagesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_REQUISITIONS_VL jobReqTemplatesE0
,IRC_REQ_LANGUAGES languagesE0
WHERE jobReqTemplatesE0.REQ_USAGE_CODE = 'ORA_TEMPLATE'
AND jobReqTemplatesE0.REQUISITION_ID = languagesE0.REQUISITION_ID
ORDER BY jobReqTemplatesE0.REQUISITION_NUMBER