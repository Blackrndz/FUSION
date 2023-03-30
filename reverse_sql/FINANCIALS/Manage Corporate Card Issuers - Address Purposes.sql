/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=HZ_PARTY_USG_ASSIGNMENTS

SELECT HzPartiesE0.PARTY_NUMBER RES_REGISTRY_ID
,HzPartiesE0.PARTY_NAME RES_NAME
,HzPartySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,HzPartySitesE0.PARTY_SITE_NAME RES_SITE_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PARTY_SITE_USE_CODE'
	AND LOOKUP_CODE = PartySiteUseEO.SITE_USE_TYPE
	) RES_PURPOSE
,TO_CHAR(PartySiteUseEO.BEGIN_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(PartySiteUseEO.END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(PartySiteUseEO.END_DATE,'DD-Mon-YYYY')) RES_TO_DATE
,PartySiteUseEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PartySiteUseEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PartySiteUseEO.CREATED_BY  RSC_CREATED_BY
,PartySiteUseEO.CREATION_DATE  RSC_CREATION_DATE
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
,HZ_PARTY_SITE_USES PartySiteUseEO
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzPartySitesE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE = 'CREDIT_CARD_PROVIDER'
AND HzPartySitesE0.STATUS = 'A'
AND HzPartySitesE0.PARTY_SITE_ID = PartySiteUseEO.PARTY_SITE_ID
ORDER BY HzPartiesE0.PARTY_NUMBER
,HzPartySitesE0.PARTY_SITE_NUMBER