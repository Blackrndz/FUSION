/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT HzPartiesE0.PARTY_NUMBER RES_REGISTRY_ID
,HzPartiesE0.PARTY_NAME RES_NAME
,HzPartySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,HzPartySitesE0.PARTY_SITE_NAME RES_SITE_NAME
,HzPartySitesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,HzPartySitesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,HzPartySitesE0.CREATED_BY  RSC_CREATED_BY
,HzPartySitesE0.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTIES HzPartiesE0
,HZ_PARTY_USG_ASSIGNMENTS HzPartyUsgAssignmentsE0
,HZ_PARTY_SITES HzPartySitesE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzPartySitesE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE = 'CREDIT_CARD_PROVIDER'
AND HzPartySitesE0.STATUS = 'A'
ORDER BY HzPartiesE0.PARTY_NUMBER
,HzPartySitesE0.PARTY_SITE_NUMBER