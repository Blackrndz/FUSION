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
,'' RES_CATEGORY_CODE
,HzPartiesE0.DUNS_NUMBER_C RES_D_U_N_S_NUMBER
,HzOrganizationProfileE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,HzOrganizationProfileE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,HzOrganizationProfileE0.CREATED_BY  RSC_CREATED_BY
,HzOrganizationProfileE0.CREATION_DATE  RSC_CREATION_DATE
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
,HZ_ORGANIZATION_PROFILES HzOrganizationProfileE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzOrganizationProfileE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE = 'CREDIT_CARD_PROVIDER'
ORDER BY HzPartiesE0.PARTY_NUMBER