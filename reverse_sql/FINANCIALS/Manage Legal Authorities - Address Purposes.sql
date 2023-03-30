/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT PartyPEO.PARTY_NAME RES_NAME
,PartyPEO.PARTY_NUMBER RES_ORGANIZATION_NUMBER
,partySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
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
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTY_SITES partySitesE0
,HZ_ORGANIZATION_PROFILES OrganizationPEO
,HZ_GEOGRAPHIES GeographyPEO
,HZ_PARTIES PartyPEO
,FND_TERRITORIES_VL TerritoryPEO
,HZ_PARTY_USG_ASSIGNMENTS PartyUsageAssignmentPEO
,HZ_LOCATIONS locationsE0
,HZ_PARTY_SITE_USES PartySiteUseEO
WHERE((PartyUsageAssignmentPEO.PARTY_ID = partypeo.party_id)
AND(PartyUsageAssignmentPEO.party_usage_code = 'LEGAL_AUTHORITY')
AND(locationsE0.location_id(+) = partySitesE0.location_id)
AND(partypeo.party_id = partySitesE0.party_id(+))
AND(partypeo.party_id = organizationpeo.party_id)
AND(organizationpeo.effective_start_date <= sysdate
AND organizationpeo.effective_end_date > sysdate)
AND(geographypeo.geography_code = territorypeo.territory_code(+))
AND(geographypeo.geography_code(+) = locationsE0.country)
AND(geographypeo.geography_type(+) = 'COUNTRY')
--AND partySitesE0.PARTY_SITE_TYPE NOT IN 'ONE_TIME' 
--AND(partySitesE0.IDENTIFYING_ADDRESS_FLAG(+) = 'Y')
AND NVL(partySitesE0.STATUS(+),'A') = 'A'
AND NVL(TRUNC(partySitesE0.START_DATE_ACTIVE(+)),TRUNC(SYSDATE)) <= TRUNC(SYSDATE)
AND NVL(TRUNC(partySitesE0.END_DATE_ACTIVE(+)),TRUNC(SYSDATE) + 1) > TRUNC(SYSDATE)
AND NVL(organizationpeo.STATUS,'A') = 'A'
AND NVL(TRUNC(organizationpeo.EFFECTIVE_START_DATE),TRUNC(SYSDATE)) <= TRUNC(SYSDATE)
AND NVL(TRUNC(organizationpeo.EFFECTIVE_END_DATE),TRUNC(SYSDATE) + 1) > TRUNC(SYSDATE))
AND partySitesE0.PARTY_SITE_ID = PartySiteUseEO.PARTY_SITE_ID
ORDER BY PartyPEO.PARTY_NAME,PartyPEO.PARTY_NUMBER,partySitesE0.PARTY_SITE_NUMBER
